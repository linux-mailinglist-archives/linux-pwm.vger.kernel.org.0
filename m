Return-Path: <linux-pwm+bounces-961-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8014883C1BF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A461C1C220DA
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248933D55F;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7798836B0E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184648; cv=none; b=UjvcJl+yaHMBdktptuJhokP5k2DT3vQ2eyg7uUFK2QZNltW7KmuOvQEt3p47py8xpcYQ1jc4a9CG/zNRT7fhhJQ1ISSsK/aZK6VCqP/kB3QkXJOywT1It5hu+9D9uCYGKA2S4cwx/+bVYZDwWEfk6+A0QhE7gpmgMTW1nhpJL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184648; c=relaxed/simple;
	bh=tHGKZTnJcqNcKRH1ScJZo1b556FGwZgwbE8VNoa5nLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r5b887W4YupZJm0Hocxjzh1jtx/6OrUztnjoCmKk3bFafYXx/cFf1jwWHxIbYnLBWoeddKHdld/43RHK8SuaBCwFMULABq7uja6q47dx3s4mgh9Rn7nc1UkYP++/eAb+Ur33NrOUfMNpoaeltd5gqM4JQlPbJFTRlAqTEj66O3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-0003jh-I8; Thu, 25 Jan 2024 13:10:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-002HQ6-5Y; Thu, 25 Jan 2024 13:10:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-007mzZ-0J;
	Thu, 25 Jan 2024 13:10:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 022/111] pwm: pca9685: Store parent device in driver data
Date: Thu, 25 Jan 2024 13:08:44 +0100
Message-ID:  <794ee57ba7a4a1169de2de24e991fd1eec1b43b6.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tHGKZTnJcqNcKRH1ScJZo1b556FGwZgwbE8VNoa5nLY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9TUiSWveqwi6rOcUSkYMF2TunNftMhb+AFp uhbdzoA4baJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPUwAKCRCPgPtYfRL+ TgvvB/4hjr3667gpUgZgmpAtEfevEO2qTRSz0NAuuhJJP7XyXNKu0NcE5MpPWvFg/THNWbbS9su XC7YFDjNdX1RW+rMvcqIgvwfC/bMMwL1CDsUW8Ebmi2ApZAoG2wJTxQhlsoCxI4cFZuBXw8NxTr Q8JWD79S/5EoE9ODAJhEVKSn304VS4ajns5mZiw972Xj4kLlMSPBOUk0NE72B2rKnYJE9cdphQy grh05FDfC0JcX60PdR8/npVhwt5TN/xGonHZSuZKIScIdVTx0LBtSzNA+pqEZcfyQj8WBQLdkN3 jPOzsPmYxR9bt9uhpo6Bwtk+exx9iAYVadDswL9yEjFyIvRx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pca9685.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index e79b1de8c4d8..04e713ef790f 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -79,6 +79,7 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	struct mutex lock;
+	struct device *parent;
 	DECLARE_BITMAP(pwms_enabled, PCA9685_MAXCHAN + 1);
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct gpio_chip gpio;
@@ -109,7 +110,7 @@ static bool pca9685_prescaler_can_change(struct pca9685 *pca, int channel)
 
 static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int *val)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = pca->parent;
 	int err;
 
 	err = regmap_read(pca->regmap, reg, val);
@@ -121,7 +122,7 @@ static int pca9685_read_reg(struct pca9685 *pca, unsigned int reg, unsigned int
 
 static int pca9685_write_reg(struct pca9685 *pca, unsigned int reg, unsigned int val)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = pca->parent;
 	int err;
 
 	err = regmap_write(pca->regmap, reg, val);
@@ -251,7 +252,7 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
 
 	if (pca9685_pwm_test_and_set_inuse(pca, offset))
 		return -EBUSY;
-	pm_runtime_get_sync(pca->chip.dev);
+	pm_runtime_get_sync(pca->parent);
 	return 0;
 }
 
@@ -275,7 +276,7 @@ static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
 	struct pca9685 *pca = gpiochip_get_data(gpio);
 
 	pca9685_pwm_set_duty(pca, offset, 0);
-	pm_runtime_put(pca->chip.dev);
+	pm_runtime_put(pca->parent);
 	pca9685_pwm_clear_inuse(pca, offset);
 }
 
@@ -308,7 +309,7 @@ static int pca9685_pwm_gpio_direction_output(struct gpio_chip *gpio,
  */
 static int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = pca->parent;
 
 	pca->gpio.label = dev_name(dev);
 	pca->gpio.parent = dev;
@@ -345,7 +346,7 @@ static inline int pca9685_pwm_gpio_probe(struct pca9685 *pca)
 
 static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
 {
-	struct device *dev = pca->chip.dev;
+	struct device *dev = pca->parent;
 	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
 				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
 	if (err) {
@@ -373,7 +374,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
 					 PCA9685_COUNTER_RANGE * 1000) - 1;
 	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
-		dev_err(chip->dev, "pwm not changed: period out of bounds!\n");
+		dev_err(pca->parent, "pwm not changed: period out of bounds!\n");
 		return -EINVAL;
 	}
 
@@ -385,7 +386,7 @@ static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	pca9685_read_reg(pca, PCA9685_PRESCALE, &val);
 	if (prescale != val) {
 		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
-			dev_err(chip->dev,
+			dev_err(pca->parent,
 				"pwm not changed: periods of enabled pwms must match!\n");
 			return -EBUSY;
 		}
@@ -482,7 +483,7 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 		mutex_unlock(&pca->lock);
 	}
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pca->parent);
 
 	return 0;
 }
@@ -496,7 +497,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	clear_bit(pwm->hwpwm, pca->pwms_enabled);
 	mutex_unlock(&pca->lock);
 
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pca->parent);
 	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
 }
 
@@ -570,6 +571,7 @@ static int pca9685_pwm_probe(struct i2c_client *client)
 	pca->chip.npwm = PCA9685_MAXCHAN + 1;
 
 	pca->chip.dev = &client->dev;
+	pca->parent = &client->dev;
 
 	ret = pwmchip_add(&pca->chip);
 	if (ret < 0)
-- 
2.43.0


