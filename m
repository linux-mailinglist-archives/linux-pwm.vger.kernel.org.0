Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC373286885
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Oct 2020 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgJGTpk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Oct 2020 15:45:40 -0400
Received: from mga02.intel.com ([134.134.136.20]:45851 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728448AbgJGTph (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 7 Oct 2020 15:45:37 -0400
IronPort-SDR: G0Wqa4RsWxwrpkL7/uf4R0SQ8/WivkI2OGPbSsq7ZsinNC9QKWIPxrMY6rtuVcrmEUDstgo/ES
 L9GlAgjBSwzQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9767"; a="151974150"
X-IronPort-AV: E=Sophos;i="5.77,348,1596524400"; 
   d="scan'208";a="151974150"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 10:43:16 -0700
IronPort-SDR: Zh/++Xfyu3aCZCZ0CfUo/CMbB01avyxbmYI6ClpPkB3dtVADOVy8RB2l+92fqAl2wiKMUOeHAM
 mjbemwz4c61w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,347,1596524400"; 
   d="scan'208";a="342989908"
Received: from ubuntu18.png.intel.com ([10.88.229.38])
  by fmsmga004.fm.intel.com with ESMTP; 07 Oct 2020 10:43:14 -0700
From:   vijayakannan.ayyathurai@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com,
        andriy.shevchenko@linux.intel.com, mgross@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        vijayakannan.ayyathurai@intel.com
Subject: [PATCH v10 1/2] pwm: Add PWM driver for Intel Keem Bay
Date:   Thu,  8 Oct 2020 01:40:30 +0800
Message-Id: <a8cb129092283cb6415e56b928293ef7121a851b.1602090900.git.vijayakannan.ayyathurai@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
In-Reply-To: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
References: <cover.1602090900.git.vijayakannan.ayyathurai@intel.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

The Intel Keem Bay SoC requires PWM support.
Add the pwm-keembay driver to enable this.

Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
Co-developed-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>
---
 drivers/pwm/Kconfig       |   9 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-keembay.c | 230 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+)
 create mode 100644 drivers/pwm/pwm-keembay.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d33..6129a9dbbfa8 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -254,6 +254,15 @@ config PWM_JZ4740
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-jz4740.
 
+config PWM_KEEMBAY
+	tristate "Intel Keem Bay PWM driver"
+	depends on ARCH_KEEMBAY || COMPILE_TEST
+	help
+	  The platform driver for Intel Keem Bay PWM controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-keembay.
+
 config PWM_LP3943
 	tristate "TI/National Semiconductor LP3943 PWM support"
 	depends on MFD_LP3943
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 2c2ba0a03557..a1051122eb07 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
+obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
new file mode 100644
index 000000000000..ff362520d3cd
--- /dev/null
+++ b/drivers/pwm/pwm-keembay.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Keem Bay PWM driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
+ *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
+ *
+ * Limitations:
+ * - Upon disabling a channel, the currently running
+ *   period will not be completed. However, upon
+ *   reconfiguration of the duty cycle/period, the
+ *   currently running period will be completed first.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define KMB_TOTAL_PWM_CHANNELS		6
+#define KMB_PWM_COUNT_MAX		U16_MAX
+#define KMB_PWM_EN_BIT			BIT(31)
+
+/* Mask */
+#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
+#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
+#define KMB_PWM_LEADIN_MASK		GENMASK(30, 0)
+
+/* PWM Register offset */
+#define KMB_PWM_LEADIN_OFFSET(ch)	(0x00 + 4 * (ch))
+#define KMB_PWM_HIGHLOW_OFFSET(ch)	(0x20 + 4 * (ch))
+
+struct keembay_pwm {
+	struct pwm_chip chip;
+	struct device *dev;
+	struct clk *clk;
+	void __iomem *base;
+};
+
+static inline struct keembay_pwm *to_keembay_pwm_dev(struct pwm_chip *chip)
+{
+	return container_of(chip, struct keembay_pwm, chip);
+}
+
+static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
+					   u32 val, u32 offset)
+{
+	u32 buff = readl(priv->base + offset);
+
+	buff = u32_replace_bits(buff, val, mask);
+	writel(buff, priv->base + offset);
+}
+
+static void keembay_pwm_enable(struct keembay_pwm *priv, int ch)
+{
+	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
+				KMB_PWM_LEADIN_OFFSET(ch));
+}
+
+static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
+{
+	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
+				KMB_PWM_LEADIN_OFFSET(ch));
+}
+
+static void keembay_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct keembay_pwm *priv = to_keembay_pwm_dev(chip);
+	unsigned long long pwm_h_count, pwm_l_count;
+	unsigned long clk_rate;
+	u32 buff;
+
+	clk_rate = clk_get_rate(priv->clk);
+
+	/* Read channel enabled status */
+	buff = readl(priv->base + KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
+	if (buff & KMB_PWM_EN_BIT)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	/* Read period and duty cycle */
+	buff = readl(priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
+	pwm_l_count = FIELD_GET(KMB_PWM_LOW_MASK, buff) * NSEC_PER_SEC;
+	pwm_h_count = FIELD_GET(KMB_PWM_HIGH_MASK, buff) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_UP_ULL(pwm_h_count, clk_rate);
+	state->period = DIV_ROUND_UP_ULL(pwm_h_count + pwm_l_count, clk_rate);
+}
+
+static int keembay_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct keembay_pwm *priv = to_keembay_pwm_dev(chip);
+	struct pwm_state current_state;
+	u16 pwm_h_count, pwm_l_count;
+	unsigned long long div;
+	unsigned long clk_rate;
+	u32 pwm_count = 0;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -ENOSYS;
+
+	keembay_pwm_update_bits(priv, KMB_PWM_LEADIN_MASK, 0,
+				KMB_PWM_LEADIN_OFFSET(pwm->hwpwm));
+
+	keembay_pwm_get_state(chip, pwm, &current_state);
+
+	if (!state->enabled) {
+		if (current_state.enabled)
+			keembay_pwm_disable(priv, pwm->hwpwm);
+		return 0;
+	}
+
+	/*
+	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
+	 * the high time of the waveform, while the last 16 bits contain
+	 * the low time of the waveform, in terms of clock cycles.
+	 *
+	 * high time = clock rate * duty cycle
+	 * low time =  clock rate * (period - duty cycle)
+	 */
+
+	clk_rate = clk_get_rate(priv->clk);
+	/* Configure waveform high time */
+	div = clk_rate * state->duty_cycle;
+	div = DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC);
+	if (div > KMB_PWM_COUNT_MAX)
+		return -ERANGE;
+
+	pwm_h_count = div;
+	/* Configure waveform low time */
+	div = clk_rate * (state->period - state->duty_cycle);
+	div = DIV_ROUND_DOWN_ULL(div, NSEC_PER_SEC - pwm_h_count);
+	if (div > KMB_PWM_COUNT_MAX)
+		return -ERANGE;
+
+	pwm_l_count = div;
+
+	pwm_count = FIELD_PREP(KMB_PWM_HIGH_MASK, pwm_h_count) |
+		    FIELD_PREP(KMB_PWM_LOW_MASK, pwm_l_count);
+
+	writel(pwm_count, priv->base + KMB_PWM_HIGHLOW_OFFSET(pwm->hwpwm));
+
+	if (state->enabled && !current_state.enabled)
+		keembay_pwm_enable(priv, pwm->hwpwm);
+
+	return 0;
+}
+
+static const struct pwm_ops keembay_pwm_ops = {
+	.owner = THIS_MODULE,
+	.apply = keembay_pwm_apply,
+	.get_state = keembay_pwm_get_state,
+};
+
+static int keembay_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct keembay_pwm *priv;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get clock\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return ret;
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base)) {
+		clk_disable_unprepare(priv->clk);
+		return PTR_ERR(priv->base);
+	}
+
+	priv->chip.base = -1;
+	priv->chip.dev = dev;
+	priv->chip.ops = &keembay_pwm_ops;
+	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret) {
+		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
+		clk_disable_unprepare(priv->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static int keembay_pwm_remove(struct platform_device *pdev)
+{
+	struct keembay_pwm *priv = platform_get_drvdata(pdev);
+
+	clk_disable_unprepare(priv->clk);
+
+	return pwmchip_remove(&priv->chip);
+}
+
+static const struct of_device_id keembay_pwm_of_match[] = {
+	{ .compatible = "intel,keembay-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, keembay_pwm_of_match);
+
+static struct platform_driver keembay_pwm_driver = {
+	.probe	= keembay_pwm_probe,
+	.remove	= keembay_pwm_remove,
+	.driver	= {
+		.name = "pwm-keembay",
+		.of_match_table = keembay_pwm_of_match,
+	},
+};
+module_platform_driver(keembay_pwm_driver);
+
+MODULE_ALIAS("platform:pwm-keembay");
+MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

