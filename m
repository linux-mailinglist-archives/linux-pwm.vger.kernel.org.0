Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEBB0372AEB
	for <lists+linux-pwm@lfdr.de>; Tue,  4 May 2021 15:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbhEDN0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 4 May 2021 09:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbhEDN0i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 4 May 2021 09:26:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC33C06174A
        for <linux-pwm@vger.kernel.org>; Tue,  4 May 2021 06:25:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldv3W-0001tH-Df; Tue, 04 May 2021 15:25:42 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ldv3V-0008SF-Am; Tue, 04 May 2021 15:25:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Thomas Hebb <tommyhebb@gmail.com>,
        Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 1/4] pwm: berlin: use consistent naming for variables
Date:   Tue,  4 May 2021 15:25:34 +0200
Message-Id: <20210504132537.62072-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

A struct berlin_pwm_chip* is now always called "bpc" (instead of "pwm"
which is usually used for struct pwm_device* or "chip" which is usually
used for struct pwm_chip*). The struct pwm_device* variables were named
"pwm_dev" or "pwm"; they is now always called "pwm".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 120 +++++++++++++++++++--------------------
 1 file changed, 60 insertions(+), 60 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index acb6fbc3cc32..0310d28408ed 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -56,17 +56,17 @@ static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct berlin_pwm_chip, chip);
 }
 
-static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *chip,
+static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *bpc,
 				   unsigned int channel, unsigned long offset)
 {
-	return readl_relaxed(chip->base + channel * 0x10 + offset);
+	return readl_relaxed(bpc->base + channel * 0x10 + offset);
 }
 
-static inline void berlin_pwm_writel(struct berlin_pwm_chip *chip,
+static inline void berlin_pwm_writel(struct berlin_pwm_chip *bpc,
 				     unsigned int channel, u32 value,
 				     unsigned long offset)
 {
-	writel_relaxed(value, chip->base + channel * 0x10 + offset);
+	writel_relaxed(value, bpc->base + channel * 0x10 + offset);
 }
 
 static int berlin_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -87,15 +87,15 @@ static void berlin_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	kfree(channel);
 }
 
-static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm_dev,
+static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			     int duty_ns, int period_ns)
 {
-	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	bool prescale_4096 = false;
 	u32 value, duty, period;
 	u64 cycles;
 
-	cycles = clk_get_rate(pwm->clk);
+	cycles = clk_get_rate(bpc->clk);
 	cycles *= period_ns;
 	do_div(cycles, NSEC_PER_SEC);
 
@@ -112,59 +112,59 @@ static int berlin_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 	do_div(cycles, period_ns);
 	duty = cycles;
 
-	value = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
+	value = berlin_pwm_readl(bpc, pwm->hwpwm, BERLIN_PWM_CONTROL);
 	if (prescale_4096)
 		value |= BERLIN_PWM_PRESCALE_4096;
 	else
 		value &= ~BERLIN_PWM_PRESCALE_4096;
-	berlin_pwm_writel(pwm, pwm_dev->hwpwm, value, BERLIN_PWM_CONTROL);
+	berlin_pwm_writel(bpc, pwm->hwpwm, value, BERLIN_PWM_CONTROL);
 
-	berlin_pwm_writel(pwm, pwm_dev->hwpwm, duty, BERLIN_PWM_DUTY);
-	berlin_pwm_writel(pwm, pwm_dev->hwpwm, period, BERLIN_PWM_TCNT);
+	berlin_pwm_writel(bpc, pwm->hwpwm, duty, BERLIN_PWM_DUTY);
+	berlin_pwm_writel(bpc, pwm->hwpwm, period, BERLIN_PWM_TCNT);
 
 	return 0;
 }
 
 static int berlin_pwm_set_polarity(struct pwm_chip *chip,
-				   struct pwm_device *pwm_dev,
+				   struct pwm_device *pwm,
 				   enum pwm_polarity polarity)
 {
-	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	u32 value;
 
-	value = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_CONTROL);
+	value = berlin_pwm_readl(bpc, pwm->hwpwm, BERLIN_PWM_CONTROL);
 
 	if (polarity == PWM_POLARITY_NORMAL)
 		value &= ~BERLIN_PWM_INVERT_POLARITY;
 	else
 		value |= BERLIN_PWM_INVERT_POLARITY;
 
-	berlin_pwm_writel(pwm, pwm_dev->hwpwm, value, BERLIN_PWM_CONTROL);
+	berlin_pwm_writel(bpc, pwm->hwpwm, value, BERLIN_PWM_CONTROL);
 
 	return 0;
 }
 
-static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm_dev)
+static int berlin_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	u32 value;
 
-	value = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
+	value = berlin_pwm_readl(bpc, pwm->hwpwm, BERLIN_PWM_EN);
 	value |= BERLIN_PWM_ENABLE;
-	berlin_pwm_writel(pwm, pwm_dev->hwpwm, value, BERLIN_PWM_EN);
+	berlin_pwm_writel(bpc, pwm->hwpwm, value, BERLIN_PWM_EN);
 
 	return 0;
 }
 
 static void berlin_pwm_disable(struct pwm_chip *chip,
-			       struct pwm_device *pwm_dev)
+			       struct pwm_device *pwm)
 {
-	struct berlin_pwm_chip *pwm = to_berlin_pwm_chip(chip);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	u32 value;
 
-	value = berlin_pwm_readl(pwm, pwm_dev->hwpwm, BERLIN_PWM_EN);
+	value = berlin_pwm_readl(bpc, pwm->hwpwm, BERLIN_PWM_EN);
 	value &= ~BERLIN_PWM_ENABLE;
-	berlin_pwm_writel(pwm, pwm_dev->hwpwm, value, BERLIN_PWM_EN);
+	berlin_pwm_writel(bpc, pwm->hwpwm, value, BERLIN_PWM_EN);
 }
 
 static const struct pwm_ops berlin_pwm_ops = {
@@ -185,50 +185,50 @@ MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 
 static int berlin_pwm_probe(struct platform_device *pdev)
 {
-	struct berlin_pwm_chip *pwm;
+	struct berlin_pwm_chip *bpc;
 	int ret;
 
-	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
-	if (!pwm)
+	bpc = devm_kzalloc(&pdev->dev, sizeof(*bpc), GFP_KERNEL);
+	if (!bpc)
 		return -ENOMEM;
 
-	pwm->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(pwm->base))
-		return PTR_ERR(pwm->base);
+	bpc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(bpc->base))
+		return PTR_ERR(bpc->base);
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk))
-		return PTR_ERR(pwm->clk);
+	bpc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(bpc->clk))
+		return PTR_ERR(bpc->clk);
 
-	ret = clk_prepare_enable(pwm->clk);
+	ret = clk_prepare_enable(bpc->clk);
 	if (ret)
 		return ret;
 
-	pwm->chip.dev = &pdev->dev;
-	pwm->chip.ops = &berlin_pwm_ops;
-	pwm->chip.npwm = 4;
-	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
-	pwm->chip.of_pwm_n_cells = 3;
+	bpc->chip.dev = &pdev->dev;
+	bpc->chip.ops = &berlin_pwm_ops;
+	bpc->chip.npwm = 4;
+	bpc->chip.of_xlate = of_pwm_xlate_with_flags;
+	bpc->chip.of_pwm_n_cells = 3;
 
-	ret = pwmchip_add(&pwm->chip);
+	ret = pwmchip_add(&bpc->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(pwm->clk);
+		clk_disable_unprepare(bpc->clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pwm);
+	platform_set_drvdata(pdev, bpc);
 
 	return 0;
 }
 
 static int berlin_pwm_remove(struct platform_device *pdev)
 {
-	struct berlin_pwm_chip *pwm = platform_get_drvdata(pdev);
+	struct berlin_pwm_chip *bpc = platform_get_drvdata(pdev);
 	int ret;
 
-	ret = pwmchip_remove(&pwm->chip);
-	clk_disable_unprepare(pwm->clk);
+	ret = pwmchip_remove(&bpc->chip);
+	clk_disable_unprepare(bpc->clk);
 
 	return ret;
 }
@@ -236,48 +236,48 @@ static int berlin_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int berlin_pwm_suspend(struct device *dev)
 {
-	struct berlin_pwm_chip *pwm = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
 	unsigned int i;
 
-	for (i = 0; i < pwm->chip.npwm; i++) {
+	for (i = 0; i < bpc->chip.npwm; i++) {
 		struct berlin_pwm_channel *channel;
 
-		channel = pwm_get_chip_data(&pwm->chip.pwms[i]);
+		channel = pwm_get_chip_data(&bpc->chip.pwms[i]);
 		if (!channel)
 			continue;
 
-		channel->enable = berlin_pwm_readl(pwm, i, BERLIN_PWM_ENABLE);
-		channel->ctrl = berlin_pwm_readl(pwm, i, BERLIN_PWM_CONTROL);
-		channel->duty = berlin_pwm_readl(pwm, i, BERLIN_PWM_DUTY);
-		channel->tcnt = berlin_pwm_readl(pwm, i, BERLIN_PWM_TCNT);
+		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
+		channel->ctrl = berlin_pwm_readl(bpc, i, BERLIN_PWM_CONTROL);
+		channel->duty = berlin_pwm_readl(bpc, i, BERLIN_PWM_DUTY);
+		channel->tcnt = berlin_pwm_readl(bpc, i, BERLIN_PWM_TCNT);
 	}
 
-	clk_disable_unprepare(pwm->clk);
+	clk_disable_unprepare(bpc->clk);
 
 	return 0;
 }
 
 static int berlin_pwm_resume(struct device *dev)
 {
-	struct berlin_pwm_chip *pwm = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
 	unsigned int i;
 	int ret;
 
-	ret = clk_prepare_enable(pwm->clk);
+	ret = clk_prepare_enable(bpc->clk);
 	if (ret)
 		return ret;
 
-	for (i = 0; i < pwm->chip.npwm; i++) {
+	for (i = 0; i < bpc->chip.npwm; i++) {
 		struct berlin_pwm_channel *channel;
 
-		channel = pwm_get_chip_data(&pwm->chip.pwms[i]);
+		channel = pwm_get_chip_data(&bpc->chip.pwms[i]);
 		if (!channel)
 			continue;
 
-		berlin_pwm_writel(pwm, i, channel->ctrl, BERLIN_PWM_CONTROL);
-		berlin_pwm_writel(pwm, i, channel->duty, BERLIN_PWM_DUTY);
-		berlin_pwm_writel(pwm, i, channel->tcnt, BERLIN_PWM_TCNT);
-		berlin_pwm_writel(pwm, i, channel->enable, BERLIN_PWM_ENABLE);
+		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
+		berlin_pwm_writel(bpc, i, channel->duty, BERLIN_PWM_DUTY);
+		berlin_pwm_writel(bpc, i, channel->tcnt, BERLIN_PWM_TCNT);
+		berlin_pwm_writel(bpc, i, channel->enable, BERLIN_PWM_ENABLE);
 	}
 
 	return 0;

base-commit: a6efb35019d00f483a0e5f188747723371d659fe
-- 
2.30.2

