Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C34754F6EA
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jun 2022 13:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381598AbiFQLqd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jun 2022 07:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiFQLqc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jun 2022 07:46:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F263F6CF46;
        Fri, 17 Jun 2022 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655466389; x=1687002389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ks7vKp2+OkgOf8fUD0T6Pb4JtsT5Do93qY1jFbyfeVI=;
  b=AdmjVz9C4tsKNNfxawdtO2hg/1e42W1Uyt8mAjscRR5nSxhQjFHLwaxx
   sRj204wzXsmXGU9VQy77za63+ny6duN1oiF3ikE+hazbtgkl/9yuCBkIn
   JwNaeiIENjufSXDQei15k6Jn6iqkJhG6X97Bjs4O0u6i4UwGlrDMqXvsq
   W0kTevfMAU/quqgWGmbvxftD43q56J2c0S0iuliXII4KdQZGRkRWRdXoW
   9m34F1GuV87BuG1+8fLsBI1bSS2EP1VLXOV70ezLOWgU5ekDB6QDx60Dg
   qmWajjiRBALTwEo5nk6TSQCJvFqAyRDKgJca4Byy/hsSiuxkwow4bM1F+
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="100506604"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 04:46:28 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 04:46:28 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Fri, 17 Jun 2022 04:46:26 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] pwm: add microchip soft ip corePWM driver
Date:   Fri, 17 Jun 2022 12:44:42 +0100
Message-ID: <20220617114442.998357-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220617114442.998357-1-conor.dooley@microchip.com>
References: <20220617114442.998357-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/pwm/pwm-microchip-core.c | 325 +++++++++++++++++++++++++++++++
 3 files changed, 336 insertions(+)
 create mode 100644 drivers/pwm/pwm-microchip-core.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05a5153..a651848e444b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -383,6 +383,16 @@ config PWM_MEDIATEK
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
index 708840b7fba8..d29754c20f91 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
+obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
 obj-$(CONFIG_PWM_MTK_DISP)	+= pwm-mtk-disp.o
 obj-$(CONFIG_PWM_MXS)		+= pwm-mxs.o
 obj-$(CONFIG_PWM_NTXEC)		+= pwm-ntxec.o
diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
new file mode 100644
index 000000000000..abbfc1cd23c4
--- /dev/null
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * corePWM driver for Microchip "soft" FPGA IP cores.
+ *
+ * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
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
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/math.h>
+
+#define PREG_TO_VAL(PREG) ((PREG) + 1)
+
+#define COREPWM_PRESCALE_REG	0x00u
+#define COREPWM_PERIOD_REG	0x04u
+#define COREPWM_EN_LOW_REG	0x08u
+#define COREPWM_EN_HIGH_REG	0x0Cu
+#define COREPWM_SYNC_UPD_REG	0xE4u
+#define COREPWM_POSEDGE_OFFSET	0x10u
+#define COREPWM_NEGEDGE_OFFSET	0x14u
+#define COREPWM_CHANNEL_OFFSET	0x08u
+
+struct mchp_core_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	u32 sync_update_mask;
+};
+
+static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mchp_core_pwm_chip, chip);
+}
+
+static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm, bool enable)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 channel_enable, reg_offset, shift;
+
+	/*
+	 * There are two adjacent 8 bit control regs, the lower reg controls
+	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
+	 * and if so, offset by the bus width.
+	 */
+	reg_offset = COREPWM_EN_LOW_REG + (pwm->hwpwm >> 3) * sizeof(u32);
+	shift = pwm->hwpwm > 7 ? pwm->hwpwm - 8 : pwm->hwpwm;
+
+	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
+	channel_enable &= ~(1 << shift);
+	channel_enable |= (enable << shift);
+
+	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
+
+	/*
+	 * Write to the sync update registers so that channels with shadow
+	 * registers will also get their enable update. This operation is a NOP
+	 * for channels without shadow registers.
+	 */
+	writel_relaxed(1U, mchp_core_pwm->base + COREPWM_SYNC_UPD_REG);
+}
+
+static void mchp_core_pwm_apply_duty(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const struct pwm_state *state, u8 prescale, u8 period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	void __iomem *channel_base = mchp_core_pwm->base + pwm->hwpwm * COREPWM_CHANNEL_OFFSET;
+	u64 duty_steps, period, tmp;
+	u8 posedge, negedge;
+	u8 prescale_val = PREG_TO_VAL(prescale);
+	u8 period_steps_val = PREG_TO_VAL(period_steps);
+
+	period = period_steps_val * prescale_val * NSEC_PER_SEC;
+	period = div64_u64(period, clk_get_rate(mchp_core_pwm->clk));
+
+	/*
+	 * Calculate the duty cycle in multiples of the prescaled period:
+	 * duty_steps = duty_in_ns / step_in_ns
+	 * step_in_ns = (prescale * NSEC_PER_SEC) / clk_rate
+	 * The code below is rearranged slightly to only divide once.
+	 *
+	 * Because the period is per channel, it is possible that the requested
+	 * duty cycle is longer than the period, in which case cap it to the
+	 * period.
+	 */
+	if (state->duty_cycle > period) {
+		duty_steps = period_steps;
+	} else {
+		duty_steps = state->duty_cycle * clk_get_rate(mchp_core_pwm->clk);
+		tmp = prescale_val * NSEC_PER_SEC;
+		duty_steps = div64_u64(duty_steps, tmp);
+	}
+
+	/*
+	 * Turn the output on unless posedge == negedge, in which case the
+	 * duty is intended to be 0, but limitations of the IP block don't
+	 * allow a zero length duty cycle - so just set the max high/low time
+	 * respectively.
+	 */
+	if (state->polarity == PWM_POLARITY_INVERSED) {
+		negedge = !duty_steps ? period_steps : 0u;
+		posedge = duty_steps;
+	} else {
+		posedge = !duty_steps ? period_steps : 0u;
+		negedge = duty_steps;
+	}
+
+	writel_relaxed(posedge, channel_base + COREPWM_POSEDGE_OFFSET);
+	writel_relaxed(negedge, channel_base + COREPWM_NEGEDGE_OFFSET);
+}
+
+static void mchp_core_pwm_apply_period(struct pwm_chip *chip, const struct pwm_state *state,
+				       u8 *prescale, u8 *period_steps)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 tmp = state->period;
+
+	/*
+	 * Calculate the period cycles and prescale values.
+	 * The registers are each 8 bits wide & multiplied to compute the period
+	 * so the maximum period that can be generated is 0xFFFF times the period
+	 * of the input clock.
+	 */
+	tmp *= clk_get_rate(mchp_core_pwm->clk);
+	do_div(tmp, NSEC_PER_SEC);
+
+	if (tmp > 0xFFFFu) {
+		*prescale = 0xFFu;
+		*period_steps = 0xFFu;
+	} else {
+		*prescale = tmp >> 8;
+		do_div(tmp, PREG_TO_VAL(*prescale));
+		*period_steps = tmp - 1;
+	}
+
+	writel_relaxed(*prescale, mchp_core_pwm->base + COREPWM_PRESCALE_REG);
+	writel_relaxed(*period_steps, mchp_core_pwm->base + COREPWM_PERIOD_REG);
+}
+
+static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	struct pwm_state current_state = pwm->state;
+	bool period_locked;
+	u16 channel_enabled;
+	u8 prescale, period_steps;
+
+	if (!state->enabled) {
+		mchp_core_pwm_enable(chip, pwm, false);
+		return 0;
+	}
+
+	/*
+	 * If the only thing that has changed is the duty cycle or the polarity,
+	 * we can shortcut the calculations and just compute/apply the new duty
+	 * cycle pos & neg edges
+	 * As all the channels share the same period, do not allow it to be
+	 * changed if any other channels are enabled.
+	 */
+	channel_enabled = (((u16)readb_relaxed(mchp_core_pwm->base + COREPWM_EN_HIGH_REG) << 8) |
+		readb_relaxed(mchp_core_pwm->base + COREPWM_EN_LOW_REG));
+	period_locked = channel_enabled & ~(1 << pwm->hwpwm);
+
+	if ((!current_state.enabled || current_state.period != state->period) && !period_locked) {
+		mchp_core_pwm_apply_period(chip, state, &prescale, &period_steps);
+	} else {
+		prescale = readb_relaxed(mchp_core_pwm->base + COREPWM_PRESCALE_REG);
+		period_steps = readb_relaxed(mchp_core_pwm->base + COREPWM_PERIOD_REG);
+	}
+
+	mchp_core_pwm_apply_duty(chip, pwm, state, prescale, period_steps);
+
+	/*
+	 * Notify the block to update the waveform from the shadow registers.
+	 * The updated values will not appear on the bus until they have been
+	 * applied to the waveform at the beginning of the next period.
+	 */
+	if (mchp_core_pwm->sync_update_mask & (1 << pwm->hwpwm)) {
+		writel_relaxed(1U, mchp_core_pwm->base + COREPWM_SYNC_UPD_REG);
+		usleep_range(state->period, state->period * 2);
+	}
+
+	mchp_core_pwm_enable(chip, pwm, true);
+
+	return 0;
+}
+
+static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	void __iomem *channel_base = mchp_core_pwm->base + pwm->hwpwm * COREPWM_CHANNEL_OFFSET;
+	u8 prescale, period_steps, duty_steps;
+	u8 posedge, negedge;
+	u16 channel_enabled;
+
+	channel_enabled = (((u16)readb_relaxed(mchp_core_pwm->base + COREPWM_EN_HIGH_REG) << 8) |
+		readb_relaxed(mchp_core_pwm->base + COREPWM_EN_LOW_REG));
+
+	if (channel_enabled & 1 << pwm->hwpwm)
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	prescale = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + COREPWM_PRESCALE_REG));
+
+	posedge = readb_relaxed(channel_base + COREPWM_POSEDGE_OFFSET);
+	negedge = readb_relaxed(channel_base + COREPWM_NEGEDGE_OFFSET);
+
+	duty_steps = abs((s16)posedge - (s16)negedge);
+	state->duty_cycle = duty_steps * prescale * NSEC_PER_SEC;
+	do_div(state->duty_cycle, clk_get_rate(mchp_core_pwm->clk));
+
+	state->polarity = negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	period_steps = PREG_TO_VAL(readb_relaxed(mchp_core_pwm->base + COREPWM_PERIOD_REG));
+	state->period = period_steps * prescale * NSEC_PER_SEC;
+	do_div(state->period, clk_get_rate(mchp_core_pwm->clk));
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
+	struct mchp_core_pwm_chip *mchp_pwm;
+	struct resource *regs;
+	int ret;
+
+	mchp_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_pwm), GFP_KERNEL);
+	if (!mchp_pwm)
+		return -ENOMEM;
+
+	mchp_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
+	if (IS_ERR(mchp_pwm->base))
+		return PTR_ERR(mchp_pwm->base);
+
+	mchp_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(mchp_pwm->clk))
+		return PTR_ERR(mchp_pwm->clk);
+
+	if (of_property_read_u32(pdev->dev.of_node, "microchip,sync-update-mask",
+				 &mchp_pwm->sync_update_mask))
+		mchp_pwm->sync_update_mask = 0u;
+
+	ret = clk_prepare_enable(mchp_pwm->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to prepare PWM clock\n");
+
+	mchp_pwm->chip.dev = &pdev->dev;
+	mchp_pwm->chip.ops = &mchp_core_pwm_ops;
+	mchp_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	mchp_pwm->chip.of_pwm_n_cells = 3;
+	mchp_pwm->chip.npwm = 16;
+
+	ret = pwmchip_add(&mchp_pwm->chip);
+	if (ret < 0) {
+		clk_disable_unprepare(mchp_pwm->clk);
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+	}
+
+	platform_set_drvdata(pdev, mchp_pwm);
+	dev_info(&pdev->dev, "Successfully registered Microchip corePWM\n");
+
+	return 0;
+}
+
+static int mchp_core_pwm_remove(struct platform_device *pdev)
+{
+	struct mchp_core_pwm_chip *mchp_pwm = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&mchp_pwm->chip);
+	clk_disable_unprepare(mchp_pwm->clk);
+
+	return 0;
+}
+
+static struct platform_driver mchp_core_pwm_driver = {
+	.driver = {
+		.name = "mchp-core-pwm",
+		.of_match_table = mchp_core_of_match,
+	},
+	.probe = mchp_core_pwm_probe,
+	.remove = mchp_core_pwm_remove,
+};
+module_platform_driver(mchp_core_pwm_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Conor Dooley <conor.dooley@microchip.com>");
+MODULE_DESCRIPTION("corePWM driver for Microchip FPGAs");
-- 
2.36.1

