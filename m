Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4E89DEA2E
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 12:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfJUK5q (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 06:57:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45132 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbfJUK5q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 06:57:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id q13so8436523wrs.12
        for <linux-pwm@vger.kernel.org>; Mon, 21 Oct 2019 03:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LGKZY/IUiUO+2uYTzAHQ0rrYcK00zgUZpnSA7MuBH8Y=;
        b=Po1yI6dCYha299HufnChjcwwTMIf04UtPqwYjI3+aENtiYRn28jjr1Hy6bjLURWwEg
         9jKkvJJYjLQN74TmmoPlO4KjpUuZ6TCfIhzQEYiJ92YW6yjx2SlGwlPmyUTDbYxA7wg+
         aFKOBExSvs5ZQ5dz0iz219iG7iGaUukH988WF8nWVFBzDizw7HeXwDH92JjF47KN17q8
         pTEzuaLYYqEwif/o/84YA+DZjcSocEVqUuC4DDl8rP9DM2blkkRV/c0e26DO/tiJICC/
         N9Z5SMjTJp+vUx0Zb9WUTMVV8cPHX0VuEH+1bV7kCYwTSw84fhBxJkWa6E94Xoxn72AN
         shRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LGKZY/IUiUO+2uYTzAHQ0rrYcK00zgUZpnSA7MuBH8Y=;
        b=sldFaKIq8P/4bV0nUM4hxQu84+Bw5KqcA5KLDaFX7CNXV+C9k4DIFni4eIxPMlpHKL
         nrHZ9CObfP9NcdIcMdeItNDtEuoxHGNZJVZ7m1SmIJZeA6dd5TPcehEhxkq0PQ8PzDxh
         jtgbV4FbC6s3zQ5XpKTS8zFhkUtM7piUrJgQO2Pckdg86OpbZ58j9dM22uuzYNANt3Gm
         1SAJYMb/VYFaXw7/ZxZbrZyvbeCrjg4YDZhiB6ppR17bEZzKOoTAgEN/z1uqiqrl56ce
         CzaThGWvwD9q4Aph8aOTs3G70xU6hkZYm4xmPO9L/BNd4y9Xy+S7yo+4mxCokVc5Sa47
         Wcng==
X-Gm-Message-State: APjAAAUzn+LEkMJh2xfI/fe6b+LOuBP6Rrehgd6zaxfufvrwVhY0mmfV
        FQr1Zza5c3bbEUgUBoK3k5s=
X-Google-Smtp-Source: APXvYqwyPBXXMSaujR7KAfnqVvM02q0ZOiR5Zdn09CvdZ5DS1l+2T2h5aNHdr3Gms59w+uPJ1wfrzQ==
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr14374076wrn.34.1571655463884;
        Mon, 21 Oct 2019 03:57:43 -0700 (PDT)
Received: from localhost (p2E5BE2CE.dip0.t-ipconnect.de. [46.91.226.206])
        by smtp.gmail.com with ESMTPSA id q11sm4149887wmq.21.2019.10.21.03.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 03:57:42 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH 2/4] pwm: cros-ec: Cache duty cycle value
Date:   Mon, 21 Oct 2019 12:57:37 +0200
Message-Id: <20191021105739.1357629-2-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191021105739.1357629-1-thierry.reding@gmail.com>
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The ChromeOS embedded controller doesn't differentiate between disabled
and duty cycle being 0. In order not to potentially confuse consumers,
cache the duty cycle and return the cached value instead of the real
value when the PWM is disabled.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
 drivers/pwm/pwm-cros-ec.c | 58 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d217..09c08dee099e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -25,11 +25,39 @@ struct cros_ec_pwm_device {
 	struct pwm_chip chip;
 };
 
+/**
+ * struct cros_ec_pwm - per-PWM driver data
+ * @duty_cycle: cached duty cycle
+ */
+struct cros_ec_pwm {
+	u16 duty_cycle;
+};
+
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 {
 	return container_of(c, struct cros_ec_pwm_device, chip);
 }
 
+static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct cros_ec_pwm *channel;
+
+	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
+	if (!channel)
+		return -ENOMEM;
+
+	pwm_set_chip_data(pwm, channel);
+
+	return 0;
+}
+
+static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
+
+	kfree(channel);
+}
+
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 {
 	struct {
@@ -96,7 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
-	int duty_cycle;
+	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
+	u16 duty_cycle;
+	int ret;
 
 	/* The EC won't let us change the period */
 	if (state->period != EC_PWM_MAX_DUTY)
@@ -108,13 +138,20 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	duty_cycle = state->enabled ? state->duty_cycle : 0;
 
-	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
+	if (ret < 0)
+		return ret;
+
+	channel->duty_cycle = state->duty_cycle;
+
+	return 0;
 }
 
 static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 				  struct pwm_state *state)
 {
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
+	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
 	int ret;
 
 	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
@@ -126,8 +163,19 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	state->enabled = (ret > 0);
 	state->period = EC_PWM_MAX_DUTY;
 
-	/* Note that "disabled" and "duty cycle == 0" are treated the same */
-	state->duty_cycle = ret;
+	/*
+	 * Note that "disabled" and "duty cycle == 0" are treated the same. If
+	 * the cached duty cycle is not zero, used the cached duty cycle. This
+	 * ensures that the configured duty cycle is kept across a disable and
+	 * enable operation and avoids potentially confusing consumers.
+	 *
+	 * For the case of the initial hardware readout, channel->duty_cycle
+	 * will be 0 and the actual duty cycle read from the EC is used.
+	 */
+	if (ret == 0 && channel->duty_cycle > 0)
+		state->duty_cycle = channel->duty_cycle;
+	else
+		state->duty_cycle = ret;
 }
 
 static struct pwm_device *
@@ -149,6 +197,8 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
 }
 
 static const struct pwm_ops cros_ec_pwm_ops = {
+	.request = cros_ec_pwm_request,
+	.free = cros_ec_pwm_free,
 	.get_state	= cros_ec_pwm_get_state,
 	.apply		= cros_ec_pwm_apply,
 	.owner		= THIS_MODULE,
-- 
2.23.0

