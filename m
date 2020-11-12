Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A32972B0A9B
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 17:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgKLQpm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 11:45:42 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:46386 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729260AbgKLQpl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Nov 2020 11:45:41 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 6F0BDC7D0FA;
        Thu, 12 Nov 2020 17:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605199111;
        bh=cIIJ3PiWJn6aNmb5SCNmZ1PfYOyHc3UB+Hid0B9eiTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmpRwnjnuXlSABAUlyHfI14K20P9aqUTBjtQftWBSZSnMSsfP/jMxKJ24PpLFnJ0d
         WUInu+s3Cgh3N6BFfnpyzNYt2pZBX9ocvtIiXnJCErGi8PTcE/0gGd36bKswL6hiyv
         64iQd6kfgD5l0YALHBBfDb954uUVDN/ceHS4m4FI=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 2/2] pwm: pca9685: support staggered output ON times
Date:   Thu, 12 Nov 2020 17:37:51 +0100
Message-Id: <20201112163751.204187-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112163751.204187-1-clemens.gruber@pqgruber.com>
References: <20201112163751.204187-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PCA9685 supports staggered LED output ON times to minimize current
surges and reduce EMI.
When this new option is enabled, the ON times of each channel are
delayed by channel number x counter range / 16, which avoids asserting
all enabled outputs at the same counter value while still maintaining
the configured duty cycle of each output.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index df214758256e..b993231ebb5e 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -75,6 +75,7 @@ struct pca9685 {
 	struct pwm_chip chip;
 	struct regmap *regmap;
 	int period_ns;
+	bool staggered_outputs;
 #if IS_ENABLED(CONFIG_GPIOLIB)
 	struct mutex lock;
 	struct gpio_chip gpio;
@@ -251,6 +252,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct pca9685 *pca = to_pca(chip);
 	unsigned long long duty;
+	unsigned int on, off;
 	unsigned int reg;
 	int prescale;
 
@@ -286,6 +288,32 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	duty = (PCA9685_COUNTER_RANGE - 1) * (unsigned long long)duty_ns;
 	duty = DIV_ROUND_UP_ULL(duty, period_ns);
 
+	if (pca->staggered_outputs && pwm->hwpwm < PCA9685_MAXCHAN) {
+		if (duty_ns > 0) {
+			/*
+			 * To reduce EMI, the ON times of each channel are
+			 * spread out evenly within the counter range, while
+			 * still maintaining the configured duty cycle
+			 */
+			on = pwm->hwpwm * PCA9685_COUNTER_RANGE /
+				PCA9685_MAXCHAN;
+			off = (on + duty) % PCA9685_COUNTER_RANGE;
+			regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm),
+				     on & 0xff);
+			regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm),
+				     (on >> 8) & 0xf);
+			regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm),
+				     off & 0xff);
+			regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
+				     (off >> 8) & 0xf);
+			return 0;
+		}
+
+		/* Clear ON times */
+		regmap_write(pca->regmap, LED_N_ON_L(pwm->hwpwm), 0);
+		regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), 0);
+	}
+
 	if (pwm->hwpwm >= PCA9685_MAXCHAN)
 		reg = PCA9685_ALL_LED_OFF_L;
 	else
@@ -416,6 +444,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
 	regmap_write(pca->regmap, PCA9685_MODE1, reg);
 
+	pca->staggered_outputs = device_property_read_bool(
+		&client->dev, "staggered-outputs");
+
 	/* Clear all "full off" bits */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
-- 
2.29.2

