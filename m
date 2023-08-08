Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE38774B00
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjHHUjP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbjHHUit (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:38:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9516075853
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-0007Ff-Fm; Tue, 08 Aug 2023 19:19:51 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-00225f-7m; Tue, 08 Aug 2023 19:19:50 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00BTCW-Bp; Tue, 08 Aug 2023 19:19:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 038/101] pwm: ntxec: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:28 +0200
Message-Id: <20230808171931.944154-39-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3499; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=TghFrMQQFrlpBRpCyH6XhW0DoOJF13kDuQ/hwU9bndo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njbgiEY9Mvu/0Oo1RpVTjDnA8EfxBxS6XZLC nh4OiOthj2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ42wAKCRCPgPtYfRL+ TkpgB/9/jagDLR7mv19YysRpxFO9XVo48MjUwzjo1mePYVJyN5p8XKE+TLWss59lJsvR3ZD9fLr lifwjgBYJm53a3PbiBwQiIbXIbFZ5l5ZZ+YcKxPWA0c6zP3bIikTstB8XWgxWy0lfsdlVb0X8eq vK50gwCvnhcm7YBvFRBIb4gix9SK7QDosGDapK/09BZB+iOo3496fWo9msYsmc3VmBN1P+9TH5f aG/TLHRSZwVYj98ZFudxSZkXRqpJdUjylpfVuS5a61sRTJ6UQ/9SukP/aN2TVY8ZmgkkLBzEEk7 PE7vSSEwD8v1q/i8TTBk7rGMMhyerPsyx+FWVE59w0AAY8Fd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-ntxec driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ntxec.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
index 78606039eda2..0c54dc0d1e9c 100644
--- a/drivers/pwm/pwm-ntxec.c
+++ b/drivers/pwm/pwm-ntxec.c
@@ -25,12 +25,11 @@
 
 struct ntxec_pwm {
 	struct ntxec *ec;
-	struct pwm_chip chip;
 };
 
 static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ntxec_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 #define NTXEC_REG_AUTO_OFF_HI	0xa1
@@ -57,7 +56,7 @@ static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
 						   int period, int duty)
 {
-	struct ntxec_pwm *priv = ntxec_pwm_from_chip(chip);
+	struct ntxec *ec = ntxec_pwm_from_chip(chip)->ec;
 
 	/*
 	 * Changes to the period and duty cycle take effect as soon as the
@@ -77,13 +76,13 @@ static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
 		{ NTXEC_REG_DUTY_LOW, ntxec_reg8(duty) },
 	};
 
-	return regmap_multi_reg_write(priv->ec->regmap, regs, ARRAY_SIZE(regs));
+	return regmap_multi_reg_write(ec->regmap, regs, ARRAY_SIZE(regs));
 }
 
 static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 			   const struct pwm_state *state)
 {
-	struct ntxec_pwm *priv = ntxec_pwm_from_chip(chip);
+	struct ntxec *ec = ntxec_pwm_from_chip(chip)->ec;
 	unsigned int period, duty;
 	int res;
 
@@ -110,18 +109,18 @@ static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 		if (res)
 			return res;
 
-		res = regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
+		res = regmap_write(ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
 		if (res)
 			return res;
 
 		/* Disable the auto-off timer */
-		res = regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8(0xff));
+		res = regmap_write(ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8(0xff));
 		if (res)
 			return res;
 
-		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(0xff));
+		return regmap_write(ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(0xff));
 	} else {
-		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
+		return regmap_write(ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
 	}
 }
 
@@ -135,22 +134,19 @@ static const struct pwm_ops ntxec_pwm_ops = {
 
 static int ntxec_pwm_probe(struct platform_device *pdev)
 {
-	struct ntxec *ec = dev_get_drvdata(pdev->dev.parent);
 	struct ntxec_pwm *priv;
 	struct pwm_chip *chip;
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = ntxec_pwm_from_chip(chip);
 
-	priv->ec = ec;
+	priv->ec = dev_get_drvdata(pdev->dev.parent);
 
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ntxec_pwm_ops;
-	chip->npwm = 1;
 
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
-- 
2.40.1

