Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC3A758471
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjGRSTO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGRSTJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6213D11C
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHo-0001tm-52; Tue, 18 Jul 2023 20:19:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHn-000Qnf-Ds; Tue, 18 Jul 2023 20:18:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-005uoV-IZ; Tue, 18 Jul 2023 20:18:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-pwm@vger.kernel.org,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 18/18] gpio: mvebu: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:49 +0200
Message-Id: <20230718181849.3947851-19-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=xBvdsZeiXAEcdnH58UItARY2e7eMwPEcvQJ6V4tOakY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttb8Ml74uT9Ms7jH2ybcBr/sYyoqPwWwbGVsr 6JV4tQiib+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW/AAKCRCPgPtYfRL+ Tpe7CACInEAGAG9ZOrW1yCrRg0ZA+e8bhc4tI97V89h3V2D3N9rfFu05I7vSYOL5sDDLeEazmWY M48zMTVsvUfccZLRWYoadYeKVjseY0B9u0AIOrwOqShTHCUFmIcXUB4UoeihCNdh69axeHaE5xP BmHyhqv9E7aS7d7mR1BXaQR+tKcvcsby4L5F++1F2iqVl3QilZddhGeO4grjAGQb9zOj0egQwSu Lfg9Zn01+KSsUX5ZNA8z7YfjEBaZv0+4cAiPS7njoDkK4+84B4t6G9OGfR0PJYXHD70uPtQlOIy HWSDVSq8FrH6iy1saF0SdPTKHsG4RgeoWHrkIW2/Gn22W6W4
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm sub-driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mvebu.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index a35958e7adf6..9557cac807f9 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -98,7 +98,6 @@ struct mvebu_pwm {
 	u32			 offset;
 	unsigned long		 clk_rate;
 	struct gpio_desc	*gpiod;
-	struct pwm_chip		 chip;
 	spinlock_t		 lock;
 	struct mvebu_gpio_chip	*mvchip;
 
@@ -614,7 +613,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
  */
 static struct mvebu_pwm *to_mvebu_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mvebu_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int mvebu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -789,6 +788,7 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	struct mvebu_pwm *mvpwm;
+	struct pwm_chip *chip;
 	void __iomem *base;
 	u32 offset;
 	u32 set;
@@ -813,9 +813,11 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 	if (IS_ERR(mvchip->clk))
 		return PTR_ERR(mvchip->clk);
 
-	mvpwm = devm_kzalloc(dev, sizeof(struct mvebu_pwm), GFP_KERNEL);
-	if (!mvpwm)
+	chip = devm_pwmchip_alloc(dev, sizeof(struct mvebu_pwm));
+	if (!chip)
 		return -ENOMEM;
+	mvpwm = pwmchip_priv(chip);
+
 	mvchip->mvpwm = mvpwm;
 	mvpwm->mvchip = mvchip;
 	mvpwm->offset = offset;
@@ -868,13 +870,12 @@ static int mvebu_pwm_probe(struct platform_device *pdev,
 		return -EINVAL;
 	}
 
-	mvpwm->chip.dev = dev;
-	mvpwm->chip.ops = &mvebu_pwm_ops;
-	mvpwm->chip.npwm = mvchip->chip.ngpio;
+	chip->ops = &mvebu_pwm_ops;
+	chip->npwm = mvchip->chip.ngpio;
 
 	spin_lock_init(&mvpwm->lock);
 
-	return devm_pwmchip_add(dev, &mvpwm->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.39.2

