Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A971D85C0
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2019 04:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389620AbfJPCLr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Oct 2019 22:11:47 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:16421 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730641AbfJPCLq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Oct 2019 22:11:46 -0400
IronPort-SDR: N6FH4mCHZeUaR7ocCQ9TWT/KdZTr6he++DDaboXcCSfGNbr8L4Nx0upnOAcEGAL3bjYVQ68hQm
 e7q22jP4ODgKUSWVwut/A7VTO4Q4h2oYwgS3yd1/08ZRQpVOkQ22cHeFXbTlmzPrfATel1bJgR
 jghT72D4v7n+l4dJQK0+11JuVyilh6jYRLTvhdUOe934Qo264QwLrM71g6NJ3Ilms3B66qo5YR
 d7TUzdDG60MnbHh21edRbC3Vj5fSF8AEKUTdba7w/5o0enXTdcEFoK7nUaVfduuc7ENqlBv2qo
 oJQ=
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 15 Oct 2019 19:11:44 -0700
IronPort-SDR: K76gbLDhuoZDDJrQCNN13HZ9A5WrcpdSTfKKkwuDeAko/lEyG4+huxLJR/0z9nbqu6QJRm2suA
 EnSYEdDjk0NgfxTDQqzp5K1dG7TxbI+SUrnWfHBG5Hetgj3D8U9z1BKaqkh+nUABL0NjxGoXIJ
 oLlxg4+E/zZVRZazdQKCbd07wM3yVBRJR0t4iBjwqxXysqOBmb8Kyd+IXe44pgrwfv9Cqj2z/+
 /g3ZUQWY+b+gAoRP2I1BLJgNJHlD4T75EPTgesmEXG4mpWq7iSew1u9ZW9VevEVYYfcvKqWWjo
 Sp0FORFCmIKvwPrY6YxUHBHY
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 15 Oct 2019 19:11:44 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 73171473B; Tue, 15 Oct 2019 19:11:44 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>, kernel-team@android.com,
        Mark Salyzyn <salyzyn@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH 1/1] pwm: Convert period and duty cycle to u64
Date:   Tue, 15 Oct 2019 19:11:39 -0700
Message-Id: <1571191899-6150-2-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
References: <1571191899-6150-1-git-send-email-gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Because period and duty cycle are defined as ints with units of
nanoseconds, the maximum time duration that can be set is limited to
~2.147 seconds. Change their definitions to u64 so that higher durations
may be set.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/core.c  |  4 ++--
 drivers/pwm/sysfs.c | 10 +++++-----
 include/linux/pwm.h | 16 ++++++++--------
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6ad51aa..dc79c03 100644
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
index 2389b86..3fb1610 100644
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
@@ -212,7 +212,7 @@ static ssize_t capture_show(struct device *child,
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
+	return sprintf(buf, "%llu %llu\n", result.period, result.duty_cycle);
 }
 
 static DEVICE_ATTR_RW(period);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b2c9c46..1efdd63 100644
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
 
@@ -308,8 +308,8 @@ struct pwm_chip {
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  */
 struct pwm_capture {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 };
 
 #if IS_ENABLED(CONFIG_PWM)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

