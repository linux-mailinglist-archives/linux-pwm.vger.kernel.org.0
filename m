Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACDB774B0C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjHHUjp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 16:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232925AbjHHUjQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 16:39:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C937A1DD56
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:12 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN9-0007Nz-9j; Tue, 08 Aug 2023 19:19:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-00226x-KL; Tue, 08 Aug 2023 19:19:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN6-00BTDY-GI; Tue, 08 Aug 2023 19:19:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 053/101] pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:43 +0200
Message-Id: <20230808171931.944154-54-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2383; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=GMCGG1YS/7rS4lyplT83r/sagIoZDDSSQf0lS6Ppw6g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njsxzCxVCBrEXYGyKXyXaEmgmNOEnN0G3uLs eihYTJZYgaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ47AAKCRCPgPtYfRL+ TguAB/4yy3IXs5LXfypasyASoOFigBS2ho+BMwYr4a5B4Oe97vgeIXsOBQWfjkzw2TOiF/6Kz7P ZgLTE9exihS6A7HcoOMsvDLRXdIjlddgGM9tTF9ILTkJoLTiGZ5mwpRAGWQSbuuZW9x/Lrmq+Kf HB9MCr3dU3vBSKIw84BA4JKMm4C8wUunrP16bFE+CSALo3X5OTWwwfAlmh5qkbMCztVZeyq6285 IU+Zg47jhrhJY91lwQhgHdd7B8vndUtB+7WlfXhxVQAKXr6WTHb6r4T7HC3uS2i3e5lMXSA6xdr T4MoowEIcIKUkfp1DjE1L+wPJqztJjmzb+I2DcRUWV8nvKRd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-stm32-lp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 444a9c9c2c29..1fdf91ec9c9b 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -18,14 +18,13 @@
 #include <linux/pwm.h>
 
 struct stm32_pwm_lp {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm_lp, chip);
+	return pwmchip_priv(chip);
 }
 
 /* STM32 Low-Power Timer is preceded by a configurable power-of-2 prescaler */
@@ -192,20 +191,20 @@ static const struct pwm_ops stm32_pwm_lp_ops = {
 static int stm32_pwm_lp_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct pwm_chip *chip;
 	struct stm32_pwm_lp *priv;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_lp(chip);
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.ops = &stm32_pwm_lp_ops;
-	priv->chip.npwm = 1;
+	chip->ops = &stm32_pwm_lp_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
@@ -216,13 +215,13 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 
 static int __maybe_unused stm32_pwm_lp_suspend(struct device *dev)
 {
-	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct pwm_state state;
 
-	pwm_get_state(&priv->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 	if (state.enabled) {
 		dev_err(dev, "The consumer didn't stop us (%s)\n",
-			priv->chip.pwms[0].label);
+			chip->pwms[0].label);
 		return -EBUSY;
 	}
 
-- 
2.40.1

