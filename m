Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1276ABA58
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Mar 2023 10:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjCFJuH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Mar 2023 04:50:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjCFJuF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Mar 2023 04:50:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2363E054;
        Mon,  6 Mar 2023 01:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1678096201; x=1709632201;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5UlR1duBSnFUqhF7s8P/FD94mV3rd0d/bnyQR9uoik=;
  b=0AdZrRD4JrdUhphJHLO2tpXOKQJkuMHPGulHdT38sUDcXqnRA7A+oaeR
   wmN58nTSrU02MYQS/wk/Og7Cp4zjuuOO93JrZAQhtLAgLImxLA++PpOvp
   a0jqNNR0K3jZEeZ2UAURz4eoWfxBKhTy+fy03oa1YaIvUdQJmBZ+9q1BJ
   BHhYtLFlQJuoRzbzgK5Ag3va25SX6NVm+KaAax4V/xwMOsRr2dbg+Imd0
   xjVIWl+Yuok2GR+WmSwYjsb1emENufJsbFJNtZc3L2XxV/L3C3zmJaOWC
   BvOyfso5cZeyXeiS0JIijsQANPM6gx8i76DlT75WLfJAARnxCXzRa81Jt
   A==;
X-IronPort-AV: E=Sophos;i="5.98,236,1673938800"; 
   d="scan'208";a="203807094"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2023 02:50:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 6 Mar 2023 02:49:58 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.16 via Frontend
 Transport; Mon, 6 Mar 2023 02:49:57 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v14 1/2] pwm: add microchip soft ip corePWM driver
Date:   Mon, 6 Mar 2023 09:48:58 +0000
Message-ID: <20230306094858.1614819-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306094858.1614819-1-conor.dooley@microchip.com>
References: <20230306094858.1614819-1-conor.dooley@microchip.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17256; i=conor.dooley@microchip.com; h=from:subject; bh=a5UlR1duBSnFUqhF7s8P/FD94mV3rd0d/bnyQR9uoik=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCms2zkvsTg03drGuH31mf/W8iXM4g5MkWVPl0kdZTHa8vVo Zs2djlIWBjEOBlkxRZbE230tUuv/uOxw7nkLM4eVCWQIAxenAExk3hZGho/TVngrvZNLy7tmsaRqtu m+5K1tznIHhPr2GWaI3dXllmD4w/P39zndFq8/rruSigPnztmRW1F1Yn3JnmMCk7lvbnPn4AYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a driver that supports the Microchip FPGA "soft" PWM IP core.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pwm/Kconfig              |  10 +
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 441 +++++++++++++++++++++++++++++++
 3 files changed, 452 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index dae023d783a22..f42756a014ed4 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -393,6 +393,16 @@ config PWM_MEDIATEK
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-mediatek.
 
+config PWM_MICROCHIP_CORE
+	tristate "Microchip corePWM PWM support"
+	depends on SOC_MICROCHIP_POLARFIRE || COMPILE_TEST
+	depends on HAS_IOMEM && OF
+	help
+	  PWM driver for Microchip FPGA soft IP core.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-microchip-core.
+
 config PWM_MXS
 	tristate "Freescale MXS PWM support"
 	depends on ARCH_MXS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b84..a65625359ece4 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
new file mode 100644
index 0000000000000..a2a2e28f39031
--- /dev/null
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * corePWM driver for Microchip "soft" FPGA IP cores.
+ *
+ * Copyright (c) 2021-2023 Microchip Corporation. All rights reserved.
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ * Documentation:
+ * https://www.microsemi.com/document-portal/doc_download/1245275-corepwm-hb
+ *
+ * Limitations:
+ * - If the IP block is configured without "shadow registers", all register
+ *   writes will take effect immediately, causing glitches on the output.
+ *   If shadow registers *are* enabled, a write to the "SYNC_UPDATE" register
+ *   notifies the core that it needs to update the registers defining the
+ *   waveform from the contents of the "shadow registers".
+ * - The IP block has no concept of a duty cycle, only rising/falling edges of
+ *   the waveform. Unfortunately, if the rising & falling edges registers have
+ *   the same value written to them the IP block will do whichever of a rising
+ *   or a falling edge is possible. I.E. a 50% waveform at twice the requested
+ *   period. Therefore to get a 0% waveform, the output is set the max high/low
+ *   time depending on polarity.
+ * - The PWM period is set for the whole IP block not per channel. The driver
+ *   will only change the period if no other PWM output is enabled.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/ktime.h>
+#include <linux/math.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+
+#define PREG_TO_VAL(PREG) ((PREG) + 1)
+
+#define MCHPCOREPWM_PRESCALE_MAX	0x100
+#define MCHPCOREPWM_PERIOD_STEPS_MAX	0xff
+#define MCHPCOREPWM_PERIOD_MAX		0xff00
+
+#define MCHPCOREPWM_PRESCALE	0x00
+#define MCHPCOREPWM_PERIOD	0x04
+#define MCHPCOREPWM_EN(i)	(0x08 + 0x04 * (i)) /* 0x08, 0x0c */
+#define MCHPCOREPWM_POSEDGE(i)	(0x10 + 0x08 * (i)) /* 0x10, 0x18, ..., 0x88 */
+#define MCHPCOREPWM_NEGEDGE(i)	(0x14 + 0x08 * (i)) /* 0x14, 0x1c, ..., 0x8c */
+#define MCHPCOREPWM_SYNC_UPD	0xe4
+#define MCHPCOREPWM_TIMEOUT_MS	100u
+
+struct mchp_core_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mutex lock; /* protects the shared period */
+	ktime_t update_timestamp;
+	u32 sync_update_mask;
+	u16 channel_enabled;
+};
+
+static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mchp_core_pwm_chip, chip);
+}
+
+static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				 bool enable, u64 period)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 channel_enable, reg_offset, shift;
+
+	/*
+	 * There are two adjacent 8 bit control regs, the lower reg controls
+	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
+	 * and if so, offset by the bus width.
+	 */
+	reg_offset = MCHPCOREPWM_EN(pwm->hwpwm >> 3);
+	shift = pwm->hwpwm & 7;
+
+	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
+	channel_enable &= ~(1 << shift);
+	channel_enable |= (enable << shift);
+
+	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
+	mchp_core_pwm->channel_enabled &= ~BIT(pwm->hwpwm);
+	mchp_core_pwm->channel_enabled |= enable << pwm->hwpwm;
+
+	/*
+	 * Notify the block to update the waveform from the shadow registers.
+	 * The updated values will not appear on the bus until they have been
+	 * applied to the waveform at the beginning of the next period.
+	 * This is a NO-OP if the channel does not have shadow registers.
+	 */
+	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm))
+		mchp_core_pwm->update_timestamp = ktime_add_ns(ktime_get(), period);
+}
+
+static void mchp_core_pwm_wait_for_sync_update(struct mchp_core_pwm_chip *mchp_core_pwm,
+					       unsigned int channel)
+{
+	/*
+	 * If a shadow register is used for this PWM channel, and iff there is
+	 * a pending update to the waveform, we must wait for it to be applied
+	 * before attempting to read its state. Reading the registers yields
+	 * the currently implemented settings & the new ones are only readable
+	 * once the current period has ended.
+	 */
+
+	if (mchp_core_pwm->sync_update_mask & (1 << channel)) {
+		ktime_t current_time = ktime_get();
+		s64 remaining_ns;
+		u32 delay_us;
+
+		remaining_ns = ktime_to_ns(ktime_sub(mchp_core_pwm->update_timestamp,
+						     current_time));
+
+		/*
+		 * If the update has gone through, don't bother waiting for
+		 * obvious reasons. Otherwise wait around for an appropriate
+		 * amount of time for the update to go through.
+		 */
+		if (remaining_ns <= 0)
+			return;
+
+		delay_us = DIV_ROUND_UP_ULL(remaining_ns, NSEC_PER_USEC);
+		fsleep(delay_us);
+	}
+}
+
+static u64 mchp_core_pwm_calc_duty(const struct pwm_state *state, u64 clk_rate,
+				   u8 prescale, u8 period_steps)
+{
+	u64 duty_steps, tmp;
+	u16 prescale_val = PREG_TO_VAL(prescale);
+
+	/*
+	 * Calculate the duty cycle in multiples of the prescaled period:
+	 * duty_steps = duty_in_ns / step_in_ns
+	 * step_in_ns = (prescale * NSEC_PER_SEC) / clk_rate
+	 * The code below is rearranged slightly to only divide once.
+	 */
+	tmp = prescale_val * NSEC_PER_SEC;
+	duty_steps = mul_u64_u64_div_u64(state->duty_cycle, clk_rate, tmp);
+
+	return duty_steps;
+}
+
+static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const struct pwm_state *state, u64 duty_steps,
+				     u16 period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 posedge, negedge;
+	u8 first_edge = 0, second_edge = duty_steps;
+
+	/*
+	 * Setting posedge == negedge doesn't yield a constant output,
+	 * so that's an unsuitable setting to model duty_steps = 0.
+	 * In that case set the unwanted edge to a value that never
+	 * triggers.
+	 */
+	if (duty_steps == 0)
+		first_edge = PREG_TO_VAL(period_steps);
+
+	if (state->polarity == PWM_POLARITY_INVERSED) {
+		negedge = first_edge;
+		posedge = second_edge;
+	} else {
+		posedge = first_edge;
+		negedge = second_edge;
+	}
+
+	writel_relaxed(posedge, mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
+	writel_relaxed(negedge, mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
+}
+
+static void mchp_core_pwm_calc_period(const struct pwm_state *state, unsigned long clk_rate,
+				      u16 *prescale, u16 *period_steps)
+{
+	u64 tmp;
+
+	/*
+	 * Calculate the period cycles and prescale values.
+	 * The registers are each 8 bits wide & multiplied to compute the period
+	 * using the formula:
+	 *           (prescale + 1) * (period_steps + 1)
+	 * period = -------------------------------------
+	 *                      clk_rate
+	 * so the maximum period that can be generated is 0x10000 times the
+	 * period of the input clock.
+	 * However, due to the design of the "hardware", it is not possible to
+	 * attain a 100% duty cycle if the full range of period_steps is used.
+	 * Therefore period_steps is restricted to 0xFE and the maximum multiple
+	 * of the clock period attainable is 0xFF00.
+	 */
+	tmp = mul_u64_u64_div_u64(state->period, clk_rate, NSEC_PER_SEC);
+
+	/*
+	 * The hardware adds one to the register value, so decrement by one to
+	 * account for the offset
+	 */
+	if (tmp >= MCHPCOREPWM_PERIOD_MAX) {
+		*prescale = MCHPCOREPWM_PRESCALE_MAX - 1;
+		*period_steps = MCHPCOREPWM_PERIOD_STEPS_MAX - 1;
+
+		return;
+	}
+
+	/*
+	 * The optimal value for prescale can be calculated using the maximum
+	 * permitted value of period_steps, 0xff.
+	 *
+	 *             period * clk_rate
+	 * prescale = ------------------- - 1
+	 *            NSEC_PER_SEC * 0xff
+	 *
+	 * However, we are purely interested in the integer upper bound of this
+	 * calculation, so ignore the subtraction & rely on the truncation done
+	 * by the division.
+	 *
+	 *  period * clk_rate
+	 * ------------------- was precomputed as `tmp`
+	 *    NSEC_PER_SEC
+	 *
+	 * period_steps is then computed using the result:
+	 *                      period * clk_rate
+	 * period_steps = ----------------------------- - 1
+	 *                NSEC_PER_SEC * (prescale + 1)
+	 */
+	*prescale = div_u64(tmp, MCHPCOREPWM_PERIOD_STEPS_MAX);
+	*period_steps = div_u64(tmp, PREG_TO_VAL(*prescale)) - 1;
+}
+
+static int mchp_core_pwm_apply_locked(struct pwm_chip *chip, struct pwm_device *pwm,
+				      const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	bool period_locked;
+	unsigned long clk_rate;
+	u64 duty_steps;
+	u16 prescale, period_steps;
+
+	if (!state->enabled) {
+		mchp_core_pwm_enable(chip, pwm, false, pwm->state.period);
+		return 0;
+	}
+
+	/*
+	 * If clk_rate is too big, the following multiplication might overflow.
+	 * However this is implausible, as the fabric of current FPGAs cannot
+	 * provide clocks at a rate high enough.
+	 */
+	clk_rate = clk_get_rate(mchp_core_pwm->clk);
+	if (clk_rate >= NSEC_PER_SEC)
+		return -EINVAL;
+
+	mchp_core_pwm_calc_period(state, clk_rate, &prescale, &period_steps);
+
+	/*
+	 * If the only thing that has changed is the duty cycle or the polarity,
+	 * we can shortcut the calculations and just compute/apply the new duty
+	 * cycle pos & neg edges
+	 * As all the channels share the same period, do not allow it to be
+	 * changed if any other channels are enabled.
+	 * If the period is locked, it may not be possible to use a period
+	 * less than that requested. In that case, we just abort.
+	 */
+	period_locked = mchp_core_pwm->channel_enabled & ~(1 << pwm->hwpwm);
+
+	if (period_locked) {
+		u16 hw_prescale;
+		u16 hw_period_steps;
+
+		hw_prescale = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		hw_period_steps = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+
+		if ((period_steps + 1) * (prescale + 1) <
+		    (hw_period_steps + 1) * (hw_prescale + 1))
+			return -EINVAL;
+
+		/*
+		 * It is possible that something could have set the period_steps
+		 * register to 0xff, which would prevent us from setting a 100%
+		 * or 0% relative duty cycle, as explained above in
+		 * mchp_core_pwm_calc_period().
+		 * The period is locked and we cannot change this, so we abort.
+		 */
+		if (hw_period_steps == MCHPCOREPWM_PERIOD_STEPS_MAX)
+			return -EINVAL;
+
+		prescale = hw_prescale;
+		period_steps = hw_period_steps;
+	} else {
+		writel_relaxed(prescale, mchp_core_pwm->base + MCHPCOREPWM_PRESCALE);
+		writel_relaxed(period_steps, mchp_core_pwm->base + MCHPCOREPWM_PERIOD);
+	}
+
+	duty_steps = mchp_core_pwm_calc_duty(state, clk_rate, prescale, period_steps);
+
+	/*
+	 * Because the period is per channel, it is possible that the requested
+	 * duty cycle is longer than the period, in which case cap it to the
+	 * period, IOW a 100% duty cycle.
+	 */
+	if (duty_steps > period_steps)
+		duty_steps = period_steps + 1;
+
+	mchp_core_pwm_apply_duty(chip, pwm, state, duty_steps, period_steps);
+
+	mchp_core_pwm_enable(chip, pwm, true, pwm->state.period);
+
+	return 0;
+}
+
+static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	int ret;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
+
+	ret = mchp_core_pwm_apply_locked(chip, pwm, state);
+
+	mutex_unlock(&mchp_core_pwm->lock);
+
+	return ret;
+}
+
+static int mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 rate;
+	u16 prescale, period_steps;
+	u8 duty_steps, posedge, negedge;
+
+	mutex_lock(&mchp_core_pwm->lock);
+
+	mchp_core_pwm_wait_for_sync_update(mchp_core_pwm, pwm->hwpwm);
+
+	if (mchp_core_pwm->channel_enabled & (1 << pwm->hwpwm))
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	rate = clk_get_rate(mchp_core_pwm->clk);
+
+	prescale = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PRESCALE));
+
+	period_steps = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_PERIOD));
+	state->period = period_steps * prescale;
+	state->period *= NSEC_PER_SEC;
+	state->period = DIV64_U64_ROUND_UP(state->period, rate);
+
+	posedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_POSEDGE(pwm->hwpwm));
+	negedge = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_NEGEDGE(pwm->hwpwm));
+
+	mutex_unlock(&mchp_core_pwm->lock);
+
+	if (negedge == posedge) {
+		state->duty_cycle = state->period;
+		state->period *= 2;
+	} else {
+		duty_steps = abs((s16)posedge - (s16)negedge);
+		state->duty_cycle = duty_steps * prescale * NSEC_PER_SEC;
+		state->duty_cycle = DIV64_U64_ROUND_UP(state->duty_cycle, rate);
+	}
+
+	state->polarity = negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	return 0;
+}
+
+static const struct pwm_ops mchp_core_pwm_ops = {
+	.apply = mchp_core_pwm_apply,
+	.get_state = mchp_core_pwm_get_state,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id mchp_core_of_match[] = {
+	{
+		.compatible = "microchip,corepwm-rtl-v4",
+	},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mchp_core_of_match);
+
+static int mchp_core_pwm_probe(struct platform_device *pdev)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm;
+	struct resource *regs;
+
+	mchp_core_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_KERNEL);
+	if (!mchp_core_pwm)
+		return -ENOMEM;
+
+	mchp_core_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mchp_core_pwm->base))
+		return PTR_ERR(mchp_core_pwm->base);
+
+	mchp_core_pwm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(mchp_core_pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(mchp_core_pwm->clk),
+				     "failed to get PWM clock\n");
+
+	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask",
+				 &mchp_core_pwm->sync_update_mask))
+		mchp_core_pwm->sync_update_mask = 0;
+
+	mutex_init(&mchp_core_pwm->lock);
+
+	mchp_core_pwm->chip.dev = &pdev->dev;
+	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
+	mchp_core_pwm->chip.npwm = 16;
+
+	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
+	mchp_core_pwm->channel_enabled |=
+		readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(1)) << 8;
+
+	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
+	mchp_core_pwm->update_timestamp = ktime_get();
+
+	return devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
+}
+
+static struct platform_driver mchp_core_pwm_driver = {
+	.driver = {
+		.name = "mchp-core-pwm",
+		.of_match_table = mchp_core_of_match,
+	},
+	.probe = mchp_core_pwm_probe,
+};
+module_platform_driver(mchp_core_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");
-- 
2.39.2

