Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F1C774693
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjHHS6x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjHHS6h (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60DD37298
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN4-0007AU-UM; Tue, 08 Aug 2023 19:19:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN3-00225D-9S; Tue, 08 Aug 2023 19:19:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00BTC5-S7; Tue, 08 Aug 2023 19:19:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 031/101] pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:21 +0200
Message-Id: <20230808171931.944154-32-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2340; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3E08n4p8JuGcRlKf5+lzS2UmRT7uuP+vSZ0qn+HDxwM=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLFZfLu5xnvzYwrDwSENEWZnj4zUprR1+rO6qX7y4zP mxQY/2xk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJ/L3L/k+tNzdY8VytS0VH 5E43+4qAHBv5XzuSbXRz/u6M2Ll75lKNbyuz3Y9uFGYtNm/9/cqO9XiVpe6m+7zLoiRvqu/Zac+ w9FhZ25utmqw3AmaeEJ+xYrLDwWnpjrOCs3xS5Z9mJvY0JUbW5O8819Cj1Vqfbnpa9/gCBX8nvc uN1q2VD5ql7sSEl9SKv32xecXbIua939PP2Uj0TFNuX2Sp/tJeYeWLC7O+5V7a3rzy1pXdx5ICm mJVOafX/Uh5+Lq3bFqY0skuYe2ud9nfMibEnt6Yl3BL36ZkhbhfqPgBt2kfX868diJeeppIe3za bY2uNqnZsr+uviz8V/dgOjO3cbuiZ0eEWVG/+NdexaoKAA==
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
2.40.1

