Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE001700A4
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 15:00:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgBZOAM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 09:00:12 -0500
Received: from mx1.tq-group.com ([62.157.118.193]:54865 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727341AbgBZOAM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Feb 2020 09:00:12 -0500
X-Greylist: delayed 427 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Feb 2020 09:00:10 EST
IronPort-SDR: 4PsY5DWDmYFZByLAkbU5eJJAp0Zc2NWUJGwDzvBqefTDK8sqWHuQz9V1kVOiEpiMl+ErTp34qJ
 2F/Shicsw21zbY6aC2lesL1x+1s2tGq+TsGwgKQYLByDZnDwCrprtCtyWUjW8K9BR9tYItM+kF
 C+B4zmQhP1ZLZ8kesMAbwO7I3wA8l+IwTA9voHJrKGTVVNuyl9XXxwRgUc9fPQvF9ehqVL1vaR
 Qb19qYrvsC2vcp0HhwG7JqY7VO1aFJ4+ZBeNXJeouoT1n/O8pJds0QtlG/5Fg9UfJUL8JZgW/T
 MTw=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120524"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 26 Feb 2020 14:53:01 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 26 Feb 2020 14:53:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1582725181; x=1614261181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Jtc891/T9/iN8OY26dOxdRRo+Y7PwF0rMOigWD7Fg08=;
  b=IYy+PT+dchWJ9Ec42GMAX/YAQG7j09J8akE5a4WU/UBQiiodRptD6/aN
   KWthUWjSsbS6OW2FpNSTLbsJfc7+GQs5bMsGaxLWSjDX40aMoXqRBmekz
   2h1m+VO9Wmbgo4JAGNRA/MHAR0ZdfVo9tLeysnCs64VR+qcrzCgHk2zon
   0TJrDE2KaQtOei5yUUKZUaUDhpUUkSSOzCoMhzw2iL76igXbpLGsJ4OzA
   WyhCYkwUZWCIsNnNjgGPgDTsakSl1RK72QAGm8zbPe9csBZnY+5jaK3F2
   BXhzHGHpjCBaBC6wzFZtnt9IjeSZq5cELyX4ikZo6LjfEtFQJAuL9U8ut
   g==;
IronPort-SDR: G0432jY/PTAMY+re6FUmDwXujS8X4tuHivg/jrdgJitp+QDcicXthfcS6S35aC8qufNVaM8mol
 szD4qjcNpBuyvQfZD0O2HPMVbT07G2tyxWhIRcTE6ocWfzIddF0wgisij75fWqIiQ0oFZez2Cn
 l0DYaDCA42oN63khGiYUYqzEGtDOUI7CQnECxqc2TZauafCb+fx7p88e3XWy8iZgHFhtfUng8F
 bOM5WnNPWf2Gu2K6R9iQ/5rYdsOLxwXuuBkH/T85RaaPA2lNo5P8l+4Ylc7P7g48gqJ3alsNyP
 fqM=
X-IronPort-AV: E=Sophos;i="5.70,488,1574118000"; 
   d="scan'208";a="11120523"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 26 Feb 2020 14:53:01 +0100
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3EB2A280075;
        Wed, 26 Feb 2020 14:53:08 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 2/4] pwm: pca9685: remove ALL_LED PWM channel
Date:   Wed, 26 Feb 2020 14:52:27 +0100
Message-Id: <20200226135229.24929-2-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The interaction of the ALL_LED PWM channel with the other channels was
not well-defined. As the ALL_LED feature does not seem very useful and
it was making the code significantly more complex, simply remove it.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/pwm/pwm-pca9685.c | 115 ++++++--------------------------------
 1 file changed, 17 insertions(+), 98 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 19ac97108a64..393ab92aa945 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -105,27 +105,12 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 static bool pca9685_pwm_is_gpio(struct pca9685 *pca, struct pwm_device *pwm)
 {
-	bool is_gpio = false;
+	bool is_gpio;
 
 	mutex_lock(&pca->lock);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
-		unsigned int i;
-
-		/*
-		 * Check if any of the GPIOs are requested and in that case
-		 * prevent using the "all LEDs" channel.
-		 */
-		for (i = 0; i < pca->gpio.ngpio; i++)
-			if (gpiochip_is_requested(&pca->gpio, i)) {
-				is_gpio = true;
-				break;
-			}
-	} else if (pwm_get_chip_data(pwm)) {
-		is_gpio = true;
-	}
-
+	is_gpio = !!pwm_get_chip_data(pwm);
 	mutex_unlock(&pca->lock);
+
 	return is_gpio;
 }
 
@@ -239,7 +224,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
-	unsigned int reg;
 	int prescale;
 
 	if (period_ns != pca->period_ns) {
@@ -272,39 +256,18 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_ns < 1) {
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_H;
-		else
-			reg = LED_N_OFF_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, LED_FULL);
+		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
 
 		return 0;
 	}
 
 	if (duty_ns == period_ns) {
 		/* Clear both OFF registers */
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_L;
-		else
-			reg = LED_N_OFF_L(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, 0x0);
-
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_OFF_H;
-		else
-			reg = LED_N_OFF_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, 0x0);
+		regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
+		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0x0);
 
 		/* Set the full ON bit */
-		if (pwm->hwpwm >= PCA9685_MAXCHAN)
-			reg = PCA9685_ALL_LED_ON_H;
-		else
-			reg = LED_N_ON_H(pwm->hwpwm);
-
-		regmap_write(pca->regmap, reg, LED_FULL);
+		regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), LED_FULL);
 
 		return 0;
 	}
@@ -312,27 +275,12 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
 	duty = DIV_ROUND_UP_ULL(duty, period_ns);
 
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_L;
-	else
-		reg = LED_N_OFF_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, (int)duty & 0xff);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
+	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), (int)duty & 0xff);
+	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
+		     ((int)duty >> 8) & 0xf);
 
 	/* Clear the full ON bit, otherwise the set OFF time has no effect */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_H;
-	else
-		reg = LED_N_ON_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
+	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
 
 	return 0;
 }
@@ -340,36 +288,19 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
-	unsigned int reg;
 
 	/*
 	 * The PWM subsystem does not support a pre-delay.
 	 * So, set the ON-timeout to 0
 	 */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_L;
-	else
-		reg = LED_N_ON_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_ON_H;
-	else
-		reg = LED_N_ON_H(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0);
+	regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
+	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
 
 	/*
 	 * Clear the full-off bit.
 	 * It has precedence over the others and must be off.
 	 */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
-
-	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
+	regmap_update_bits(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL, 0x0);
 
 	return 0;
 }
@@ -377,22 +308,11 @@ static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
-	unsigned int reg;
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_H;
-	else
-		reg = LED_N_OFF_H(pwm->hwpwm);
 
-	regmap_write(pca->regmap, reg, LED_FULL);
+	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
 
 	/* Clear the LED_OFF counter. */
-	if (pwm->hwpwm >= PCA9685_MAXCHAN)
-		reg = PCA9685_ALL_LED_OFF_L;
-	else
-		reg = LED_N_OFF_L(pwm->hwpwm);
-
-	regmap_write(pca->regmap, reg, 0x0);
+	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
 }
 
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -469,8 +389,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
 
 	pca->chip.ops = &pca9685_pwm_ops;
-	/* add an extra channel for ALL_LED */
-	pca->chip.npwm = PCA9685_MAXCHAN + 1;
+	pca->chip.npwm = PCA9685_MAXCHAN;
 
 	pca->chip.dev = &client->dev;
 	pca->chip.base = -1;
-- 
2.17.1

