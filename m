Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B2F2FD3A5
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 16:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbhATPNU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 10:13:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390424AbhATPKa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 Jan 2021 10:10:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4B8AE23159;
        Wed, 20 Jan 2021 15:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611155390;
        bh=WUbBotuq4Oy3mOku8gwtWKS3a6Wa5oh19lqXYgHBTPk=;
        h=From:To:Cc:Subject:Date:From;
        b=XJe6y9IkPheSVA1dkehUm4nXJaNtJmMAWGxhpbS1n76Bb8Jwp7txkWfhJrz1dZxbE
         mG2e9yDMJVBY86Qh1VmEn0DkBluSzuR1jSLnYemOLxGy62R9F4H0SqDuGAtuGk78rG
         y+a7qAnFqTvU8gymBknDVMsw4av+iH3+WlTcl3U7st9TrYGwgBYHlgEztf68JStGVL
         tQ1dx9wdAl2WsCIIYOP+m48JaeTguu9SKyBti97BqI0gQriMrF4Z82zIAA/YdrjvTF
         svmvw+AgImzUNoPsiSMWQZo141JCH5FfLqsOYaG2U9WX6YRIVJjxntxs4vQzC3m8Ks
         QkvXLriQSK0tw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: remove zte zx driver
Date:   Wed, 20 Jan 2021 16:09:22 +0100
Message-Id: <20210120150944.1688327-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The zte zx platform is getting removed, so this driver is no
longer needed.

Cc: Jun Nie <jun.nie@linaro.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../devicetree/bindings/pwm/pwm-zx.txt        |  22 --
 drivers/pwm/Kconfig                           |  20 --
 drivers/pwm/Makefile                          |   2 -
 drivers/pwm/pwm-zx.c                          | 278 ------------------
 4 files changed, 322 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-zx.txt
 delete mode 100644 drivers/pwm/pwm-zx.c

diff --git a/Documentation/devicetree/bindings/pwm/pwm-zx.txt b/Documentation/devicetree/bindings/pwm/pwm-zx.txt
deleted file mode 100644
index 3c8fe7aa8269..000000000000
--- a/Documentation/devicetree/bindings/pwm/pwm-zx.txt
+++ /dev/null
@@ -1,22 +0,0 @@
-ZTE ZX PWM controller
-
-Required properties:
- - compatible: Should be "zte,zx296718-pwm".
- - reg: Physical base address and length of the controller's registers.
- - clocks : The phandle and specifier referencing the controller's clocks.
- - clock-names: "pclk" for PCLK, "wclk" for WCLK to the PWM controller.  The
-   PCLK is for register access, while WCLK is the reference clock for
-   calculating period and duty cycles.
- - #pwm-cells: Should be 3. See pwm.yaml in this directory for a description of
-   the cells format.
-
-Example:
-
-	pwm: pwm@1439000 {
-		compatible = "zte,zx296718-pwm";
-		reg = <0x1439000 0x1000>;
-		clocks = <&lsp1crm LSP1_PWM_PCLK>,
-			 <&lsp1crm LSP1_PWM_WCLK>;
-		clock-names = "pclk", "wclk";
-		#pwm-cells = <3>;
-	};
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0937e1c047ac..4c28d0634ce9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -601,24 +601,4 @@ config PWM_TWL_LED
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-twl-led.
 
-config PWM_VT8500
-	tristate "vt8500 PWM support"
-	depends on ARCH_VT8500 || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Generic PWM framework driver for vt8500.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-vt8500.
-
-config PWM_ZX
-	tristate "ZTE ZX PWM support"
-	depends on ARCH_ZX || COMPILE_TEST
-	depends on HAS_IOMEM
-	help
-	  Generic PWM framework driver for ZTE ZX family SoCs.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called pwm-zx.
-
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 18b89d7fd092..e90d0fd789f3 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -56,5 +56,3 @@ obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
-obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
-obj-$(CONFIG_PWM_ZX)		+= pwm-zx.o
diff --git a/drivers/pwm/pwm-zx.c b/drivers/pwm/pwm-zx.c
deleted file mode 100644
index 34e91195ce98..000000000000
--- a/drivers/pwm/pwm-zx.c
+++ /dev/null
@@ -1,278 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2017 Sanechips Technology Co., Ltd.
- * Copyright 2017 Linaro Ltd.
- */
-
-#include <linux/clk.h>
-#include <linux/err.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/pwm.h>
-#include <linux/slab.h>
-
-#define ZX_PWM_MODE		0x0
-#define ZX_PWM_CLKDIV_SHIFT	2
-#define ZX_PWM_CLKDIV_MASK	GENMASK(11, 2)
-#define ZX_PWM_CLKDIV(x)	(((x) << ZX_PWM_CLKDIV_SHIFT) & \
-					 ZX_PWM_CLKDIV_MASK)
-#define ZX_PWM_POLAR		BIT(1)
-#define ZX_PWM_EN		BIT(0)
-#define ZX_PWM_PERIOD		0x4
-#define ZX_PWM_DUTY		0x8
-
-#define ZX_PWM_CLKDIV_MAX	1023
-#define ZX_PWM_PERIOD_MAX	65535
-
-struct zx_pwm_chip {
-	struct pwm_chip chip;
-	struct clk *pclk;
-	struct clk *wclk;
-	void __iomem *base;
-};
-
-static inline struct zx_pwm_chip *to_zx_pwm_chip(struct pwm_chip *chip)
-{
-	return container_of(chip, struct zx_pwm_chip, chip);
-}
-
-static inline u32 zx_pwm_readl(struct zx_pwm_chip *zpc, unsigned int hwpwm,
-			       unsigned int offset)
-{
-	return readl(zpc->base + (hwpwm + 1) * 0x10 + offset);
-}
-
-static inline void zx_pwm_writel(struct zx_pwm_chip *zpc, unsigned int hwpwm,
-				 unsigned int offset, u32 value)
-{
-	writel(value, zpc->base + (hwpwm + 1) * 0x10 + offset);
-}
-
-static void zx_pwm_set_mask(struct zx_pwm_chip *zpc, unsigned int hwpwm,
-			    unsigned int offset, u32 mask, u32 value)
-{
-	u32 data;
-
-	data = zx_pwm_readl(zpc, hwpwm, offset);
-	data &= ~mask;
-	data |= value & mask;
-	zx_pwm_writel(zpc, hwpwm, offset, data);
-}
-
-static void zx_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-			     struct pwm_state *state)
-{
-	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
-	unsigned long rate;
-	unsigned int div;
-	u32 value;
-	u64 tmp;
-
-	value = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_MODE);
-
-	if (value & ZX_PWM_POLAR)
-		state->polarity = PWM_POLARITY_NORMAL;
-	else
-		state->polarity = PWM_POLARITY_INVERSED;
-
-	if (value & ZX_PWM_EN)
-		state->enabled = true;
-	else
-		state->enabled = false;
-
-	div = (value & ZX_PWM_CLKDIV_MASK) >> ZX_PWM_CLKDIV_SHIFT;
-	rate = clk_get_rate(zpc->wclk);
-
-	tmp = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_PERIOD);
-	tmp *= div * NSEC_PER_SEC;
-	state->period = DIV_ROUND_CLOSEST_ULL(tmp, rate);
-
-	tmp = zx_pwm_readl(zpc, pwm->hwpwm, ZX_PWM_DUTY);
-	tmp *= div * NSEC_PER_SEC;
-	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, rate);
-}
-
-static int zx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			 unsigned int duty_ns, unsigned int period_ns)
-{
-	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
-	unsigned int period_cycles, duty_cycles;
-	unsigned long long c;
-	unsigned int div = 1;
-	unsigned long rate;
-
-	/* Find out the best divider */
-	rate = clk_get_rate(zpc->wclk);
-
-	while (1) {
-		c = rate / div;
-		c = c * period_ns;
-		do_div(c, NSEC_PER_SEC);
-
-		if (c < ZX_PWM_PERIOD_MAX)
-			break;
-
-		div++;
-
-		if (div > ZX_PWM_CLKDIV_MAX)
-			return -ERANGE;
-	}
-
-	/* Calculate duty cycles */
-	period_cycles = c;
-	c *= duty_ns;
-	do_div(c, period_ns);
-	duty_cycles = c;
-
-	/*
-	 * If the PWM is being enabled, we have to temporarily disable it
-	 * before configuring the registers.
-	 */
-	if (pwm_is_enabled(pwm))
-		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_EN, 0);
-
-	/* Set up registers */
-	zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_CLKDIV_MASK,
-			ZX_PWM_CLKDIV(div));
-	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_PERIOD, period_cycles);
-	zx_pwm_writel(zpc, pwm->hwpwm, ZX_PWM_DUTY, duty_cycles);
-
-	/* Re-enable the PWM if needed */
-	if (pwm_is_enabled(pwm))
-		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
-				ZX_PWM_EN, ZX_PWM_EN);
-
-	return 0;
-}
-
-static int zx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			const struct pwm_state *state)
-{
-	struct zx_pwm_chip *zpc = to_zx_pwm_chip(chip);
-	struct pwm_state cstate;
-	int ret;
-
-	pwm_get_state(pwm, &cstate);
-
-	if (state->polarity != cstate.polarity)
-		zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE, ZX_PWM_POLAR,
-				(state->polarity == PWM_POLARITY_INVERSED) ?
-				 0 : ZX_PWM_POLAR);
-
-	if (state->period != cstate.period ||
-	    state->duty_cycle != cstate.duty_cycle) {
-		ret = zx_pwm_config(chip, pwm, state->duty_cycle,
-				    state->period);
-		if (ret)
-			return ret;
-	}
-
-	if (state->enabled != cstate.enabled) {
-		if (state->enabled) {
-			ret = clk_prepare_enable(zpc->wclk);
-			if (ret)
-				return ret;
-
-			zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
-					ZX_PWM_EN, ZX_PWM_EN);
-		} else {
-			zx_pwm_set_mask(zpc, pwm->hwpwm, ZX_PWM_MODE,
-					ZX_PWM_EN, 0);
-			clk_disable_unprepare(zpc->wclk);
-		}
-	}
-
-	return 0;
-}
-
-static const struct pwm_ops zx_pwm_ops = {
-	.apply = zx_pwm_apply,
-	.get_state = zx_pwm_get_state,
-	.owner = THIS_MODULE,
-};
-
-static int zx_pwm_probe(struct platform_device *pdev)
-{
-	struct zx_pwm_chip *zpc;
-	unsigned int i;
-	int ret;
-
-	zpc = devm_kzalloc(&pdev->dev, sizeof(*zpc), GFP_KERNEL);
-	if (!zpc)
-		return -ENOMEM;
-
-	zpc->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(zpc->base))
-		return PTR_ERR(zpc->base);
-
-	zpc->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(zpc->pclk))
-		return PTR_ERR(zpc->pclk);
-
-	zpc->wclk = devm_clk_get(&pdev->dev, "wclk");
-	if (IS_ERR(zpc->wclk))
-		return PTR_ERR(zpc->wclk);
-
-	ret = clk_prepare_enable(zpc->pclk);
-	if (ret)
-		return ret;
-
-	zpc->chip.dev = &pdev->dev;
-	zpc->chip.ops = &zx_pwm_ops;
-	zpc->chip.base = -1;
-	zpc->chip.npwm = 4;
-	zpc->chip.of_xlate = of_pwm_xlate_with_flags;
-	zpc->chip.of_pwm_n_cells = 3;
-
-	/*
-	 * PWM devices may be enabled by firmware, and let's disable all of
-	 * them initially to save power.
-	 */
-	for (i = 0; i < zpc->chip.npwm; i++)
-		zx_pwm_set_mask(zpc, i, ZX_PWM_MODE, ZX_PWM_EN, 0);
-
-	ret = pwmchip_add(&zpc->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(zpc->pclk);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, zpc);
-
-	return 0;
-}
-
-static int zx_pwm_remove(struct platform_device *pdev)
-{
-	struct zx_pwm_chip *zpc = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = pwmchip_remove(&zpc->chip);
-	clk_disable_unprepare(zpc->pclk);
-
-	return ret;
-}
-
-static const struct of_device_id zx_pwm_dt_ids[] = {
-	{ .compatible = "zte,zx296718-pwm", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, zx_pwm_dt_ids);
-
-static struct platform_driver zx_pwm_driver = {
-	.driver = {
-		.name = "zx-pwm",
-		.of_match_table = zx_pwm_dt_ids,
-	},
-	.probe = zx_pwm_probe,
-	.remove = zx_pwm_remove,
-};
-module_platform_driver(zx_pwm_driver);
-
-MODULE_ALIAS("platform:zx-pwm");
-MODULE_AUTHOR("Shawn Guo <shawn.guo@linaro.org>");
-MODULE_DESCRIPTION("ZTE ZX PWM Driver");
-MODULE_LICENSE("GPL v2");
-- 
2.29.2

