Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 826E8459F3B
	for <lists+linux-pwm@lfdr.de>; Tue, 23 Nov 2021 10:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbhKWJdF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 23 Nov 2021 04:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234917AbhKWJdF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 23 Nov 2021 04:33:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3DCC061714
        for <linux-pwm@vger.kernel.org>; Tue, 23 Nov 2021 01:29:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7e-0004zM-28; Tue, 23 Nov 2021 10:29:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7c-000acI-Ba; Tue, 23 Nov 2021 10:29:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mpS7b-0004YV-89; Tue, 23 Nov 2021 10:29:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Sean Anderson <sean.anderson@seco.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/5] pwm: tegra: Rename variable pointing to driver private data
Date:   Tue, 23 Nov 2021 10:29:36 +0100
Message-Id: <20211123092939.82705-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
References: <20211123092939.82705-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Kc9bK9WyJGl8CZVDVUdD2NvGaRW2SH5YoDRJ62CNx+E=; m=oDBxZ6V4YK8cJWQqCcYU91ygddyoMeyIeexX69RkOh8=; p=0Uer0kF+EnjVLPDMD8FNlUJmRPPcTIXQ6KLeSNrZ3LI=; g=a7001b314ef319505fb4801cf47c50271396e65a
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGctHYACgkQwfwUeK3K7Am18Af9E0b 4TLiZiWiPjEGinG9RYUbsObSrFkonzVz1vyY/Ck6s3qTkCJc+ee/HDwAxh9DQPlQVd1XsklMVWLlr 6c7XbovtGp9Q0yTw7YA3k6iLeFji20Xn/rsOD6d46Xs0bd+1OLxstcQRIuJUvBrZzl96KRELik1Tc RvPB6eho44Op2ezBzEFGxICwDDx4CrN98BwPv8mVjVcHaoA37hadm4Amnf+8AXOEY+YaMTM73oph2 YV3Hi45Xpt5NB2RSYFeichS9X9oRLKkJzmcRUgBtyJz5vvYJVfakiyqzMVltswvp4UIiq+Y8Sc9aA vnj7XBOoTZTfMeuQ2lm+MRDdd3W6dyA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Status quo is that variables of type struct tegra_pwm_chip * are named
"pwm", "chip" or "pc". The two formers are all not optimal because
usually only struct pwm_device * variables are named "pwm" and "chip" is
usually used for variabled of type struct pwm_chip *.

So consistently use the same and non-conflicting name "pc".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tegra.c | 58 ++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 11a10b575ace..0cc8475e0071 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -81,15 +81,15 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct tegra_pwm_chip, chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *chip, unsigned int num)
+static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int num)
 {
-	return readl(chip->regs + (num << 4));
+	return readl(pc->regs + (num << 4));
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *chip, unsigned int num,
+static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int num,
 			     unsigned long val)
 {
-	writel(val, chip->regs + (num << 4));
+	writel(val, pc->regs + (num << 4));
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -236,28 +236,28 @@ static const struct pwm_ops tegra_pwm_ops = {
 
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
-	struct tegra_pwm_chip *pwm;
+	struct tegra_pwm_chip *pc;
 	int ret;
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
 		return -ENOMEM;
 
-	pwm->soc = of_device_get_match_data(&pdev->dev);
-	pwm->dev = &pdev->dev;
+	pc->soc = of_device_get_match_data(&pdev->dev);
+	pc->dev = &pdev->dev;
 
-	pwm->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pwm->regs))
-		return PTR_ERR(pwm->regs);
+	pc->regs = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->regs))
+		return PTR_ERR(pc->regs);
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, pc);
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk))
-		return PTR_ERR(pwm->clk);
+	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pc->clk))
+		return PTR_ERR(pc->clk);
 
 	/* Set maximum frequency of the IP */
-	ret = clk_set_rate(pwm->clk, pwm->soc->max_frequency);
+	ret = clk_set_rate(pc->clk, pc->soc->max_frequency);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Failed to set max frequency: %d\n", ret);
 		return ret;
@@ -268,29 +268,29 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	 * clock register resolutions. Get the configured frequency
 	 * so that PWM period can be calculated more accurately.
 	 */
-	pwm->clk_rate = clk_get_rate(pwm->clk);
+	pc->clk_rate = clk_get_rate(pc->clk);
 
 	/* Set minimum limit of PWM period for the IP */
-	pwm->min_period_ns =
-	    (NSEC_PER_SEC / (pwm->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
+	pc->min_period_ns =
+	    (NSEC_PER_SEC / (pc->soc->max_frequency >> PWM_DUTY_WIDTH)) + 1;
 
-	pwm->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
-	if (IS_ERR(pwm->rst)) {
-		ret = PTR_ERR(pwm->rst);
+	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
+	if (IS_ERR(pc->rst)) {
+		ret = PTR_ERR(pc->rst);
 		dev_err(&pdev->dev, "Reset control is not found: %d\n", ret);
 		return ret;
 	}
 
-	reset_control_deassert(pwm->rst);
+	reset_control_deassert(pc->rst);
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &tegra_pwm_ops;
-	pwm->chip.npwm = pwm->soc->num_channels;
+	pc->chip.dev = &pdev->dev;
+	pc->chip.ops = &tegra_pwm_ops;
+	pc->chip.npwm = pc->soc->num_channels;
 
-	ret = pwmchip_add(&pwm->chip);
+	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-		reset_control_assert(pwm->rst);
+		reset_control_assert(pc->rst);
 		return ret;
 	}
 
-- 
2.30.2

