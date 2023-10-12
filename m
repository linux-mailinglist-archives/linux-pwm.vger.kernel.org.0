Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A202D7C72E6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379624AbjJLQbf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379638AbjJLQbL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:11 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C59CA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-0005Ym-9K; Thu, 12 Oct 2023 18:31:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-001C9Q-Iw; Thu, 12 Oct 2023 18:31:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaW-00F5Qa-9a; Thu, 12 Oct 2023 18:31:04 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 067/109] pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:35 +0200
Message-ID: <20231012162827.1002444-178-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=07wTOrvuV3nzYopLuVHekaJ6g07TBx6SMb++5tLy2GA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB77Savtth2XVH8mrPfCMfdq5TKb+39KLgwB6 lBi1Bs7D9aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge+wAKCRCPgPtYfRL+ TruKCACfThCYNa2Nuz5ZW66sQHEgb/+PJ/KbvufyCqtBgpfeN/xPVs6yNEJ6tZ7irkeQnwWtupw pLqdOKAGnOCbWGY1NqDE1Ytyx6PMDh0lHHZU6L9DCMLJkOikS1WLyUatJVRPZfkWPQXc+PLbOLj +hCdgKrDy2wb2cIK0I/XayKdSuaKfR2MCMa+uRqHU/HKs8nlA01Oklf5NQIjmHMEmOrsanTRMTF hgNejcuJDAsK5sFt/zAi5/my/IF4LdtvrHueIPo2/xT7wHyJlW8/Ipo5N6eU87LkX5d/doZ5WcH M5DEWOJ9e2oWGdXD424CRvaShkumTrbNiTpm9h75YKbNbCvu
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

This prepares the pwm-lpc32xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc32xx.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 78f664e41e6e..2b4186c309a6 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -15,7 +15,6 @@
 #include <linux/slab.h>
 
 struct lpc32xx_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 };
@@ -23,8 +22,8 @@ struct lpc32xx_pwm_chip {
 #define PWM_ENABLE	BIT(31)
 #define PWM_PIN_LEVEL	BIT(30)
 
-#define to_lpc32xx_pwm_chip(_chip) \
-	container_of(_chip, struct lpc32xx_pwm_chip, chip)
+#define to_lpc32xx_pwm_chip(chip) \
+	pwmchip_priv(chip)
 
 static int lpc32xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			      int duty_ns, int period_ns)
@@ -119,13 +118,15 @@ static const struct pwm_ops lpc32xx_pwm_ops = {
 
 static int lpc32xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct lpc32xx_pwm_chip *lpc32xx;
 	int ret;
 	u32 val;
 
-	lpc32xx = devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GFP_KERNEL);
-	if (!lpc32xx)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*lpc32xx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	lpc32xx = to_lpc32xx_pwm_chip(chip);
 
 	lpc32xx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc32xx->base))
@@ -135,16 +136,14 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(lpc32xx->clk))
 		return PTR_ERR(lpc32xx->clk);
 
-	lpc32xx->chip.dev = &pdev->dev;
-	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
-	lpc32xx->chip.npwm = 1;
+	chip->ops = &lpc32xx_pwm_ops;
 
 	/* If PWM is disabled, configure the output to the default value */
 	val = readl(lpc32xx->base);
 	val &= ~PWM_PIN_LEVEL;
 	writel(val, lpc32xx->base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &lpc32xx->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip, error %d\n", ret);
 		return ret;
-- 
2.42.0

