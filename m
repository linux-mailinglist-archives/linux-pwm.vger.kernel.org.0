Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEB8B28C1
	for <lists+linux-pwm@lfdr.de>; Sat, 14 Sep 2019 01:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404228AbfIMXE2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Sep 2019 19:04:28 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18033 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404185AbfIMXE2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Sep 2019 19:04:28 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 13 Sep 2019 15:58:24 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg03-sd.qualcomm.com with ESMTP; 13 Sep 2019 15:58:23 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id D30BF4634; Fri, 13 Sep 2019 15:58:23 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org, Fenglin Wu <fenglinw@codeaurora.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH 1/2] pwm: Add different PWM output types support
Date:   Fri, 13 Sep 2019 15:57:43 -0700
Message-Id: <1568415464-20267-1-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Fenglin Wu <fenglinw@codeaurora.org>

Normally, PWM channel has fixed output until software request to change
its settings. There are some PWM devices which their outputs could be
changed autonomously according to a predefined pattern programmed in
hardware. Add pwm_output_type enum type to identify these two different
PWM types and add relevant helper functions to set and get PWM output
types and pattern.

Change-Id: Ia1f914a45ab4f4dd7be037a395eeb89d0e65a80e
Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/core.c  | 26 ++++++++++++++++++++
 drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 146 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 8edfac1..960a451 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -282,6 +282,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
+		pwm->state.output_type = PWM_OUTPUT_FIXED;
 
 		if (chip->ops->get_state)
 			chip->ops->get_state(chip, pwm, &pwm->state);
@@ -498,6 +499,31 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 			pwm->state.polarity = state->polarity;
 		}
 
+		if (state->output_type != pwm->state.output_type) {
+			if (!pwm->chip->ops->set_output_type)
+				return -ENOTSUPP;
+
+			err = pwm->chip->ops->set_output_type(pwm->chip, pwm,
+						state->output_type);
+			if (err)
+				return err;
+
+			pwm->state.output_type = state->output_type;
+		}
+
+		if (state->output_pattern != pwm->state.output_pattern &&
+				state->output_pattern != NULL) {
+			if (!pwm->chip->ops->set_output_pattern)
+				return -ENOTSUPP;
+
+			err = pwm->chip->ops->set_output_pattern(pwm->chip,
+					pwm, state->output_pattern);
+			if (err)
+				return err;
+
+			pwm->state.output_pattern = state->output_pattern;
+		}
+
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
 			err = pwm->chip->ops->config(pwm->chip, pwm,
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b86..ab703f2 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -215,11 +215,60 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t output_type_show(struct device *child,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	const struct pwm_device *pwm = child_to_pwm_device(child);
+	const char *output_type = "unknown";
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+	switch (state.output_type) {
+	case PWM_OUTPUT_FIXED:
+		output_type = "fixed";
+		break;
+	case PWM_OUTPUT_MODULATED:
+		output_type = "modulated";
+		break;
+	default:
+		break;
+	}
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", output_type);
+}
+
+static ssize_t output_type_store(struct device *child,
+			      struct device_attribute *attr,
+			      const char *buf, size_t size)
+{
+	struct pwm_export *export = child_to_pwm_export(child);
+	struct pwm_device *pwm = export->pwm;
+	struct pwm_state state;
+	int ret = -EINVAL;
+
+	mutex_lock(&export->lock);
+	pwm_get_state(pwm, &state);
+	if (sysfs_streq(buf, "fixed"))
+		state.output_type = PWM_OUTPUT_FIXED;
+	else if (sysfs_streq(buf, "modulated"))
+		state.output_type = PWM_OUTPUT_MODULATED;
+	else
+		goto unlock;
+
+	ret = pwm_apply_state(pwm, &state);
+unlock:
+	mutex_unlock(&export->lock);
+
+	return ret ? : size;
+}
+
 static DEVICE_ATTR_RW(period);
 static DEVICE_ATTR_RW(duty_cycle);
 static DEVICE_ATTR_RW(enable);
 static DEVICE_ATTR_RW(polarity);
 static DEVICE_ATTR_RO(capture);
+static DEVICE_ATTR_RW(output_type);
 
 static struct attribute *pwm_attrs[] = {
 	&dev_attr_period.attr,
@@ -227,6 +276,7 @@ static ssize_t capture_show(struct device *child,
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_output_type.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 24632a7..416f08e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -48,6 +48,29 @@ enum {
 	PWMF_EXPORTED = 1 << 1,
 };
 
+/**
+ * enum pwm_output_type - output type of the PWM signal
+ * @PWM_OUTPUT_FIXED: PWM output is fixed until a change request
+ * @PWM_OUTPUT_MODULATED: PWM output is modulated in hardware
+ * autonomously with a predefined pattern
+ */
+enum pwm_output_type {
+	PWM_OUTPUT_FIXED = 1 << 0,
+	PWM_OUTPUT_MODULATED = 1 << 1,
+};
+
+/**
+ * struct pwm_output_pattern - PWM duty pattern for MODULATED duty type
+ * @duty_pattern: PWM duty cycles in the pattern for duty modulation
+ * @num_entries: number of entries in the pattern
+ * @cycles_per_duty: number of PWM period cycles an entry stays at
+ */
+struct pwm_output_pattern {
+	unsigned int *duty_pattern;
+	unsigned int num_entries;
+	unsigned int cycles_per_duty;
+};
+
 /*
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
@@ -59,6 +82,8 @@ struct pwm_state {
 	unsigned int period;
 	unsigned int duty_cycle;
 	enum pwm_polarity polarity;
+	enum pwm_output_type output_type;
+	struct pwm_output_pattern *output_pattern;
 	bool enabled;
 };
 
@@ -144,6 +169,26 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return state.polarity;
 }
 
+static inline enum pwm_output_type pwm_get_output_type(
+		const struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return state.output_type;
+}
+
+static inline struct pwm_output_pattern *pwm_get_output_pattern(
+				struct pwm_device *pwm)
+{
+	struct pwm_state state;
+
+	pwm_get_state(pwm, &state);
+
+	return pwm->state.output_pattern ?: NULL;
+}
+
 static inline void pwm_get_args(const struct pwm_device *pwm,
 				struct pwm_args *args)
 {
@@ -250,6 +295,9 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
  * @get_state: get the current PWM state. This function is only
  *	       called once per PWM device when the PWM chip is
  *	       registered.
+ * @get_output_type_supported: get the supported output type
+ * @set_output_type: set PWM output type
+ * @set_output_pattern: set the pattern for the modulated output
  * @owner: helps prevent removal of modules exporting active PWMs
  * @config: configure duty cycles and period length for this PWM
  * @set_polarity: configure the polarity of this PWM
@@ -265,6 +313,13 @@ struct pwm_ops {
 		     struct pwm_state *state);
 	void (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
 			  struct pwm_state *state);
+	int (*get_output_type_supported)(struct pwm_chip *chip,
+			struct pwm_device *pwm);
+	int (*set_output_type)(struct pwm_chip *chip, struct pwm_device *pwm,
+			enum pwm_output_type output_type);
+	int (*set_output_pattern)(struct pwm_chip *chip,
+			struct pwm_device *pwm,
+			struct pwm_output_pattern *output_pattern);
 	struct module *owner;
 
 	/* Only used by legacy drivers */
@@ -320,6 +375,21 @@ struct pwm_capture {
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
+ * pwm_output_type_support()
+ * @pwm: PWM device
+ *
+ * Returns:  output types supported by the PWM device
+ */
+static inline int pwm_get_output_type_supported(struct pwm_device *pwm)
+{
+	if (pwm->chip->ops->get_output_type_supported != NULL)
+		return pwm->chip->ops->get_output_type_supported(pwm->chip,
+				pwm);
+	else
+		return PWM_OUTPUT_FIXED;
+}
+
+/**
  * pwm_config() - change a PWM device configuration
  * @pwm: PWM device
  * @duty_ns: "on" time (in nanoseconds)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

