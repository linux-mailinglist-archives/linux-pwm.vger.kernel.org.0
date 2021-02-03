Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 727C630DA4D
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Feb 2021 13:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhBCMz7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Feb 2021 07:55:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbhBCMxu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 3 Feb 2021 07:53:50 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE45C0617A9;
        Wed,  3 Feb 2021 04:53:24 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id c132so17346945pga.3;
        Wed, 03 Feb 2021 04:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5oXdUY1DM4rWQPgrG2i9zVGY3R7TYhERB4FaMsTEgU=;
        b=D9lOTPo77lvE5oITlRXhmDxQHrIxQ9LV1io4RQLkN5XKpyWuJMZ7OHOCHRNINBIa5D
         i5QAomIwxgg66LNi82KgD6VfXN6y9uPiBC54pofNp7+xjK2+1Ln/r8nREM/NYRQWdq+j
         i3CuCjlbwc/yMFWTHuabFfn7mqNh5jJhOfNtgrhwlKQe38dv35y8IMEv9yblkBMsfPfB
         DlXK/XY82pm96WfHGZVf6CCdt31kDu3G5POgqlIURdzrcJ1jud+JoWiLzympB472vRO3
         2XD3CKBR3vH2qTM6wZhLf4zXxC82oOFQ/s3HGR/evx0T6RD92H/Qt8d03xwAsyIG3363
         qFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F5oXdUY1DM4rWQPgrG2i9zVGY3R7TYhERB4FaMsTEgU=;
        b=szOCFn5nYLzCHgnGT+secll4wSfwpP1MxsBVi0Whgng16FcqNYUMubjom2wBV2NGcG
         vwrcsKimFnm659zbyfIsQLsj2kGWsB267x2KWsASw06duBptDN+kVSEcsQ+lk0GQZYsH
         CMuiAFdmfnnL3EIahia7HZ6LpwyMcsbgj8tQr/NTnwAsFSJ+TCZiuYv+bfV3ZuXXzXHo
         K4UJdNMEgMmpemwViyUPajQ9g9ib9tPFXWTdqJ+lThCNLTZ9Ncvx7EqpJDo0utTq195i
         FM6Z0CrH2PThdx1qQ0Oz9jgs603aUZOExYmH9LTnFkTTYjL+lTLxAKjGVBdPL620k5tA
         9dyA==
X-Gm-Message-State: AOAM531k+05AkPAi3uUYOI6YikXAhEejtWOh8qIL/a6xJsdBQ8Nd5s0w
        Zdlfze7rsMcG7CSMNtHE+A==
X-Google-Smtp-Source: ABdhPJzWnwUaSkNDEDzu6jxD5hRlc8YKxGO2kbVqK8u2+cr3Lp/823JG59AzYINUIUkGCUUwpupoXw==
X-Received: by 2002:a63:2009:: with SMTP id g9mr3448412pgg.219.1612356803780;
        Wed, 03 Feb 2021 04:53:23 -0800 (PST)
Received: from INTERNET-129.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id y21sm2409191pfp.208.2021.02.03.04.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Feb 2021 04:53:22 -0800 (PST)
From:   Ban Tao <fengzheng923@gmail.com>
X-Google-Original-From: Ban Tao
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        mripard@kernel.org, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ban Tao <fengzheng923@gmail.com>
Subject: [PATCH v2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Date:   Wed,  3 Feb 2021 20:53:17 +0800
Message-Id: <20210203125317.1975-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ban Tao <fengzheng923@gmail.com>

The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
IP compared to the older Allwinner SoCs.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>

---
v1->v2:
1.delete unnecessary code.
2.using a named define for some constants.
3.Add comment in sun50i_pwm_config function.
4.using dev_err_probe() for error handling.
5.disable the clock after pwmchip_remove().
---
 MAINTAINERS              |   6 +
 drivers/pwm/Kconfig      |  11 ++
 drivers/pwm/Makefile     |   1 +
 drivers/pwm/pwm-sun50i.c | 348 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 366 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun50i.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..d33cf1b69b43 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -737,6 +737,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/media/sunxi/cedrus/
 
+ALLWINNER PWM DRIVER
+M:	Ban Tao <fengzheng923@gmail.com>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	drivers/pwm/pwm-sun50i.c
+
 ALPHA PORT
 M:	Richard Henderson <rth@twiddle.net>
 M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 9a4f66ae8070..17635a8f2ed3 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -552,6 +552,17 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN50I
+	tristate "Allwinner enhanced PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && COMMON_CLK
+	help
+	  Enhanced PWM framework driver for Allwinner R818, A133, R329,
+	  V536 and V833 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun50i.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 6374d3b1d6f3..b4754927fd8f 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN50I)	+= pwm-sun50i.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
diff --git a/drivers/pwm/pwm-sun50i.c b/drivers/pwm/pwm-sun50i.c
new file mode 100644
index 000000000000..37285d771924
--- /dev/null
+++ b/drivers/pwm/pwm-sun50i.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Allwinner sun50i Pulse Width Modulation Controller
+ *
+ * Copyright (C) 2020 Ban Tao <fengzheng923@gmail.com>
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))
+#define PWM_CLK_APB_SCR			BIT(7)
+#define PWM_DIV_M			0
+#define PWM_DIV_M_WIDTH			0x4
+
+#define PWM_CLK_REG			0x40
+#define PWM_CLK_GATING			BIT(0)
+
+#define PWM_ENABLE_REG			0x80
+#define PWM_EN				BIT(0)
+
+#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
+#define PWM_ACT_STA			BIT(8)
+#define PWM_PRESCAL_K			0
+#define PWM_PRESCAL_K_WIDTH		0x8
+
+#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
+#define PWM_ENTIRE_CYCLE		16
+#define PWM_ENTIRE_CYCLE_WIDTH		0x10
+#define PWM_ACT_CYCLE			0
+#define PWM_ACT_CYCLE_WIDTH		0x10
+
+#define BIT_CH(bit, chan)		((bit) << (chan))
+
+#define SETMASK(width, shift)		((width?((-1U) >> (32-width)):0)  << (shift))
+#define CLRMASK(width, shift)		(~(SETMASK(width, shift)))
+#define GET_BITS(shift, width, reg)     \
+	    (((reg) & SETMASK(width, shift)) >> (shift))
+#define SET_BITS(shift, width, reg, val) \
+	    (((reg) & CLRMASK(width, shift)) | (val << (shift)))
+
+#define PWM_OSC_CLK			24000000
+#define PWM_PRESCALER_MAX		256
+#define PWM_CLK_DIV_M__MAX		9
+#define PWM_ENTIRE_CYCLE_MAX		65536
+
+struct sun50i_pwm_data {
+	unsigned int npwm;
+};
+
+struct sun50i_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct reset_control *rst_clk;
+	void __iomem *base;
+	const struct sun50i_pwm_data *data;
+};
+
+static inline struct sun50i_pwm_chip *sun50i_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sun50i_pwm_chip, chip);
+}
+
+static inline u32 sun50i_pwm_readl(struct sun50i_pwm_chip *chip,
+				  unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun50i_pwm_writel(struct sun50i_pwm_chip *chip,
+				    u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static int sun50i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				enum pwm_polarity polarity)
+{
+	struct sun50i_pwm_chip *sun50i_pwm = sun50i_pwm_from_chip(chip);
+	u32 temp;
+
+	temp = sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		temp |= PWM_ACT_STA;
+	else
+		temp &= ~PWM_ACT_STA;
+
+	sun50i_pwm_writel(sun50i_pwm, temp, PWM_CTL_REG(pwm->hwpwm));
+
+	return 0;
+}
+
+static int sun50i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+		int duty_ns, int period_ns)
+{
+	struct sun50i_pwm_chip *sun50i_pwm = sun50i_pwm_from_chip(chip);
+	unsigned long long c;
+	unsigned long entire_cycles, active_cycles;
+	unsigned int div_m, prescaler;
+	u32 tmp;
+
+	if (period_ns > 334) {
+		/* if freq < 3M, then select 24M clock */
+		c = PWM_OSC_CLK;
+		tmp = sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+		tmp &= ~PWM_CLK_APB_SCR;
+		sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	} else {
+		/* if freq > 3M, then select APB as clock */
+		c = clk_get_rate(sun50i_pwm->clk);
+		tmp = sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+		tmp |= PWM_CLK_APB_SCR;
+		sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	}
+
+	dev_dbg(chip->dev, "duty_ns=%d period_ns=%d c =%llu.\n",
+			duty_ns, period_ns, c);
+
+	/*
+	 * (clk / div_m / prescaler) / entire_cycles = NSEC_PER_SEC / period_ns.
+	 * So, entire_cycles = clk * period_ns / NSEC_PER_SEC / div_m / prescaler.
+	 */
+	c = c * period_ns;
+	do_div(c, NSEC_PER_SEC);
+	for (div_m = 0; div_m < PWM_CLK_DIV_M__MAX; div_m++) {
+		for (prescaler = 0; prescaler < PWM_PRESCALER_MAX; prescaler++) {
+			/*
+			 * actual prescaler = prescaler + 1.
+			 * actual div_m = 0x1 << div_m.
+			*/
+			entire_cycles = ((unsigned long)c/(0x1 << div_m))/(prescaler + 1);
+			if (entire_cycles <= PWM_ENTIRE_CYCLE_MAX) {
+				goto calc_end;
+			}
+		}
+	}
+
+calc_end:
+	/*
+	 * duty_ns / period_ns = active_cycles / entire_cycles.
+	 * So, active_cycles = entire_cycles * duty_ns / period_ns.
+	 */
+	c = (unsigned long long)entire_cycles * duty_ns;
+	do_div(c, period_ns);
+	active_cycles = c;
+	if (entire_cycles == 0)
+		entire_cycles++;
+
+	/* enable clk gating */
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
+	tmp |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
+
+	/* config  clk div_m*/
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	tmp = SET_BITS(PWM_DIV_M, PWM_DIV_M_WIDTH, tmp, div_m);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+
+	/* config prescal */
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_CTL_REG(pwm->hwpwm));
+	tmp = SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_WIDTH, tmp, prescaler);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CTL_REG(pwm->hwpwm));
+
+	/* config active and period cycles */
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_PERIOD_REG(pwm->hwpwm));
+	tmp = SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_WIDTH, tmp, active_cycles);
+	tmp = SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYCLE_WIDTH, tmp, (entire_cycles - 1));
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_PERIOD_REG(pwm->hwpwm));
+
+	dev_dbg(chip->dev, "active_cycles=%lu entire_cycles=%lu prescaler=%u div_m=%u\n",
+			active_cycles, entire_cycles, prescaler, div_m);
+
+	return 0;
+}
+
+static int sun50i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sun50i_pwm_chip *sun50i_pwm = sun50i_pwm_from_chip(chip);
+	u32 tmp;
+
+	/* enable pwm controller */
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
+	tmp |= BIT_CH(PWM_EN, pwm->hwpwm);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
+
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
+	tmp |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
+
+	return 0;
+}
+
+static void sun50i_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct sun50i_pwm_chip *sun50i_pwm = sun50i_pwm_from_chip(chip);
+	u32 tmp;
+
+	/* disable pwm controller */
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_ENABLE_REG);
+	tmp &= ~BIT_CH(PWM_EN, pwm->hwpwm);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_ENABLE_REG);
+
+	tmp = sun50i_pwm_readl(sun50i_pwm, PWM_CLK_REG);
+	tmp &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+	sun50i_pwm_writel(sun50i_pwm, tmp, PWM_CLK_REG);
+}
+
+static const struct pwm_ops sun50i_pwm_ops = {
+	.config = sun50i_pwm_config,
+	.enable = sun50i_pwm_enable,
+	.disable = sun50i_pwm_disable,
+	.set_polarity = sun50i_pwm_set_polarity,
+	.owner = THIS_MODULE,
+};
+
+static const struct sun50i_pwm_data sun8i_pwm_data_c9 = {
+	.npwm = 9,
+};
+
+static const struct sun50i_pwm_data sun50i_pwm_data_c16 = {
+	.npwm = 16,
+};
+
+static const struct of_device_id sun50i_pwm_dt_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-v833-pwm",
+		.data = &sun8i_pwm_data_c9,
+	}, {
+		.compatible = "allwinner,sun8i-v536-pwm",
+		.data = &sun8i_pwm_data_c9,
+	}, {
+		.compatible = "allwinner,sun50i-r818-pwm",
+		.data = &sun50i_pwm_data_c16,
+	}, {
+		.compatible = "allwinner,sun50i-a133-pwm",
+		.data = &sun50i_pwm_data_c16,
+	}, {
+		.compatible = "allwinner,sun50i-r329-pwm",
+		.data = &sun8i_pwm_data_c9,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, sun50i_pwm_dt_ids);
+
+static int sun50i_pwm_probe(struct platform_device *pdev)
+{
+	struct sun50i_pwm_chip *pwm;
+	int ret;
+
+	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->data = of_device_get_match_data(&pdev->dev);
+	if (!pwm->data)
+		return -ENODEV;
+
+	pwm->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pwm->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->base),
+				     "can't remap pwm resource\n");
+
+	pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
+				     "get unnamed clock failed\n");
+
+	pwm->rst_clk = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(pwm->rst_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->rst_clk),
+				     "get reset failed\n");
+
+	/* Deassert reset */
+	ret = reset_control_deassert(pwm->rst_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot prepare and enable clk %pe\n",
+			ERR_PTR(ret));
+		goto err_clk;
+	}
+
+	pwm->chip.dev = &pdev->dev;
+	pwm->chip.ops = &sun50i_pwm_ops;
+	pwm->chip.npwm = pwm->data->npwm;
+	pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	pwm->chip.base = -1;
+	pwm->chip.of_pwm_n_cells = 3;
+
+	ret = pwmchip_add(&pwm->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		goto err_pwm_add;
+	}
+
+	platform_set_drvdata(pdev, pwm);
+
+	return 0;
+
+err_pwm_add:
+	clk_disable_unprepare(pwm->clk);
+err_clk:
+	reset_control_assert(pwm->rst_clk);
+
+	return ret;
+}
+
+static int sun50i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun50i_pwm_chip *pwm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&pwm->chip);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pwm->clk);
+	reset_control_assert(pwm->rst_clk);
+
+	return 0;
+}
+
+static struct platform_driver sun50i_pwm_driver = {
+	.driver = {
+		.name = "sun50i-pwm",
+		.of_match_table = sun50i_pwm_dt_ids,
+	},
+	.probe = sun50i_pwm_probe,
+	.remove = sun50i_pwm_remove,
+};
+module_platform_driver(sun50i_pwm_driver);
+
+MODULE_ALIAS("platform:sun50i-pwm");
+MODULE_AUTHOR("Ban Tao <fengzheng923@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun50i PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.22.0.windows.1

