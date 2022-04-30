Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D6515B2A
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Apr 2022 09:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiD3ICz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Apr 2022 04:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239680AbiD3ICx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Apr 2022 04:02:53 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF46892304;
        Sat, 30 Apr 2022 00:59:31 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.91,187,1647270000"; 
   d="scan'208";a="118453223"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 30 Apr 2022 16:59:31 +0900
Received: from localhost.localdomain (unknown [10.226.92.1])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 2195B40065B7;
        Sat, 30 Apr 2022 16:59:27 +0900 (JST)
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
Subject: [RFC 2/5] pwm: Add support for RZ/G2L GPT
Date:   Sat, 30 Apr 2022 08:59:12 +0100
Message-Id: <20220430075915.5036-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
References: <20220430075915.5036-1-biju.das.jz@bp.renesas.com>
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
 drivers/pwm/Kconfig         |  11 ++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-rzg2l-gpt.c | 355 ++++++++++++++++++++++++++++++++++++
 3 files changed, 367 insertions(+)
 create mode 100644 drivers/pwm/pwm-rzg2l-gpt.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 21e3b05a5153..d93b510f9ca8 100644
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
index 708840b7fba8..bd213ae64074 100644
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
index 000000000000..8895e17ff902
--- /dev/null
+++ b/drivers/pwm/pwm-rzg2l-gpt.c
@@ -0,0 +1,355 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L General PWM Timer (GPT) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/units.h>
+
+#define GPT_IO_PER_CHANNEL	2
+
+#define GTPR_MAX_VALUE	0xFFFFFFFF
+#define GTCR		0x2c
+#define GTUDDTYC	0x30
+#define GTIOR		0x34
+#define GTBER		0x40
+#define GTCNT		0x48
+#define GTCCRA		0x4c
+#define GTCCRB		0x50
+#define GTPR		0x64
+
+#define GTCR_CST_MASK			BIT(0)
+#define GTCR_MD_MASK			GENMASK(18, 16)
+#define GTCR_TPCS_MASK			GENMASK(26, 24)
+#define GTCR_MD_SAW_WAVE_PWM_MODE	(0)
+
+#define GTUDDTYC_UP	BIT(0)
+#define GTUDDTYC_UDF	BIT(1)
+#define UP_COUNTING	(GTUDDTYC_UP | GTUDDTYC_UDF)
+
+#define GTIOR_GTIOA_MASK			GENMASK(4, 0)
+#define GTIOR_OAE_MASK				BIT(8)
+#define GTIOR_GTIOB_MASK			GENMASK(20, 16)
+#define GTIOR_OBE_MASK				BIT(24)
+#define GTIOR_GTIOA				0x19
+#define GTIOR_OAE				BIT(8)
+#define GTIOR_GTIOB				(0x19 << 16)
+#define GTIOR_OBE				BIT(24)
+#define GTIOR_GTIOA_OUT_HI_END_LO_CMP_MATCH	(GTIOR_GTIOA | GTIOR_OAE)
+#define GTIOR_GTIOB_OUT_HI_END_LO_CMP_MATCH	(GTIOR_GTIOB | GTIOR_OBE)
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
+		GTIOR_GTIOA_OUT_HI_END_LO_CMP_MATCH,
+		GTIOR_GTIOA_MASK | GTIOR_OAE_MASK,
+		GTCCRA,
+	},
+
+	/* Setting for phase B */
+	{
+		GTIOR_GTIOB_OUT_HI_END_LO_CMP_MATCH,
+		GTIOR_GTIOB_MASK | GTIOR_OBE_MASK,
+		GTCCRB,
+	},
+};
+
+struct rzg2l_gpt_chip;
+
+struct gpt_pwm_device {
+	struct rzg2l_gpt_chip *pc;
+	const struct phase *ph;
+	unsigned int channel;	/* IO channel number in the GPT */
+
+	enum pwm_polarity polarity;
+};
+
+struct rzg2l_gpt_chip {
+	struct pwm_chip chip;
+	void __iomem *mmio_base;
+	struct reset_control *rstc;
+	struct clk *clk;
+};
+
+static inline struct rzg2l_gpt_chip *to_rzg2l_gpt_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rzg2l_gpt_chip, chip);
+}
+
+static void rzg2l_gpt_write(struct rzg2l_gpt_chip *pc, u32 data,
+			    unsigned int offset)
+{
+	iowrite32(data, pc->mmio_base + offset);
+}
+
+static void rzg2l_gpt_write_mask(struct rzg2l_gpt_chip *pc, u32 data, u32 mask,
+				 unsigned int offset)
+{
+	u32 tmp;
+
+	tmp = ioread32(pc->mmio_base + offset);
+	tmp &= ~mask;
+	iowrite32(tmp | data, pc->mmio_base + offset);
+}
+
+static int rzg2l_calculate_prescale(struct rzg2l_gpt_chip *pc, int period_ns)
+{
+	unsigned long long c, clk_rate;
+	unsigned long period_cycles;
+	int prescale;
+	int i, prod;
+
+	clk_rate = clk_get_rate(pc->clk);
+	c = clk_rate * period_ns;
+	period_cycles = div_u64(c, NANO);
+
+	if (period_cycles < 1)
+		period_cycles = 1;
+
+	prescale = -1;
+	/* prescale 1, 4, 16, 64, 256 and 1024 */
+	for (i = 0, prod = 1; i < 6; i++) {
+		if ((period_cycles / GTPR_MAX_VALUE * prod) == 0) {
+			prescale = i;
+			break;
+		}
+
+		prod *= 4;
+	}
+
+	return prescale;
+}
+
+static unsigned long
+rzg2l_time_to_tick_number(struct rzg2l_gpt_chip *pc, int time_ns,
+			  unsigned long prescale)
+{
+	unsigned long long c, clk_rate;
+	unsigned long period_cycles;
+	int i, prod;
+
+	clk_rate = clk_get_rate(pc->clk);
+	c = clk_rate * time_ns;
+	period_cycles = div_u64(c, NANO);
+
+	if (period_cycles < 1)
+		period_cycles = 1;
+
+	/* Divide by 1, 4, 16, 64, 256 and 1024 */
+	for (i = 0, prod = 1; i < prescale; i++)
+		prod *= 4;
+
+	return period_cycles / prod;
+}
+
+static int rzg2l_gpt_request(struct pwm_chip *chip, struct pwm_device *_pwm)
+{
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	struct gpt_pwm_device *pwm;
+
+	if (_pwm->hwpwm >= GPT_IO_PER_CHANNEL)
+		return -EINVAL;
+
+	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
+	if (!pwm)
+		return -ENOMEM;
+
+	pwm->pc = pc;
+	pwm->channel = _pwm->hwpwm;
+	pwm->polarity = PWM_POLARITY_NORMAL;
+	pwm->ph = &phase_params[pwm->channel & 0x1];
+	pwm_set_chip_data(_pwm, pwm);
+
+	pm_runtime_get_sync(chip->dev);
+
+	return 0;
+}
+
+static void rzg2l_gpt_free(struct pwm_chip *chip, struct pwm_device *_pwm)
+{
+	struct gpt_pwm_device *pwm = pwm_get_chip_data(_pwm);
+
+	pm_runtime_put(chip->dev);
+	kfree(pwm);
+}
+
+static int rzg2l_gpt_config(struct pwm_chip *chip, struct pwm_device *_pwm,
+			    int duty_ns, int period_ns)
+{
+	struct gpt_pwm_device *pwm = pwm_get_chip_data(_pwm);
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	unsigned long pv, dc;
+	int prescale;
+
+	if (duty_ns < 0 || period_ns < 0) {
+		dev_err(chip->dev, "ch=%d Set time negative\n", pwm->channel);
+		return -EINVAL;
+	}
+
+	prescale = rzg2l_calculate_prescale(pc, period_ns);
+	if (prescale < 0) {
+		dev_err(chip->dev, "ch=%d wrong prescale val\n", pwm->channel);
+		return -EINVAL;
+	}
+
+	pv = rzg2l_time_to_tick_number(pc, period_ns, prescale);
+	dc = rzg2l_time_to_tick_number(pc, duty_ns, prescale);
+	if (duty_ns == period_ns)
+		dc = pv;
+
+	/* GPT setting saw-wave up-counting */
+	rzg2l_gpt_write_mask(pc, GTCR_MD_SAW_WAVE_PWM_MODE, GTCR_MD_MASK, GTCR);
+	rzg2l_gpt_write_mask(pc, (prescale << 24), GTCR_TPCS_MASK, GTCR);
+	/* Set counting mode */
+	rzg2l_gpt_write(pc, UP_COUNTING, GTUDDTYC);
+	/* Set period */
+	rzg2l_gpt_write(pc, pv, GTPR);
+
+	/* Enable pin output */
+	rzg2l_gpt_write_mask(pc, pwm->ph->value, pwm->ph->mask, GTIOR);
+
+	/* Set duty cycle */
+	rzg2l_gpt_write(pc, dc, pwm->ph->duty_reg_offset);
+
+	/* Set initial value for counter */
+	rzg2l_gpt_write(pc, 0, GTCNT);
+	/* Set no buffer operation */
+	rzg2l_gpt_write(pc, 0, GTBER);
+
+	return 0;
+}
+
+static int rzg2l_gpt_enable(struct rzg2l_gpt_chip *pc)
+{
+	/* Start count */
+	rzg2l_gpt_write_mask(pc, 1, GTCR_CST_MASK, GTCR);
+
+	return 0;
+}
+
+static void rzg2l_gpt_disable(struct rzg2l_gpt_chip *pc)
+{
+	/* Stop count */
+	rzg2l_gpt_write_mask(pc, 0, GTCR_CST_MASK, GTCR);
+}
+
+static int rzg2l_gpt_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct rzg2l_gpt_chip *pc = to_rzg2l_gpt_chip(chip);
+	int ret;
+
+	if (!state->enabled) {
+		rzg2l_gpt_disable(pc);
+		return 0;
+	}
+
+	ret = rzg2l_gpt_config(chip, pwm, state->duty_cycle, state->period);
+	if (!ret)
+		ret = rzg2l_gpt_enable(pc);
+
+	return ret;
+}
+
+static const struct pwm_ops rzg2l_gpt_ops = {
+	.request = rzg2l_gpt_request,
+	.free = rzg2l_gpt_free,
+	.apply = rzg2l_gpt_apply,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id rzg2l_gpt_of_table[] = {
+	{ .compatible = "renesas,rzg2l-gpt", },
+	{ /* Sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, rzg2l_gpt_of_table);
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
+	rzg2l_gpt->mmio_base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzg2l_gpt->mmio_base))
+		return PTR_ERR(rzg2l_gpt->mmio_base);
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
+	rzg2l_gpt->chip.dev = &pdev->dev;
+	rzg2l_gpt->chip.ops = &rzg2l_gpt_ops;
+	rzg2l_gpt->chip.npwm = GPT_IO_PER_CHANNEL;
+
+	ret = pwmchip_add(&rzg2l_gpt->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to register GPT chip: %d\n", ret);
+		pm_runtime_disable(&pdev->dev);
+		reset_control_assert(rzg2l_gpt->rstc);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rzg2l_gpt_remove(struct platform_device *pdev)
+{
+	struct rzg2l_gpt_chip *rzg2l_gpt = platform_get_drvdata(pdev);
+
+	pwmchip_remove(&rzg2l_gpt->chip);
+	pm_runtime_disable(&pdev->dev);
+	reset_control_assert(rzg2l_gpt->rstc);
+
+	return 0;
+}
+
+static struct platform_driver rzg2l_gpt_driver = {
+	.driver = {
+		.name = "pwm-rzg2l-gpt",
+		.of_match_table = of_match_ptr(rzg2l_gpt_of_table),
+	},
+	.probe = rzg2l_gpt_probe,
+	.remove = rzg2l_gpt_remove,
+};
+module_platform_driver(rzg2l_gpt_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L General PWM Timer (GPT) Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pwm-rzg2l-gpt");
-- 
2.25.1

