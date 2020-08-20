Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 086AB24BAF5
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Aug 2020 14:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgHTMUy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 08:20:54 -0400
Received: from protonic.xs4all.nl ([83.163.252.89]:41918 "EHLO
        protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgHTMUs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Aug 2020 08:20:48 -0400
X-Greylist: delayed 343 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Aug 2020 08:20:47 EDT
Received: from erd988.prtnl (erd988.prtnl [192.168.224.30])
        by sparta.prtnl (Postfix) with ESMTP id 83FEC44AB555;
        Thu, 20 Aug 2020 14:14:59 +0200 (CEST)
From:   David Jander <david@protonic.nl>
To:     Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Clemens Gruber <clemens.gruber@pqgruber.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH] drivers: pwm: pwm-pca9685.c: Disable unused alternative addresses
Date:   Thu, 20 Aug 2020 14:13:58 +0200
Message-Id: <20200820121358.729873-1-david@protonic.nl>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PCA9685 supports listening to 1 or more alternative I2C chip addresses
for some special features that this driver does not support.
By default the LED ALLCALL address is active (default 0x70), which causes
this chip to respond to address 0x70 in addition to its main address
(0x41). This is not desireable if there is another device on the same bus
that uses this address (like a TMP103 for example).
Since this feature is not supported by this driver, it is best to disable
these addresses in the chip to avoid unsuspecting bus collisions.

Signed-off-by: David Jander <david@protonic.nl>
---
 drivers/pwm/pwm-pca9685.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 76cd22bd6614..63ff1f22246d 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -58,6 +58,10 @@
 #define PCA9685_MAXCHAN		0x10
 
 #define LED_FULL		(1 << 4)
+#define MODE1_ALLCALL		(1 << 0)
+#define MODE1_SUB3		(1 << 1)
+#define MODE1_SUB2		(1 << 2)
+#define MODE1_SUB1		(1 << 3)
 #define MODE1_SLEEP		(1 << 4)
 #define MODE2_INVRT		(1 << 4)
 #define MODE2_OUTDRV		(1 << 2)
@@ -444,7 +448,7 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 {
 	struct pca9685 *pca;
 	int ret;
-	int mode2;
+	int reg;
 
 	pca = devm_kzalloc(&client->dev, sizeof(*pca), GFP_KERNEL);
 	if (!pca)
@@ -461,19 +465,24 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 
 	i2c_set_clientdata(client, pca);
 
-	regmap_read(pca->regmap, PCA9685_MODE2, &mode2);
+	regmap_read(pca->regmap, PCA9685_MODE2, &reg);
 
 	if (device_property_read_bool(&client->dev, "invert"))
-		mode2 |= MODE2_INVRT;
+		reg |= MODE2_INVRT;
 	else
-		mode2 &= ~MODE2_INVRT;
+		reg &= ~MODE2_INVRT;
 
 	if (device_property_read_bool(&client->dev, "open-drain"))
-		mode2 &= ~MODE2_OUTDRV;
+		reg &= ~MODE2_OUTDRV;
 	else
-		mode2 |= MODE2_OUTDRV;
+		reg |= MODE2_OUTDRV;
 
-	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
+	regmap_write(pca->regmap, PCA9685_MODE2, reg);
+
+	/* Disable all LED ALLCALL and SUBx addresses to avoid bus collisions */
+	regmap_read(pca->regmap, PCA9685_MODE1, &reg);
+	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
+	regmap_write(pca->regmap, PCA9685_MODE1, reg);
 
 	/* clear all "full off" bits */
 	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
-- 
2.25.1

