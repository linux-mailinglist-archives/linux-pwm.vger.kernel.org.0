Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157CF758468
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGRSTK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjGRSTG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E7C186
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:18:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-0001oU-V9; Tue, 18 Jul 2023 20:18:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-000Qmp-9A; Tue, 18 Jul 2023 20:18:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-005unk-9j; Tue, 18 Jul 2023 20:18:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 06/18] pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:37 +0200
Message-Id: <20230718181849.3947851-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5565; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cqRaQd9WKdDaNM/c6iC3zypeXN2mgXD9xhKfUHs8W3E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbu888bd22v2keSN3cO0R6k8sZtGWTzz7IhA uS1NW0ZMyeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW7gAKCRCPgPtYfRL+ TmrUB/oDbTx9zO4wKkznbtqFGbKR56yEFPEvD/P34Az2BlKs9GjBmv5HwjdCaSzMTanEzYtjpJo 8J52oGgcX80QQLdJnje0VHMJcUTZE+IOgDigtCU2EudcGEnPtZV47sWjvdKT11ReEu63nJp/+ov 3rKEs6nS78VIJ+nYCbtaSN2BGpsZYUoUaPOTqSiRR5FX6kx7Jj0L7ZkF6alVnju8g9Axztyw0YR 4hSOX1JrmAasvlpiJsSW/IaNB/UkWgr4XeDh5PQU1FajiNFmBJVnpBiFQzI4MZrgiS8udn2MnYG DOEF/Ako8TczXFegQ7fI/9CkpgJ1pSZZjwct1dDo6qFp2vXd
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

This prepares the pwm-fsl-ftm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 47 +++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 5caadbd6194e..9e01c439dd6a 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -41,7 +41,6 @@ struct fsl_pwm_periodcfg {
 };
 
 struct fsl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex lock;
 	struct regmap *regmap;
 
@@ -56,7 +55,7 @@ struct fsl_pwm_chip {
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct fsl_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
@@ -222,10 +221,11 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
 		return false;
 }
 
-static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
+static int fsl_pwm_apply_config(struct pwm_chip *chip,
 				struct pwm_device *pwm,
 				const struct pwm_state *newstate)
 {
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	unsigned int duty;
 	u32 reg_polarity;
 
@@ -233,7 +233,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		dev_err(chip->dev, "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -247,7 +247,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(fpc->chip.dev,
+			dev_err(chip->dev,
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -323,7 +323,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		goto end_mutex;
 	}
 
-	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
 		goto end_mutex;
 
@@ -394,18 +394,19 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct fsl_pwm_chip *fpc;
 	void __iomem *base;
 	int ret;
 
-	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
-	if (!fpc)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*fpc));
+	if (!chip)
 		return -ENOMEM;
+	fpc = to_fsl_chip(chip);
 
 	mutex_init(&fpc->lock);
 
 	fpc->soc = of_device_get_match_data(&pdev->dev);
-	fpc->chip.dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -424,16 +425,16 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
-	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
+	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(&pdev->dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
 
-	fpc->clk[FSL_PWM_CLK_EXT] = devm_clk_get(fpc->chip.dev, "ftm_ext");
+	fpc->clk[FSL_PWM_CLK_EXT] = devm_clk_get(&pdev->dev, "ftm_ext");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_EXT]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_EXT]);
 
 	fpc->clk[FSL_PWM_CLK_CNTEN] =
-				devm_clk_get(fpc->chip.dev, "ftm_cnt_clk_en");
+				devm_clk_get(&pdev->dev, "ftm_cnt_clk_en");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
@@ -446,16 +447,16 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
 
 
-	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.npwm = 8;
+	chip->ops = &fsl_pwm_ops;
+	chip->npwm = 8;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, fpc);
+	platform_set_drvdata(pdev, chip);
 
 	return fsl_pwm_init(fpc);
 }
@@ -463,14 +464,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int fsl_pwm_suspend(struct device *dev)
 {
-	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
 	regcache_cache_only(fpc->regmap, true);
 	regcache_mark_dirty(fpc->regmap);
 
-	for (i = 0; i < fpc->chip.npwm; i++) {
-		struct pwm_device *pwm = &fpc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
@@ -489,11 +491,12 @@ static int fsl_pwm_suspend(struct device *dev)
 
 static int fsl_pwm_resume(struct device *dev)
 {
-	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
-	for (i = 0; i < fpc->chip.npwm; i++) {
-		struct pwm_device *pwm = &fpc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
-- 
2.39.2

