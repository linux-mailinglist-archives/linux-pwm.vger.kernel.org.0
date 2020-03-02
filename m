Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62FB3176407
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Mar 2020 20:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCBTe2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Mar 2020 14:34:28 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:36504 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727624AbgCBTe2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Mar 2020 14:34:28 -0500
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Mar 2020 11:34:27 -0800
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 02 Mar 2020 11:34:27 -0800
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 559C14B04; Mon,  2 Mar 2020 11:34:27 -0800 (PST)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [RESEND v6 2/2] pwm: core: Convert period and duty cycle to u64
Date:   Mon,  2 Mar 2020 11:34:23 -0800
Message-Id: <2458595b274728b7ab46d4e397040f9d4d10fabc.1583177501.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583177501.git.gurus@codeaurora.org>
References: <cover.1583177501.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583177501.git.gurus@codeaurora.org>
References: <cover.1583177501.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Because period and duty cycle are defined as ints with units of
nanoseconds, the maximum time duration that can be set is limited to
~2.147 seconds. Change their definitions to u64 in the structs of the
PWM framework so that higher durations may be set.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/core.c  |  4 ++--
 drivers/pwm/sysfs.c |  8 ++++----
 include/linux/pwm.h | 12 ++++++------
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5a7f659..81aa3c2 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -1163,8 +1163,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
 
-		seq_printf(s, " period: %u ns", state.period);
-		seq_printf(s, " duty: %u ns", state.duty_cycle);
+		seq_printf(s, " period: %llu ns", state.period);
+		seq_printf(s, " duty: %llu ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b86..449dbc0 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -42,7 +42,7 @@ static ssize_t period_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%u\n", state.period);
+	return sprintf(buf, "%llu\n", state.period);
 }
 
 static ssize_t period_store(struct device *child,
@@ -52,10 +52,10 @@ static ssize_t period_store(struct device *child,
 	struct pwm_export *export = child_to_pwm_export(child);
 	struct pwm_device *pwm = export->pwm;
 	struct pwm_state state;
-	unsigned int val;
+	u64 val;
 	int ret;
 
-	ret = kstrtouint(buf, 0, &val);
+	ret = kstrtou64(buf, 0, &val);
 	if (ret)
 		return ret;
 
@@ -77,7 +77,7 @@ static ssize_t duty_cycle_show(struct device *child,
 
 	pwm_get_state(pwm, &state);
 
-	return sprintf(buf, "%u\n", state.duty_cycle);
+	return sprintf(buf, "%llu\n", state.duty_cycle);
 }
 
 static ssize_t duty_cycle_store(struct device *child,
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0ef808d..b53f13d 100644
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
 
@@ -56,8 +56,8 @@ enum {
  * @enabled: PWM enabled status
  */
 struct pwm_state {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 	enum pwm_polarity polarity;
 	bool enabled;
 };
@@ -105,13 +105,13 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 	return state.enabled;
 }
 
-static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
+static inline void pwm_set_period(struct pwm_device *pwm, u64 period)
 {
 	if (pwm)
 		pwm->state.period = period;
 }
 
-static inline unsigned int pwm_get_period(const struct pwm_device *pwm)
+static inline u64 pwm_get_period(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
@@ -126,7 +126,7 @@ static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
 		pwm->state.duty_cycle = duty;
 }
 
-static inline unsigned int pwm_get_duty_cycle(const struct pwm_device *pwm)
+static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

