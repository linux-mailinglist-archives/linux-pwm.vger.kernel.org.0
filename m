Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27CB224C07
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Jul 2020 16:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGROtx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Jul 2020 10:49:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:3940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726574AbgGROtw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sat, 18 Jul 2020 10:49:52 -0400
IronPort-SDR: WKCyeeKh0jT0qVDhnldqqpZcs2zJqHOSl5Olz+eRDrLNWtv+kR3hr9XpaKCgzb23N/tJqSe+c/
 1d9VCj9i74/Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="129826076"
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="129826076"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 07:49:52 -0700
IronPort-SDR: QFZxNnYkhH1B5Jsyp57bvbKt1p3t44GMPwJV9KYM6kZ3YSP485y4+3O4bE7m5c0eguNm2A3iUz
 9Oa3y3vlEu4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,367,1589266800"; 
   d="scan'208";a="300836346"
Received: from vgjayaku-ilbpg7.png.intel.com ([10.88.227.96])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2020 07:49:49 -0700
From:   vineetha.g.jaya.kumaran@intel.com
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        wan.ahmad.zainie.wan.mohamad@intel.com, andriy.shevchenko@intel.com
Subject: [PATCH v2 1/2] pwm: Add PWM driver for Intel Keem Bay
Date:   Sat, 18 Jul 2020 22:47:07 +0800
Message-Id: <1595083628-20734-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
References: <1595083628-20734-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: "Lai, Poey Seng" <poey.seng.lai@intel.com>

Enable PWM support for the Intel Keem Bay SoC.

Signed-off-by: Lai, Poey Seng <poey.seng.lai@intel.com>
Signed-off-by: Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
---
 drivers/pwm/Kconfig       |   9 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-keembay.c | 239 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 drivers/pwm/pwm-keembay.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739..2b0419b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -569,4 +569,13 @@ config PWM_ZX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-zx.
 
+config PWM_KEEMBAY
+	tristate "Intel Keem Bay PWM driver"
+	depends on ARM64 || COMPILE_TEST
+	help
+	  The platform driver for Intel Keem Bay PWM controller.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-keembay.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index a59c710..0c84ff2 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -55,3 +55,4 @@ obj-$(CONFIG_PWM_TWL)		+= pwm-twl.o
 obj-$(CONFIG_PWM_TWL_LED)	+= pwm-twl-led.o
 obj-$(CONFIG_PWM_VT8500)	+= pwm-vt8500.o
 obj-$(CONFIG_PWM_ZX)		+= pwm-zx.o
+obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
diff --git a/drivers/pwm/pwm-keembay.c b/drivers/pwm/pwm-keembay.c
new file mode 100644
index 00000000..fa5fe95
--- /dev/null
+++ b/drivers/pwm/pwm-keembay.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Keem Bay PWM driver
+ *
+ * Copyright (C) 2020 Intel Corporation
+ * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
+ *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define KMB_TOTAL_PWM_CHANNELS		6
+#define KMB_PWM_COUNT_MAX		65535
+#define KMB_PWM_EN_BIT			BIT(31)
+
+/* Mask */
+#define KMB_PWM_HIGH_MASK		GENMASK(31, 16)
+#define KMB_PWM_LOW_MASK		GENMASK(15, 0)
+#define KMB_PWM_COUNT_MASK		GENMASK(31, 0)
+
+/* PWM Register offset */
+#define KMB_PWM_LEADIN0_OFFSET		0x00
+#define KMB_PWM_LEADIN1_OFFSET		0x04
+#define KMB_PWM_LEADIN2_OFFSET		0x08
+#define KMB_PWM_LEADIN3_OFFSET		0x0c
+#define KMB_PWM_LEADIN4_OFFSET		0x10
+#define KMB_PWM_LEADIN5_OFFSET		0x14
+
+#define KMB_PWM_HIGHLOW0_OFFSET		0x20
+#define KMB_PWM_HIGHLOW1_OFFSET		0x24
+#define KMB_PWM_HIGHLOW2_OFFSET		0x28
+#define KMB_PWM_HIGHLOW3_OFFSET		0x2c
+#define KMB_PWM_HIGHLOW4_OFFSET		0x30
+#define KMB_PWM_HIGHLOW5_OFFSET		0x34
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
+					   u32 val, u32 reg, int ch)
+{
+	u32 buff, offset, tmp;
+	void __iomem *address;
+
+	offset = reg + ch * 4;
+	address = priv->base + offset;
+	buff = readl(address);
+	tmp = buff & ~mask;
+	tmp |= FIELD_PREP(mask, val);
+	writel(tmp, address);
+}
+
+static void keembay_pwm_enable(struct keembay_pwm *priv, int ch)
+{
+	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 1,
+				KMB_PWM_LEADIN0_OFFSET, ch);
+}
+
+static void keembay_pwm_disable(struct keembay_pwm *priv, int ch)
+{
+	keembay_pwm_update_bits(priv, KMB_PWM_EN_BIT, 0,
+				KMB_PWM_LEADIN0_OFFSET, ch);
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
+	buff = readl(priv->base + KMB_PWM_LEADIN0_OFFSET + pwm->hwpwm * 4);
+	if (buff & KMB_PWM_EN_BIT)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	/* Read period and duty cycle*/
+	buff = readl(priv->base + KMB_PWM_HIGHLOW0_OFFSET + pwm->hwpwm * 4);
+	pwm_l_count = (buff & KMB_PWM_LOW_MASK) * NSEC_PER_SEC;
+	pwm_h_count = ((buff & KMB_PWM_HIGH_MASK) >> 16) * NSEC_PER_SEC;
+	state->duty_cycle = pwm_h_count / clk_rate;
+	state->period = (pwm_h_count + pwm_l_count) / clk_rate;
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
+	pwm_get_state(pwm, &current_state);
+
+	if (!state->enabled && current_state.enabled) {
+		keembay_pwm_disable(priv, pwm->hwpwm);
+		return 0;
+	}
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -ENOSYS;
+
+	/*
+	 * The upper 16 bits of the KMB_PWM_HIGHLOWx_OFFSET register contain
+	 * the high time of the waveform, while the last 16 bits contain
+	 * the low time of the waveform, in terms of clock cycles.
+	 *
+	 * high time = clock rate * duty cycle / NSEC_PER_SEC
+	 * low time =  clock rate * (period - duty cycle) / NSEC_PER_SEC
+	 *
+	 * e.g. For period 50000ns, duty cycle 30000ns, and clock rate 500MHz:
+	 * high time = (500000000 * 30000) / 1000000000 = 0x3A98
+	 * low time = (500000000 * 20000) / 1000000000 = 0x2710
+	 * Value written to KMB_PWM_HIGHLOWx_OFFSET = 0x3A982710
+	 */
+
+	clk_rate = clk_get_rate(priv->clk);
+
+	/* Configure waveform high time */
+	div = clk_rate * state->duty_cycle;
+	do_div(div, NSEC_PER_SEC);
+	if (div > KMB_PWM_COUNT_MAX)
+		return -ERANGE;
+
+	pwm_h_count = (u16)div;
+
+	/* Configure waveform low time */
+	div = clk_rate * (state->period - state->duty_cycle);
+	do_div(div, NSEC_PER_SEC);
+	if (div > KMB_PWM_COUNT_MAX)
+		return -ERANGE;
+
+	pwm_l_count = (u16)div;
+
+	pwm_count |= pwm_h_count << 16;
+	pwm_count |= pwm_l_count;
+
+	keembay_pwm_update_bits(priv, KMB_PWM_COUNT_MASK,
+				pwm_count, KMB_PWM_HIGHLOW0_OFFSET, pwm->hwpwm);
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
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(priv->clk)) {
+		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get clock: %pe", priv->clk);
+
+		return PTR_ERR(priv->clk);
+	}
+
+	priv->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	priv->chip.base = -1;
+	priv->chip.dev = dev;
+	priv->chip.ops = &keembay_pwm_ops;
+	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret < 0) {
+		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
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
+MODULE_ALIAS("platform:keembay");
+MODULE_DESCRIPTION("Intel Keem Bay PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1

