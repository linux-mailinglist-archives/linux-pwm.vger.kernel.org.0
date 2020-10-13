Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0AE928CA24
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 10:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403775AbgJMIVt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 04:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403772AbgJMIVt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 04:21:49 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63377C0613D0
        for <linux-pwm@vger.kernel.org>; Tue, 13 Oct 2020 01:21:49 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFZ3-0002lD-I0; Tue, 13 Oct 2020 10:21:45 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kSFZ3-00053U-7J; Tue, 13 Oct 2020 10:21:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] [RFC] pwm: make use of devm_clk_{prepared,enabled}
Date:   Tue, 13 Oct 2020 10:21:32 +0200
Message-Id: <20201013082132.661993-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
References: <20201013082132.661993-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c       | 12 ++----------
 drivers/pwm/pwm-bcm-iproc.c   | 14 ++------------
 drivers/pwm/pwm-bcm2835.c     | 18 ++----------------
 drivers/pwm/pwm-berlin.c      | 13 ++-----------
 drivers/pwm/pwm-brcmstb.c     | 24 ++++--------------------
 drivers/pwm/pwm-hibvt.c       | 16 +++-------------
 drivers/pwm/pwm-imx-tpm.c     | 18 +++---------------
 drivers/pwm/pwm-lpc18xx-sct.c | 23 +++++------------------
 drivers/pwm/pwm-mtk-disp.c    | 27 ++++-----------------------
 drivers/pwm/pwm-rockchip.c    | 13 ++-----------
 drivers/pwm/pwm-samsung.c     | 11 +----------
 drivers/pwm/pwm-sifive.c      | 23 ++++++-----------------
 drivers/pwm/pwm-spear.c       | 17 ++++-------------
 drivers/pwm/pwm-sun4i.c       | 24 ++++++++----------------
 drivers/pwm/pwm-tiehrpwm.c    | 17 ++---------------
 drivers/pwm/pwm-vt8500.c      | 11 +----------
 16 files changed, 51 insertions(+), 230 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index aa0b36695dc7..fa280a12a3e9 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -418,16 +418,11 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->base),
 				     "Failed to remap register space\n");
 
-	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	atmel_pwm->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(atmel_pwm->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
 				     "Failed to get clock\n");
 
-	ret = clk_prepare(atmel_pwm->clk);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret,
-				     "Failed to prepare PWM clock\n");
-
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
@@ -436,11 +431,9 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.npwm = 4;
 
 	ret = pwmchip_add(&atmel_pwm->chip);
-	if (ret < 0) {
-		clk_unprepare(atmel_pwm->clk);
+	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "Failed to add PWM chip\n");
-	}
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
@@ -451,7 +444,6 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
 
-	clk_unprepare(atmel_pwm->clk);
 	mutex_destroy(&atmel_pwm->isr_lock);
 
 	return pwmchip_remove(&atmel_pwm->chip);
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 79b1e58e946d..450f28d83653 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -220,19 +220,13 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	if (IS_ERR(ip->base))
 		return PTR_ERR(ip->base);
 
-	ip->clk = devm_clk_get(&pdev->dev, NULL);
+	ip->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(ip->clk)) {
 		dev_err(&pdev->dev, "failed to get clock: %ld\n",
 			PTR_ERR(ip->clk));
 		return PTR_ERR(ip->clk);
 	}
 
-	ret = clk_prepare_enable(ip->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
-
 	/* Set full drive and normal polarity for all channels */
 	value = readl(ip->base + IPROC_PWM_CTRL_OFFSET);
 
@@ -244,10 +238,8 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	writel(value, ip->base + IPROC_PWM_CTRL_OFFSET);
 
 	ret = pwmchip_add(&ip->chip);
-	if (ret < 0) {
+	if (ret < 0)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(ip->clk);
-	}
 
 	return ret;
 }
@@ -256,8 +248,6 @@ static int iproc_pwmc_remove(struct platform_device *pdev)
 {
 	struct iproc_pwmc *ip = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(ip->clk);
-
 	return pwmchip_remove(&ip->chip);
 }
 
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index d78f86f8e462..5add49fa0bc3 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -151,7 +151,7 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk)) {
 		ret = PTR_ERR(pc->clk);
 		if (ret != -EPROBE_DEFER)
@@ -160,10 +160,6 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pc->clk);
-	if (ret)
-		return ret;
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.base = -1;
@@ -173,23 +169,13 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pc);
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0)
-		goto add_fail;
-
-	return 0;
-
-add_fail:
-	clk_disable_unprepare(pc->clk);
-	return ret;
+	return pwmchip_add(&pc->chip);
 }
 
 static int bcm2835_pwm_remove(struct platform_device *pdev)
 {
 	struct bcm2835_pwm *pc = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(pc->clk);
-
 	return pwmchip_remove(&pc->chip);
 }
 
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index b91c477cc84b..5ee00421f743 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -198,14 +198,10 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
-	ret = clk_prepare_enable(pwm->clk);
-	if (ret)
-		return ret;
-
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &berlin_pwm_ops;
 	pwm->chip.base = -1;
@@ -216,7 +212,6 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(pwm->clk);
 		return ret;
 	}
 
@@ -228,12 +223,8 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 static int berlin_pwm_remove(struct platform_device *pdev)
 {
 	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pwmchip_remove(&pwm->chip);
-	clk_disable_unprepare(pwm->clk);
 
-	return ret;
+	return pwmchip_remove(&pwm->chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index fea612c45f20..331175506e40 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -243,18 +243,12 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	spin_lock_init(&p->lock);
 
-	p->clk = devm_clk_get(&pdev->dev, NULL);
+	p->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
 		dev_err(&pdev->dev, "failed to obtain clock\n");
 		return PTR_ERR(p->clk);
 	}
 
-	ret = clk_prepare_enable(p->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable clock: %d\n", ret);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, p);
 
 	p->chip.dev = &pdev->dev;
@@ -266,31 +260,21 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	p->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(p->base)) {
 		ret = PTR_ERR(p->base);
-		goto out_clk;
+		return ret;
 	}
 
 	ret = pwmchip_add(&p->chip);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		goto out_clk;
-	}
 
-	return 0;
-
-out_clk:
-	clk_disable_unprepare(p->clk);
 	return ret;
 }
 
 static int brcmstb_pwm_remove(struct platform_device *pdev)
 {
 	struct brcmstb_pwm *p = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = pwmchip_remove(&p->chip);
-	clk_disable_unprepare(p->clk);
-
-	return ret;
+	return pwmchip_remove(&p->chip);
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ad205fdad372..b8e6852773e0 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -198,7 +198,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	if (pwm_chip == NULL)
 		return -ENOMEM;
 
-	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
+	pwm_chip->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(pwm_chip->clk)) {
 		dev_err(&pdev->dev, "getting clock failed with %ld\n",
 				PTR_ERR(pwm_chip->clk));
@@ -218,25 +218,17 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm_chip->base))
 		return PTR_ERR(pwm_chip->base);
 
-	ret = clk_prepare_enable(pwm_chip->clk);
-	if (ret < 0)
-		return ret;
-
 	pwm_chip->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(pwm_chip->rstc)) {
-		clk_disable_unprepare(pwm_chip->clk);
+	if (IS_ERR(pwm_chip->rstc))
 		return PTR_ERR(pwm_chip->rstc);
-	}
 
 	reset_control_assert(pwm_chip->rstc);
 	msleep(30);
 	reset_control_deassert(pwm_chip->rstc);
 
 	ret = pwmchip_add(&pwm_chip->chip);
-	if (ret < 0) {
-		clk_disable_unprepare(pwm_chip->clk);
+	if (ret < 0)
 		return ret;
-	}
 
 	for (i = 0; i < pwm_chip->chip.npwm; i++) {
 		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
@@ -258,8 +250,6 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 	msleep(30);
 	reset_control_deassert(pwm_chip->rstc);
 
-	clk_disable_unprepare(pwm_chip->clk);
-
 	return pwmchip_remove(&pwm_chip->chip);
 }
 
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index fcdf6befb838..589fd5b3c09e 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -349,7 +349,7 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	if (IS_ERR(tpm->base))
 		return PTR_ERR(tpm->base);
 
-	tpm->clk = devm_clk_get(&pdev->dev, NULL);
+	tpm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(tpm->clk)) {
 		ret = PTR_ERR(tpm->clk);
 		if (ret != -EPROBE_DEFER)
@@ -358,13 +358,6 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(tpm->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to prepare or enable clock: %d\n", ret);
-		return ret;
-	}
-
 	tpm->chip.dev = &pdev->dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
 	tpm->chip.base = -1;
@@ -378,10 +371,8 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	mutex_init(&tpm->lock);
 
 	ret = pwmchip_add(&tpm->chip);
-	if (ret) {
+	if (ret)
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(tpm->clk);
-	}
 
 	return ret;
 }
@@ -389,11 +380,8 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 static int pwm_imx_tpm_remove(struct platform_device *pdev)
 {
 	struct imx_tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
-	int ret = pwmchip_remove(&tpm->chip);
-
-	clk_disable_unprepare(tpm->clk);
 
-	return ret;
+	return pwmchip_remove(&tpm->chip);
 }
 
 static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 5ff11145c1a3..893ab4800485 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -341,23 +341,16 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(lpc18xx_pwm->base))
 		return PTR_ERR(lpc18xx_pwm->base);
 
-	lpc18xx_pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
+	lpc18xx_pwm->pwm_clk = devm_clk_get_enabled(&pdev->dev, "pwm");
 	if (IS_ERR(lpc18xx_pwm->pwm_clk)) {
 		dev_err(&pdev->dev, "failed to get pwm clock\n");
 		return PTR_ERR(lpc18xx_pwm->pwm_clk);
 	}
 
-	ret = clk_prepare_enable(lpc18xx_pwm->pwm_clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "could not prepare or enable pwm clock\n");
-		return ret;
-	}
-
 	lpc18xx_pwm->clk_rate = clk_get_rate(lpc18xx_pwm->pwm_clk);
 	if (!lpc18xx_pwm->clk_rate) {
 		dev_err(&pdev->dev, "pwm clock has no frequency\n");
-		ret = -EINVAL;
-		goto disable_pwmclk;
+		return -EINVAL;
 	}
 
 	mutex_init(&lpc18xx_pwm->res_lock);
@@ -403,7 +396,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&lpc18xx_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
-		goto disable_pwmclk;
+		return ret;
 	}
 
 	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
@@ -414,8 +407,8 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 		data = devm_kzalloc(lpc18xx_pwm->dev, sizeof(*data),
 				    GFP_KERNEL);
 		if (!data) {
-			ret = -ENOMEM;
-			goto remove_pwmchip;
+			pwmchip_remove(&lpc18xx_pwm->chip);
+			return -ENOMEM;
 		}
 
 		pwm_set_chip_data(pwm, data);
@@ -431,12 +424,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
 
 	return 0;
-
-remove_pwmchip:
-	pwmchip_remove(&lpc18xx_pwm->chip);
-disable_pwmclk:
-	clk_disable_unprepare(lpc18xx_pwm->pwm_clk);
-	return ret;
 }
 
 static int lpc18xx_pwm_remove(struct platform_device *pdev)
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 83b8be0209b7..2ddbba25b87d 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -186,22 +186,14 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(mdp->base))
 		return PTR_ERR(mdp->base);
 
-	mdp->clk_main = devm_clk_get(&pdev->dev, "main");
+	mdp->clk_main = devm_clk_get_prepared(&pdev->dev, "main");
 	if (IS_ERR(mdp->clk_main))
 		return PTR_ERR(mdp->clk_main);
 
-	mdp->clk_mm = devm_clk_get(&pdev->dev, "mm");
+	mdp->clk_mm = devm_clk_get_prepared(&pdev->dev, "mm");
 	if (IS_ERR(mdp->clk_mm))
 		return PTR_ERR(mdp->clk_mm);
 
-	ret = clk_prepare(mdp->clk_main);
-	if (ret < 0)
-		return ret;
-
-	ret = clk_prepare(mdp->clk_mm);
-	if (ret < 0)
-		goto disable_clk_main;
-
 	mdp->chip.dev = &pdev->dev;
 	mdp->chip.ops = &mtk_disp_pwm_ops;
 	mdp->chip.base = -1;
@@ -210,7 +202,7 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&mdp->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto disable_clk_mm;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, mdp);
@@ -229,24 +221,13 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 	}
 
 	return 0;
-
-disable_clk_mm:
-	clk_unprepare(mdp->clk_mm);
-disable_clk_main:
-	clk_unprepare(mdp->clk_main);
-	return ret;
 }
 
 static int mtk_disp_pwm_remove(struct platform_device *pdev)
 {
 	struct mtk_disp_pwm *mdp = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pwmchip_remove(&mdp->chip);
-	clk_unprepare(mdp->clk_mm);
-	clk_unprepare(mdp->clk_main);
 
-	return ret;
+	return pwmchip_remove(&mdp->chip);
 }
 
 static const struct mtk_pwm_data mt2701_pwm_data = {
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index eb8c9cb645a6..adf276ce4d58 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -303,7 +303,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-	pc->clk = devm_clk_get(&pdev->dev, "pwm");
+	pc->clk = devm_clk_get_enabled(&pdev->dev, "pwm");
 	if (IS_ERR(pc->clk)) {
 		pc->clk = devm_clk_get(&pdev->dev, NULL);
 		if (IS_ERR(pc->clk)) {
@@ -329,16 +329,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
-		return ret;
-	}
-
 	ret = clk_prepare(pc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't prepare APB clk: %d\n", ret);
-		goto err_clk;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
@@ -369,8 +363,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 err_pclk:
 	clk_unprepare(pc->pclk);
-err_clk:
-	clk_disable_unprepare(pc->clk);
 
 	return ret;
 }
@@ -394,7 +386,6 @@ static int rockchip_pwm_remove(struct platform_device *pdev)
 		clk_disable(pc->clk);
 
 	clk_unprepare(pc->pclk);
-	clk_unprepare(pc->clk);
 
 	return pwmchip_remove(&pc->chip);
 }
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 87a886f7dc2f..9e7e7c606120 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -546,18 +546,12 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->base_clk = devm_clk_get(&pdev->dev, "timers");
+	chip->base_clk = devm_clk_get_enabled(&pdev->dev, "timers");
 	if (IS_ERR(chip->base_clk)) {
 		dev_err(dev, "failed to get timer base clk\n");
 		return PTR_ERR(chip->base_clk);
 	}
 
-	ret = clk_prepare_enable(chip->base_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable base clock\n");
-		return ret;
-	}
-
 	for (chan = 0; chan < SAMSUNG_PWM_NUM; ++chan)
 		if (chip->variant.output_mask & BIT(chan))
 			pwm_samsung_set_invert(chip, chan, true);
@@ -571,7 +565,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&chip->chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
-		clk_disable_unprepare(chip->base_clk);
 		return ret;
 	}
 
@@ -592,8 +585,6 @@ static int pwm_samsung_remove(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
-	clk_disable_unprepare(chip->base_clk);
-
 	return 0;
 }
 
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 62de0bb85921..01f62600db59 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -253,44 +253,34 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	if (IS_ERR(ddata->regs))
 		return PTR_ERR(ddata->regs);
 
-	ddata->clk = devm_clk_get(dev, NULL);
+	ddata->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(ddata->clk)) {
 		if (PTR_ERR(ddata->clk) != -EPROBE_DEFER)
 			dev_err(dev, "Unable to find controller clock\n");
 		return PTR_ERR(ddata->clk);
 	}
 
-	ret = clk_prepare_enable(ddata->clk);
-	if (ret) {
-		dev_err(dev, "failed to enable clock for pwm: %d\n", ret);
-		return ret;
-	}
-
 	/* Watch for changes to underlying clock frequency */
 	ddata->notifier.notifier_call = pwm_sifive_clock_notifier;
 	ret = clk_notifier_register(ddata->clk, &ddata->notifier);
 	if (ret) {
 		dev_err(dev, "failed to register clock notifier: %d\n", ret);
-		goto disable_clk;
+		return ret;
 	}
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(dev, "cannot register PWM: %d\n", ret);
-		goto unregister_clk;
+
+		clk_notifier_unregister(ddata->clk, &ddata->notifier);
+
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, ddata);
 	dev_dbg(dev, "SiFive PWM chip registered %d PWMs\n", chip->npwm);
 
 	return 0;
-
-unregister_clk:
-	clk_notifier_unregister(ddata->clk, &ddata->notifier);
-disable_clk:
-	clk_disable_unprepare(ddata->clk);
-
-	return ret;
 }
 
 static int pwm_sifive_remove(struct platform_device *dev)
@@ -310,7 +300,6 @@ static int pwm_sifive_remove(struct platform_device *dev)
 	if (is_enabled)
 		clk_disable(ddata->clk);
 
-	clk_disable_unprepare(ddata->clk);
 	ret = pwmchip_remove(&ddata->chip);
 	clk_notifier_unregister(ddata->clk, &ddata->notifier);
 
diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 6c6b44fd3f43..1bbe6cef365c 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -187,7 +187,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
@@ -198,16 +198,11 @@ static int spear_pwm_probe(struct platform_device *pdev)
 	pc->chip.base = -1;
 	pc->chip.npwm = NUM_PWM;
 
-	ret = clk_prepare(pc->clk);
-	if (ret)
-		return ret;
-
 	if (of_device_is_compatible(np, "st,spear1340-pwm")) {
 		ret = clk_enable(pc->clk);
-		if (ret) {
-			clk_unprepare(pc->clk);
+		if (ret)
 			return ret;
-		}
+
 		/*
 		 * Following enables PWM chip, channels would still be
 		 * enabled individually through their control register
@@ -220,10 +215,8 @@ static int spear_pwm_probe(struct platform_device *pdev)
 	}
 
 	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->clk);
+	if (ret < 0)
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-	}
 
 	return ret;
 }
@@ -236,8 +229,6 @@ static int spear_pwm_remove(struct platform_device *pdev)
 	for (i = 0; i < NUM_PWM; i++)
 		pwm_disable(&pc->chip.pwms[i]);
 
-	/* clk was prepared in probe, hence unprepare it here */
-	clk_unprepare(pc->clk);
 	return pwmchip_remove(&pc->chip);
 }
 
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 961c59c99bb3..0144b24ed47a 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -440,14 +440,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
-	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
-	if (IS_ERR(pwm->bus_clk)) {
-		if (PTR_ERR(pwm->bus_clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "get bus clock failed %pe\n",
-				pwm->bus_clk);
-		return PTR_ERR(pwm->bus_clk);
-	}
-
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
 		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
@@ -468,11 +460,13 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 * We're keeping the bus clock on for the sake of simplicity.
 	 * Actually it only needs to be on for hardware register accesses.
 	 */
-	ret = clk_prepare_enable(pwm->bus_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "cannot prepare and enable bus_clk %pe\n",
-			ERR_PTR(ret));
-		goto err_bus;
+	pwm->bus_clk = devm_clk_get_optional_enabled(&pdev->dev, "bus");
+	if (IS_ERR(pwm->bus_clk)) {
+		if (PTR_ERR(pwm->bus_clk) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get bus clock failed %pe\n",
+				pwm->bus_clk);
+		ret = PTR_ERR(pwm->bus_clk);
+		goto err_get_clk;
 	}
 
 	pwm->chip.dev = &pdev->dev;
@@ -495,8 +489,7 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
-	clk_disable_unprepare(pwm->bus_clk);
-err_bus:
+err_get_clk:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -511,7 +504,6 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 0846917ff2d2..e57dbbcb2285 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -461,41 +461,28 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pc->mmio_base);
 
 	/* Acquire tbclk for Time Base EHRPWM submodule */
-	pc->tbclk = devm_clk_get(&pdev->dev, "tbclk");
+	pc->tbclk = devm_clk_get_prepared(&pdev->dev, "tbclk");
 	if (IS_ERR(pc->tbclk)) {
 		dev_err(&pdev->dev, "Failed to get tbclk\n");
 		return PTR_ERR(pc->tbclk);
 	}
 
-	ret = clk_prepare(pc->tbclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "clk_prepare() failed: %d\n", ret);
-		return ret;
-	}
-
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		goto err_clk_unprepare;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
-
-err_clk_unprepare:
-	clk_unprepare(pc->tbclk);
-
-	return ret;
 }
 
 static int ehrpwm_pwm_remove(struct platform_device *pdev)
 {
 	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
 
-	clk_unprepare(pc->tbclk);
-
 	pm_runtime_disable(&pdev->dev);
 
 	return pwmchip_remove(&pc->chip);
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 11d45e56a923..cc20643c26a3 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -213,7 +213,7 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	chip->chip.base = -1;
 	chip->chip.npwm = VT8500_NR_PWMS;
 
-	chip->clk = devm_clk_get(&pdev->dev, NULL);
+	chip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(chip->clk)) {
 		dev_err(&pdev->dev, "clock source not specified\n");
 		return PTR_ERR(chip->clk);
@@ -224,16 +224,9 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	ret = clk_prepare(chip->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to prepare clock\n");
-		return ret;
-	}
-
 	ret = pwmchip_add(&chip->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
-		clk_unprepare(chip->clk);
 		return ret;
 	}
 
@@ -249,8 +242,6 @@ static int vt8500_pwm_remove(struct platform_device *pdev)
 	if (chip == NULL)
 		return -ENODEV;
 
-	clk_unprepare(chip->clk);
-
 	return pwmchip_remove(&chip->chip);
 }
 
-- 
2.28.0

