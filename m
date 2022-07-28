Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF358441A
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Jul 2022 18:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbiG1QZt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Jul 2022 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiG1QZo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Jul 2022 12:25:44 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C668B41D35;
        Thu, 28 Jul 2022 09:25:42 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,198,1654527600"; 
   d="scan'208";a="127694158"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 29 Jul 2022 01:25:41 +0900
Received: from localhost.localdomain (unknown [10.226.93.50])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 8DA4D400940D;
        Fri, 29 Jul 2022 01:25:38 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v4 2/2] pwm: Add support for RZ/G2L GPT
Date:   Thu, 28 Jul 2022 17:25:26 +0100
Message-Id: <20220728162526.330542-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728162526.330542-1-biju.das.jz@bp.renesas.com>
References: <20220728162526.330542-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

RZ/G2L General PWM Timer (GPT) composed of 8 channels with 32-bit timer
(GPT32E). It supports the following functions
 * 32 bits × 8 channels
 * Up-counting or down-counting (saw waves) or up/down-counting
   (triangle waves) for each counter.
 * Clock sources independently selectable for each channel
 * Two I/O pins per channel
 * Two output compare/input capture registers per channel
 * For the two output compare/input capture registers of each channel,
   four registers are provided as buffer registers and are capable of
   operating as comparison registers when buffering is not in use.
 * In output compare operation, buffer switching can be at crests or
   troughs, enabling the generation of laterally asymmetric PWM waveforms.
 * Registers for setting up frame cycles in each channel (with capability
   for generating interrupts at overflow or underflow)
 * Generation of dead times in PWM operation
 * Synchronous starting, stopping and clearing counters for arbitrary
   channels
 * Starting, stopping, clearing and up/down counters in response to input
   level comparison
 * Starting, clearing, stopping and up/down counters in response to a
   maximum of four external triggers
 * Output pin disable function by dead time error and detected
   short-circuits between output pins
 * A/D converter start triggers can be generated (GPT32E0 to GPT32E3)
 * Enables the noise filter for input capture and external trigger
   operation

This patch adds basic pwm support for RZ/G2L GPT driver by creating
separate logical channels for each IOs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Changed the local variable type i from u16->u8 and prescaled_period_
   cycles from u64->u32 in calculate_prescale().
 * Replaced mul_u64_u64_div_u64()->mul_u64_u32_div()
 * Dropped the comma after the sentinel.
 * Add a variable to track pwm enabled by bootloader and added comments
   in probe().
 * Removed unnecessary rzg2l_gpt_reset_assert_pm_disable() from probe.
 * Replaced devm_clk_get()->devm_clk_get_prepared()
 * Removed devm_clk_get_optional_enabled()
v2->v3:
 * Updated limitation section
 * Added prefix "RZG2L_" for all macros
 * Modified prescale calculation
 * Removed pwm_set_chip_data
 * Updated comment related to modifying Mode and Prescaler
 * Updated setting of prescale value in rzg2l_gpt_config()
 * Removed else branch from rzg2l_gpt_get_state()
 * removed the err label from rzg2l_gpt_apply()
 * Added devm_clk_get_optional_enabled() to retain clk on status,
   in case bootloader turns on the clk of pwm.
 * Replaced devm_reset_control_get_exclusive->devm_reset_control_get_shared
   as single reset shared between 8 channels.
v1->v2:
 * Added Limitations section
 * dropped "_MASK" from the define names.
 * used named initializer for struct phase
 * Added gpt_pwm_device into a flexible array member in rzg2l_gpt_chip
 * Revised the logic for prescale
 * Added .get_state callback
 * Improved error handling in rzg2l_gpt_apply
 * Removed .remove callback
 * Tested driver with PWM_DEBUG enabled
RFC->V1:
 * Updated macros
 * replaced rzg2l_gpt_write_mask()->rzg2l_gpt_modify()
 * Added rzg2l_gpt_read()
---
 drivers/pwm/Kconfig         |  11 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-rzg2l-gpt.c | 371 ++++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+)
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 904de8d61828..a6cf24cb31e0 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -471,6 +471,17 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_RZG2L_GPT
+	tristate "Renesas RZ/G2L General PWM Timer support"
+	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the General PWM Timer controller found in Renesas
+	  RZ/G2L like chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rzg2l-gpt.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 5c08bdb817b4..12bc2a005e24 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
new file mode 100644
index 000000000000..8d25428bed69
--- /dev/null
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -0,0 +1,371 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L General PWM Timer (GPT) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Limitations:
+ * - GTCNT must be stopped before modifying Mode and Prescaler.
+ * - When PWM is disabled, the output is driven to inactive.
+ * - While the hardware supports both polarities, the driver (for now)
+ *   only handles normal polarity.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/time.h>
+
+#define RZG2L_GPT_IO_PER_CHANNEL	2
+
+#define RZG2L_GTPR_MAX_VALUE	0xFFFFFFFF
+#define RZG2L_GTCR		0x2c
+#define RZG2L_GTUDDTYC		0x30
+#define RZG2L_GTIOR		0x34
+#define RZG2L_GTBER		0x40
+#define RZG2L_GTCNT		0x48
+#define RZG2L_GTCCRA		0x4c
+#define RZG2L_GTCCRB		0x50
+#define RZG2L_GTPR		0x64
+
+#define RZG2L_GTCR_CST		BIT(0)
+#define RZG2L_GTCR_MD		GENMASK(18, 16)
+#define RZG2L_GTCR_TPCS		GENMASK(26, 24)
+
+#define RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE	FIELD_PREP(RZG2L_GTCR_MD, 0)
+
+#define RZG2L_GTUDDTYC_UP	BIT(0)
+#define RZG2L_GTUDDTYC_UDF	BIT(1)
+#define RZG2L_UP_COUNTING	(RZG2L_GTUDDTYC_UP | RZG2L_GTUDDTYC_UDF)
+
+#define RZG2L_GTIOR_GTIOA	GENMASK(4, 0)
+#define RZG2L_GTIOR_GTIOB	GENMASK(20, 16)
+#define RZG2L_GTIOR_OAE		BIT(8)
+#define RZG2L_GTIOR_OBE		BIT(24)
+
+#define RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE	0x07
+#define RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE	0x1b
+
+#define RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH \
+	(RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE | RZG2L_GTIOR_OAE)
+#define RZG2L_GTIOR_GTIOA_OUT_LO_END_TOGGLE_CMP_MATCH \
+	(RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE | RZG2L_GTIOR_OAE)
+#define RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH \
+	((RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
+#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
+	((RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE << 16) | RZG2L_GTIOR_OBE)
+
+struct phase {
+	u32 value;
+	u32 mask;
+	u32 duty_reg_offset;
+};
+
+static const struct phase phase_params[] = {
+	/* Setting for phase A */
+	{
+		.value = RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH,
+		.mask = RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
+		.duty_reg_offset = RZG2L_GTCCRA,
+	},
+	/* Setting for phase B */
+	{
+		.value = RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH,
+		.mask = RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
+		.duty_reg_offset = RZG2L_GTCCRB,
+	},
+};
+
+struct gpt_pwm_device {
+	const struct phase *ph;
+};
+
+struct rzg2l_gpt_chip {
+	struct pwm_chip chip;
+	void __iomem *mmio;
+	struct reset_control *rstc;
+	struct clk *clk;
+	struct gpt_pwm_device gpt[2];
+	bool pwm_enabled_by_bootloader;
+};
+
+static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rzg2l_gpt_chip, chip);
+}
+
+static void rzg2l_gpt_write(struct rzg2l_gpt_chip *pc, u32 reg, u32 data)
+{
+	iowrite32(data, pc->mmio + reg);
+}
+
+static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *pc, u32 reg)
+{
+	return ioread32(pc->mmio + reg);
+}
+
+static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *pc, u32 reg, u32 clr, u32 set)
+{
+	rzg2l_gpt_write(pc, reg, (rzg2l_gpt_read(pc, reg) & ~clr) | set);
+}
+
+static u8 rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, u64 period_cycles)
+{
+	u32 prescaled_period_cycles;
+	u8 prescale, i;
+
+	prescaled_period_cycles = period_cycles >> 32;
+	prescale = 5;
+	/* prescale 1, 4, 16, 64, 256 and 1024 */
+	for (i = 0; i < 6; i++) {
+		if ((1 << (2 * i)) > prescaled_period_cycles) {
+			prescale = i;
+			break;
+		}
+	}
+
+	return prescale;
+}
+
+static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	struct gpt_pwm_device *gpt;
+
+	if (pwm->hwpwm >= RZG2L_GPT_IO_PER_CHANNEL)
+		return -EINVAL;
+
+	gpt = &pc->gpt[pwm->hwpwm];
+	gpt->ph = &phase_params[pwm->hwpwm];
+
+	pm_runtime_get_sync(chip->dev);
+
+	return 0;
+}
+
+static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	pm_runtime_put(chip->dev);
+}
+
+static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc)
+{
+	/* Start count */
+	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_CST, RZG2L_GTCR_CST);
+
+	return 0;
+}
+
+static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc)
+{
+	/* Stop count, Output low on GTIOCx pin when counting stops */
+	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_CST, 0);
+}
+
+static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    u64 duty_ns, u64 period_ns)
+{
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	struct gpt_pwm_device *gpt = &pc->gpt[pwm->hwpwm];
+	unsigned long rate, pv, dc;
+	u64 period_cycles;
+	u8 prescale;
+
+	rate = clk_get_rate(pc->clk);
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflowing the following
+	 * calculation.
+	 */
+	if (rate > NSEC_PER_SEC)
+		return -EINVAL;
+
+	period_cycles = mul_u64_u32_div(period_ns, rate, NSEC_PER_SEC);
+	prescale = rzg2l_calculate_prescale(pc, period_cycles);
+
+	pv = round_down(period_cycles >> (2 * prescale), 1 << (2 * prescale));
+	period_cycles = mul_u64_u32_div(duty_ns, rate, NSEC_PER_SEC);
+	dc = round_down(period_cycles >> (2 * prescale), 1 << (2 * prescale));
+
+	/* GTCNT must be stopped before modifying Mode and Prescaler */
+	if (rzg2l_gpt_read(pc, RZG2L_GTCR) & RZG2L_GTCR_CST)
+		rzg2l_gpt_disable(pc);
+
+	/* GPT set operating mode (saw-wave up-counting) */
+	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_MD, RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
+
+	/* Set count direction */
+	rzg2l_gpt_write(pc, RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
+
+	/* Select count clock */
+	rzg2l_gpt_modify(pc, RZG2L_GTCR, RZG2L_GTCR_TPCS, FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
+
+	/* Set cycle */
+	rzg2l_gpt_write(pc, RZG2L_GTPR, pv);
+
+	/* Set duty cycle */
+	rzg2l_gpt_write(pc, gpt->ph->duty_reg_offset, dc);
+
+	/* Set initial value for counter */
+	rzg2l_gpt_write(pc, RZG2L_GTCNT, 0);
+
+	/* Set no buffer operation */
+	rzg2l_gpt_write(pc, RZG2L_GTBER, 0);
+
+	/* Enable pin output */
+	rzg2l_gpt_modify(pc, RZG2L_GTIOR, gpt->ph->mask, gpt->ph->value);
+
+	return 0;
+}
+
+static void rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	struct gpt_pwm_device *gpt = &pc->gpt[pwm->hwpwm];
+	unsigned long rate;
+	u8 prescale;
+	u64 tmp;
+	u32 val;
+
+	val = rzg2l_gpt_read(pc, RZG2L_GTCR);
+	state->enabled = val & RZG2L_GTCR_CST;
+	if (state->enabled) {
+		rate = clk_get_rate(pc->clk);
+		prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
+
+		val = rzg2l_gpt_read(pc, RZG2L_GTPR);
+		tmp = NSEC_PER_SEC * val << (2 * prescale);
+		state->period = DIV_ROUND_UP_ULL(tmp, rate);
+
+		val = rzg2l_gpt_read(pc, gpt->ph->duty_reg_offset);
+		tmp = NSEC_PER_SEC * val << (2 * prescale);
+		state->duty_cycle = DIV_ROUND_UP_ULL(tmp, rate);
+	}
+
+	state->polarity = PWM_POLARITY_NORMAL;
+}
+
+static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		rzg2l_gpt_disable(pc);
+		return 0;
+	}
+
+	ret = rzg2l_gpt_config(chip, pwm, state->duty_cycle, state->period);
+	if (ret)
+		return ret;
+
+	return rzg2l_gpt_enable(pc);
+}
+
+static const struct pwm_ops rzg2l_gpt_ops = {
+	.request = rzg2l_gpt_request,
+	.free = rzg2l_gpt_free,
+	.get_state = rzg2l_gpt_get_state,
+	.apply = rzg2l_gpt_apply,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,rzg2l-gpt", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
+
+static void rzg2l_gpt_reset_assert_pm_disable(void *data)
+{
+	struct rzg2l_gpt_chip *pc = data;
+
+	if (pc->pwm_enabled_by_bootloader)
+		clk_disable(pc->clk);
+
+	pm_runtime_disable(pc->chip.dev);
+	reset_control_assert(pc->rstc);
+}
+
+static int rzg2l_gpt_probe(struct platform_device *pdev)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	int ret;
+
+	rzg2l_gpt = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
+	if (!rzg2l_gpt)
+		return -ENOMEM;
+
+	rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzg2l_gpt->mmio))
+		return PTR_ERR(rzg2l_gpt->mmio);
+
+	rzg2l_gpt->rstc = devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(rzg2l_gpt->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
+				     "get reset failed\n");
+
+	rzg2l_gpt->clk = devm_clk_get_prepared(&pdev->dev, NULL);
+	if (IS_ERR(rzg2l_gpt->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
+				     "cannot get clock\n");
+
+	platform_set_drvdata(pdev, rzg2l_gpt);
+
+	ret = reset_control_deassert(rzg2l_gpt->rstc);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot deassert reset control: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rzg2l_gpt_reset_assert_pm_disable,
+				       rzg2l_gpt);
+	if (ret < 0)
+		return ret;
+
+	ret = clk_enable(rzg2l_gpt->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "clk enable failed\n");
+	/*
+	 *  We need to keep the clock on, in case the bootloader enabled PWM and
+	 *  is running during probe().
+	 */
+	if (rzg2l_gpt_read(rzg2l_gpt, RZG2L_GTCR) & RZG2L_GTCR_CST)
+		rzg2l_gpt->pwm_enabled_by_bootloader = true;
+	else
+		clk_disable(rzg2l_gpt->clk);
+
+	rzg2l_gpt->chip.dev = &pdev->dev;
+	rzg2l_gpt->chip.ops = &rzg2l_gpt_ops;
+	rzg2l_gpt->chip.npwm = RZG2L_GPT_IO_PER_CHANNEL;
+
+	return devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
+}
+
+static struct platform_driver rzg2l_gpt_driver = {
+	.driver = {
+		.name = "pwm-rzg2l-gpt",
+		.of_match_table = of_match_ptr(rzg2l_gpt_of_table),
+	},
+	.probe = rzg2l_gpt_probe,
+};
+module_platform_driver(rzg2l_gpt_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pwm-rzg2l-gpt");
-- 
2.25.1

