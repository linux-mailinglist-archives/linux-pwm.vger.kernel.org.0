Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D83DA319FC1
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Feb 2021 14:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhBLNV6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Feb 2021 08:21:58 -0500
Received: from mo-csw1514.securemx.jp ([210.130.202.153]:52422 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLNVt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Feb 2021 08:21:49 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 11CDJSbM027470; Fri, 12 Feb 2021 22:19:28 +0900
X-Iguazu-Qid: 34tMScsDAqfUiYuTB4
X-Iguazu-QSIG: v=2; s=0; t=1613135968; q=34tMScsDAqfUiYuTB4; m=z1OyDtMlrB7n7LoaVx0bkjrSihFhe7MphaT4/bt7/w4=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1511) id 11CDJRxK021399;
        Fri, 12 Feb 2021 22:19:27 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 11CDJReG008799;
        Fri, 12 Feb 2021 22:19:27 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 11CDJQ7g021201;
        Fri, 12 Feb 2021 22:19:26 +0900
From:   Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        punit1.agrawal@toshiba.co.jp, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH v2 2/2] pwm: visconti: Add Toshiba Visconti SoC PWM support
Date:   Fri, 12 Feb 2021 22:19:10 +0900
X-TSB-HOP: ON
Message-Id: <20210212131910.557581-3-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210212131910.557581-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add driver for the PWM controller on Toshiba Visconti ARM SoC.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/pwm/Kconfig        |   9 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-visconti.c | 173 +++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)
 create mode 100644 drivers/pwm/pwm-visconti.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 9a4f66ae8070..8ae68d6203fb 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -601,6 +601,15 @@ config PWM_TWL_LED
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-twl-led.
 
+config PWM_VISCONTI
+	tristate "Toshiba Visconti PWM support"
+	depends on ARCH_VISCONTI || COMPILE_TEST
+	help
+	  PWM Subsystem driver support for Toshiba Visconti SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-visconti.
+
 config PWM_VT8500
 	tristate "vt8500 PWM support"
 	depends on ARCH_VT8500 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 6374d3b1d6f3..d43b1e17e8e1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -56,4 +56,5 @@ obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
 obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
+obj-$(CONFIG_PWM_VISCONTI)	+= pwm-visconti.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
new file mode 100644
index 000000000000..2aa140f1ec04
--- /dev/null
+++ b/drivers/pwm/pwm-visconti.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Toshiba Visconti pulse-width-modulation controller driver
+ *
+ * Copyright (c) 2020 TOSHIBA CORPORATION
+ * Copyright (c) 2020 Toshiba Electronic Devices & Storage Corporation
+ *
+ * Authors: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/platform_device.h>
+
+
+#define PIPGM_PCSR(ch) (0x400 + 4 * (ch))
+#define PIPGM_PDUT(ch) (0x420 + 4 * (ch))
+#define PIPGM_PWMC(ch) (0x440 + 4 * (ch))
+
+#define PIPGM_PWMC_PWMACT		BIT(5)
+#define PIPGM_PWMC_CLK_MASK		GENMASK(1, 0)
+#define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
+#define PIPGM_PDUT_MAX			0xFFFF
+
+struct visconti_pwm_chip {
+	struct pwm_chip chip;
+	void __iomem *base;
+};
+
+#define to_visconti_chip(chip) \
+	container_of(chip, struct visconti_pwm_chip, chip)
+
+static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
+	u32 period, duty, pwmc0;
+
+	dev_dbg(chip->dev, "%s: ch = %d en = %d p = 0x%llx d = 0x%llx\n", __func__,
+		pwm->hwpwm, state->enabled, state->period, state->duty_cycle);
+
+	/*
+	 * pwmc is a 2-bit divider for the input clock running at 1 MHz.
+	 * When the settings of the PWM are modified, the new values are shadowed in hardware until
+	 * the period register (PCSR) is written and the currently running period is completed. This
+	 * way the hardware switches atomically from the old setting to the new.
+	 * Also, disabling the hardware completes the currently running period and keeps the output
+	 * at low level at all times.
+	 */
+	if (!state->enabled) {
+		writel(0, priv->base + PIPGM_PCSR(pwm->hwpwm));
+		return 0;
+	}
+
+	period = state->period / NSEC_PER_USEC;
+	duty = state->duty_cycle / NSEC_PER_USEC;
+	if (period < 0x10000)
+		pwmc0 = 0;
+	else if (period < 0x20000)
+		pwmc0 = 1;
+	else if (period < 0x40000)
+		pwmc0 = 2;
+	else if (period < 0x80000)
+		pwmc0 = 3;
+	else
+		return -EINVAL;
+
+	if (duty > PIPGM_PDUT_MAX)
+		return -EINVAL;
+
+	period >>= pwmc0;
+	duty >>= pwmc0;
+
+	if (state->polarity == PWM_POLARITY_INVERSED)
+		pwmc0 |= PIPGM_PWMC_PWMACT;
+
+	writel(pwmc0, priv->base + PIPGM_PWMC(pwm->hwpwm));
+	writel(duty, priv->base + PIPGM_PDUT(pwm->hwpwm));
+	writel(period, priv->base + PIPGM_PCSR(pwm->hwpwm));
+
+	return 0;
+}
+
+static void visconti_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct visconti_pwm_chip *priv = to_visconti_chip(chip);
+	u32 period, duty, pwmc0, pwmc0_clk;
+
+	period = readl(priv->base + PIPGM_PCSR(pwm->hwpwm));
+	if (period)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	duty = readl(priv->base + PIPGM_PDUT(pwm->hwpwm));
+	pwmc0 = readl(priv->base + PIPGM_PWMC(pwm->hwpwm));
+	pwmc0_clk = pwmc0 & PIPGM_PWMC_CLK_MASK;
+
+	state->period = (period << pwmc0_clk) * NSEC_PER_USEC;
+	state->duty_cycle = (duty << pwmc0_clk) * NSEC_PER_USEC;
+	if (pwmc0 & PIPGM_PWMC_POLARITY_MASK)
+		state->polarity = PWM_POLARITY_INVERSED;
+	else
+		state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static const struct pwm_ops visconti_pwm_ops = {
+	.apply = visconti_pwm_apply,
+	.get_state = visconti_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int visconti_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct visconti_pwm_chip *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	platform_set_drvdata(pdev, priv);
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &visconti_pwm_ops;
+	priv->chip.base = -1;
+	priv->chip.npwm = 4;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
+
+	dev_dbg(&pdev->dev, "visconti PWM registered\n");
+
+	return 0;
+}
+
+static int visconti_pwm_remove(struct platform_device *pdev)
+{
+	struct visconti_pwm_chip *priv = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&priv->chip);
+}
+
+static const struct of_device_id visconti_pwm_of_match[] = {
+	{ .compatible = "toshiba,pwm-visconti", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, visconti_pwm_of_match);
+
+static struct platform_driver visconti_pwm_driver = {
+	.driver = {
+		.name = "pwm-visconti",
+		.of_match_table = visconti_pwm_of_match,
+	},
+	.probe = visconti_pwm_probe,
+	.remove = visconti_pwm_remove,
+};
+module_platform_driver(visconti_pwm_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>");
+MODULE_ALIAS("platform:visconti-pwm");
-- 
2.30.0.rc2

