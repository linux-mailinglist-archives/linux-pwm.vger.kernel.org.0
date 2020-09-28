Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B38F27A747
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Sep 2020 08:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgI1GQi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 28 Sep 2020 02:16:38 -0400
Received: from mga01.intel.com ([192.55.52.88]:10412 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725294AbgI1GQi (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 28 Sep 2020 02:16:38 -0400
IronPort-SDR: xGMnXAPkEaP1UnEQvTdz1/T4Qofp58KqYAS1rT9qHORD5FPQkiTdiDU40k+D9nkjkPsWrBubxt
 yhAvN9zFrmNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="180100275"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="180100275"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 23:16:36 -0700
IronPort-SDR: e2ihJGsKkhcAHDjgi4LLv03IQ487aL7DVvV8UDNXgPP5jHomT82ZU0lIvvQad95KRAqUNCFzBI
 CffkYtex9buQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="293138487"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2020 23:16:33 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com, Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v14 2/2] Add PWM fan controller driver for LGM SoC
Date:   Mon, 28 Sep 2020 14:15:58 +0800
Message-Id: <937f0a387169b119ec3dbcf62fd47c0556e255b1.1601273429.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1601273429.git.rahul.tanwar@linux.intel.com>
References: <cover.1601273429.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1601273429.git.rahul.tanwar@linux.intel.com>
References: <cover.1601273429.git.rahul.tanwar@linux.intel.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
This PWM controller does not have any other consumer, it is a
dedicated PWM controller for fan attached to the system. Add
driver for this PWM fan controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/pwm/Kconfig         |  11 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-intel-lgm.c | 244 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+)
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 7dbcf6973d33..4949c51fe90b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -232,6 +232,17 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.
 
+config PWM_INTEL_LGM
+	tristate "Intel LGM PWM support"
+	depends on HAS_IOMEM
+	depends on (OF && X86) || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  Generic PWM fan controller driver for LGM SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-intel-lgm.
+
 config PWM_IQS620A
 	tristate "Azoteq IQS620A PWM support"
 	depends on MFD_IQS62X || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 2c2ba0a03557..e9431b151694 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
+obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
new file mode 100644
index 000000000000..e9e54dda07aa
--- /dev/null
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ *
+ * Limitations:
+ * - The hardware supports fixed period & configures only 2-wire mode.
+ * - Supports normal polarity. Does not support changing polarity.
+ * - When PWM is disabled, output of PWM will become 0(inactive). It doesn't
+ *   keep track of running period.
+ * - When duty cycle is changed, PWM output may be a mix of previous setting
+ *   and new setting for the first period. From second period, the output is
+ *   based on new setting.
+ * - It is a dedicated PWM fan controller. There are no other consumers for
+ *   this PWM controller.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/mod_devicetable.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define LGM_PWM_FAN_CON0		0x0
+#define LGM_PWM_FAN_EN_EN		BIT(0)
+#define LGM_PWM_FAN_EN_DIS		0x0
+#define LGM_PWM_FAN_EN_MSK		BIT(0)
+#define LGM_PWM_FAN_MODE_2WIRE		0x0
+#define LGM_PWM_FAN_MODE_MSK		BIT(1)
+#define LGM_PWM_FAN_DC_MSK		GENMASK(23, 16)
+
+#define LGM_PWM_FAN_CON1		0x4
+#define LGM_PWM_FAN_MAX_RPM_MSK		GENMASK(15, 0)
+
+#define LGM_PWM_MAX_RPM			(BIT(16) - 1)
+#define LGM_PWM_DEFAULT_RPM		4000
+#define LGM_PWM_MAX_DUTY_CYCLE		(BIT(8) - 1)
+
+#define LGM_PWM_DC_BITS			8
+
+#define LGM_PWM_PERIOD_2WIRE_NS		(40 * NSEC_PER_MSEC)
+
+struct lgm_pwm_chip {
+	struct pwm_chip chip;
+	struct regmap *regmap;
+	u32 period;
+};
+
+static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct lgm_pwm_chip, chip);
+}
+
+static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
+{
+	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
+	struct regmap *regmap = pc->regmap;
+
+	return regmap_update_bits(regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_EN_MSK,
+				  enable ? LGM_PWM_FAN_EN_EN : LGM_PWM_FAN_EN_DIS);
+}
+
+static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
+	u32 duty_cycle, val;
+	int ret;
+
+	/* The hardware only supports normal polarity and fixed period. */
+	if (state->polarity != PWM_POLARITY_NORMAL || state->period < pc->period)
+		return -EINVAL;
+
+	if (!state->enabled)
+		return lgm_pwm_enable(chip, 0);
+
+	duty_cycle = min_t(u64, state->duty_cycle, pc->period);
+	val = duty_cycle * LGM_PWM_MAX_DUTY_CYCLE / pc->period;
+
+	ret = regmap_update_bits(pc->regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_DC_MSK,
+				 FIELD_PREP(LGM_PWM_FAN_DC_MSK, val));
+	if (ret)
+		return ret;
+
+	return lgm_pwm_enable(chip, 1);
+}
+
+static void lgm_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
+	u32 duty, val;
+
+	state->enabled = regmap_test_bits(pc->regmap, LGM_PWM_FAN_CON0,
+					  LGM_PWM_FAN_EN_EN);
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->period = pc->period; /* fixed period */
+
+	regmap_read(pc->regmap, LGM_PWM_FAN_CON0, &val);
+	duty = FIELD_GET(LGM_PWM_FAN_DC_MSK, val);
+	state->duty_cycle = DIV_ROUND_UP(duty * pc->period, LGM_PWM_MAX_DUTY_CYCLE);
+}
+
+static const struct pwm_ops lgm_pwm_ops = {
+	.get_state = lgm_pwm_get_state,
+	.apply = lgm_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static void lgm_pwm_init(struct lgm_pwm_chip *pc)
+{
+	struct regmap *regmap = pc->regmap;
+	u32 con0_val;
+
+	con0_val = FIELD_PREP(LGM_PWM_FAN_MODE_MSK, LGM_PWM_FAN_MODE_2WIRE);
+	pc->period = LGM_PWM_PERIOD_2WIRE_NS;
+	regmap_update_bits(regmap, LGM_PWM_FAN_CON1, LGM_PWM_FAN_MAX_RPM_MSK,
+			   LGM_PWM_DEFAULT_RPM);
+	regmap_update_bits(regmap, LGM_PWM_FAN_CON0, LGM_PWM_FAN_MODE_MSK,
+			   con0_val);
+}
+
+static const struct regmap_config lgm_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static void lgm_clk_release(void *data)
+{
+	struct clk *clk = data;
+
+	clk_disable_unprepare(clk);
+}
+
+static int lgm_clk_enable(struct device *dev, struct clk *clk)
+{
+	int ret;
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, lgm_clk_release, clk);
+}
+
+static void lgm_reset_control_release(void *data)
+{
+	struct reset_control *rst = data;
+
+	reset_control_assert(rst);
+}
+
+static int lgm_reset_control_deassert(struct device *dev, struct reset_control *rst)
+{
+	int ret;
+
+	ret = reset_control_deassert(rst);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, lgm_reset_control_release, rst);
+}
+
+static int lgm_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct reset_control *rst;
+	struct lgm_pwm_chip *pc;
+	void __iomem *io_base;
+	struct clk *clk;
+	int ret;
+
+	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, pc);
+
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
+	if (IS_ERR(pc->regmap))
+		return dev_err_probe(dev, PTR_ERR(pc->regmap),
+				     "failed to init register map\n");
+
+	clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "failed to get clock\n");
+
+	ret = lgm_clk_enable(dev, clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clock\n");
+
+	rst = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(rst))
+		return dev_err_probe(dev, PTR_ERR(rst),
+				     "failed to get reset control\n");
+
+	ret = lgm_reset_control_deassert(dev, rst);
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot deassert reset control\n");
+
+	pc->chip.dev = dev;
+	pc->chip.ops = &lgm_pwm_ops;
+	pc->chip.npwm = 1;
+	pc->chip.base = -1;
+
+	lgm_pwm_init(pc);
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static int lgm_pwm_remove(struct platform_device *pdev)
+{
+	struct lgm_pwm_chip *pc = platform_get_drvdata(pdev);
+
+	return pwmchip_remove(&pc->chip);
+}
+
+static const struct of_device_id lgm_pwm_of_match[] = {
+	{ .compatible = "intel,lgm-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lgm_pwm_of_match);
+
+static struct platform_driver lgm_pwm_driver = {
+	.driver = {
+		.name = "intel-pwm",
+		.of_match_table = lgm_pwm_of_match,
+	},
+	.probe = lgm_pwm_probe,
+	.remove = lgm_pwm_remove,
+};
+module_platform_driver(lgm_pwm_driver);
+
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

