Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C22C341A06
	for <lists+linux-pwm@lfdr.de>; Fri, 19 Mar 2021 11:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhCSK32 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 19 Mar 2021 06:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230024AbhCSK3E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 19 Mar 2021 06:29:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CDC06174A
        for <linux-pwm@vger.kernel.org>; Fri, 19 Mar 2021 03:29:04 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNJ-0003is-LF; Fri, 19 Mar 2021 11:29:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lNCNJ-0001gg-BX; Fri, 19 Mar 2021 11:29:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 07/14] pwm: Always allocate pwm id dynamically
Date:   Fri, 19 Mar 2021 11:28:45 +0100
Message-Id: <20210319102852.101209-8-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
References: <20210319102852.101209-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit 5e5da1e9fbee ("pwm: ab8500: Explicitly allocate pwm chip
base dynamically") all drivers use dynamic id allocation explicitly. New
drivers are supposed to do the same, so remove support for driver
specified ids and drop all assignments in the low-level drivers.

Link: https://lore.kernel.org/r/20210301185719.1689526-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c             | 23 ++++++-----------------
 drivers/pwm/pwm-ab8500.c       |  1 -
 drivers/pwm/pwm-atmel-hlcdc.c  |  1 -
 drivers/pwm/pwm-atmel-tcb.c    |  1 -
 drivers/pwm/pwm-atmel.c        |  1 -
 drivers/pwm/pwm-bcm-iproc.c    |  1 -
 drivers/pwm/pwm-bcm-kona.c     |  1 -
 drivers/pwm/pwm-bcm2835.c      |  1 -
 drivers/pwm/pwm-berlin.c       |  1 -
 drivers/pwm/pwm-brcmstb.c      |  1 -
 drivers/pwm/pwm-clps711x.c     |  1 -
 drivers/pwm/pwm-crc.c          |  1 -
 drivers/pwm/pwm-cros-ec.c      |  1 -
 drivers/pwm/pwm-dwc.c          |  1 -
 drivers/pwm/pwm-ep93xx.c       |  1 -
 drivers/pwm/pwm-fsl-ftm.c      |  1 -
 drivers/pwm/pwm-hibvt.c        |  1 -
 drivers/pwm/pwm-img.c          |  1 -
 drivers/pwm/pwm-imx-tpm.c      |  1 -
 drivers/pwm/pwm-imx1.c         |  1 -
 drivers/pwm/pwm-imx27.c        |  1 -
 drivers/pwm/pwm-intel-lgm.c    |  1 -
 drivers/pwm/pwm-iqs620a.c      |  1 -
 drivers/pwm/pwm-jz4740.c       |  1 -
 drivers/pwm/pwm-keembay.c      |  1 -
 drivers/pwm/pwm-lp3943.c       |  1 -
 drivers/pwm/pwm-lpc18xx-sct.c  |  1 -
 drivers/pwm/pwm-lpc32xx.c      |  1 -
 drivers/pwm/pwm-lpss.c         |  1 -
 drivers/pwm/pwm-mediatek.c     |  1 -
 drivers/pwm/pwm-meson.c        |  1 -
 drivers/pwm/pwm-mtk-disp.c     |  1 -
 drivers/pwm/pwm-mxs.c          |  1 -
 drivers/pwm/pwm-omap-dmtimer.c |  1 -
 drivers/pwm/pwm-pca9685.c      |  1 -
 drivers/pwm/pwm-pxa.c          |  1 -
 drivers/pwm/pwm-rcar.c         |  1 -
 drivers/pwm/pwm-renesas-tpu.c  |  1 -
 drivers/pwm/pwm-rockchip.c     |  1 -
 drivers/pwm/pwm-samsung.c      |  1 -
 drivers/pwm/pwm-sifive.c       |  1 -
 drivers/pwm/pwm-sl28cpld.c     |  1 -
 drivers/pwm/pwm-spear.c        |  1 -
 drivers/pwm/pwm-sprd.c         |  1 -
 drivers/pwm/pwm-sti.c          |  1 -
 drivers/pwm/pwm-stm32-lp.c     |  1 -
 drivers/pwm/pwm-stm32.c        |  1 -
 drivers/pwm/pwm-stmpe.c        |  1 -
 drivers/pwm/pwm-sun4i.c        |  1 -
 drivers/pwm/pwm-tegra.c        |  1 -
 drivers/pwm/pwm-tiecap.c       |  1 -
 drivers/pwm/pwm-tiehrpwm.c     |  1 -
 drivers/pwm/pwm-twl-led.c      |  1 -
 drivers/pwm/pwm-twl.c          |  1 -
 drivers/pwm/pwm-vt8500.c       |  1 -
 55 files changed, 6 insertions(+), 71 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index e7a2d9095669..9a2e739f2020 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -37,23 +37,13 @@ static struct pwm_device *pwm_to_device(unsigned int pwm)
 	return radix_tree_lookup(&pwm_tree, pwm);
 }
 
-static int alloc_pwms(int pwm, unsigned int count)
+static int alloc_pwms(unsigned int count)
 {
-	unsigned int from = 0;
 	unsigned int start;
 
-	if (pwm >= MAX_PWMS)
-		return -EINVAL;
-
-	if (pwm >= 0)
-		from = pwm;
-
-	start = bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, from,
+	start = bitmap_find_next_zero_area(allocated_pwms, MAX_PWMS, 0,
 					   count, 0);
 
-	if (pwm >= 0 && start != pwm)
-		return -EEXIST;
-
 	if (start + count > MAX_PWMS)
 		return -ENOSPC;
 
@@ -263,8 +253,7 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  * pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
  *
- * Register a new PWM chip. If chip->base < 0 then a dynamically assigned base
- * will be used.
+ * Register a new PWM chip.
  *
  * Returns: 0 on success or a negative error code on failure.
  */
@@ -282,18 +271,18 @@ int pwmchip_add(struct pwm_chip *chip)
 
 	mutex_lock(&pwm_lock);
 
-	ret = alloc_pwms(chip->base, chip->npwm);
+	ret = alloc_pwms(chip->npwm);
 	if (ret < 0)
 		goto out;
 
+	chip->base = ret;
+
 	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
 	if (!chip->pwms) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	chip->base = ret;
-
 	for (i = 0; i < chip->npwm; i++) {
 		pwm = &chip->pwms[i];
 
diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 5b0a71243d0f..e2a26d9da25b 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -98,7 +98,6 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 
 	ab8500->chip.dev = &pdev->dev;
 	ab8500->chip.ops = &ab8500_pwm_ops;
-	ab8500->chip.base = -1;
 	ab8500->chip.npwm = 1;
 
 	err = pwmchip_add(&ab8500->chip);
diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 4551aa2c484c..6ab597e54005 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -265,7 +265,6 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->hlcdc = hlcdc;
 	chip->chip.ops = &atmel_hlcdc_pwm_ops;
 	chip->chip.dev = dev;
-	chip->chip.base = -1;
 	chip->chip.npwm = 1;
 	chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	chip->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 5ccc3e7420e9..ee70a615532b 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -454,7 +454,6 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
 	tcbpwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	tcbpwm->chip.of_pwm_n_cells = 3;
-	tcbpwm->chip.base = -1;
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->channel = channel;
 	tcbpwm->regmap = regmap;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 5813339b597b..a4d0be6b265b 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -429,7 +429,6 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	atmel_pwm->chip.of_pwm_n_cells = 3;
-	atmel_pwm->chip.base = -1;
 	atmel_pwm->chip.npwm = 4;
 
 	ret = pwmchip_add(&atmel_pwm->chip);
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index f4853c4a2d75..529a66ab692d 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -209,7 +209,6 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 
 	ip->chip.dev = &pdev->dev;
 	ip->chip.ops = &iproc_pwm_ops;
-	ip->chip.base = -1;
 	ip->chip.npwm = 4;
 	ip->chip.of_xlate = of_pwm_xlate_with_flags;
 	ip->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 717b55677573..f09a31042859 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -271,7 +271,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 
 	kp->chip.dev = &pdev->dev;
 	kp->chip.ops = &kona_pwm_ops;
-	kp->chip.base = -1;
 	kp->chip.npwm = 6;
 	kp->chip.of_xlate = of_pwm_xlate_with_flags;
 	kp->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index d593cce249d9..e4b54675b356 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -158,7 +158,6 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
-	pc->chip.base = -1;
 	pc->chip.npwm = 2;
 	pc->chip.of_xlate = of_pwm_xlate_with_flags;
 	pc->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index fe405289e582..acb6fbc3cc32 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -206,7 +206,6 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &berlin_pwm_ops;
-	pwm->chip.base = -1;
 	pwm->chip.npwm = 4;
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 8b66f9d2f589..8b1d1e7aa856 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -258,7 +258,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 
 	p->chip.dev = &pdev->dev;
 	p->chip.ops = &brcmstb_pwm_ops;
-	p->chip.base = -1;
 	p->chip.npwm = 2;
 
 	p->base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index cb1af86873ee..f3d17a590305 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -128,7 +128,6 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 
 	priv->chip.ops = &clps711x_pwm_ops;
 	priv->chip.dev = &pdev->dev;
-	priv->chip.base = -1;
 	priv->chip.npwm = 2;
 	priv->chip.of_xlate = clps711x_pwm_xlate;
 	priv->chip.of_pwm_n_cells = 1;
diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 1e2276808b7a..02522a9a3073 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -168,7 +168,6 @@ static int crystalcove_pwm_probe(struct platform_device *pdev)
 
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &crc_pwm_ops;
-	pwm->chip.base = -1;
 	pwm->chip.npwm = 1;
 
 	/* get the PMIC regmap */
diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index c1c337969e4e..d3115cb0e058 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -253,7 +253,6 @@ static int cros_ec_pwm_probe(struct platform_device *pdev)
 	chip->ops = &cros_ec_pwm_ops;
 	chip->of_xlate = cros_ec_pwm_xlate;
 	chip->of_pwm_n_cells = 1;
-	chip->base = -1;
 	ret = cros_ec_num_pwms(ec);
 	if (ret < 0) {
 		dev_err(dev, "Couldn't find PWMs: %d\n", ret);
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index f6c98e0d57c2..7568300bb11e 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -233,7 +233,6 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
-	dwc->chip.base = -1;
 
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index c9fc6f223640..4ca70794ad96 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -185,7 +185,6 @@ static int ep93xx_pwm_probe(struct platform_device *pdev)
 
 	ep93xx_pwm->chip.dev = &pdev->dev;
 	ep93xx_pwm->chip.ops = &ep93xx_pwm_ops;
-	ep93xx_pwm->chip.base = -1;
 	ep93xx_pwm->chip.npwm = 1;
 
 	ret = pwmchip_add(&ep93xx_pwm->chip);
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 2a6801226aba..0e1ae9469eda 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -453,7 +453,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc->chip.ops = &fsl_pwm_ops;
 	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
 	fpc->chip.of_pwm_n_cells = 3;
-	fpc->chip.base = -1;
 	fpc->chip.npwm = 8;
 
 	ret = pwmchip_add(&fpc->chip);
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index a1900d0a872e..82d17fc75c21 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -205,7 +205,6 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 
 	pwm_chip->chip.ops = &hibvt_pwm_ops;
 	pwm_chip->chip.dev = &pdev->dev;
-	pwm_chip->chip.base = -1;
 	pwm_chip->chip.npwm = soc->num_pwms;
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 6faf5b5a5584..cc37054589cc 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -304,7 +304,6 @@ static int img_pwm_probe(struct platform_device *pdev)
 
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &img_pwm_ops;
-	pwm->chip.base = -1;
 	pwm->chip.npwm = IMG_PWM_NPWM;
 
 	ret = pwmchip_add(&pwm->chip);
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index eec9ec4e1a2a..97c9133b6876 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -363,7 +363,6 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	tpm->chip.dev = &pdev->dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
-	tpm->chip.base = -1;
 	tpm->chip.of_xlate = of_pwm_xlate_with_flags;
 	tpm->chip.of_pwm_n_cells = 3;
 
diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index 727e0d3e249e..c957b365448e 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -155,7 +155,6 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 
 	imx->chip.ops = &pwm_imx1_ops;
 	imx->chip.dev = &pdev->dev;
-	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 18055326a2f3..ba695115c160 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -327,7 +327,6 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 
 	imx->chip.ops = &pwm_imx27_ops;
 	imx->chip.dev = &pdev->dev;
-	imx->chip.base = -1;
 	imx->chip.npwm = 1;
 
 	imx->chip.of_xlate = of_pwm_xlate_with_flags;
diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
index e9e54dda07aa..015f5eba09a1 100644
--- a/drivers/pwm/pwm-intel-lgm.c
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -207,7 +207,6 @@ static int lgm_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = dev;
 	pc->chip.ops = &lgm_pwm_ops;
 	pc->chip.npwm = 1;
-	pc->chip.base = -1;
 
 	lgm_pwm_init(pc);
 
diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 957b972c458b..6c6e26d18329 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -206,7 +206,6 @@ static int iqs620_pwm_probe(struct platform_device *pdev)
 
 	iqs620_pwm->chip.dev = &pdev->dev;
 	iqs620_pwm->chip.ops = &iqs620_pwm_ops;
-	iqs620_pwm->chip.base = -1;
 	iqs620_pwm->chip.npwm = 1;
 
 	mutex_init(&iqs620_pwm->lock);
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 00c642fa2eed..5b6bdcdcecf5 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -244,7 +244,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = info->num_pwms;
-	jz4740->chip.base = -1;
 	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
 	jz4740->chip.of_pwm_n_cells = 3;
 
diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
index cdfdef66ff8e..521a825c8ba0 100644
--- a/drivers/pwm/pwm-keembay.c
+++ b/drivers/pwm/pwm-keembay.c
@@ -203,7 +203,6 @@ static int keembay_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	priv->chip.base = -1;
 	priv->chip.dev = dev;
 	priv->chip.ops = &keembay_pwm_ops;
 	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
diff --git a/drivers/pwm/pwm-lp3943.c b/drivers/pwm/pwm-lp3943.c
index bf3f14fb5f24..7551253ada32 100644
--- a/drivers/pwm/pwm-lp3943.c
+++ b/drivers/pwm/pwm-lp3943.c
@@ -275,7 +275,6 @@ static int lp3943_pwm_probe(struct platform_device *pdev)
 	lp3943_pwm->chip.dev = &pdev->dev;
 	lp3943_pwm->chip.ops = &lp3943_pwm_ops;
 	lp3943_pwm->chip.npwm = LP3943_NUM_PWMS;
-	lp3943_pwm->chip.base = -1;
 
 	platform_set_drvdata(pdev, lp3943_pwm);
 
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 7ef40243eb6c..3f8e54ec28c6 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -370,7 +370,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 
 	lpc18xx_pwm->chip.dev = &pdev->dev;
 	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
-	lpc18xx_pwm->chip.base = -1;
 	lpc18xx_pwm->chip.npwm = 16;
 	lpc18xx_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	lpc18xx_pwm->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-lpc32xx.c b/drivers/pwm/pwm-lpc32xx.c
index 6b4090436c06..c42cc314c170 100644
--- a/drivers/pwm/pwm-lpc32xx.c
+++ b/drivers/pwm/pwm-lpc32xx.c
@@ -116,7 +116,6 @@ static int lpc32xx_pwm_probe(struct platform_device *pdev)
 	lpc32xx->chip.dev = &pdev->dev;
 	lpc32xx->chip.ops = &lpc32xx_pwm_ops;
 	lpc32xx->chip.npwm = 1;
-	lpc32xx->chip.base = -1;
 
 	ret = pwmchip_add(&lpc32xx->chip);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 939de93c157b..9ea6a176cbe5 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -234,7 +234,6 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *r,
 
 	lpwm->chip.dev = dev;
 	lpwm->chip.ops = &pwm_lpss_ops;
-	lpwm->chip.base = -1;
 	lpwm->chip.npwm = info->npwm;
 
 	ret = pwmchip_add(&lpwm->chip);
diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index fcfc3b147e5f..87fb37d43814 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -263,7 +263,6 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &pwm_mediatek_ops;
-	pc->chip.base = -1;
 	pc->chip.npwm = pc->soc->num_pwms;
 
 	ret = pwmchip_add(&pc->chip);
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index a3ce9789412a..9eb060613cb4 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -550,7 +550,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	spin_lock_init(&meson->lock);
 	meson->chip.dev = &pdev->dev;
 	meson->chip.ops = &meson_pwm_ops;
-	meson->chip.base = -1;
 	meson->chip.npwm = MESON_NUM_PWMS;
 	meson->chip.of_xlate = of_pwm_xlate_with_flags;
 	meson->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index 87c6b4bc5d43..9b3ba401a3db 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -202,7 +202,6 @@ static int mtk_disp_pwm_probe(struct platform_device *pdev)
 
 	mdp->chip.dev = &pdev->dev;
 	mdp->chip.ops = &mtk_disp_pwm_ops;
-	mdp->chip.base = -1;
 	mdp->chip.npwm = 1;
 
 	ret = pwmchip_add(&mdp->chip);
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 7ce616923c52..0266e84e982c 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -140,7 +140,6 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 	mxs->chip.ops = &mxs_pwm_ops;
 	mxs->chip.of_xlate = of_pwm_xlate_with_flags;
 	mxs->chip.of_pwm_n_cells = 3;
-	mxs->chip.base = -1;
 
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 358db4ff9d4f..612b3c859295 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -403,7 +403,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 
 	omap->chip.dev = &pdev->dev;
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
-	omap->chip.base = -1;
 	omap->chip.npwm = 1;
 	omap->chip.of_xlate = of_pwm_xlate_with_flags;
 	omap->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 4a55dc18656c..00976b2c57b2 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -493,7 +493,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
 	pca->chip.npwm = PCA9685_MAXCHAN + 1;
 
 	pca->chip.dev = &client->dev;
-	pca->chip.base = -1;
 
 	ret = pwmchip_add(&pca->chip);
 	if (ret < 0)
diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index d06cf60e6575..cfb683827d32 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -184,7 +184,6 @@ static int pwm_probe(struct platform_device *pdev)
 
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &pxa_pwm_ops;
-	pwm->chip.base = -1;
 	pwm->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
 
 	if (IS_ENABLED(CONFIG_OF)) {
diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 002ab79a7ec2..9daca0c772c7 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -224,7 +224,6 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 	rcar_pwm->chip.dev = &pdev->dev;
 	rcar_pwm->chip.ops = &rcar_pwm_ops;
-	rcar_pwm->chip.base = -1;
 	rcar_pwm->chip.npwm = 1;
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index d02b24b77cdf..e2959fae0969 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -410,7 +410,6 @@ static int tpu_probe(struct platform_device *pdev)
 	tpu->chip.ops = &tpu_pwm_ops;
 	tpu->chip.of_xlate = of_pwm_xlate_with_flags;
 	tpu->chip.of_pwm_n_cells = 3;
-	tpu->chip.base = -1;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 6ad7d0a50aed..301785fa293e 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -352,7 +352,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc->data = id->data;
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &rockchip_pwm_ops;
-	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
 	if (pc->data->supports_polarity) {
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 645d0066ff0a..515489fa4f6d 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -519,7 +519,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	chip->chip.dev = &pdev->dev;
 	chip->chip.ops = &pwm_samsung_ops;
-	chip->chip.base = -1;
 	chip->chip.npwm = SAMSUNG_PWM_NUM;
 	chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 2a7cd2deaeea..688737f091ac 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -244,7 +244,6 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	chip->ops = &pwm_sifive_ops;
 	chip->of_xlate = of_pwm_xlate_with_flags;
 	chip->of_pwm_n_cells = 3;
-	chip->base = -1;
 	chip->npwm = 4;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 0b01ec25e2f0..7a69c1a0c060 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -229,7 +229,6 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	chip = &priv->pwm_chip;
 	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
-	chip->base = -1;
 	chip->npwm = 1;
 
 	platform_set_drvdata(pdev, priv);
diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index f63b54aae1b4..1a1cedfd11ce 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -193,7 +193,6 @@ static int spear_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &spear_pwm_ops;
-	pc->chip.base = -1;
 	pc->chip.npwm = NUM_PWM;
 
 	ret = clk_prepare(pc->clk);
diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index 5123d948efd6..108cbec88667 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -268,7 +268,6 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 
 	spc->chip.dev = &pdev->dev;
 	spc->chip.ops = &sprd_pwm_ops;
-	spc->chip.base = -1;
 	spc->chip.npwm = spc->num_pwms;
 
 	ret = pwmchip_add(&spc->chip);
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 99c70e07858d..aa2b211d7ee3 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -619,7 +619,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
-	pc->chip.base = -1;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
 	ret = pwmchip_add(&pc->chip);
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 134c14621ee0..af08f564ef1d 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -205,7 +205,6 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->chip.base = -1;
 	priv->chip.dev = &pdev->dev;
 	priv->chip.ops = &stm32_pwm_lp_ops;
 	priv->chip.npwm = 1;
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index d3be944f2ae9..c46fb90036ab 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -633,7 +633,6 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	stm32_pwm_detect_complementary(priv);
 
-	priv->chip.base = -1;
 	priv->chip.dev = dev;
 	priv->chip.ops = &stm32pwm_ops;
 	priv->chip.npwm = stm32_pwm_detect_channels(priv);
diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index be5f6d7359d4..9dc983a3cbf1 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -278,7 +278,6 @@ static int __init stmpe_pwm_probe(struct platform_device *pdev)
 
 	pwm->stmpe = stmpe;
 	pwm->chip.dev = &pdev->dev;
-	pwm->chip.base = -1;
 
 	if (stmpe->partnum == STMPE2401 || stmpe->partnum == STMPE2403) {
 		pwm->chip.ops = &stmpe_24xx_pwm_ops;
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index ce5c4fc8da6f..e01becd102c0 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -459,7 +459,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
-	pwm->chip.base = -1;
 	pwm->chip.npwm = pwm->data->npwm;
 	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm->chip.of_pwm_n_cells = 3;
diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 55bc63d5a0ae..c529a170bcdd 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -285,7 +285,6 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &tegra_pwm_ops;
-	pwm->chip.base = -1;
 	pwm->chip.npwm = pwm->soc->num_channels;
 
 	ret = pwmchip_add(&pwm->chip);
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 2a8949014bb1..b9a17ab0c202 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -226,7 +226,6 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	pc->chip.ops = &ecap_pwm_ops;
 	pc->chip.of_xlate = of_pwm_xlate_with_flags;
 	pc->chip.of_pwm_n_cells = 3;
-	pc->chip.base = -1;
 	pc->chip.npwm = 1;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index a7fb224d6535..90095a19bf2d 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -449,7 +449,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	pc->chip.ops = &ehrpwm_pwm_ops;
 	pc->chip.of_xlate = of_pwm_xlate_with_flags;
 	pc->chip.of_pwm_n_cells = 3;
-	pc->chip.base = -1;
 	pc->chip.npwm = NUM_PWM_CHANNEL;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index 630b9a578820..6c8df5f4e87d 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -291,7 +291,6 @@ static int twl_pwmled_probe(struct platform_device *pdev)
 	}
 
 	twl->chip.dev = &pdev->dev;
-	twl->chip.base = -1;
 
 	mutex_init(&twl->mutex);
 
diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index aee67974f353..e83a826bf621 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -310,7 +310,6 @@ static int twl_pwm_probe(struct platform_device *pdev)
 		twl->chip.ops = &twl6030_pwm_ops;
 
 	twl->chip.dev = &pdev->dev;
-	twl->chip.base = -1;
 	twl->chip.npwm = 2;
 
 	mutex_init(&twl->mutex);
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 6e36851a22bb..52fe5d19473a 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -209,7 +209,6 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	chip->chip.ops = &vt8500_pwm_ops;
 	chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	chip->chip.of_pwm_n_cells = 3;
-	chip->chip.base = -1;
 	chip->chip.npwm = VT8500_NR_PWMS;
 
 	chip->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.30.1

