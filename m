Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4512DB5DD
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 22:29:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgLOV3S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 16:29:18 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:54806 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgLOV3D (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Dec 2020 16:29:03 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 6D531C727E5;
        Tue, 15 Dec 2020 22:28:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608067698;
        bh=wke4oDo2nWqDUCqwQBkNnTYrwLML1pZG+thQsTK+htE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pS5ZwXvdZ0u5XeIB/Fpm9cElQh/heQDO9aUrF52eFiiaykP9r8o9+/g83sRsMNehB
         wUv0ZY7Iej+W7LIXCyC4n3/dnL/mYsD69QELvy1cWhxrmJ/er5K1uBHPAt54y/OM4X
         0P5GnMUZMoe/P0zo4S/WVemX7pumJaxJKhjyZGLY=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v5 4/7] pwm: pca9685: Reset registers to POR state in probe
Date:   Tue, 15 Dec 2020 22:22:25 +0100
Message-Id: <20201215212228.185517-4-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Reset the prescale and ON/OFF registers to their POR default state in
the probe function. Otherwise, the PWMs could still be active after a
watchdog reset and reboot, etc.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 7b14447f3c05..38aadaf50996 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -47,6 +47,7 @@
 #define PCA9685_ALL_LED_OFF_H	0xFD
 #define PCA9685_PRESCALE	0xFE
 
+#define PCA9685_PRESCALE_DEF	0x1E	/* => default frequency of ~200 Hz */
 #define PCA9685_PRESCALE_MIN	0x03	/* => max. frequency of 1526 Hz */
 #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
 
@@ -446,9 +447,11 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
 	regmap_write(pca->regmap, PCA9685_MODE1, reg);
 
-	/* Clear all "full off" bits */
+	/* Reset ON/OFF registers to HW defaults (only full OFF bit is set) */
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
-	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
+	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
 
 	pca->chip.ops = &pca9685_pwm_ops;
 	/* Add an extra channel for ALL_LED */
@@ -470,8 +473,10 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	/*
 	 * The chip comes out of power-up in the sleep state,
 	 * but force it to sleep in case it was woken up before
+	 * and set the default prescale value
 	 */
 	pca9685_set_sleep_mode(pca, true);
+	regmap_write(pca->regmap, PCA9685_PRESCALE, PCA9685_PRESCALE_DEF);
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_enable(&client->dev);
 
-- 
2.29.2

