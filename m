Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E207C72BB
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379632AbjJLQbK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379599AbjJLQa7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:59 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C5D3CC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-0004qE-JO; Thu, 12 Oct 2023 18:30:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaN-001C6d-0h; Thu, 12 Oct 2023 18:30:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaM-00F5NV-Np; Thu, 12 Oct 2023 18:30:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 022/109] pwm: pca9685: Store parent device in driver data
Date:   Thu, 12 Oct 2023 18:28:50 +0200
Message-ID: <20231012162827.1002444-133-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4284; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dKhHJ+2Q2+kNUGtniDV0zRbVUGnf0obvhWbuXPHbaxU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7G0/RQFw8tg7hV1niRGKk9crU30PgA+YJ5N l6rUJT6LOyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgexgAKCRCPgPtYfRL+ TpdiB/9JvDYBj/3B1AibktMLm0sViUOGbQmwREKQHRDK7MeQdpBf311Y508tVhMAjC0CToNZeAa jhMEgz+t0X1v4JopRsjHFp8o1g8PtYcLopf0o+IOoD6rOVoUVnesVrijL8dzPF6k08kd5lB8F70 FB6qqfHxGIPFXPS/bZAMy4NS/OF9FtQFBtkhI6Qzb/IRURRIAEQfJzNS7j5M5kz5bw5MtVj5f9+ VmAzynGYFJywUq7WGJUlGNK8sP6B71zwQva6AmKkXcf2pmU92PLSeydE9j5zg3OUsx3z/Gfpfw6 tIG8HSXhnSLOmkelOqX6+yr3KjsehPkir3vHQhf4OxDqV2Ri
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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
2.42.0

