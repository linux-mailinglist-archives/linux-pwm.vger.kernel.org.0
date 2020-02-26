Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DB1700A6
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 15:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBZOAO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 09:00:14 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:30248 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727470AbgBZOAN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 09:00:13 -0500
IronPort-SDR: gbVhfIABwRAaGzo5z9nA3wIaeDXV9+zgCVWCraMP7njrPIOeyo3CV0DcUalJIaQ6+j/uDL5dvK
 1kYB9vEjSGbE7wtjR3lGQydCFoKXb3sbNrNo9QQA2q248Ncei1c8OrRtDG+eE8QJ2PFnfIZ9V6
 sRU+GOJoXxQK1BVZ81uh0GGcqV518YZn2NkpAc1ZLt5nf4gnCxWsAnOIirsFQp+HUhdIif5Qil
 jVn0YF8BqQI3vn0UKskXlfGrbzlgy6eps8XcszyosaDbXgtFDX7If6TraLqWwFnELqp6k+zNIp
 vc8=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120528"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 14:53:02 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 14:53:02 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 14:53:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582725182; x=1614261182;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=9V8+JzvNSjdZ1QyjAXX7GSR1pLWlEW6lGUK2vTELh0E=;
  b=hQmBpSvExa/ft9maOBPMlx0kRasdrxUH6G3yIF/XizGMBWIGUJ7wFTwA
   CxtJbXAWf/Y0M/9XuZBQa91rXARH1lG+zXhbVfUHbEdAyr40of0y7OMTe
   YEmfYxWTOCtHAH2te8YhGh5pp5YeL0nZx8DDlY6HJp9BdPIXxEpUfzISE
   J8RYNeVJDxUg1F64X8ffzRYNHXOe5N36GQ2lt7Mnz7NCWsA032CLxQdkJ
   Co+F1VJaWbfGpYUE2R2TuamxE9thPIIk9NY0k7thJW/HKCyrHnLKZg2YX
   kMbE202osMDHRxEb1ZEMb3pp8qRz6ekM2M8WzQ+xSOkNlK+D3EqhlDnRJ
   Q==;
IronPort-SDR: 7aNfk6zmaYUJEBGSCRKBfuBfIYdEOMYFtu9OZAqSik/P5RoqOJv1NOPDXQxxux+R6E+mzWAvEe
 m4AbMfyJ//rdegIdlNCnCblqMFJedHjL6oVIsAF6tdBoZ1q2nYtVR1uP2VoY2EsKCfPpiHrfUt
 RTVRuFZNA6ohOsseVOGfzry9xwT19MzNfWQRpq+c0BYRhPst98bIMp24pjxK0pC3ne6LehMct8
 BoJcVcI2AtkSA4XarW+VPY2Ctl/roO82eVNbdR5g5Bf8Nfmpt1x1kJrZjnsNPWYP4qWrLJ8p9+
 fjE=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120527"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 14:53:02 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 836D4280065;
        Wed, 26 Feb 2020 14:53:08 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 4/4] pwm: pca9685: migrate config/enable/disable to apply
Date:   Wed, 26 Feb 2020 14:52:29 +0100
Message-Id: <20200226135229.24929-4-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For consistency with disabled state, initialize all LEDs in FULL_OFF
state during probe.

This also fixes a broken interaction between config with 100% duty cycle
(which would set the LED to FULL_ON) and enable (which would unset
FULL_ON), effectively disabling the LED again when enable was called
after config. This behaviour was observed with the leds-pwm driver when
directly switching from 0 to maximum brightness.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 53 +++++++++++----------------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 370691b21107..e266cbbd39bf 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -219,15 +219,16 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 	}
 }
 
-static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			      int duty_ns, int period_ns)
+static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
 	int prescale;
 
-	if (period_ns != pca->period_ns) {
-		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
+	if (state->period != pca->period_ns) {
+		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ *
+					     state->period,
 					     PCA9685_COUNTER_RANGE * 1000) - 1;
 
 		if (prescale >= PCA9685_PRESCALE_MIN &&
@@ -247,7 +248,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			/* Wake the chip up */
 			pca9685_set_sleep_mode(pca, false);
 
-			pca->period_ns = period_ns;
+			pca->period_ns = state->period;
 		} else {
 			dev_err(chip->dev,
 				"prescaler not set: period out of bounds!\n");
@@ -255,13 +256,13 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-	if (duty_ns < 1) {
+	if (!state->enabled || state->duty_cycle < 1) {
+		/* Set the full OFF bit */
 		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
-
 		return 0;
 	}
 
-	if (duty_ns == period_ns) {
+	if (state->duty_cycle == state->period) {
 		/* Clear both OFF registers */
 		regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
 		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0x0);
@@ -272,8 +273,8 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
-	duty = DIV_ROUND_UP_ULL(duty, period_ns);
+	duty = PCA9685_COUNTER_RANGE * (unsigned long long)state->duty_cycle;
+	duty = DIV_ROUND_UP_ULL(duty, state->period);
 
 	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), (int)duty & 0xff);
 	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
@@ -285,29 +286,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-
-	/*
-	 * Clear the full-off bit.
-	 * It has precedence over the others and must be off.
-	 */
-	regmap_update_bits(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL, 0x0);
-
-	return 0;
-}
-
-static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pca9685 *pca = to_pca(chip);
-
-	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
-
-	/* Clear the LED_OFF counter. */
-	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
-}
-
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -321,14 +299,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pca9685_pwm_disable(chip, pwm);
 	pm_runtime_put(chip->dev);
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
-	.enable = pca9685_pwm_enable,
-	.disable = pca9685_pwm_disable,
-	.config = pca9685_pwm_config,
+	.apply = pca9685_pwm_apply,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
@@ -377,9 +352,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
 
-	/* clear all "full off" bits */
+	/* Set all LEDs full off */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
 
 	/*
 	 * The PWM subsystem does not support a pre-delay.
-- 
2.17.1

