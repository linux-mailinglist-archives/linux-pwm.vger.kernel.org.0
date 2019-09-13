Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC15B28C2
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2019 01:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404185AbfIMXE3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Sep 2019 19:04:29 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:37540 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404024AbfIMXE2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Sep 2019 19:04:28 -0400
X-Greylist: delayed 363 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 19:04:27 EDT
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Sep 2019 15:58:24 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 13 Sep 2019 15:58:24 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 70EC24634; Fri, 13 Sep 2019 15:58:24 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH 2/2] pwm: core: Add option to config PWM duty/period with u64 data length
Date:   Fri, 13 Sep 2019 15:57:44 -0700
Message-Id: <1568415464-20267-2-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
References: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fenglin Wu <fenglinw@codeaurora.org>

Currently, PWM core driver provides interfaces for configuring PWM
period and duty length in nanoseconds with an integer data type, so
the max period can be only set to ~2.147 seconds. Add interfaces which
can set PWM period and duty with u64 data type to remove this
limitation.

Change-Id: Ic8722088510d447fc939ab6a5014711aef1b832f
Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/core.c  |  20 ++++++---
 drivers/pwm/sysfs.c |   6 +--
 include/linux/pwm.h | 115 ++++++++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 126 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 960a451..02ad16b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -526,9 +526,19 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
-			err = pwm->chip->ops->config(pwm->chip, pwm,
-						     state->duty_cycle,
-						     state->period);
+			if (pwm->chip->ops->config_extend) {
+				err = pwm->chip->ops->config_extend(pwm->chip,
+						pwm, state->duty_cycle,
+						state->period);
+			} else {
+				if (state->period > UINT_MAX)
+					pr_warn("period %llu duty_cycle %llu will be truncated\n",
+							state->period,
+							state->duty_cycle);
+				err = pwm->chip->ops->config(pwm->chip, pwm,
+						state->duty_cycle,
+						state->period);
+			}
 			if (err)
 				return err;
 
@@ -1181,8 +1191,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
 
-		seq_printf(s, " period: %u ns", state.period);
-		seq_printf(s, " duty: %u ns", state.duty_cycle);
+		seq_printf(s, " period: %llu ns", state.period);
+		seq_printf(s, " duty: %llu ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index ab703f2..ef78c40 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -42,7 +42,7 @@ static ssize_t period_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%u\n", state.period);
+	return sprintf(buf, "%llu\n", state.period);
 }
 
 static ssize_t period_store(struct device *child,
@@ -77,7 +77,7 @@ static ssize_t duty_cycle_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%u\n", state.duty_cycle);
+	return sprintf(buf, "%llu\n", state.duty_cycle);
 }
 
 static ssize_t duty_cycle_store(struct device *child,
@@ -212,7 +212,7 @@ static ssize_t capture_show(struct device *child,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
+	return sprintf(buf, "%llu %llu\n", result.period, result.duty_cycle);
 }
 
 static ssize_t output_type_show(struct device *child,
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 416f08e..d714385 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -39,7 +39,7 @@ enum pwm_polarity {
  * current PWM hardware state.
  */
 struct pwm_args {
-	unsigned int period;
+	u64 period;
 	enum pwm_polarity polarity;
 };
 
@@ -66,9 +66,9 @@ enum pwm_output_type {
  * @cycles_per_duty: number of PWM period cycles an entry stays at
  */
 struct pwm_output_pattern {
-	unsigned int *duty_pattern;
+	u64 *duty_pattern;
 	unsigned int num_entries;
-	unsigned int cycles_per_duty;
+	u64 cycles_per_duty;
 };
 
 /*
@@ -79,8 +79,8 @@ struct pwm_output_pattern {
  * @enabled: PWM enabled status
  */
 struct pwm_state {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 	enum pwm_polarity polarity;
 	enum pwm_output_type output_type;
 	struct pwm_output_pattern *output_pattern;
@@ -136,12 +136,30 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
 		pwm->state.period = period;
 }
 
+static inline void pwm_set_period_extend(struct pwm_device *pwm, u64 period)
+{
+	if (pwm)
+		pwm->state.period = period;
+}
+
 static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
 	pwm_get_state(pwm, &state);
 
+	if (state.period > UINT_MAX)
+		pr_warn("PWM period %llu is truncated\n", state.period);
+
+	return (unsigned int)state.period;
+}
+
+static inline u64 pwm_get_period_extend(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
 	return state.period;
 }
 
@@ -151,12 +169,30 @@ static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 		pwm->state.duty_cycle = duty;
 }
 
+static inline void pwm_set_duty_cycle_extend(struct pwm_device *pwm, u64 duty)
+{
+	if (pwm)
+		pwm->state.duty_cycle = duty;
+}
+
 static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
 	pwm_get_state(pwm, &state);
 
+	if (state.duty_cycle > UINT_MAX)
+		pr_warn("PWM duty cycle %llu is truncated\n", state.duty_cycle);
+
+	return (unsigned int)state.duty_cycle;
+}
+
+static inline u64 pwm_get_duty_cycle_extend(const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
 	return state.duty_cycle;
 }
 
@@ -300,6 +336,8 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
  * @set_output_pattern: set the pattern for the modulated output
  * @owner: helps prevent removal of modules exporting active PWMs
  * @config: configure duty cycles and period length for this PWM
+ * @config_extend: configure duty cycles and period length for this
+ *	PWM with u64 data type
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
@@ -325,6 +363,8 @@ struct pwm_ops {
 	/* Only used by legacy drivers */
 	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		      int duty_ns, int period_ns);
+	int (*config_extend)(struct pwm_chip *chip, struct pwm_device *pwm,
+		      u64 duty_ns, u64 period_ns);
 	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
@@ -363,8 +403,8 @@ struct pwm_chip {
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  */
 struct pwm_capture {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 };
 
 #if IS_ENABLED(CONFIG_PWM)
@@ -418,6 +458,67 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 }
 
 /**
+ * pwm_config_extend() - change PWM period and duty length with u64 data type
+ * @pwm: PWM device
+ * @duty_ns: "on" time (in nanoseconds)
+ * @period_ns: duration (in nanoseconds) of one cycle
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int pwm_config_extend(struct pwm_device *pwm, u64 duty_ns,
+			     u64 period_ns)
+{
+	struct pwm_state state;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &state);
+	if (state.duty_cycle == duty_ns && state.period == period_ns)
+		return 0;
+
+	state.duty_cycle = duty_ns;
+	state.period = period_ns;
+	return pwm_apply_state(pwm, &state);
+}
+
+/**
+ * pwm_set_polarity() - configure the polarity of a PWM signal
+ * @pwm: PWM device
+ * @polarity: new polarity of the PWM signal
+ *
+ * Note that the polarity cannot be configured while the PWM device is
+ * enabled.
+ *
+ * Returns: 0 on success or a negative error code on failure.
+ */
+static inline int pwm_set_polarity(struct pwm_device *pwm,
+				   enum pwm_polarity polarity)
+{
+	struct pwm_state state;
+
+	if (!pwm)
+		return -EINVAL;
+
+	pwm_get_state(pwm, &state);
+	if (state.polarity == polarity)
+		return 0;
+
+	/*
+	 * Changing the polarity of a running PWM without adjusting the
+	 * dutycycle/period value is a bit risky (can introduce glitches).
+	 * Return -EBUSY in this case.
+	 * Note that this is allowed when using pwm_apply_state() because
+	 * the user specifies all the parameters.
+	 */
+	if (state.enabled)
+		return -EBUSY;
+
+	state.polarity = polarity;
+	return pwm_apply_state(pwm, &state);
+}
+
+/**
  * pwm_enable() - start a PWM output toggling
  * @pwm: PWM device
  *
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

