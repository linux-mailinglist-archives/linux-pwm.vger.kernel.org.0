Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4373A33B0BB
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Mar 2021 12:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCOLLy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 15 Mar 2021 07:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbhCOLL3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 15 Mar 2021 07:11:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E12DC061574
        for <linux-pwm@vger.kernel.org>; Mon, 15 Mar 2021 04:11:29 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lLl8A-0006YL-Rh; Mon, 15 Mar 2021 12:11:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lLl8A-00033H-H8; Mon, 15 Mar 2021 12:11:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 4/4] pwm: Simplify all drivers with explicit of_pwm_n_cells = 3
Date:   Mon, 15 Mar 2021 12:11:24 +0100
Message-Id: <20210315111124.2475274-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
References: <20210315111124.2475274-1-u.kleine-koenig@pengutronix.de>
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

With the previous commit there is no need for the lowlevel driver any
more to specify it it uses two or three cells. So simplify accordingly.

The only non-trival change affects the pwm-rockchip driver: It used to only
support three cells if the hardware supports polarity. Now the default
number depends on the device tree which has to match hardware anyhow
(and if it doesn't the error is just a bit delayed as a PWM handle with
an inverted setting is catched when pwm_apply_state() is called).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c  | 2 --
 drivers/pwm/pwm-atmel-tcb.c    | 2 --
 drivers/pwm/pwm-atmel.c        | 2 --
 drivers/pwm/pwm-bcm-iproc.c    | 2 --
 drivers/pwm/pwm-bcm-kona.c     | 2 --
 drivers/pwm/pwm-bcm2835.c      | 2 --
 drivers/pwm/pwm-berlin.c       | 2 --
 drivers/pwm/pwm-fsl-ftm.c      | 2 --
 drivers/pwm/pwm-hibvt.c        | 2 --
 drivers/pwm/pwm-imx-tpm.c      | 2 --
 drivers/pwm/pwm-imx27.c        | 3 ---
 drivers/pwm/pwm-jz4740.c       | 2 --
 drivers/pwm/pwm-lpc18xx-sct.c  | 2 --
 drivers/pwm/pwm-meson.c        | 2 --
 drivers/pwm/pwm-mxs.c          | 2 --
 drivers/pwm/pwm-omap-dmtimer.c | 2 --
 drivers/pwm/pwm-renesas-tpu.c  | 2 --
 drivers/pwm/pwm-rockchip.c     | 5 -----
 drivers/pwm/pwm-samsung.c      | 3 ---
 drivers/pwm/pwm-sifive.c       | 2 --
 drivers/pwm/pwm-stm32-lp.c     | 2 --
 drivers/pwm/pwm-stm32.c        | 2 --
 drivers/pwm/pwm-sun4i.c        | 2 --
 drivers/pwm/pwm-tiecap.c       | 2 --
 drivers/pwm/pwm-tiehrpwm.c     | 2 --
 drivers/pwm/pwm-vt8500.c       | 2 --
 26 files changed, 57 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 6ab597e54005..4459325d3650 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -266,8 +266,6 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 	chip->chip.ops = &atmel_hlcdc_pwm_ops;
 	chip->chip.dev = dev;
 	chip->chip.npwm = 1;
-	chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&chip->chip);
 	if (ret) {
diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 8451d3e846be..bf398f21484d 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -469,8 +469,6 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 
 	tcbpwm->chip.dev = &pdev->dev;
 	tcbpwm->chip.ops = &atmel_tcb_pwm_ops;
-	tcbpwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	tcbpwm->chip.of_pwm_n_cells = 3;
 	tcbpwm->chip.npwm = NPWM;
 	tcbpwm->channel = channel;
 	tcbpwm->regmap = regmap;
diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index a4d0be6b265b..b5ab401159f8 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -427,8 +427,6 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
-	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	atmel_pwm->chip.of_pwm_n_cells = 3;
 	atmel_pwm->chip.npwm = 4;
 
 	ret = pwmchip_add(&atmel_pwm->chip);
diff --git a/drivers/pwm/pwm-bcm-iproc.c b/drivers/pwm/pwm-bcm-iproc.c
index 529a66ab692d..5af713d96575 100644
--- a/drivers/pwm/pwm-bcm-iproc.c
+++ b/drivers/pwm/pwm-bcm-iproc.c
@@ -210,8 +210,6 @@ static int iproc_pwmc_probe(struct platform_device *pdev)
 	ip->chip.dev = &pdev->dev;
 	ip->chip.ops = &iproc_pwm_ops;
 	ip->chip.npwm = 4;
-	ip->chip.of_xlate = of_pwm_xlate_with_flags;
-	ip->chip.of_pwm_n_cells = 3;
 
 	ip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(ip->base))
diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index f09a31042859..a228c3e4b2dc 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -272,8 +272,6 @@ static int kona_pwmc_probe(struct platform_device *pdev)
 	kp->chip.dev = &pdev->dev;
 	kp->chip.ops = &kona_pwm_ops;
 	kp->chip.npwm = 6;
-	kp->chip.of_xlate = of_pwm_xlate_with_flags;
-	kp->chip.of_pwm_n_cells = 3;
 
 	kp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kp->base))
diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index e4b54675b356..5783768aeeba 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -159,8 +159,6 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 
 	platform_set_drvdata(pdev, pc);
 
diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index acb6fbc3cc32..a7fa6a4bf1c9 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -207,8 +207,6 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &berlin_pwm_ops;
 	pwm->chip.npwm = 4;
-	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&pwm->chip);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 0e1ae9469eda..96ccd772280c 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -451,8 +451,6 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 
 
 	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.of_xlate = of_pwm_xlate_with_flags;
-	fpc->chip.of_pwm_n_cells = 3;
 	fpc->chip.npwm = 8;
 
 	ret = pwmchip_add(&fpc->chip);
diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 82d17fc75c21..4a6e9ad3c0ff 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -206,8 +206,6 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.ops = &hibvt_pwm_ops;
 	pwm_chip->chip.dev = &pdev->dev;
 	pwm_chip->chip.npwm = soc->num_pwms;
-	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm_chip->chip.of_pwm_n_cells = 3;
 	pwm_chip->soc = soc;
 
 	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 97c9133b6876..dbb50493abdd 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -363,8 +363,6 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	tpm->chip.dev = &pdev->dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
-	tpm->chip.of_xlate = of_pwm_xlate_with_flags;
-	tpm->chip.of_pwm_n_cells = 3;
 
 	/* get number of channels */
 	val = readl(tpm->base + PWM_IMX_TPM_PARAM);
diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index ba695115c160..f6588a96fbd9 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -329,9 +329,6 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	imx->chip.dev = &pdev->dev;
 	imx->chip.npwm = 1;
 
-	imx->chip.of_xlate = of_pwm_xlate_with_flags;
-	imx->chip.of_pwm_n_cells = 3;
-
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 5b6bdcdcecf5..990e7904c7f1 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -244,8 +244,6 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	jz4740->chip.dev = dev;
 	jz4740->chip.ops = &jz4740_pwm_ops;
 	jz4740->chip.npwm = info->num_pwms;
-	jz4740->chip.of_xlate = of_pwm_xlate_with_flags;
-	jz4740->chip.of_pwm_n_cells = 3;
 
 	platform_set_drvdata(pdev, jz4740);
 
diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 3f8e54ec28c6..a586e9233f87 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -371,8 +371,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->chip.dev = &pdev->dev;
 	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
 	lpc18xx_pwm->chip.npwm = 16;
-	lpc18xx_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	lpc18xx_pwm->chip.of_pwm_n_cells = 3;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 9eb060613cb4..595afec53a2d 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -551,8 +551,6 @@ static int meson_pwm_probe(struct platform_device *pdev)
 	meson->chip.dev = &pdev->dev;
 	meson->chip.ops = &meson_pwm_ops;
 	meson->chip.npwm = MESON_NUM_PWMS;
-	meson->chip.of_xlate = of_pwm_xlate_with_flags;
-	meson->chip.of_pwm_n_cells = 3;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
diff --git a/drivers/pwm/pwm-mxs.c b/drivers/pwm/pwm-mxs.c
index 0266e84e982c..a22180803bd7 100644
--- a/drivers/pwm/pwm-mxs.c
+++ b/drivers/pwm/pwm-mxs.c
@@ -138,8 +138,6 @@ static int mxs_pwm_probe(struct platform_device *pdev)
 
 	mxs->chip.dev = &pdev->dev;
 	mxs->chip.ops = &mxs_pwm_ops;
-	mxs->chip.of_xlate = of_pwm_xlate_with_flags;
-	mxs->chip.of_pwm_n_cells = 3;
 
 	ret = of_property_read_u32(np, "fsl,pwm-number", &mxs->chip.npwm);
 	if (ret < 0) {
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 612b3c859295..507a2d945b90 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -404,8 +404,6 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	omap->chip.dev = &pdev->dev;
 	omap->chip.ops = &pwm_omap_dmtimer_ops;
 	omap->chip.npwm = 1;
-	omap->chip.of_xlate = of_pwm_xlate_with_flags;
-	omap->chip.of_pwm_n_cells = 3;
 
 	mutex_init(&omap->mutex);
 
diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index e2959fae0969..b853e7942605 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -408,8 +408,6 @@ static int tpu_probe(struct platform_device *pdev)
 
 	tpu->chip.dev = &pdev->dev;
 	tpu->chip.ops = &tpu_pwm_ops;
-	tpu->chip.of_xlate = of_pwm_xlate_with_flags;
-	tpu->chip.of_pwm_n_cells = 3;
 	tpu->chip.npwm = TPU_CHANNEL_MAX;
 
 	pm_runtime_enable(&pdev->dev);
diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 301785fa293e..cbe900877724 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -354,11 +354,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc->chip.ops = &rockchip_pwm_ops;
 	pc->chip.npwm = 1;
 
-	if (pc->data->supports_polarity) {
-		pc->chip.of_xlate = of_pwm_xlate_with_flags;
-		pc->chip.of_pwm_n_cells = 3;
-	}
-
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = (ctrl & enable_conf) == enable_conf;
diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 515489fa4f6d..f6c528f02d43 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -526,9 +526,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
-
-		chip->chip.of_xlate = of_pwm_xlate_with_flags;
-		chip->chip.of_pwm_n_cells = 3;
 	} else {
 		if (!pdev->dev.platform_data) {
 			dev_err(&pdev->dev, "no platform data specified\n");
diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 688737f091ac..420edc4aa94a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -242,8 +242,6 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 	chip = &ddata->chip;
 	chip->dev = dev;
 	chip->ops = &pwm_sifive_ops;
-	chip->of_xlate = of_pwm_xlate_with_flags;
-	chip->of_pwm_n_cells = 3;
 	chip->npwm = 4;
 
 	ddata->regs = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index af08f564ef1d..93dd03618465 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -208,8 +208,6 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	priv->chip.dev = &pdev->dev;
 	priv->chip.ops = &stm32_pwm_lp_ops;
 	priv->chip.npwm = 1;
-	priv->chip.of_xlate = of_pwm_xlate_with_flags;
-	priv->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index c46fb90036ab..794ca5b02968 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -621,8 +621,6 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
 	priv->max_arr = ddata->max_arr;
-	priv->chip.of_xlate = of_pwm_xlate_with_flags;
-	priv->chip.of_pwm_n_cells = 3;
 
 	if (!priv->regmap || !priv->clk)
 		return -EINVAL;
diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index e01becd102c0..c952604e91f3 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -460,8 +460,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.npwm = pwm->data->npwm;
-	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm->chip.of_pwm_n_cells = 3;
 
 	spin_lock_init(&pwm->ctrl_lock);
 
diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index b9a17ab0c202..f40975fcb195 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -224,8 +224,6 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ecap_pwm_ops;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.npwm = 1;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 90095a19bf2d..17909fa53211 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -447,8 +447,6 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &ehrpwm_pwm_ops;
-	pc->chip.of_xlate = of_pwm_xlate_with_flags;
-	pc->chip.of_pwm_n_cells = 3;
 	pc->chip.npwm = NUM_PWM_CHANNEL;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 52fe5d19473a..f9eb36be9088 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -207,8 +207,6 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 
 	chip->chip.dev = &pdev->dev;
 	chip->chip.ops = &vt8500_pwm_ops;
-	chip->chip.of_xlate = of_pwm_xlate_with_flags;
-	chip->chip.of_pwm_n_cells = 3;
 	chip->chip.npwm = VT8500_NR_PWMS;
 
 	chip->clk = devm_clk_get(&pdev->dev, NULL);
-- 
2.30.1

