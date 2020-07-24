Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313DE22D0E1
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jul 2020 23:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgGXVho (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jul 2020 17:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgGXVhg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jul 2020 17:37:36 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE0AC0619D3;
        Fri, 24 Jul 2020 14:37:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r12so9455710wrj.13;
        Fri, 24 Jul 2020 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=28LwBVVwVsushQlU82bqzuuA+Tc52p+PHMn6Y1UPBXA=;
        b=IIkgFyxoP1n8od4RxMqeCJt+yUvFfzM1pny3lFx0E1EkpgRYoB/sTL4aeoh+wtwSN0
         psOqFJRWFwYfuMX4lrcONhq+UhzboqDSDw8bVkxKdOPxfJo+oA8KDUnu6br0yrbkbjr6
         uTpZkZu4WGuFRUljMPb9S4sgXcL+HMCjVB+Yj0oT6PERMeD7qyoK9zxRV+Wiqpf0vIns
         yEGf90bia0aoXFVNobTY1gojVxC9Gp3OuOT3REMfR7NmLJldRZOuRHhiUNl3KZNKDpoK
         vf1rKOYYNiqj+GXkYJjNTYae6CsUHiPyvo7EPworedFtUwrEIDd1bP4tUtLpowRiC1FV
         9LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=28LwBVVwVsushQlU82bqzuuA+Tc52p+PHMn6Y1UPBXA=;
        b=ZmD9OP9G8vH8Kbtvg9dbWcicMwhCfxdgXo3NrelucTlpk3I8eIkDYpiZTfAfGv7zv9
         UVkinIHI4QPZzeWzcc4ed6LOp+jO3dokC38F/pOpyxLEN5XY/1XRcQy4r+gcfoM5UWmK
         peO0ijnitB+Z8CcMyjFkqTovXfl8VldQtpn7osoeTeHp5yfwOWyCSxeNAVJQ2aJbNr2D
         fTTCLWokLWomElX+HIVqrytnMzyfblaOfIJlpd7Tw6jxky6VuCjDC/GTrbmo5nKvVFhs
         4OvdXS9rGfpEQZkHoldjBwSg40KlDfLXkgFReyiWN5fSmuhIRJMg6MeigQwk1f99Xe11
         t6kg==
X-Gm-Message-State: AOAM531I4YRD6pvMjlea5yk7eNC172b7xnKi8NeFmmi+U9/LZdVXKpZL
        2MCyyXxklMKJV3r1vaEQdcfKN0qXvsE=
X-Google-Smtp-Source: ABdhPJyNyzR29bgCpxN8HwTQ+ReHU7rD7rFFaMrqwael6mx25KFpZl0rjagzwKKdB8n+1LKlZCKEoA==
X-Received: by 2002:adf:a192:: with SMTP id u18mr11209840wru.158.1595626655009;
        Fri, 24 Jul 2020 14:37:35 -0700 (PDT)
Received: from TimeMachine.localdomain (bband-dyn34.178-41-255.t-com.sk. [178.41.255.34])
        by smtp.googlemail.com with ESMTPSA id 129sm8853400wmd.48.2020.07.24.14.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2020 14:37:34 -0700 (PDT)
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
Subject: [PATCH RCC 1/6] pwm: Add different PWM output types support
Date:   Fri, 24 Jul 2020 23:36:51 +0200
Message-Id: <20200724213659.273599-2-martin.botka1@gmail.com>
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

Normally, PWM channel has fixed output until software request to change
its settings. There are some PWM devices which their outputs could be
changed autonomously according to a predefined pattern programmed in
hardware. Add pwm_output_type enum type to identify these two different
PWM types and add relevant helper functions to set and get PWM output
types and pattern.

Signed-off-by: Fenglin Wu <fenglinw@codeaurora.org>
[konradybcio@gmail.com: Fast-forward from kernel 4.14 to 5.8]
Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
Signed-off-by: Martin Botka <martin.botka1@gmail.com>
---
 drivers/pwm/core.c  | 26 +++++++++++++++++
 drivers/pwm/sysfs.c | 50 ++++++++++++++++++++++++++++++++
 include/linux/pwm.h | 69 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 004b2ea9b5fd..f3aa44106962 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -304,6 +304,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->pwm = chip->base + i;
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
+		pwm->state.output_type = PWM_OUTPUT_FIXED;
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -627,6 +628,31 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 			pwm->state.polarity = state->polarity;
 		}
 
+		if (state->output_type != pwm->state.output_type) {
+			if (!pwm->chip->ops->set_output_type)
+				return -ENOTSUPP;
+
+			err = pwm->chip->ops->set_output_type(pwm->chip, pwm,
+										state->output_type);
+			if (err)
+				return err;
+
+			pwm->state.output_type = state->output_type;
+		}
+
+		if (state->output_pattern != pwm->state.output_pattern &&
+						state->output_pattern != NULL) {
+			if (!pwm->chip->ops->set_output_pattern)
+				return -ENOTSUPP;
+
+			err = pwm->chip->ops->set_output_pattern(pwm->chip,
+								pwm, state->output_pattern);
+			if (err)
+				return err;
+
+			pwm->state.output_pattern = state->output_pattern;
+		}
+
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
 			err = chip->ops->config(pwm->chip, pwm,
diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
index 2389b8669846..4ee1e81db0bc 100644
--- a/drivers/pwm/sysfs.c
+++ b/drivers/pwm/sysfs.c
@@ -215,11 +215,60 @@ static ssize_t capture_show(struct device *child,
 	return sprintf(buf, "%u %u\n", result.period, result.duty_cycle);
 }
 
+static ssize_t output_type_show(struct device *child,
+							struct device_attribute *attr,
+							char *buf)
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
+								struct device_attribute *attr,
+								const char *buf, size_t size)
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
@@ -227,6 +276,7 @@ static struct attribute *pwm_attrs[] = {
 	&dev_attr_enable.attr,
 	&dev_attr_polarity.attr,
 	&dev_attr_capture.attr,
+	&dev_attr_output_type.attr,
 	NULL
 };
 ATTRIBUTE_GROUPS(pwm);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 2635b2a55090..10a102efadc4 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -48,6 +48,29 @@ enum {
 	PWMF_EXPORTED = 1 << 1,
 };
 
+/*
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
+/*
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
 
@@ -146,6 +171,26 @@ static inline enum pwm_polarity pwm_get_polarity(const struct pwm_device *pwm)
 	return state.polarity;
 }
 
+static inline enum pwm_output_type pwm_get_output_type(
+				const struct pwm_device *pwm)
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
@@ -254,6 +299,9 @@ pwm_set_relative_duty_cycle(struct pwm_state *state, unsigned int duty_cycle,
  * @set_polarity: configure the polarity of this PWM
  * @enable: enable PWM output toggling
  * @disable: disable PWM output toggling
+ * @get_output_type_supported: get the supported output type
+ * @set_output_type: set PWM output type
+ * @set_output_pattern: set the pattern for the modulated output
  */
 struct pwm_ops {
 	int (*request)(struct pwm_chip *chip, struct pwm_device *pwm);
@@ -273,6 +321,13 @@ struct pwm_ops {
 			    enum pwm_polarity polarity);
 	int (*enable)(struct pwm_chip *chip, struct pwm_device *pwm);
 	void (*disable)(struct pwm_chip *chip, struct pwm_device *pwm);
+	int (*get_output_type_supported)(struct pwm_chip *chip,
+			    struct pwm_device *pwm);
+	int (*set_output_type)(struct pwm_chip *chip, struct pwm_device *pwm,
+			    enum pwm_output_type output_type);
+	int (*set_output_pattern)(struct pwm_chip *chip,
+			    struct pwm_device *pwm,
+			    struct pwm_output_pattern *output_pattern);
 };
 
 /**
@@ -318,6 +373,20 @@ void pwm_free(struct pwm_device *pwm);
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
+/*
+ * pwm_output_type_support()
+ * @pwm: PWM device
+ *
+ * Returns:  output types supported by the PWM device
+ */
+static inline int pwm_get_output_type_supported(struct pwm_device *pwm)
+{
+	if (pwm->chip->ops->get_output_type_supported != NULL)
+		return pwm->chip->ops->get_output_type_supported(pwm->chip, pwm);
+	else
+		return PWM_OUTPUT_FIXED;
+}
+
 /**
  * pwm_config() - change a PWM device configuration
  * @pwm: PWM device
-- 
2.27.0

