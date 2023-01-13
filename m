Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCC36696EE
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Jan 2023 13:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjAMM0j (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Jan 2023 07:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241361AbjAMM0T (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Jan 2023 07:26:19 -0500
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72A0778270;
        Fri, 13 Jan 2023 04:23:58 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.97,213,1669042800"; 
   d="scan'208";a="146233439"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 13 Jan 2023 21:23:57 +0900
Received: from localhost.localdomain (unknown [10.226.92.190])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2AAE14454912;
        Fri, 13 Jan 2023 21:23:54 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v13 2/2] pwm: Add support for RZ/G2L GPT
Date:   Fri, 13 Jan 2023 12:23:43 +0000
Message-Id: <20230113122343.769329-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230113122343.769329-1-biju.das.jz@bp.renesas.com>
References: <20230113122343.769329-1-biju.das.jz@bp.renesas.com>
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
v12->v13:
 * Replaced Kconfig dependency from ARCH_RENESAS->ARCH_RZG2L
 * Sorted #include <linux/limits.h> alphabetically
 * Added a comment for mutex_lock to fix check patch warning
 * Replaced data type of duty_cycle from unsigned int->u32 as
   the maximum value stored is U32_MAX.
 * Improved rzg2l_gpt_config() by removing unwanted duty_cycle related code.
 * Improved rzg2l_gpt_get_state() by setting "val = rzg2l_gpt->duty_cycle[pwm->hwpwm];", 
   and factor "tmp = NSEC_PER_SEC * (u64)val;" out of the if-statement.
 * Started using DEFINE_RUNTIME_DEV_PM_OPS(), and dropped __maybe_unused
   from the callbacks.
v11->v12:
 * Added return code for get_state()
 * Cache duty cycle/prescale as the driver cannot read the current duty
   cycle/prescale from the hardware if the hardware is disabled. Cache the
   last programmed duty cycle/prescale value to return in that case.
 * Updated rzg2l_gpt_enable to enable the clocks.
 * Updated rzg2l_gpt_disable to disable the clocks.
 * Updated rzg2l_gpt_config() to cache duty cucle/prescale value
 * Updated rzg2l_gpt_get_state to use cached value of duty cycle/prescale,If the PWM
   is disabled.
 * Simplified rzg2l_gpt_apply()
 * Added comments in rzg2l_gpt_reset_assert_pm_disable()
v10->v11:
 * Used bitmap_zero for initializing bitmap varable.
 * Fixed clock imbalance during remove for the case bootloader turning
   on PWM and module unload is called just after the boot.
 * Fixed over flow condition in get_state() for a prescale value of 2 & more.
 * Improved rzg2l_gpt_cntr_need_stop() based on prescale as it is the
   only runtime variable.
 * Added array for Cache variables state_period and prescale
 * Probe caches the prescale value set by the bootloader.
 * Updated rzg2l_gpt_config() to make use of array variables.
v9->v10:
 * Updated the error handling in probe(), clk_disable_unprepare called
   on the error path.
 * Removed ch_en array and started using bitmask instead.
v8->v9:
 * deassert after devm_clk_get() to avoid reset stays deasserted,in case
   clk_get() fails.
 * Removed ch_offs from struct rzg2l_gpt_chip and use macro instead.
 * Updated error handling in probe()
v7->v8:
 * Modelled as single PWM device handling multiple channels
 * Replaced shared reset->devm_reset_control_get_exclusive()
 * Replaced iowrite32->writel and ioread32->readl
 * Updated prescale calculation
 * Added PM runtime callbacks
 * Updated PM handling and removed "pwm_enabled_by_bootloader" variable
 * Introduced rzg2l_gpt_is_ch_enabled for checking enable status on both
   IO's
 * Moved enable/disable output pins from config->enable/disable.
 * Added rzg2l_gpt_cntr_need_stop() for caching prescalar/mode values.
v6->v7:
 * Added the comment for cacheing rzg2l_gpt->state_period.
 * Fixed boundary values for pv and dc.
 * Added comment for modifying mode, prescaler, timer counter and buffer enable
   registers.
 * Fixed buffer overflow in get_state()
 * Removed unnecessary assignment of state->period value in get_state().
 * Fixed state->duty_cycle value in get_state().
 * Added a limitation for disabling the channels.
v5->v6:
 * Updated macros RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH and
   RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH with computation
   involving FIELD_PREP macro.
 * Removed struct rzg2l_gpt_phase and started using RZG2L_GTCCR macro
   for duty_offset.
 * replaced misnomer real_period->state_period.
 * Added handling for values >= (1024 << 32) for both period
   and duty cycle.
 * Added comments for pwm {en,dis}abled by bootloader during probe.
v4->v5:
 * Added Hardware manual details
 * Replaced the comment GTCNT->Counter
 * Removed the macros RZG2L_GPT_IO_PER_CHANNEL and chip.npwm directly
   used in probe.
 * Removed the unsed macro RZG2L_GTPR_MAX_VALUE
 * Added driver prefix for the type name and the variable.
 * Initialization of per_channel data moved from request->probe.
 * Updated clr parameter for rzg2l_gpt_modify for Start count.
 * Started using mutex and usage_count for handling shared
   period and prescalar for the 2 channels.
 * Updated the comment cycle->period.
 * Removed clk_disable from rzg2l_gpt_reset_assert_pm_disable()
 * Replaced pc->rzg2l_gpt.
 * Updated prescale calculation.
 * Moved pm_runtime_{get_sync,put} from {request,free}->{enable,disable}
 * Removed platform_set_drvdata as it is unused
 * Removed the variable pwm_enabled_by_bootloader 
 * Added dev_err_probe in various error paths in probe.
 * Added an error message, if devm_pwmchip_add() fails.
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
 drivers/pwm/Kconfig         |  11 +
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-rzg2l-gpt.c | 564 ++++++++++++++++++++++++++++++++++++
 3 files changed, 576 insertions(+)
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dae023d783a2..74cbc674d846 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -481,6 +481,17 @@ config PWM_ROCKCHIP
 	  Generic PWM framework driver for the PWM controller found on
 	  Rockchip SoCs.
 
+config PWM_RZG2L_GPT
+	tristate "Renesas RZ/G2L General PWM Timer support"
+	depends on ARCH_RZG2L || COMPILE_TEST
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
index 7bf1a29f02b8..cac39b18d1ee 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -44,6 +44,7 @@ obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
+obj-$(CONFIG_PWM_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
new file mode 100644
index 000000000000..2a84bb9d35cb
--- /dev/null
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L General PWM Timer (GPT) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ *
+ * Limitations:
+ * - Counter must be stopped before modifying Mode and Prescaler.
+ * - When PWM is disabled, the output is driven to inactive.
+ * - While the hardware supports both polarities, the driver (for now)
+ *   only handles normal polarity.
+ * - When both channels are used, disabling the channel on one stops the
+ *   other.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/time.h>
+
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
+	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_HI_OUT_HI_END_TOGGLE) | RZG2L_GTIOR_OBE)
+#define RZG2L_GTIOR_GTIOB_OUT_LO_END_TOGGLE_CMP_MATCH \
+	(FIELD_PREP(RZG2L_GTIOR_GTIOB, RZG2L_INIT_OUT_LO_OUT_LO_END_TOGGLE) | RZG2L_GTIOR_OBE)
+
+#define RZG2L_GTCCR(i) (0x4c + 4 * (i))
+
+#define RZG2L_MAX_HW_CHANNELS	(8)
+#define RZG2L_CHANNELS_PER_IO	(2)
+#define RZG2L_MAX_PWM_CHANNELS	(RZG2L_MAX_HW_CHANNELS * RZG2L_CHANNELS_PER_IO)
+
+#define RZG2L_IS_IOB(a) ((a) & 0x1)
+#define RZG2L_GET_CH_INDEX(a) ((a) / 2)
+
+#define RZG2L_GET_CH_OFFS(i) (0x100 * (i))
+
+struct rzg2l_gpt_chip {
+	struct pwm_chip chip;
+	void __iomem *mmio;
+	struct reset_control *rstc;
+	struct clk *clk;
+	struct mutex lock; /* lock to protect shared channel resources */
+	unsigned long rate;
+	u32 state_period[RZG2L_MAX_HW_CHANNELS];
+	u32 user_count[RZG2L_MAX_HW_CHANNELS];
+	/*
+	 * The driver cannot read the current duty cycle/prescale from the
+	 * hardware if the hardware is disabled. Cache the last programmed
+	 * duty cycle/prescale value to return in that case.
+	 */
+	u8 prescale[RZG2L_MAX_HW_CHANNELS];
+	u32 duty_cycle[RZG2L_MAX_PWM_CHANNELS];
+};
+
+static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rzg2l_gpt_chip, chip);
+}
+
+static void rzg2l_gpt_write(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 data)
+{
+	writel(data, rzg2l_gpt->mmio + reg);
+}
+
+static u32 rzg2l_gpt_read(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg)
+{
+	return readl(rzg2l_gpt->mmio + reg);
+}
+
+static void rzg2l_gpt_modify(struct rzg2l_gpt_chip *rzg2l_gpt, u32 reg, u32 clr,
+			     u32 set)
+{
+	rzg2l_gpt_write(rzg2l_gpt, reg,
+			(rzg2l_gpt_read(rzg2l_gpt, reg) & ~clr) | set);
+}
+
+static u8 rzg2l_gpt_calculate_prescale(struct rzg2l_gpt_chip *rzg2l_gpt,
+				       u64 period_cycles)
+{
+	u32 prescaled_period_cycles;
+	u8 prescale;
+
+	prescaled_period_cycles = period_cycles >> 32;
+	if (prescaled_period_cycles >= 256)
+		prescale = 5;
+	else
+		prescale = (fls(prescaled_period_cycles) + 1) / 2;
+
+	return prescale;
+}
+
+static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u32 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
+
+	mutex_lock(&rzg2l_gpt->lock);
+	rzg2l_gpt->user_count[ch_index]++;
+	mutex_unlock(&rzg2l_gpt->lock);
+
+	return 0;
+}
+
+static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u32 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
+
+	mutex_lock(&rzg2l_gpt->lock);
+	rzg2l_gpt->user_count[ch_index]--;
+	mutex_unlock(&rzg2l_gpt->lock);
+}
+
+static bool rzg2l_gpt_is_ch_enabled(struct rzg2l_gpt_chip *rzg2l_gpt, u8 ch)
+{
+	u8 ch_index = RZG2L_GET_CH_INDEX(ch);
+	u32 offs = RZG2L_GET_CH_OFFS(ch_index);
+	bool is_counter_running, is_output_en;
+	u32 val;
+
+	val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
+	is_counter_running = val & RZG2L_GTCR_CST;
+
+	val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTIOR);
+	if (RZG2L_IS_IOB(ch))
+		is_output_en = val & RZG2L_GTIOR_OBE;
+	else
+		is_output_en = val & RZG2L_GTIOR_OAE;
+
+	return (is_counter_running && is_output_en);
+}
+
+static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *rzg2l_gpt,
+			    struct pwm_device *pwm)
+{
+	u8 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
+	u32 offs = RZG2L_GET_CH_OFFS(ch_index);
+	int rc;
+
+	rc = pm_runtime_resume_and_get(rzg2l_gpt->chip.dev);
+	if (rc)
+		return rc;
+
+	/* Enable pin output */
+	if (RZG2L_IS_IOB(pwm->hwpwm))
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
+				 RZG2L_GTIOR_GTIOB | RZG2L_GTIOR_OBE,
+				 RZG2L_GTIOR_GTIOB_OUT_HI_END_TOGGLE_CMP_MATCH);
+	else
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR,
+				 RZG2L_GTIOR_GTIOA | RZG2L_GTIOR_OAE,
+				 RZG2L_GTIOR_GTIOA_OUT_HI_END_TOGGLE_CMP_MATCH);
+
+	/* Start count */
+	rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, 0, RZG2L_GTCR_CST);
+
+	return 0;
+}
+
+static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *rzg2l_gpt,
+			      struct pwm_device *pwm)
+{
+	u8 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
+	u32 offs = RZG2L_GET_CH_OFFS(ch_index);
+
+	/* Disable pin output */
+	if (RZG2L_IS_IOB(pwm->hwpwm))
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, RZG2L_GTIOR_OBE, 0);
+	else
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTIOR, RZG2L_GTIOR_OAE, 0);
+
+	/* Stop count, Output low on GTIOCx pin when counting stops */
+	if (rzg2l_gpt->user_count[ch_index] <= 1)
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);
+
+	pm_runtime_put_sync(rzg2l_gpt->chip.dev);
+}
+
+static bool rzg2l_gpt_cntr_need_stop(struct rzg2l_gpt_chip *rzg2l_gpt, u32 ch,
+				     u8 prescale)
+{
+	u8 ch_index = RZG2L_GET_CH_INDEX(ch);
+
+	return rzg2l_gpt->prescale[ch_index] != FIELD_PREP(RZG2L_GTCR_TPCS,
+							   prescale);
+}
+
+static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u8 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
+	u32 offs = RZG2L_GET_CH_OFFS(ch_index);
+	bool is_counter_running;
+	unsigned long pv, dc;
+	u64 period_cycles;
+	u64 duty_cycles;
+	u8 prescale;
+	int err;
+
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflowing the following
+	 * calculation.
+	 */
+	if (rzg2l_gpt->rate > NSEC_PER_SEC)
+		return -EINVAL;
+
+	/*
+	 * GPT counter is shared by multiple channels, so prescale and period
+	 * can NOT be modified when there are multiple channels in use with
+	 * different settings.
+	 */
+	if (state->period != rzg2l_gpt->state_period[ch_index] &&
+	    rzg2l_gpt->user_count[ch_index] > 1)
+		return -EBUSY;
+
+	/*
+	 * GPT counter is shared by multiple channels, we cache the period value
+	 * from the first enabled channel and use the same value for both
+	 * channels.
+	 */
+	rzg2l_gpt->state_period[ch_index] = state->period;
+
+	period_cycles = mul_u64_u32_div(state->period, rzg2l_gpt->rate, NSEC_PER_SEC);
+	prescale = rzg2l_gpt_calculate_prescale(rzg2l_gpt, period_cycles);
+	rzg2l_gpt->prescale[ch_index] = prescale;
+
+	if (period_cycles >> (2 * prescale) <= U32_MAX)
+		pv = period_cycles >> (2 * prescale);
+	else
+		pv = U32_MAX;
+
+	duty_cycles = mul_u64_u32_div(state->duty_cycle, rzg2l_gpt->rate, NSEC_PER_SEC);
+	if (duty_cycles >> (2 * prescale) <= U32_MAX)
+		dc = duty_cycles >> (2 * prescale);
+	else
+		dc = U32_MAX;
+
+	/*
+	 * Store the duty cycle/prescale for future reference in cases where the
+	 * corresponding registers can't be read (i.e. when the PWM is disabled).
+	 */
+	rzg2l_gpt->prescale[ch_index] = prescale;
+	rzg2l_gpt->duty_cycle[pwm->hwpwm] = dc;
+
+	/*
+	 * If the PWM channel is disabled, make sure to turn on the clock
+	 * before writing the register.
+	 */
+	if (!pwm_is_enabled(pwm)) {
+		err = pm_runtime_resume_and_get(chip->dev);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Counter must be stopped before modifying mode, prescaler, timer
+	 * counter and buffer enable registers. These registers are shared
+	 * between both channels. So allow updating these registers only for the
+	 * first enabled channel.
+	 */
+	if (rzg2l_gpt->user_count[ch_index] <= 1 &&
+	    rzg2l_gpt_cntr_need_stop(rzg2l_gpt, pwm->hwpwm, prescale))
+		rzg2l_gpt_modify(rzg2l_gpt,
+				 offs + RZG2L_GTCR, RZG2L_GTCR_CST, 0);
+
+	is_counter_running = rzg2l_gpt_read(rzg2l_gpt,
+					    offs + RZG2L_GTCR) & RZG2L_GTCR_CST;
+	if (!is_counter_running)
+		/* GPT set operating mode (saw-wave up-counting) */
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_MD,
+				 RZG2L_GTCR_MD_SAW_WAVE_PWM_MODE);
+
+	/* Set count direction */
+	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTUDDTYC, RZG2L_UP_COUNTING);
+	if (!is_counter_running)
+		/* Select count clock */
+		rzg2l_gpt_modify(rzg2l_gpt, offs + RZG2L_GTCR, RZG2L_GTCR_TPCS,
+				 FIELD_PREP(RZG2L_GTCR_TPCS, prescale));
+
+	/* Set period */
+	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTPR, pv);
+
+	/* Set duty cycle */
+	rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm->hwpwm)),
+			dc);
+	if (!is_counter_running) {
+		/* Set initial value for counter */
+		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTCNT, 0);
+
+		/* Set no buffer operation */
+		rzg2l_gpt_write(rzg2l_gpt, offs + RZG2L_GTBER, 0);
+	}
+
+	/* If the PWM is not enabled, turn the clock off again to save power. */
+	if (!pwm_is_enabled(pwm))
+		pm_runtime_put(chip->dev);
+
+	return 0;
+}
+
+static int rzg2l_gpt_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+			       struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	u32 ch_index = RZG2L_GET_CH_INDEX(pwm->hwpwm);
+	u32 offs = RZG2L_GET_CH_OFFS(ch_index);
+	u8 prescale;
+	u64 tmp;
+	u32 val;
+
+	pm_runtime_get_sync(chip->dev);
+	val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
+	state->enabled = rzg2l_gpt_is_ch_enabled(rzg2l_gpt, pwm->hwpwm);
+	if (state->enabled) {
+		prescale = FIELD_GET(RZG2L_GTCR_TPCS, val);
+
+		val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTPR);
+		tmp = NSEC_PER_SEC * (u64)val;
+		state->period = DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 * prescale);
+		val = rzg2l_gpt_read(rzg2l_gpt,
+				     offs + RZG2L_GTCCR(RZG2L_IS_IOB(pwm->hwpwm)));
+	} else {
+		/* If the PWM is disabled, use the cached value. */
+		prescale = rzg2l_gpt->prescale[ch_index];
+		val = rzg2l_gpt->duty_cycle[pwm->hwpwm];
+	}
+
+	tmp = NSEC_PER_SEC * (u64)val;
+	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, rzg2l_gpt->rate) << (2 * prescale);
+	state->polarity = PWM_POLARITY_NORMAL;
+	pm_runtime_put(chip->dev);
+
+	return 0;
+}
+
+static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = to_rzg2l_gpt_chip(chip);
+	bool enabled = pwm->state.enabled;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (enabled)
+			rzg2l_gpt_disable(rzg2l_gpt, pwm);
+
+		return 0;
+	}
+
+	mutex_lock(&rzg2l_gpt->lock);
+	ret = rzg2l_gpt_config(chip, pwm, state);
+	mutex_unlock(&rzg2l_gpt->lock);
+	if (ret)
+		return ret;
+
+	if (!enabled)
+		ret = rzg2l_gpt_enable(rzg2l_gpt, pwm);
+
+	return ret;
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
+static int rzg2l_gpt_pm_runtime_suspend(struct device *dev)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rzg2l_gpt->clk);
+
+	return 0;
+}
+
+static int rzg2l_gpt_pm_runtime_resume(struct device *dev)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = dev_get_drvdata(dev);
+
+	clk_prepare_enable(rzg2l_gpt->clk);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(rzg2l_gpt_pm_ops,
+				 rzg2l_gpt_pm_runtime_suspend,
+				 rzg2l_gpt_pm_runtime_resume, NULL);
+
+static void rzg2l_gpt_reset_assert_pm_disable(void *data)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = data;
+	u32 i;
+
+	/*
+	 * The below check is for making balanced PM usage count
+	 * eg: boot loader is turning on PWM and probe increments the PM usage
+	 * count. Before apply, if there is unbind/remove callback we need to
+	 * decrement the PM usage count.
+	 */
+
+	clk_prepare_enable(rzg2l_gpt->clk);
+	for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
+		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i))
+			pm_runtime_put(rzg2l_gpt->chip.dev);
+	}
+	clk_disable_unprepare(rzg2l_gpt->clk);
+
+	pm_runtime_disable(rzg2l_gpt->chip.dev);
+	pm_runtime_set_suspended(rzg2l_gpt->chip.dev);
+	reset_control_assert(rzg2l_gpt->rstc);
+}
+
+static int rzg2l_gpt_probe(struct platform_device *pdev)
+{
+	DECLARE_BITMAP(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
+	struct rzg2l_gpt_chip *rzg2l_gpt;
+	u32 ch_index, offs, val;
+	int ret;
+	u32 i;
+
+	rzg2l_gpt = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_gpt), GFP_KERNEL);
+	if (!rzg2l_gpt)
+		return -ENOMEM;
+
+	rzg2l_gpt->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzg2l_gpt->mmio))
+		return PTR_ERR(rzg2l_gpt->mmio);
+
+	rzg2l_gpt->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(rzg2l_gpt->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->rstc),
+				     "get reset failed\n");
+
+	rzg2l_gpt->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(rzg2l_gpt->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzg2l_gpt->clk),
+				     "cannot get clock\n");
+
+	ret = reset_control_deassert(rzg2l_gpt->rstc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot deassert reset control\n");
+
+	rzg2l_gpt->rate = clk_get_rate(rzg2l_gpt->clk);
+
+	clk_prepare_enable(rzg2l_gpt->clk);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rzg2l_gpt_reset_assert_pm_disable,
+				       rzg2l_gpt);
+	if (ret < 0)
+		goto clk_disable;
+
+	mutex_init(&rzg2l_gpt->lock);
+	platform_set_drvdata(pdev, rzg2l_gpt);
+	bitmap_zero(ch_en_bits, RZG2L_MAX_PWM_CHANNELS);
+
+	/*
+	 *  We need to keep the clock on, in case the bootloader has enabled the
+	 *  PWM and is running during probe().
+	 */
+	for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
+		if (rzg2l_gpt_is_ch_enabled(rzg2l_gpt, i)) {
+			ch_index = RZG2L_GET_CH_INDEX(i);
+			offs = RZG2L_GET_CH_OFFS(ch_index);
+			val = rzg2l_gpt_read(rzg2l_gpt, offs + RZG2L_GTCR);
+			rzg2l_gpt->prescale[ch_index] = FIELD_PREP(RZG2L_GTCR_TPCS,
+								   val);
+			set_bit(i, ch_en_bits);
+			pm_runtime_get_sync(&pdev->dev);
+		}
+	}
+
+	rzg2l_gpt->chip.dev = &pdev->dev;
+	rzg2l_gpt->chip.ops = &rzg2l_gpt_ops;
+	rzg2l_gpt->chip.npwm = RZG2L_MAX_PWM_CHANNELS;
+
+	ret = devm_pwmchip_add(&pdev->dev, &rzg2l_gpt->chip);
+	if (ret) {
+		for (i = 0; i < RZG2L_MAX_PWM_CHANNELS; i++) {
+			if (test_bit(i, ch_en_bits))
+				pm_runtime_put(&pdev->dev);
+		}
+
+		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+		goto clk_disable;
+	}
+
+	return 0;
+
+clk_disable:
+	clk_disable_unprepare(rzg2l_gpt->clk);
+	return ret;
+}
+
+static struct platform_driver rzg2l_gpt_driver = {
+	.driver = {
+		.name = "pwm-rzg2l-gpt",
+		.pm = pm_ptr(&rzg2l_gpt_pm_ops),
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

