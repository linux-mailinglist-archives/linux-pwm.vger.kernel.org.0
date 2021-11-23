Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86CCB459F3D
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 10:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235019AbhKWJdG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 04:33:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhKWJdG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 04:33:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D8DC061574
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 01:29:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7f-0004zL-Ou; Tue, 23 Nov 2021 10:29:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7c-000acF-BY; Tue, 23 Nov 2021 10:29:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7b-0004Y7-1M; Tue, 23 Nov 2021 10:29:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Ed Blake <ed.blake@sondrel.com>,
        Naidu Tellapati <naidu.tellapati@imgtec.com>
Subject: [PATCH 1/5] pwm: img: Rename variable pointing to driver private data
Date:   Tue, 23 Nov 2021 10:29:35 +0100
Message-Id: <20211123092939.82705-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
References: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=iC95otp/xmDi3haHfWLDlVPa4inshvMo2QxKqGV2Bqs=; m=dRlnDlBOR7S8oNvrSjMiReMwSuZQ61g/lQGYClDgAZQ=; p=V7ZGHSrVaMMCh+7Y6Dp/Ech/sZ2I3gCiPNWCsKCbfNs=; g=9ce875b5e14f4146204171c5caf4ed53466d8bb8
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGctHIACgkQwfwUeK3K7AkJlQf/ZjH ss7Do9QVK8pLn5P273z8tolTt+wHN+nVaLIzwP7GlqjxLsCqxLAOvaHLL3DANeQzyw82f8wiAlMN4 EnOzivRo7GENTbBuy1aqNjYit0gadpcIXXV0Ef0MSmC4vnV2L9AFyXhA48f4d77WnWMLdbTosGLxr OTFhT47EqUdhk4MMNBLob4oIxKwZnIjGCWFnzJAgglrNvfJOc7+EgaAoCWLMkL8XGDGMXSFolz1Lq m4xUnWhuhWISFaOe/grrNMeeL6cGwhTEFJkJr6n/oPT0LqKTH4r1cdBm0MWpqjOqs4maYsQD42iTA fpWXDOR59UE7x5ecxlbQOVvhRiavFJQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Status quo is that variables of type struct img_pwm_chip * are named
"pwm_chip", "pwm" or "chip" which are all not optimal because there is a
struct pwm_chip in the core, usually only struct pwm_device * variables are
named "pwm" and "chip" is usually used for variabled of type struct
pwm_chip *.

So consistently use the same and non-conflicting name "imgchip".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 141 +++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 71 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index f97f82548293..de0c34149d0b 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -77,16 +77,15 @@ static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct img_pwm_chip, chip);
 }
 
-static inline void img_pwm_writel(struct img_pwm_chip *chip,
+static inline void img_pwm_writel(struct img_pwm_chip *imgchip,
 				  u32 reg, u32 val)
 {
-	writel(val, chip->base + reg);
+	writel(val, imgchip->base + reg);
 }
 
-static inline u32 img_pwm_readl(struct img_pwm_chip *chip,
-					 u32 reg)
+static inline u32 img_pwm_readl(struct img_pwm_chip *imgchip, u32 reg)
 {
-	return readl(chip->base + reg);
+	return readl(imgchip->base + reg);
 }
 
 static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -94,17 +93,17 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	u32 val, div, duty, timebase;
 	unsigned long mul, output_clk_hz, input_clk_hz;
-	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
-	unsigned int max_timebase = pwm_chip->data->max_timebase;
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
+	unsigned int max_timebase = imgchip->data->max_timebase;
 	int ret;
 
-	if (period_ns < pwm_chip->min_period_ns ||
-	    period_ns > pwm_chip->max_period_ns) {
+	if (period_ns < imgchip->min_period_ns ||
+	    period_ns > imgchip->max_period_ns) {
 		dev_err(chip->dev, "configured period not in range\n");
 		return -ERANGE;
 	}
 
-	input_clk_hz = clk_get_rate(pwm_chip->pwm_clk);
+	input_clk_hz = clk_get_rate(imgchip->pwm_clk);
 	output_clk_hz = DIV_ROUND_UP(NSEC_PER_SEC, period_ns);
 
 	mul = DIV_ROUND_UP(input_clk_hz, output_clk_hz);
@@ -134,15 +133,15 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
-	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
+	val = img_pwm_readl(imgchip, PWM_CTRL_CFG);
 	val &= ~(PWM_CTRL_CFG_DIV_MASK << PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm));
 	val |= (div & PWM_CTRL_CFG_DIV_MASK) <<
 		PWM_CTRL_CFG_DIV_SHIFT(pwm->hwpwm);
-	img_pwm_writel(pwm_chip, PWM_CTRL_CFG, val);
+	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
 	val = (duty << PWM_CH_CFG_DUTY_SHIFT) |
 	      (timebase << PWM_CH_CFG_TMBASE_SHIFT);
-	img_pwm_writel(pwm_chip, PWM_CH_CFG(pwm->hwpwm), val);
+	img_pwm_writel(imgchip, PWM_CH_CFG(pwm->hwpwm), val);
 
 	pm_runtime_mark_last_busy(chip->dev);
 	pm_runtime_put_autosuspend(chip->dev);
@@ -153,18 +152,18 @@ static int img_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	u32 val;
-	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 	int ret;
 
 	ret = pm_runtime_resume_and_get(chip->dev);
 	if (ret < 0)
 		return ret;
 
-	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
+	val = img_pwm_readl(imgchip, PWM_CTRL_CFG);
 	val |= BIT(pwm->hwpwm);
-	img_pwm_writel(pwm_chip, PWM_CTRL_CFG, val);
+	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
-	regmap_update_bits(pwm_chip->periph_regs, PERIP_PWM_PDM_CONTROL,
+	regmap_update_bits(imgchip->periph_regs, PERIP_PWM_PDM_CONTROL,
 			   PERIP_PWM_PDM_CONTROL_CH_MASK <<
 			   PERIP_PWM_PDM_CONTROL_CH_SHIFT(pwm->hwpwm), 0);
 
@@ -174,11 +173,11 @@ static int img_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void img_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	u32 val;
-	struct img_pwm_chip *pwm_chip = to_img_pwm_chip(chip);
+	struct img_pwm_chip *imgchip = to_img_pwm_chip(chip);
 
-	val = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
+	val = img_pwm_readl(imgchip, PWM_CTRL_CFG);
 	val &= ~BIT(pwm->hwpwm);
-	img_pwm_writel(pwm_chip, PWM_CTRL_CFG, val);
+	img_pwm_writel(imgchip, PWM_CTRL_CFG, val);
 
 	pm_runtime_mark_last_busy(chip->dev);
 	pm_runtime_put_autosuspend(chip->dev);
@@ -206,29 +205,29 @@ MODULE_DEVICE_TABLE(of, img_pwm_of_match);
 
 static int img_pwm_runtime_suspend(struct device *dev)
 {
-	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
 
-	clk_disable_unprepare(pwm_chip->pwm_clk);
-	clk_disable_unprepare(pwm_chip->sys_clk);
+	clk_disable_unprepare(imgchip->pwm_clk);
+	clk_disable_unprepare(imgchip->sys_clk);
 
 	return 0;
 }
 
 static int img_pwm_runtime_resume(struct device *dev)
 {
-	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(pwm_chip->sys_clk);
+	ret = clk_prepare_enable(imgchip->sys_clk);
 	if (ret < 0) {
 		dev_err(dev, "could not prepare or enable sys clock\n");
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pwm_chip->pwm_clk);
+	ret = clk_prepare_enable(imgchip->pwm_clk);
 	if (ret < 0) {
 		dev_err(dev, "could not prepare or enable pwm clock\n");
-		clk_disable_unprepare(pwm_chip->sys_clk);
+		clk_disable_unprepare(imgchip->sys_clk);
 		return ret;
 	}
 
@@ -240,42 +239,42 @@ static int img_pwm_probe(struct platform_device *pdev)
 	int ret;
 	u64 val;
 	unsigned long clk_rate;
-	struct img_pwm_chip *pwm;
+	struct img_pwm_chip *imgchip;
 	const struct of_device_id *of_dev_id;
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	imgchip = devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
+	if (!imgchip)
 		return -ENOMEM;
 
-	pwm->dev = &pdev->dev;
+	imgchip->dev = &pdev->dev;
 
-	pwm->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pwm->base))
-		return PTR_ERR(pwm->base);
+	imgchip->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(imgchip->base))
+		return PTR_ERR(imgchip->base);
 
 	of_dev_id = of_match_device(img_pwm_of_match, &pdev->dev);
 	if (!of_dev_id)
 		return -ENODEV;
-	pwm->data = of_dev_id->data;
+	imgchip->data = of_dev_id->data;
 
-	pwm->periph_regs = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
-							   "img,cr-periph");
-	if (IS_ERR(pwm->periph_regs))
-		return PTR_ERR(pwm->periph_regs);
+	imgchip->periph_regs = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
+							       "img,cr-periph");
+	if (IS_ERR(imgchip->periph_regs))
+		return PTR_ERR(imgchip->periph_regs);
 
-	pwm->sys_clk = devm_clk_get(&pdev->dev, "sys");
-	if (IS_ERR(pwm->sys_clk)) {
+	imgchip->sys_clk = devm_clk_get(&pdev->dev, "sys");
+	if (IS_ERR(imgchip->sys_clk)) {
 		dev_err(&pdev->dev, "failed to get system clock\n");
-		return PTR_ERR(pwm->sys_clk);
+		return PTR_ERR(imgchip->sys_clk);
 	}
 
-	pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
-	if (IS_ERR(pwm->pwm_clk)) {
-		dev_err(&pdev->dev, "failed to get pwm clock\n");
-		return PTR_ERR(pwm->pwm_clk);
+	imgchip->pwm_clk = devm_clk_get(&pdev->dev, "imgchip");
+	if (IS_ERR(imgchip->pwm_clk)) {
+		dev_err(&pdev->dev, "failed to get imgchip clock\n");
+		return PTR_ERR(imgchip->pwm_clk);
 	}
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, imgchip);
 
 	pm_runtime_set_autosuspend_delay(&pdev->dev, IMG_PWM_PM_TIMEOUT);
 	pm_runtime_use_autosuspend(&pdev->dev);
@@ -286,27 +285,27 @@ static int img_pwm_probe(struct platform_device *pdev)
 			goto err_pm_disable;
 	}
 
-	clk_rate = clk_get_rate(pwm->pwm_clk);
+	clk_rate = clk_get_rate(imgchip->pwm_clk);
 	if (!clk_rate) {
-		dev_err(&pdev->dev, "pwm clock has no frequency\n");
+		dev_err(&pdev->dev, "imgchip clock has no frequency\n");
 		ret = -EINVAL;
 		goto err_suspend;
 	}
 
 	/* The maximum input clock divider is 512 */
-	val = (u64)NSEC_PER_SEC * 512 * pwm->data->max_timebase;
+	val = (u64)NSEC_PER_SEC * 512 * imgchip->data->max_timebase;
 	do_div(val, clk_rate);
-	pwm->max_period_ns = val;
+	imgchip->max_period_ns = val;
 
 	val = (u64)NSEC_PER_SEC * MIN_TMBASE_STEPS;
 	do_div(val, clk_rate);
-	pwm->min_period_ns = val;
+	imgchip->min_period_ns = val;
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &img_pwm_ops;
-	pwm->chip.npwm = IMG_PWM_NPWM;
+	imgchip->chip.dev = &pdev->dev;
+	imgchip->chip.ops = &img_pwm_ops;
+	imgchip->chip.npwm = IMG_PWM_NPWM;
 
-	ret = pwmchip_add(&pwm->chip);
+	ret = pwmchip_add(&imgchip->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add failed: %d\n", ret);
 		goto err_suspend;
@@ -325,13 +324,13 @@ static int img_pwm_probe(struct platform_device *pdev)
 
 static int img_pwm_remove(struct platform_device *pdev)
 {
-	struct img_pwm_chip *pwm_chip = platform_get_drvdata(pdev);
+	struct img_pwm_chip *imgchip = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_pwm_runtime_suspend(&pdev->dev);
 
-	pwmchip_remove(&pwm_chip->chip);
+	pwmchip_remove(&imgchip->chip);
 
 	return 0;
 }
@@ -339,7 +338,7 @@ static int img_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int img_pwm_suspend(struct device *dev)
 {
-	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
 	int i, ret;
 
 	if (pm_runtime_status_suspended(dev)) {
@@ -348,11 +347,11 @@ static int img_pwm_suspend(struct device *dev)
 			return ret;
 	}
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++)
-		pwm_chip->suspend_ch_cfg[i] = img_pwm_readl(pwm_chip,
-							    PWM_CH_CFG(i));
+	for (i = 0; i < imgchip->chip.npwm; i++)
+		imgchip->suspend_ch_cfg[i] = img_pwm_readl(imgchip,
+							   PWM_CH_CFG(i));
 
-	pwm_chip->suspend_ctrl_cfg = img_pwm_readl(pwm_chip, PWM_CTRL_CFG);
+	imgchip->suspend_ctrl_cfg = img_pwm_readl(imgchip, PWM_CTRL_CFG);
 
 	img_pwm_runtime_suspend(dev);
 
@@ -361,7 +360,7 @@ static int img_pwm_suspend(struct device *dev)
 
 static int img_pwm_resume(struct device *dev)
 {
-	struct img_pwm_chip *pwm_chip = dev_get_drvdata(dev);
+	struct img_pwm_chip *imgchip = dev_get_drvdata(dev);
 	int ret;
 	int i;
 
@@ -369,15 +368,15 @@ static int img_pwm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++)
-		img_pwm_writel(pwm_chip, PWM_CH_CFG(i),
-			       pwm_chip->suspend_ch_cfg[i]);
+	for (i = 0; i < imgchip->chip.npwm; i++)
+		img_pwm_writel(imgchip, PWM_CH_CFG(i),
+			       imgchip->suspend_ch_cfg[i]);
 
-	img_pwm_writel(pwm_chip, PWM_CTRL_CFG, pwm_chip->suspend_ctrl_cfg);
+	img_pwm_writel(imgchip, PWM_CTRL_CFG, imgchip->suspend_ctrl_cfg);
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++)
-		if (pwm_chip->suspend_ctrl_cfg & BIT(i))
-			regmap_update_bits(pwm_chip->periph_regs,
+	for (i = 0; i < imgchip->chip.npwm; i++)
+		if (imgchip->suspend_ctrl_cfg & BIT(i))
+			regmap_update_bits(imgchip->periph_regs,
 					   PERIP_PWM_PDM_CONTROL,
 					   PERIP_PWM_PDM_CONTROL_CH_MASK <<
 					   PERIP_PWM_PDM_CONTROL_CH_SHIFT(i),
-- 
2.30.2

