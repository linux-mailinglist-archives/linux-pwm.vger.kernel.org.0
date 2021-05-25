Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4304B38F997
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 06:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbhEYEc4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 00:32:56 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:60591 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhEYEc4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 00:32:56 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 14P4INRP021133;
        Tue, 25 May 2021 12:18:23 +0800 (GMT-8)
        (envelope-from billy_tsai@aspeedtech.com)
Received: from BillyTsai-pc.aspeed.com (192.168.2.149) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 25 May
 2021 12:31:21 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <lee.jones@linaro.org>, <robh+dt@kernel.org>, <joel@jms.id.au>,
        <andrew@aj.id.au>, <thierry.reding@gmail.com>,
        <u.kleine-koenig@pengutronix.de>, <p.zabel@pengutronix.de>,
        <billy_tsai@aspeedtech.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [v7 2/2] pwm: Add Aspeed ast2600 PWM support
Date:   Tue, 25 May 2021 12:32:24 +0800
Message-ID: <20210525043224.27998-3-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210525043224.27998-1-billy_tsai@aspeedtech.com>
References: <20210525043224.27998-1-billy_tsai@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.2.149]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 14P4INRP021133
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This patch add the support of PWM controller which can be found at aspeed
ast2600 soc. The pwm supoorts up to 16 channels and it's part function
of multi-function device "pwm-tach controller".

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/pwm/Kconfig         |   9 +
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-aspeed-g6.c | 334 ++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 drivers/pwm/pwm-aspeed-g6.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 63be5362fd3a..3b2d4cf024a6 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -51,6 +51,15 @@ config PWM_AB8500
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-ab8500.
 
+config PWM_ASPEED_G6
+	tristate "ASPEEDG6 PWM support"
+	depends on ARCH_ASPEED || COMPILE_TEST
+	help
+	  Generic PWM framework driver for ASPEED G6 SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-aspeed-g6.
+
 config PWM_ATMEL
 	tristate "Atmel PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cbdcd55d69ee..29d22d806e68 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_SYSFS)		+= sysfs.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
+obj-$(CONFIG_PWM_ASPEED_G6)	+= pwm-aspeed-g6.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
diff --git a/drivers/pwm/pwm-aspeed-g6.c b/drivers/pwm/pwm-aspeed-g6.c
new file mode 100644
index 000000000000..566aff9d7f23
--- /dev/null
+++ b/drivers/pwm/pwm-aspeed-g6.c
@@ -0,0 +1,334 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 ASPEED Technology Inc.
+ *
+ * PWM controller driver for Aspeed ast26xx SoCs.
+ * This drivers doesn't support earlier version of the IP.
+ *
+ * The formula of pwm frequency:
+ * PWM frequency = CLK Source / ((DIV_L + 1) * BIT(DIV_H) * (PERIOD + 1))
+ *
+ * The software driver fixes the period to 255, which causes the high-frequency
+ * precision of the PWM to be coarse, in exchange for the fineness of the duty cycle.
+ *
+ * Register usage:
+ * PIN_ENABLE: When it is unset the pwm controller will always output low to the extern.
+ * Use to determine whether the PWM channel is enabled or disabled
+ * CLK_ENABLE: When it is unset the pwm controller will reset the duty counter to 0 and
+ * output low to the PIN_ENABLE mux after that the driver can still change the pwm period
+ * and duty and the value will apply when CLK_ENABLE be set again.
+ * Use to determin whether duty_cycle bigger than 0.
+ * PWM_ASPEED_CTRL_INVERSE: When it is toggled the output value will inverse immediately.
+ * PWM_ASPEED_DUTY_CYCLE_FALLING_POINT/PWM_ASPEED_DUTY_CYCLE_RISING_POINT: When these two
+ * values are equal it means the duty cycle = 100%.
+ *
+ * Limitations:
+ * - When changing both duty cycle and period, we cannot prevent in
+ *   software that the output might produce a period with mixed
+ *   settings.
+ *
+ * Improvements:
+ * - When changing the duty cycle or period, our pwm controller will not
+ *   generate the glitch, the configure will change at next cycle of pwm.
+ *   This improvement can disable/enable through PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE.
+ */
+
+#include <linux/clk.h>
+#include <linux/errno.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/sysfs.h>
+#include <linux/reset.h>
+#include <linux/regmap.h>
+#include <linux/bitfield.h>
+#include <linux/slab.h>
+#include <linux/pwm.h>
+#include <linux/math64.h>
+
+/* The channel number of Aspeed pwm controller */
+#define PWM_ASPEED_NR_PWMS 16
+
+/* PWM Control Register */
+#define PWM_ASPEED_CTRL_CH(ch) (((ch)*0x10) + 0x00)
+#define PWM_ASPEED_CTRL_LOAD_SEL_RISING_AS_WDT BIT(19)
+#define PWM_ASPEED_CTRL_DUTY_LOAD_AS_WDT_ENABLE BIT(18)
+#define PWM_ASPEED_CTRL_DUTY_SYNC_DISABLE BIT(17)
+#define PWM_ASPEED_CTRL_CLK_ENABLE BIT(16)
+#define PWM_ASPEED_CTRL_LEVEL_OUTPUT BIT(15)
+#define PWM_ASPEED_CTRL_INVERSE BIT(14)
+#define PWM_ASPEED_CTRL_OPEN_DRAIN_ENABLE BIT(13)
+#define PWM_ASPEED_CTRL_PIN_ENABLE BIT(12)
+#define PWM_ASPEED_CTRL_CLK_DIV_H GENMASK(11, 8)
+#define PWM_ASPEED_CTRL_CLK_DIV_L GENMASK(7, 0)
+
+/* PWM Duty Cycle Register */
+#define PWM_ASPEED_DUTY_CYCLE_CH(ch) (((ch)*0x10) + 0x04)
+#define PWM_ASPEED_DUTY_CYCLE_PERIOD GENMASK(31, 24)
+#define PWM_ASPEED_DUTY_CYCLE_POINT_AS_WDT GENMASK(23, 16)
+#define PWM_ASPEED_DUTY_CYCLE_FALLING_POINT GENMASK(15, 8)
+#define PWM_ASPEED_DUTY_CYCLE_RISING_POINT GENMASK(7, 0)
+
+/* PWM fixed value */
+#define PWM_ASPEED_FIXED_PERIOD FIELD_MAX(PWM_ASPEED_DUTY_CYCLE_PERIOD)
+
+struct aspeed_pwm_data {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct regmap *regmap;
+	struct reset_control *reset;
+};
+
+static inline struct aspeed_pwm_data *
+aspeed_pwm_chip_to_data(struct pwm_chip *c)
+{
+	return container_of(c, struct aspeed_pwm_data, chip);
+}
+
+static u64 aspeed_pwm_get_period(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	unsigned long rate;
+	u32 index = pwm->hwpwm;
+	u32 val;
+	u64 period, div_h, div_l, clk_period;
+
+	rate = clk_get_rate(priv->clk);
+	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
+	div_h = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_H, val);
+	div_l = FIELD_GET(PWM_ASPEED_CTRL_CLK_DIV_L, val);
+	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &val);
+	clk_period = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_PERIOD, val);
+	period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * _BITULL(div_h) *
+					  (div_l + 1) * (clk_period + 1),
+				  rate);
+
+	return period;
+}
+
+static void aspeed_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct device *dev = chip->dev;
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	u32 index = pwm->hwpwm;
+	bool polarity, ch_en, clk_en;
+	u32 duty_pt, val;
+
+	regmap_read(priv->regmap, PWM_ASPEED_CTRL_CH(index), &val);
+	polarity = FIELD_GET(PWM_ASPEED_CTRL_INVERSE, val);
+	ch_en = FIELD_GET(PWM_ASPEED_CTRL_PIN_ENABLE, val);
+	clk_en = FIELD_GET(PWM_ASPEED_CTRL_CLK_ENABLE, val);
+	regmap_read(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index), &val);
+	duty_pt = FIELD_GET(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT, val);
+
+	state->period = aspeed_pwm_get_period(chip, pwm);
+	if (clk_en && duty_pt)
+		state->duty_cycle = DIV_ROUND_UP_ULL(
+			state->period * duty_pt, PWM_ASPEED_FIXED_PERIOD + 1);
+	else
+		state->duty_cycle = clk_en ? state->period : 0;
+	state->polarity = polarity;
+	state->enabled = ch_en;
+	dev_dbg(dev, "get period: %lldns, duty_cycle: %lldns", state->period,
+		state->duty_cycle);
+}
+
+static int aspeed_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct device *dev = chip->dev;
+	struct aspeed_pwm_data *priv = aspeed_pwm_chip_to_data(chip);
+	u32 index = pwm->hwpwm, duty_pt;
+	unsigned long rate;
+	u64 apply_period, div_h, div_l, divisor;
+
+	dev_dbg(dev, "expect period: %lldns, duty_cycle: %lldns", state->period,
+		state->duty_cycle);
+
+	rate = clk_get_rate(priv->clk);
+	/*
+	 * Pick the smallest value for div_h so that div_l can be the biggest
+	 * which results in a finer resolution near the target period value.
+	 */
+	divisor = (u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1) *
+		  (FIELD_MAX(PWM_ASPEED_CTRL_CLK_DIV_L) + 1);
+	div_h = order_base_2(DIV64_U64_ROUND_UP(rate * state->period, divisor));
+	if (div_h > 0xf)
+		div_h = 0xf;
+
+	divisor = ((u64)NSEC_PER_SEC * (PWM_ASPEED_FIXED_PERIOD + 1)) << div_h;
+	div_l = div64_u64(rate * state->period, divisor);
+
+	if (div_l == 0)
+		return -ERANGE;
+
+	div_l -= 1;
+
+	if (div_l > 255)
+		div_l = 255;
+
+	dev_dbg(dev, "clk source: %ld div_h %lld, div_l : %lld\n", rate, div_h,
+		div_l);
+
+	apply_period = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * _BITULL(div_h) *
+						(div_l + 1) *
+						(PWM_ASPEED_FIXED_PERIOD + 1),
+					rate);
+	duty_pt = DIV_ROUND_DOWN_ULL(state->duty_cycle *
+					     (PWM_ASPEED_FIXED_PERIOD + 1),
+				     apply_period);
+	dev_dbg(dev, "apply_period = %lld, duty_cycle = %lld, duty_pt = %d\n",
+		apply_period, state->duty_cycle, duty_pt);
+
+	/*
+	 * Fixed the period to the max value and rising point to 0
+	 * for high resolution and simplify frequency calculation.
+	 */
+	regmap_update_bits(priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
+			   (PWM_ASPEED_DUTY_CYCLE_PERIOD |
+			    PWM_ASPEED_DUTY_CYCLE_RISING_POINT),
+			   FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_PERIOD,
+				      PWM_ASPEED_FIXED_PERIOD));
+
+	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
+			   PWM_ASPEED_CTRL_PIN_ENABLE,
+			   state->enabled ? PWM_ASPEED_CTRL_PIN_ENABLE : 0);
+
+	regmap_update_bits(
+		priv->regmap, PWM_ASPEED_CTRL_CH(index),
+		(PWM_ASPEED_CTRL_CLK_DIV_H | PWM_ASPEED_CTRL_CLK_DIV_L),
+		FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_H, div_h) |
+			FIELD_PREP(PWM_ASPEED_CTRL_CLK_DIV_L, div_l));
+
+	if (duty_pt == 0) {
+		regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
+				   PWM_ASPEED_CTRL_CLK_ENABLE, 0);
+	} else {
+		if (duty_pt >= (PWM_ASPEED_FIXED_PERIOD + 1))
+			duty_pt = 0;
+		regmap_update_bits(
+			priv->regmap, PWM_ASPEED_DUTY_CYCLE_CH(index),
+			PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
+			FIELD_PREP(PWM_ASPEED_DUTY_CYCLE_FALLING_POINT,
+				   duty_pt));
+		regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
+				   PWM_ASPEED_CTRL_CLK_ENABLE,
+				   PWM_ASPEED_CTRL_CLK_ENABLE);
+	}
+
+	regmap_update_bits(priv->regmap, PWM_ASPEED_CTRL_CH(index),
+			   PWM_ASPEED_CTRL_INVERSE,
+			   FIELD_PREP(PWM_ASPEED_CTRL_INVERSE,
+				      state->polarity));
+	return 0;
+}
+
+static const struct pwm_ops aspeed_pwm_ops = {
+	.apply = aspeed_pwm_apply,
+	.get_state = aspeed_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static int aspeed_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	int ret;
+	struct aspeed_pwm_data *priv;
+	struct device_node *np;
+	struct platform_device *parent_dev;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	np = pdev->dev.parent->of_node;
+	if (!of_device_is_compatible(np, "aspeed,ast2600-pwm-tach"))
+		return dev_err_probe(dev, -ENODEV,
+				     "unsupported pwm device binding\n");
+
+	priv->regmap = syscon_node_to_regmap(np);
+	if (IS_ERR(priv->regmap))
+		return dev_err_probe(dev, PTR_ERR(priv->regmap),
+				     "couldn't get regmap\n");
+
+	parent_dev = of_find_device_by_node(np);
+	priv->clk = devm_clk_get(&parent_dev->dev, 0);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "couldn't get clock\n");
+
+	ret = clk_prepare_enable(priv->clk);
+	if (ret)
+		return dev_err_probe(dev, ret, "couldn't enable clock\n");
+
+	priv->reset = of_reset_control_get_shared(np, NULL);
+	if (IS_ERR(priv->reset))
+		return dev_err_probe(dev, PTR_ERR(priv->reset),
+				     "get reset failed\n");
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret) {
+		dev_err(dev, "cannot deassert reset control: %pe\n",
+			ERR_PTR(ret));
+		goto err_disable_clk;
+	}
+
+	priv->chip.dev = dev;
+	priv->chip.ops = &aspeed_pwm_ops;
+	priv->chip.npwm = PWM_ASPEED_NR_PWMS;
+	priv->chip.of_xlate = of_pwm_xlate_with_flags;
+	priv->chip.of_pwm_n_cells = 3;
+
+	ret = pwmchip_add(&priv->chip);
+	if (ret < 0) {
+		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));
+		goto err_assert_reset;
+	}
+	dev_set_drvdata(dev, priv);
+	return 0;
+err_assert_reset:
+	reset_control_assert(priv->reset);
+err_disable_clk:
+	clk_disable_unprepare(priv->clk);
+	return ret;
+}
+
+static int aspeed_pwm_remove(struct platform_device *dev)
+{
+	struct aspeed_pwm_data *priv = platform_get_drvdata(dev);
+
+	pwmchip_remove(&priv->chip);
+	reset_control_assert(priv->reset);
+	clk_disable_unprepare(priv->clk);
+
+	return 0;
+}
+
+static const struct of_device_id of_pwm_match_table[] = {
+	{
+		.compatible = "aspeed,ast2600-pwm",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, of_pwm_match_table);
+
+static struct platform_driver aspeed_pwm_driver = {
+	.probe = aspeed_pwm_probe,
+	.remove	= aspeed_pwm_remove,
+	.driver	= {
+		.name = "aspeed_pwm",
+		.of_match_table = of_pwm_match_table,
+	},
+};
+
+module_platform_driver(aspeed_pwm_driver);
+
+MODULE_AUTHOR("Billy Tsai <billy_tsai@aspeedtech.com>");
+MODULE_DESCRIPTION("ASPEED PWM device driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

