Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7404C1FF132
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Jun 2020 14:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgFRMF7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Jun 2020 08:05:59 -0400
Received: from mga04.intel.com ([192.55.52.120]:1360 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726919AbgFRMF5 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 18 Jun 2020 08:05:57 -0400
IronPort-SDR: 48K+z7wRexBQSPTjKSZf3Tnh7FU0WZc0p1DCckitNKzgkoC/da4NgCBOcvTtQQK4UtrDMyy1ue
 y0zIhf9hQ1Rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9655"; a="140053066"
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="140053066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 05:05:38 -0700
IronPort-SDR: 4DuZsritGa6AooZxsX91VH3PPXRuUBWDLv0d16Bu6L1GCjc8Lq15VA9mXB/8e27QDr/Ve6nWp7
 n862mwK1A+IQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,526,1583222400"; 
   d="scan'208";a="421476557"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 18 Jun 2020 05:05:33 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Cc:     thierry.reding@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, andriy.shevchenko@intel.com,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v2 2/2] Add PWM fan controller driver for LGM SoC
Date:   Thu, 18 Jun 2020 20:05:13 +0800
Message-Id: <79fefda4aad5ebeb368129375bf128b74ed12224.1592474693.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
References: <cover.1592474693.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
This PWM controller does not have any other consumer, it is a
dedicated PWM controller for fan attached to the system. Add
driver for this PWM fan controller.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/pwm/Kconfig         |   9 +
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-intel-lgm.c | 400 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 410 insertions(+)
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index cb8d739067d2..a3303e22d5fa 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -232,6 +232,15 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.
 
+config PWM_INTEL_LGM
+	tristate "Intel LGM PWM support"
+	depends on X86 || COMPILE_TEST
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
index a59c710e98c7..db154a6b4f51 100644
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
index 000000000000..3c7077acb161
--- /dev/null
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -0,0 +1,400 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ *
+ * Notes & Limitations:
+ * - The hardware supports fixed period which is dependent on 2/3 or 4
+ *   wire fan mode.
+ * - Supports normal polarity. Does not support changing polarity.
+ * - When PWM is disabled, output of PWM will become 0(inactive). It doesn't
+ *   keep track of running period.
+ * - When duty cycle is changed, PWM output may be a mix of previous setting
+ *   and new setting for the first period. From second period, the output is
+ *   based on new setting.
+ * - Supports 100% duty cycle.
+ * - It is a dedicated PWM fan controller. There are no other consumers for
+ *   this PWM controller.
+ */
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#define PWM_FAN_CON0		0x0
+#define PWM_FAN_EN_EN		BIT(0)
+#define PWM_FAN_EN_DIS		0x0
+#define PWM_FAN_EN_MSK		BIT(0)
+#define PWM_FAN_MODE_2WIRE	0x0
+#define PWM_FAN_MODE_4WIRE	0x1
+#define PWM_FAN_MODE_MSK	BIT(1)
+#define PWM_FAN_PWM_DIS_DIS	0x0
+#define PWM_FAN_PWM_DIS_MSK	BIT(2)
+#define PWM_TACH_EN_EN		0x1
+#define PWM_TACH_EN_MSK		BIT(4)
+#define PWM_TACH_PLUS_2		0x0
+#define PWM_TACH_PLUS_4		0x1
+#define PWM_TACH_PLUS_MSK	BIT(5)
+#define PWM_FAN_DC_MSK		GENMASK(23, 16)
+
+#define PWM_FAN_CON1		0x4
+#define PWM_FAN_MAX_RPM_MSK	GENMASK(15, 0)
+
+#define PWM_FAN_STAT		0x10
+#define PWM_FAN_TACH_MASK	GENMASK(15, 0)
+
+#define MAX_RPM			(BIT(16) - 1)
+#define DFAULT_RPM		4000
+#define MAX_DUTY_CYCLE		(BIT(8) - 1)
+
+#define FRAC_BITS		10
+#define DC_BITS			8
+#define TWO_TENTH		204
+
+#define PERIOD_2WIRE_NSECS	40000000
+#define PERIOD_4WIRE_NSECS	40000
+
+#define TWO_SECONDS		2000
+#define IGNORE_FIRST_ERR	1
+#define THIRTY_SECS_WINDOW	15
+#define ERR_CNT_THRESHOLD	6
+
+struct lgm_pwm_chip {
+	struct pwm_chip chip;
+	struct regmap *regmap;
+	struct clk *clk;
+	struct reset_control *rst;
+	u32 tach_en;
+	u32 max_rpm;
+	u32 set_rpm;
+	u32 set_dc;
+	u32 period;
+	struct delayed_work work;
+};
+
+static inline struct lgm_pwm_chip *to_lgm_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct lgm_pwm_chip, chip);
+}
+
+static int lgm_pwm_update_dc(struct lgm_pwm_chip *pc, u32 val)
+{
+	return regmap_update_bits(pc->regmap, PWM_FAN_CON0, PWM_FAN_DC_MSK,
+				  FIELD_PREP(PWM_FAN_DC_MSK, val));
+}
+
+static int lgm_pwm_enable(struct pwm_chip *chip, bool enable)
+{
+	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
+	struct regmap *regmap = pc->regmap;
+
+	if (enable) {
+		regmap_update_bits(regmap, PWM_FAN_CON0,
+				   PWM_FAN_EN_MSK, PWM_FAN_EN_EN);
+		if (pc->tach_en)
+			schedule_delayed_work(&pc->work, msecs_to_jiffies(10000));
+	} else {
+		if (pc->tach_en)
+			cancel_delayed_work_sync(&pc->work);
+		regmap_update_bits(regmap, PWM_FAN_CON0,
+			   	   PWM_FAN_EN_MSK, PWM_FAN_EN_DIS);
+	}
+
+	return 0;
+}
+
+static int lgm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
+	struct pwm_state cur_state;
+	u32 duty_cycle, duty, val;
+	int ret = 0;
+
+	if (state->polarity != PWM_POLARITY_NORMAL ||
+	    state->period != pc->period)
+		return -EINVAL;
+
+	cur_state = pwm->state;
+	duty_cycle = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycle = 0;
+
+	duty = duty_cycle * (1U << DC_BITS);
+	val = DIV_ROUND_CLOSEST(duty, state->period);
+	val = min_t(u32, val, MAX_DUTY_CYCLE);
+
+	if (pc->tach_en) {
+		pc->set_dc = val;
+		pc->set_rpm = val * pc->max_rpm / MAX_DUTY_CYCLE;
+	}
+
+	ret = lgm_pwm_update_dc(pc, val);
+
+	if (state->enabled != cur_state.enabled)
+		lgm_pwm_enable(chip, state->enabled);
+
+	return ret;
+}
+
+static void lgm_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			      struct pwm_state *state)
+{
+	struct lgm_pwm_chip *pc = to_lgm_pwm_chip(chip);
+	u32 duty, val;
+
+	state->enabled = regmap_test_bits(pc->regmap, PWM_FAN_CON0,
+					  PWM_FAN_EN_EN);
+	state->polarity = PWM_POLARITY_NORMAL;
+	state->period = pc->period; /* fixed period */
+
+	regmap_read(pc->regmap, PWM_FAN_CON0, &val);
+	duty = FIELD_GET(PWM_FAN_DC_MSK, val);
+	state->duty_cycle = duty * pc->period >> DC_BITS;
+}
+
+static const struct pwm_ops lgm_pwm_ops = {
+	.get_state = lgm_pwm_get_state,
+	.apply = lgm_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static void lgm_pwm_tach_work(struct work_struct *work)
+{
+	struct lgm_pwm_chip *pc = container_of(work, struct lgm_pwm_chip,
+						 work.work);
+	struct regmap *regmap = pc->regmap;
+	u32 fan_tach, fan_dc, val;
+	s32 diff;
+	static u32 fanspeed_err_cnt, time_window, delta_dc;
+
+	/*
+	 * Fan speed is tracked by reading the active duty cycle of PWM output
+	 * from the active duty cycle register. Some variance in the duty cycle
+	 * register value is expected. So we set a time window of 30 seconds and
+	 * if we detect inaccurate fan speed 6 times within 30 seconds then we
+	 * mark it as fan speed problem and fix it by readjusting the duty cycle.
+	 */
+
+	if (fanspeed_err_cnt > IGNORE_FIRST_ERR)
+		/*
+		 * Ignore first time we detect inaccurate fan speed
+		 * because it is expected during bootup.
+		 */
+		time_window++;
+
+	if (time_window == THIRTY_SECS_WINDOW) {
+		/*
+		 * This work is scheduled every 2 seconds i.e. each time_window
+		 * counter step roughly mean 2 seconds. When the time window
+		 * reaches 30 seconds, reset all the counters/logic.
+		 */
+		fanspeed_err_cnt = 0;
+		delta_dc = 0;
+		time_window = 0;
+	}
+
+	regmap_read(regmap, PWM_FAN_STAT, &fan_tach);
+	fan_tach &= PWM_FAN_TACH_MASK;
+	if (!fan_tach)
+		goto restart_work;
+
+	val = DIV_ROUND_CLOSEST(pc->set_rpm << FRAC_BITS, fan_tach);
+	diff = val - BIT(FRAC_BITS);
+
+	if (abs(diff) > TWO_TENTH) {
+		/* if duty cycle diff is more than two tenth, detect it as error */
+		if (fanspeed_err_cnt > IGNORE_FIRST_ERR)
+			delta_dc += val;
+		fanspeed_err_cnt++;
+	}
+
+	if (fanspeed_err_cnt == ERR_CNT_THRESHOLD) {
+		/*
+		 * We detected fan speed errors 6 times with 30 seconds.
+		 * Fix the error by readjusting duty cycle and reset
+		 * our counters/logic.
+		 */
+		fan_dc = pc->set_dc * delta_dc >> (FRAC_BITS + 2);
+		fan_dc = min_t(u32, fan_dc, MAX_DUTY_CYCLE);
+		lgm_pwm_update_dc(pc, fan_dc);
+		fanspeed_err_cnt = 0;
+		delta_dc = 0;
+		time_window = 0;
+	}
+
+restart_work:
+	/*
+	 * Fan speed doesn't need continous tracking. Schedule this work
+	 * every two seconds so it doesn't steal too much cpu cycles.
+	 */
+	schedule_delayed_work(&pc->work, msecs_to_jiffies(TWO_SECONDS));
+}
+
+static void lgm_pwm_init(struct lgm_pwm_chip *pc)
+{
+	struct device *dev = pc->chip.dev;
+	struct regmap *regmap = pc->regmap;
+	u32 max_rpm, fan_wire, tach_plus, con0_val, con0_mask;
+
+	if (device_property_read_u32(dev, "intel,fan-wire", &fan_wire))
+		fan_wire = 2; /* default is 2 wire mode */
+
+	con0_val = FIELD_PREP(PWM_FAN_PWM_DIS_MSK, PWM_FAN_PWM_DIS_DIS);
+	con0_mask = PWM_FAN_PWM_DIS_MSK | PWM_FAN_MODE_MSK;
+
+	switch (fan_wire) {
+	case 4:
+		con0_val |= FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_4WIRE) |
+			    FIELD_PREP(PWM_TACH_EN_MSK, PWM_TACH_EN_EN);
+		con0_mask |= PWM_TACH_EN_MSK | PWM_TACH_PLUS_MSK;
+		pc->tach_en = 1;
+		pc->period = PERIOD_4WIRE_NSECS;
+		break;
+	default:
+		/* default is 2wire mode */
+		con0_val |= FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_2WIRE);
+		pc->period = PERIOD_2WIRE_NSECS;
+		break;
+	}
+
+	if (pc->tach_en) {
+		if (device_property_read_u32(dev, "intel,tach-plus",
+					     &tach_plus))
+			tach_plus = 2;
+
+		switch (tach_plus) {
+		case 4:
+			con0_val |= FIELD_PREP(PWM_TACH_PLUS_MSK,
+					       PWM_TACH_PLUS_4);
+			break;
+		default:
+			con0_val |= FIELD_PREP(PWM_TACH_PLUS_MSK,
+					       PWM_TACH_PLUS_2);
+			break;
+		}
+
+		if (device_property_read_u32(dev, "intel,max-rpm", &max_rpm))
+			max_rpm = DFAULT_RPM;
+
+		max_rpm = min_t(u32, max_rpm, MAX_RPM);
+		if (max_rpm == 0)
+			max_rpm = DFAULT_RPM;
+
+		pc->max_rpm = max_rpm;
+		INIT_DEFERRABLE_WORK(&pc->work, lgm_pwm_tach_work);
+		regmap_update_bits(regmap, PWM_FAN_CON1,
+				   PWM_FAN_MAX_RPM_MSK, max_rpm);
+	}
+
+	regmap_update_bits(regmap, PWM_FAN_CON0, con0_mask, con0_val);
+}
+
+static const struct regmap_config pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static int lgm_pwm_probe(struct platform_device *pdev)
+{
+	struct lgm_pwm_chip *pc;
+	struct device *dev = &pdev->dev;
+	void __iomem *io_base;
+	int ret;
+
+	pc = devm_kzalloc(dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return -ENOMEM;
+
+	io_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(io_base))
+		return PTR_ERR(io_base);
+
+	pc->regmap = devm_regmap_init_mmio(dev, io_base, &pwm_regmap_config);
+	if (IS_ERR(pc->regmap)) {
+		ret = PTR_ERR(pc->regmap);
+		dev_err(dev, "failed to init register map: %pe\n", pc->regmap);
+		return ret;
+	}
+
+	pc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pc->clk)) {
+		ret = PTR_ERR(pc->clk);
+		dev_err(dev, "failed to get clock: %pe\n", pc->clk);
+		return ret;
+	}
+
+	pc->rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(pc->rst)) {
+		ret = PTR_ERR(pc->rst);
+		dev_err(dev, "failed to get reset control: %pe\n", pc->rst);
+		return ret;
+	}
+
+	ret = reset_control_deassert(pc->rst);
+	if (ret) {
+		dev_err(dev, "cannot deassert reset control: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pc->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	pc->chip.dev = dev;
+	pc->chip.ops = &lgm_pwm_ops;
+	pc->chip.npwm = 1;
+
+	lgm_pwm_init(pc);
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(dev, "failed to add PWM chip: %d\n", ret);
+		clk_disable_unprepare(pc->clk);
+		reset_control_assert(pc->rst);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pc);
+	return 0;
+}
+
+static int lgm_pwm_remove(struct platform_device *pdev)
+{
+	struct lgm_pwm_chip *pc = platform_get_drvdata(pdev);
+	int ret;
+
+	if (pc->tach_en)
+		cancel_delayed_work_sync(&pc->work);
+
+	ret = pwmchip_remove(&pc->chip);
+	if (ret < 0)
+		return ret;
+
+	clk_disable_unprepare(pc->clk);
+	reset_control_assert(pc->rst);
+
+	return 0;
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
-- 
2.11.0

