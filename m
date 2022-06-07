Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D09B53F88C
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Jun 2022 10:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiFGIsa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 7 Jun 2022 04:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbiFGIsH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 7 Jun 2022 04:48:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73ACD37A17;
        Tue,  7 Jun 2022 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654591656; x=1686127656;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JaC0/xniieJ2OJO+WVRNKO7+QAKfVZ1NKpA/lEJEDuY=;
  b=r+CN9EU4UAB+HujFCQBxV/pmddJu1xAfkgALkqGS6MEkZQrVxybhdbck
   PXyZOaCmgtC9k4ziT3/wuAOAFMlZDfAHag5Z0eDiSwEr9JMLy9QE0Fs+W
   T5dxsMp7UuufqqHze9OOeibtdKVURc4rJtBkebV3m0mpfohXihmY/cTeS
   whoIO5L08WDm/2IlZSTylv5L6g4yyacgzVPWdDnCaCRqIba6OmEL1GgCY
   mWvz+JAYSXHBuJTBfhO7t6ttzlMrYZzC3+EVbMDclwZhJO5x/t6f1ybff
   OAK3OZsM023mIOBBASoHAzFYxXSPAJWYy4eKeZow1B8CEf9ziowyzIG9F
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,283,1647327600"; 
   d="scan'208";a="167052016"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jun 2022 01:47:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 7 Jun 2022 01:47:31 -0700
Received: from wendy.microchip.com (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Tue, 7 Jun 2022 01:47:29 -0700
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Lee Jones" <lee.jones@linaro.org>
CC:     Daire McNamara <daire.mcnamara@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH 1/2] pwm: add microchip soft ip corePWM driver
Date:   Tue, 7 Jun 2022 09:45:51 +0100
Message-ID: <20220607084551.2735922-2-conor.dooley@microchip.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607084551.2735922-1-conor.dooley@microchip.com>
References: <20220607084551.2735922-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 drivers/pwm/Kconfig              |  10 ++
 drivers/pwm/Makefile             |   1 +
 drivers/pwm/pwm-microchip-core.c | 289 +++++++++++++++++++++++++++++++
 3 files changed, 300 insertions(+)
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
index 000000000000..2cc1de163bcc
--- /dev/null
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * corePWM driver for Microchip FPGAs
+ *
+ * Copyright (c) 2021-2022 Microchip Corporation. All rights reserved.
+ * Author: Conor Dooley <conor.dooley@microchip.com>
+ *
+ */
+
+#include <linux/clk.h>
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
+#define PRESCALE_REG	0x00u
+#define PERIOD_REG	0x04u
+#define PWM_EN_LOW_REG	0x08u
+#define PWM_EN_HIGH_REG	0x0Cu
+#define SYNC_UPD_REG	0xE4u
+#define POSEDGE_OFFSET	0x10u
+#define NEGEDGE_OFFSET	0x14u
+#define CHANNEL_OFFSET	0x08u
+
+struct mchp_core_pwm_registers {
+	u8 posedge;
+	u8 negedge;
+	u8 period_steps;
+	u8 prescale;
+};
+
+struct mchp_core_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	void __iomem *base;
+	struct mchp_core_pwm_registers *regs;
+};
+
+static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
+{
+	return container_of(chip, struct mchp_core_pwm_chip, chip);
+}
+
+static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				 bool enable)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u8 channel_enable, reg_offset, shift;
+
+	/*
+	 * There are two adjacent 8 bit control regs, the lower reg controls
+	 * 0-7 and the upper reg 8-15. Check if the pwm is in the upper reg
+	 * and if so, offset by the bus width.
+	 */
+	reg_offset = PWM_EN_LOW_REG + (pwm->hwpwm >> 3) * sizeof(u32);
+	shift = pwm->hwpwm > 7 ? pwm->hwpwm - 8 : pwm->hwpwm;
+
+	channel_enable = readb_relaxed(mchp_core_pwm->base + reg_offset);
+	channel_enable &= ~(1 << shift);
+	channel_enable |= (enable << shift);
+
+	writel_relaxed(channel_enable, mchp_core_pwm->base + reg_offset);
+}
+
+static void mchp_core_pwm_calculate_duty(struct pwm_chip *chip,
+					 const struct pwm_state *desired_state,
+					 struct mchp_core_pwm_registers *regs)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 clk_period = NSEC_PER_SEC;
+	u64 duty_steps;
+
+	/* Calculate the clk period and then the duty cycle edges */
+	do_div(clk_period, clk_get_rate(mchp_core_pwm->clk));
+
+	duty_steps = desired_state->duty_cycle * PREG_TO_VAL(regs->period_steps);
+	do_div(duty_steps, (clk_period * PREG_TO_VAL(regs->period_steps)));
+	if (desired_state->polarity == PWM_POLARITY_INVERSED) {
+		regs->negedge = 0u;
+		regs->posedge = duty_steps;
+	} else {
+		regs->posedge = 0u;
+		regs->negedge = duty_steps;
+	}
+}
+
+static void mchp_core_pwm_apply_duty(const u8 channel,
+				     struct mchp_core_pwm_chip *pwm_chip,
+				     struct mchp_core_pwm_registers *regs)
+{
+	void __iomem *channel_base = pwm_chip->base + channel * CHANNEL_OFFSET;
+
+	writel_relaxed(regs->posedge, channel_base + POSEDGE_OFFSET);
+	writel_relaxed(regs->negedge, channel_base + NEGEDGE_OFFSET);
+}
+
+static void mchp_core_pwm_apply_period(struct mchp_core_pwm_chip *pwm_chip,
+				       struct mchp_core_pwm_registers *regs)
+{
+	writel_relaxed(regs->prescale, pwm_chip->base + PRESCALE_REG);
+	writel_relaxed(regs->period_steps, pwm_chip->base + PERIOD_REG);
+}
+
+static int mchp_core_pwm_calculate_base(struct pwm_chip *chip,
+					const struct pwm_state *desired_state,
+					u8 *period_steps_r, u8 *prescale_r)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	u64 tmp = desired_state->period;
+
+	/* Calculate the period cycles and prescale value */
+	tmp *= clk_get_rate(mchp_core_pwm->clk);
+	do_div(tmp, NSEC_PER_SEC);
+
+	if (tmp > 65535) {
+		dev_err(chip->dev,
+			"requested prescale exceeds the maximum possible\n");
+		return -EINVAL;
+	} else if (tmp <= 256) {
+		*prescale_r = 0;
+		*period_steps_r = tmp - 1;
+	} else {
+		*prescale_r = fls(tmp) - 8;
+		*period_steps_r = (tmp >> *prescale_r) - 1;
+	}
+
+	return 0;
+}
+
+static int mchp_core_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *desired_state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	struct pwm_state current_state;
+	u8 period_steps_r, prescale_r;
+	int ret;
+	u8 channel = pwm->hwpwm;
+
+	pwm_get_state(pwm, &current_state);
+
+	if (desired_state->enabled) {
+		if (current_state.enabled &&
+		    current_state.period == desired_state->period &&
+		    current_state.polarity == desired_state->polarity) {
+			mchp_core_pwm_calculate_duty(chip, desired_state, mchp_core_pwm->regs);
+			mchp_core_pwm_apply_duty(channel, mchp_core_pwm, mchp_core_pwm->regs);
+		} else {
+			ret = mchp_core_pwm_calculate_base(chip, desired_state, &period_steps_r,
+							   &prescale_r);
+			if (ret) {
+				dev_err(chip->dev, "failed to calculate base\n");
+				return ret;
+			}
+
+			mchp_core_pwm->regs->period_steps = period_steps_r;
+			mchp_core_pwm->regs->prescale = prescale_r;
+
+			mchp_core_pwm_calculate_duty(chip, desired_state, mchp_core_pwm->regs);
+			mchp_core_pwm_apply_duty(channel, mchp_core_pwm, mchp_core_pwm->regs);
+			mchp_core_pwm_apply_period(mchp_core_pwm, mchp_core_pwm->regs);
+		}
+
+		if (mchp_core_pwm->regs->posedge == mchp_core_pwm->regs->negedge)
+			mchp_core_pwm_enable(chip, pwm, false);
+		else
+			mchp_core_pwm_enable(chip, pwm, true);
+
+	} else if (!desired_state->enabled) {
+		mchp_core_pwm_enable(chip, pwm, false);
+	}
+
+	return 0;
+}
+
+static void mchp_core_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				    struct pwm_state *state)
+{
+	struct mchp_core_pwm_chip *mchp_core_pwm = to_mchp_core_pwm(chip);
+	void __iomem *channel_base = mchp_core_pwm->base + pwm->hwpwm * CHANNEL_OFFSET;
+	u64 clk_period = NSEC_PER_SEC;
+	u8 prescale, period_steps, duty_steps;
+	u8 posedge, negedge;
+	u16 channel_enabled;
+
+	channel_enabled = (((u16)readb_relaxed(mchp_core_pwm->base + PWM_EN_HIGH_REG) << 8) |
+		readb_relaxed(mchp_core_pwm->base + PWM_EN_LOW_REG));
+
+	posedge = readb_relaxed(channel_base + POSEDGE_OFFSET);
+	negedge = readb_relaxed(channel_base + NEGEDGE_OFFSET);
+
+	duty_steps = abs((s8)posedge - (s8)negedge);
+	state->polarity = negedge < posedge ? PWM_POLARITY_INVERSED : PWM_POLARITY_NORMAL;
+
+	prescale = readb_relaxed(mchp_core_pwm->base + PRESCALE_REG);
+	period_steps = readb_relaxed(mchp_core_pwm->base + PERIOD_REG);
+
+	do_div(clk_period, clk_get_rate(mchp_core_pwm->clk));
+	state->duty_cycle = PREG_TO_VAL(prescale) * clk_period * duty_steps;
+	state->period = PREG_TO_VAL(prescale) * clk_period * PREG_TO_VAL(period_steps);
+
+	if (channel_enabled & 1 << pwm->hwpwm)
+		state->enabled = true;
+	else
+		state->enabled = false;
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
+	mchp_pwm->regs = devm_kzalloc(&pdev->dev, sizeof(*regs), GFP_KERNEL);
+	if (!mchp_pwm->regs)
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
+	ret = clk_prepare(mchp_pwm->clk);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to prepare PWM clock\n");
+
+	mchp_pwm->chip.dev = &pdev->dev;
+	mchp_pwm->chip.ops = &mchp_core_pwm_ops;
+	mchp_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
+	mchp_pwm->chip.of_pwm_n_cells = 3;
+	mchp_pwm->chip.base = -1;
+	mchp_pwm->chip.npwm = 16;
+
+	ret = pwmchip_add(&mchp_pwm->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	writel_relaxed(0u, mchp_pwm->base + PWM_EN_LOW_REG);
+	writel_relaxed(0u, mchp_pwm->base + PWM_EN_HIGH_REG);
+
+	platform_set_drvdata(pdev, mchp_pwm);
+	dev_info(&pdev->dev, "Successfully registered Microchip corePWM\n");
+
+	return 0;
+}
+
+static int mchp_core_pwm_remove(struct platform_device *pdev)
+{
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

