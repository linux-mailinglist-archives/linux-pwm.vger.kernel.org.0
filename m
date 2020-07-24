Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E7A22D0E9
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 23:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbgGXVhn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 17:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgGXVhl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 17:37:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CEDC0619D3;
        Fri, 24 Jul 2020 14:37:41 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so9093267wmh.4;
        Fri, 24 Jul 2020 14:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=68WPn9Azec2JlDfoJpM6NykYgzwfTUR4vZsC2W/Vl0A=;
        b=PzZCPqrNNr7QU/p8ABDo7x77KzKK7yeAlH+BydGkQqlJshtJVHV7oHggyWGenqi1sG
         1Rz7fU2onQBvi8x12p0M4v0iN99o6T1gi1Yk/DNcx83IYtKSSNje8cb7+BYcG02Ydb7W
         diesQLO0acMXZXx8xYOnCbDkv2IfhVRWX9hKGXdI+zCxl37On/rnjVLRzeX2DrF6O0AI
         WLToDxYqis8PRGOOVzGvt1naRmbDLOJSVnYaMQgx5+BdhbRF9LVL9tSNAF239jy+UAwE
         Ko+HYlNSzlRqxJT3IAUzUKQovrJpl+WsYQbk57OK/aPeW0Khqarh1rZSW4zJg2INXXXb
         gZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=68WPn9Azec2JlDfoJpM6NykYgzwfTUR4vZsC2W/Vl0A=;
        b=IF7Br3essrhFDaA++qWq1JHcX3EQgtM9FjxddPTpv5pgofvA3T1Io0A/T6avvdqjy1
         vwxrQyV+Mh0AANS0S2Mx6VTiMdhlYlabT10kRDJoBa953Li6RfVCcuS1Ase9yyvrX+Vk
         C2KXk5sEHQflVzSYZo1ki1yPnok1f+S6e1jKVbEEcDBai6M0yJPlf6TN4NU0H4NQnv+A
         h8pSfv/7P6VMy4aEyViFF12UYBgMUSMD8lHZ9nMgfGaxz91cB2cCyjBAN70MQs3ELmCL
         bK0L3l6i42OwUSMSnIOIjkmznfF3eQm/JUjv6LV40m6qiv8Gc0bJ+oVACA9VY69nxkTZ
         Rd6w==
X-Gm-Message-State: AOAM533NNiJ4EUGTBVBpkOFhUJvqlP2vlNYVzOl1VgIiMf6/Ba4ILFXa
        d0efSIoCojAtpBGRjxbJ8v8AZY1rcjI=
X-Google-Smtp-Source: ABdhPJw9WWSL99kw6ZlCZqx3kn6SwW0KdxQxr5/VS0sg7sBJoWu1O5HZGOrIWCIOQmnU1YGXka7IvQ==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr9958053wmc.2.1595626660001;
        Fri, 24 Jul 2020 14:37:40 -0700 (PDT)
Received: from TimeMachine.localdomain (bband-dyn34.178-41-255.t-com.sk. [178.41.255.34])
        by smtp.googlemail.com with ESMTPSA id 129sm8853400wmd.48.2020.07.24.14.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:37:39 -0700 (PDT)
From:   Martin Botka <martin.botka1@gmail.com>
Cc:     Fenglin Wu <fenglinw@codeaurora.org>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Martin Botka <martin.botka1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH RFC 2/6] pwm: core: Add option to config PWM duty/period with u64 data length
Date:   Fri, 24 Jul 2020 23:36:52 +0200
Message-Id: <20200724213659.273599-3-martin.botka1@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724213659.273599-1-martin.botka1@gmail.com>
References: <20200724213659.273599-1-martin.botka1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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

Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
[konradybcio@gmail.com: Fast-forward from kernel 4.14 to 5.8]
Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: Martin Botka <martin.botka1@gmail.com>
---
 drivers/pwm/core.c  | 30 +++++++++++------
 drivers/pwm/sysfs.c |  6 ++--
 include/linux/pwm.h | 79 +++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 95 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f3aa44106962..82411e3ccbbb 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -511,12 +511,12 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	    last->period > s2.period &&
 	    last->period <= state->period)
 		dev_warn(chip->dev,
-			 ".apply didn't pick the best available period (requested: %u, applied: %u, possible: %u)\n",
+			 ".apply didn't pick the best available period (requested: %llu, applied: %llu, possible: %llu)\n",
 			 state->period, s2.period, last->period);
 
 	if (state->enabled && state->period < s2.period)
 		dev_warn(chip->dev,
-			 ".apply is supposed to round down period (requested: %u, applied: %u)\n",
+			 ".apply is supposed to round down period (requested: %llu, applied: %llu)\n",
 			 state->period, s2.period);
 
 	if (state->enabled &&
@@ -525,14 +525,14 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	    last->duty_cycle > s2.duty_cycle &&
 	    last->duty_cycle <= state->duty_cycle)
 		dev_warn(chip->dev,
-			 ".apply didn't pick the best available duty cycle (requested: %u/%u, applied: %u/%u, possible: %u/%u)\n",
+			 ".apply didn't pick the best available duty cycle (requested: %llu/%llu, applied: %llu/%llu, possible: %llu/%llu)\n",
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period,
 			 last->duty_cycle, last->period);
 
 	if (state->enabled && state->duty_cycle < s2.duty_cycle)
 		dev_warn(chip->dev,
-			 ".apply is supposed to round down duty_cycle (requested: %u/%u, applied: %u/%u)\n",
+			 ".apply is supposed to round down duty_cycle (requested: %llu/%llu, applied: %llu/%llu)\n",
 			 state->duty_cycle, state->period,
 			 s2.duty_cycle, s2.period);
 
@@ -559,7 +559,7 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	    (s1.enabled && s1.period != last->period) ||
 	    (s1.enabled && s1.duty_cycle != last->duty_cycle)) {
 		dev_err(chip->dev,
-			".apply is not idempotent (ena=%d pol=%d %u/%u) -> (ena=%d pol=%d %u/%u)\n",
+			".apply is not idempotent (ena=%d pol=%d %llu/%llu) -> (ena=%d pol=%d %llu/%llu)\n",
 			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
 			last->enabled, last->polarity, last->duty_cycle,
 			last->period);
@@ -655,9 +655,19 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
-			err = chip->ops->config(pwm->chip, pwm,
-						state->duty_cycle,
-						state->period);
+			if (pwm->chip->ops->config_extend) {
+					err = pwm->chip->ops->config_extend(pwm->chip,
+								pwm, state->duty_cycle,
+								state->period);
+			} else {
+				if (state->period > UINT_MAX)
+					pr_warn("period %llu duty_cycle %llu will be truncated\n",
+								state->period,
+								state->duty_cycle);
+				err = pwm->chip->ops->config(pwm->chip, pwm,
+								state->duty_cycle,
+								state->period);
+			}
 			if (err)
 				return err;
 
@@ -1310,8 +1320,8 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		if (state.enabled)
 			seq_puts(s, " enabled");
 
-		seq_printf(s, " period: %u ns", state.period);
-		seq_printf(s, " duty: %u ns", state.duty_cycle);
+		seq_printf(s, " period: %llu ns", state.period);
+		seq_printf(s, " duty: %llu ns", state.duty_cycle);
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 4ee1e81db0bc..f9d7ebfb48f4 100644
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
index 10a102efadc4..ab235007287f 100644
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
@@ -138,12 +138,30 @@ static inline void pwm_set_period(struct pwm_device *pwm, unsigned int period)
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
 
@@ -153,12 +171,30 @@ static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
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
 
@@ -296,6 +332,8 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  *	       registered.
  * @owner: helps prevent removal of modules exporting active PWMs
  * @config: configure duty cycles and period length for this PWM
+ * @config_extend: configure duty cycles and period length for this
+ *	       PWM with u64 data type
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
@@ -317,6 +355,8 @@ struct pwm_ops {
 	/* Only used by legacy drivers */
 	int (*config)(struct pwm_chip *chip, struct pwm_device *pwm,
 		      int duty_ns, int period_ns);
+	int (*config_extend)(struct pwm_chip *chip, struct pwm_device *pwm,
+		      u64 duty_ns, u64 period_ns);
 	int (*set_polarity)(struct pwm_chip *chip, struct pwm_device *pwm,
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
@@ -362,8 +402,8 @@ struct pwm_chip {
  * @duty_cycle: duty cycle of the PWM signal (in nanoseconds)
  */
 struct pwm_capture {
-	unsigned int period;
-	unsigned int duty_cycle;
+	u64 period;
+	u64 duty_cycle;
 };
 
 #if IS_ENABLED(CONFIG_PWM)
@@ -415,6 +455,31 @@ static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 	return pwm_apply_state(pwm, &state);
 }
 
+/*
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
 /**
  * pwm_enable() - start a PWM output toggling
  * @pwm: PWM device
-- 
2.27.0

