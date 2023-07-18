Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F433758473
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjGRSTP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjGRSTM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A07E60
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001pg-KO; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHm-000QnI-E0; Tue, 18 Jul 2023 20:18:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-005uoA-LT; Tue, 18 Jul 2023 20:18:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 13/18] pwm: lpc32xx: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:44 +0200
Message-Id: <20230718181849.3947851-14-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2321; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6kQT79iFHarrvCN8dpXKKLaaZrm+SGn1UmBOwD5U5NA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttb2GwuGKShz12zKoCm/6RIdiJtEBl6r8jy17 es3vxAcw+SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW9gAKCRCPgPtYfRL+ TnqbB/42lQTbrywAf5Q4GOFSYerdmuYL6Jk/G2TvyX2N4yNzX2I/XFYHc3ESVzArZ+wPPbq/DDy Sc8dalpUWIMV8Z4nhJHV/tNFCu0iKdygz1HwN3Bh4IiCKV2o3nzVT1CZZHcR7r1WuCHXm2vuunk AqGl8XpDUC2hgHeGAcLkh92YEvtBDbuqlMYfjTZZm9hK8ey7wOf/+zhn8wxdKe2QacjbYvlZaej WM7FZ+E0LVd9IjFXbukg6TZ+D7xDrD8c/NJn900i9yUVUWm/DJIKN2+JbeR0DDEqWtTpbE7diov lgshk+NDR3PxHUIX7YarTVmoTDroWR/7JiYR6IDlGrCBuAkQ
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

This prepares the pwm-lpc32xx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc32xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 806f0bb3ad6d..ea891a8be12f 100644
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
@@ -120,13 +119,15 @@ static const struct pwm_ops lpc32xx_pwm_ops = {
 
 static int lpc32xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct lpc32xx_pwm_chip *lpc32xx;
 	int ret;
 	u32 val;
 
-	lpc32xx = devm_kzalloc(&pdev->dev, sizeof(*lpc32xx), GFP_KERNEL);
-	if (!lpc32xx)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*lpc32xx));
+	if (!chip)
 		return -ENOMEM;
+	lpc32xx = to_lpc32xx_pwm_chip(chip);
 
 	lpc32xx->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc32xx->base))
@@ -136,16 +137,15 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(lpc32xx->clk))
 		return PTR_ERR(lpc32xx->clk);
 
-	lpc32xx->chip.dev = &pdev->dev;
-	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
-	lpc32xx->chip.npwm = 1;
+	chip->ops = &lpc32xx_pwm_ops;
+	chip->npwm = 1;
 
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
2.39.2

