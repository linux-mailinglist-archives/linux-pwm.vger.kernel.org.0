Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8605C1DE12C
	for <lists+linux-pwm@lfdr.de>; Fri, 22 May 2020 09:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgEVHmP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 May 2020 03:42:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:21951 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727839AbgEVHmP (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 22 May 2020 03:42:15 -0400
IronPort-SDR: myiTBxbxLj69KHmgbcQvyYjpjob7NAE1YfXTJoHlXhXbTSbW6PftbT6yZJRp6zbcYbrmFtBLKz
 rVGxbr82fPXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 00:42:14 -0700
IronPort-SDR: Luruh70CIJQxJl9IUxA3Gochei59vsdonlywZClV7eLsoC7FNwDNzl/1olbGyk8dQ6Hnmf8Ja0
 +IAZUfEj5haA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,420,1583222400"; 
   d="scan'208";a="412680073"
Received: from sgsxdev001.isng.intel.com (HELO localhost) ([10.226.88.11])
  by orsmga004.jf.intel.com with ESMTP; 22 May 2020 00:42:11 -0700
From:   Rahul Tanwar <rahul.tanwar@linux.intel.com>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        p.zabel@pengutronix.de, linux-pwm@vger.kernel.org,
        robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>
Subject: [PATCH v1 2/2] Add PWM driver for LGM
Date:   Fri, 22 May 2020 15:41:59 +0800
Message-Id: <3c1d2343b034325dbc185ccd23a35b40a62a4e7b.1590132733.git.rahul.tanwar@linux.intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
In-Reply-To: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
References: <cover.1590132733.git.rahul.tanwar@linux.intel.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add PWM controller driver for Intel's Lightning Mountain(LGM) SoC.

Signed-off-by: Rahul Tanwar <rahul.tanwar@linux.intel.com>
---
 drivers/pwm/Kconfig         |   9 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-intel-lgm.c | 356 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 366 insertions(+)
 create mode 100644 drivers/pwm/pwm-intel-lgm.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index eebbc917ac97..a582214f50b2 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -232,6 +232,15 @@ config PWM_IMX_TPM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-imx-tpm.
 
+config PWM_INTEL_LGM
+	tristate "Intel LGM PWM support"
+	depends on X86 || COMPILE_TEST
+	help
+	  Generic PWM framework driver for LGM SoC.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-intel-lgm.
+
 config PWM_JZ4740
 	tristate "Ingenic JZ47xx PWM support"
 	depends on MACH_INGENIC
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9a475073dafc..c16a972a101d 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_PWM_IMG)		+= pwm-img.o
 obj-$(CONFIG_PWM_IMX1)		+= pwm-imx1.o
 obj-$(CONFIG_PWM_IMX27)		+= pwm-imx27.o
 obj-$(CONFIG_PWM_IMX_TPM)	+= pwm-imx-tpm.o
+obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
diff --git a/drivers/pwm/pwm-intel-lgm.c b/drivers/pwm/pwm-intel-lgm.c
new file mode 100644
index 000000000000..e307fd2457df
--- /dev/null
+++ b/drivers/pwm/pwm-intel-lgm.c
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation.
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
+#define TWO_TENTH		204
+
+#define TWO_SECONDS		2000
+#define IGNORE_FIRST_ERR	1
+#define THIRTY_SECS_WINDOW	15
+#define ERR_CNT_THRESHOLD	6
+
+struct intel_pwm_chip {
+	struct pwm_chip		chip;
+	struct regmap		*regmap;
+	struct clk		*clk;
+	struct reset_control	*rst;
+	u32			tach_en;
+	u32			max_rpm;
+	u32			set_rpm;
+	u32			set_dc;
+	struct delayed_work	work;
+};
+
+static inline struct intel_pwm_chip *to_intel_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct intel_pwm_chip, chip);
+}
+
+static int pwm_update_dc(struct intel_pwm_chip *pc, u32 val)
+{
+	return regmap_update_bits(pc->regmap, PWM_FAN_CON0, PWM_FAN_DC_MSK,
+				  FIELD_PREP(PWM_FAN_DC_MSK, val));
+}
+
+static int intel_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    int duty_ns, int period_ns)
+{
+	struct intel_pwm_chip *pc = to_intel_pwm_chip(chip);
+	u32 val;
+
+	val = DIV_ROUND_CLOSEST(duty_ns * MAX_DUTY_CYCLE, period_ns);
+	val = min_t(u32, val, MAX_DUTY_CYCLE);
+
+	if (pc->tach_en) {
+		pc->set_dc = val;
+		pc->set_rpm = val * pc->max_rpm / MAX_DUTY_CYCLE;
+	}
+
+	return pwm_update_dc(pc, val);
+}
+
+static int intel_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct intel_pwm_chip *pc = to_intel_pwm_chip(chip);
+	struct regmap *regmap = pc->regmap;
+
+	regmap_update_bits(regmap, PWM_FAN_CON0,
+			   PWM_FAN_EN_MSK, PWM_FAN_EN_EN);
+
+	if (pc->tach_en)
+		schedule_delayed_work(&pc->work, msecs_to_jiffies(10000));
+
+	return 0;
+}
+
+static void intel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct intel_pwm_chip *pc = to_intel_pwm_chip(chip);
+	struct regmap *regmap = pc->regmap;
+
+	if (pc->tach_en)
+		cancel_delayed_work_sync(&pc->work);
+
+	regmap_update_bits(regmap, PWM_FAN_CON0,
+			   PWM_FAN_EN_MSK, PWM_FAN_EN_DIS);
+}
+
+static const struct pwm_ops intel_pwm_ops = {
+	.config		= intel_pwm_config,
+	.enable		= intel_pwm_enable,
+	.disable	= intel_pwm_disable,
+	.owner		= THIS_MODULE,
+};
+
+static void tach_work(struct work_struct *work)
+{
+	struct intel_pwm_chip *pc = container_of(work, struct intel_pwm_chip,
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
+		pwm_update_dc(pc, fan_dc);
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
+static void pwm_init(struct intel_pwm_chip *pc)
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
+	case 2 ... 3:
+		con0_val |= FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_2WIRE);
+		break;
+	case 4:
+		con0_val |= FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_4WIRE) |
+			    FIELD_PREP(PWM_TACH_EN_MSK, PWM_TACH_EN_EN);
+		con0_mask |= PWM_TACH_EN_MSK | PWM_TACH_PLUS_MSK;
+		pc->tach_en = 1;
+		break;
+	default:
+		/* default is 2wire mode */
+		con0_val |= FIELD_PREP(PWM_FAN_MODE_MSK, PWM_FAN_MODE_2WIRE);
+		break;
+	}
+
+	if (pc->tach_en) {
+		if (device_property_read_u32(dev, "intel,tach-plus",
+					     &tach_plus))
+			tach_plus = 2;
+
+		switch (tach_plus) {
+		case 2:
+			con0_val |= FIELD_PREP(PWM_TACH_PLUS_MSK,
+					       PWM_TACH_PLUS_2);
+			break;
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
+		INIT_DEFERRABLE_WORK(&pc->work, tach_work);
+		regmap_update_bits(regmap, PWM_FAN_CON1,
+				   PWM_FAN_MAX_RPM_MSK, max_rpm);
+	}
+
+	regmap_update_bits(regmap, PWM_FAN_CON0, con0_mask, con0_val);
+}
+
+static const struct regmap_config pwm_regmap_config = {
+	.reg_bits       = 32,
+	.reg_stride     = 4,
+	.val_bits       = 32,
+};
+
+static int intel_pwm_probe(struct platform_device *pdev)
+{
+	struct intel_pwm_chip *pc;
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
+		dev_err(dev, "failed to init register map: %d\n", ret);
+		return ret;
+	}
+
+	pc->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(pc->clk)) {
+		ret = PTR_ERR(pc->clk);
+		dev_err(dev, "failed to get clock: %d\n", ret);
+		return ret;
+	}
+
+	pc->rst = devm_reset_control_get(dev, NULL);
+	if (IS_ERR(pc->rst)) {
+		ret = PTR_ERR(pc->rst);
+		dev_err(dev, "failed to get reset control: %d\n", ret);
+		return ret;
+	}
+
+	ret = clk_prepare_enable(pc->clk);
+	if (ret) {
+		dev_err(dev, "failed to enable clock\n");
+		return ret;
+	}
+
+	reset_control_deassert(pc->rst);
+
+	pc->chip.dev = dev;
+	pc->chip.ops = &intel_pwm_ops;
+	pc->chip.npwm = 1;
+
+	pwm_init(pc);
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(dev, "failed to add PWM chip: %d\n", ret);
+		clk_disable_unprepare(pc->clk);
+		return ret;
+	}
+
+	platform_set_drvdata(pdev, pc);
+	return 0;
+}
+
+static int intel_pwm_remove(struct platform_device *pdev)
+{
+	struct intel_pwm_chip *pc = platform_get_drvdata(pdev);
+	int ret;
+
+	if (pc->tach_en)
+		cancel_delayed_work_sync(&pc->work);
+
+	ret = pwmchip_remove(&pc->chip);
+	if (ret < 0)
+		return ret;
+
+	reset_control_assert(pc->rst);
+
+	clk_disable_unprepare(pc->clk);
+
+	return 0;
+}
+
+static const struct of_device_id intel_pwm_of_match[] = {
+	{ .compatible = "intel,lgm-pwm" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, intel_pwm_of_match);
+
+static struct platform_driver intel_pwm_driver = {
+	.driver = {
+		.name = "intel-pwm",
+		.of_match_table = intel_pwm_of_match,
+	},
+	.probe = intel_pwm_probe,
+	.remove = intel_pwm_remove,
+};
+module_platform_driver(intel_pwm_driver);
-- 
2.11.0

