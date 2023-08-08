Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FAB7746AF
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjHHS7E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjHHS6r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D47175DEB
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-00070T-1i; Tue, 08 Aug 2023 19:19:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00224W-DR; Tue, 08 Aug 2023 19:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-00BTBN-Ea; Tue, 08 Aug 2023 19:19:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 019/101] pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:09 +0200
Message-Id: <20230808171931.944154-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5582; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=cSZBqLS/qreFp1l79DtA4XUckZmuMsG149LMnq+bfWo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhpRLFcfuWknYbDFUfWBttzzIYomhyfTTd9cninTvtpvup ypTHizdyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBE7O6y/xVOEPNexuq97NLs jwsv9l3dtHurmf50obyL8YYvPjrKtvvNZGGoE5l1W4+zVE8ufM1fTa/c2t9P2Z7U3PI8/ZPLt2n BmzpxF7X33/pSqu9096n9OFfKv+N026W4JQ3NMh//zK83nlP+5L5H0U9/R3vJtKtV0fsS3dqT0z 6xeAfY/bX3LHJj2njlRlu7287Mz1eu+M9+67ozu6w37m3YUl4XvesuT/Z4qs2Sm5/+0Pib+PSHJ X51Zv++ftuocSRiXcrc1CjTy78k28wqrJg6dVc/Vnsi/yOz3ZJD4sic1RXb9u3ZKdMnv77dd1rU ci+nXoYvIiKPZI3UBM/uC6g8V/ffLKQ6X3rRmib1kp67AA==
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

This prepares the pwm-fsl-ftm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 48 ++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index d1b6d1aa4773..f56c7e9f491a 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -40,7 +40,6 @@ struct fsl_pwm_periodcfg {
 };
 
 struct fsl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex lock;
 	struct regmap *regmap;
 
@@ -55,7 +54,7 @@ struct fsl_pwm_chip {
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct fsl_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
@@ -221,10 +220,11 @@ static bool fsl_pwm_is_other_pwm_enabled(struct fsl_pwm_chip *fpc,
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
 
@@ -232,7 +232,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	bool do_write_period = false;
 
 	if (!fsl_pwm_calculate_period(fpc, newstate->period, &periodcfg)) {
-		dev_err(fpc->chip.dev, "failed to calculate new period\n");
+		dev_err(chip->dev, "failed to calculate new period\n");
 		return -EINVAL;
 	}
 
@@ -246,7 +246,7 @@ static int fsl_pwm_apply_config(struct fsl_pwm_chip *fpc,
 	 */
 	else if (!fsl_pwm_periodcfg_are_equal(&fpc->period, &periodcfg)) {
 		if (fsl_pwm_is_other_pwm_enabled(fpc, pwm)) {
-			dev_err(fpc->chip.dev,
+			dev_err(chip->dev,
 				"Cannot change period for PWM %u, disable other PWMs first\n",
 				pwm->hwpwm);
 			return -EBUSY;
@@ -322,7 +322,7 @@ static int fsl_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		goto end_mutex;
 	}
 
-	ret = fsl_pwm_apply_config(fpc, pwm, newstate);
+	ret = fsl_pwm_apply_config(chip, pwm, newstate);
 	if (ret)
 		goto end_mutex;
 
@@ -392,18 +392,19 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct fsl_pwm_chip *fpc;
 	void __iomem *base;
 	int ret;
 
-	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
-	if (!fpc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*fpc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	fpc = to_fsl_chip(chip);
 
 	mutex_init(&fpc->lock);
 
 	fpc->soc = of_device_get_match_data(&pdev->dev);
-	fpc->chip.dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -422,16 +423,16 @@ static int fsl_pwm_probe(struct platform_device *pdev)
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
 
@@ -444,16 +445,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
 
 
-	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.npwm = 8;
+	chip->ops = &fsl_pwm_ops;
 
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
@@ -461,14 +461,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
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
@@ -487,11 +488,12 @@ static int fsl_pwm_suspend(struct device *dev)
 
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
2.40.1

