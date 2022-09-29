Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0075EF381
	for <lists+linux-pwm@lfdr.de>; Thu, 29 Sep 2022 12:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235475AbiI2KbL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 29 Sep 2022 06:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233770AbiI2KbI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 29 Sep 2022 06:31:08 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BD9FA1288BF;
        Thu, 29 Sep 2022 03:31:05 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,354,1654527600"; 
   d="scan'208";a="136619488"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 29 Sep 2022 19:31:05 +0900
Received: from localhost.localdomain (unknown [10.226.92.32])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id BC38D400F7A6;
        Thu, 29 Sep 2022 19:31:02 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH RFC 4/7] pwm: Add support for RZ/G2L MTU3 PWM
Date:   Thu, 29 Sep 2022 11:30:40 +0100
Message-Id: <20220929103043.1228235-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
References: <20220929103043.1228235-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add support for RZ/G2L MTU3 PWM driver. The IP supports
following PWM modes

1) PWM mode 1
2) PWM mode 2
3) Reset-synchronized PWM mode
4) Complementary PWM mode 1 (transfer at crest)
5) Complementary PWM mode 2 (transfer at trough)
6) Complementary PWM mode 3 (transfer at crest and trough)

This patch adds basic pwm mode 1 support for RZ/G2L MTU3 driver
by creating separate logical channels for each IOs.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/pwm/Kconfig       |  11 ++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-rz-mtu3.c | 384 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 396 insertions(+)
 create mode 100644 drivers/pwm/pwm-rz-mtu3.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 2723a3e9ff65..a32e2a20bd1d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -492,6 +492,17 @@ config PWM_RZG2L_GPT
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-rzg2l-gpt.
 
+config PWM_RZ_MTU3
+	tristate "Renesas RZ/G2L MTU3 PWM Timer support"
+	depends on ARCH_RZG2L || COMPILE_TEST
+	depends on HAS_IOMEM
+	help
+	  This driver exposes the MTU3 PWM Timer controller found in Renesas
+	  RZ/G2L like chips through the PWM API.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-rz-mtu3.
+
 config PWM_SAMSUNG
 	tristate "Samsung PWM support"
 	depends on PLAT_SAMSUNG || ARCH_S5PV210 || ARCH_EXYNOS || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index cac39b18d1ee..e307fec041f7 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -45,6 +45,7 @@ obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_RZG2L_GPT)	+= pwm-rzg2l-gpt.o
+obj-$(CONFIG_PWM_RZ_MTU3)	+= pwm-rz-mtu3.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
 obj-$(CONFIG_PWM_SL28CPLD)	+= pwm-sl28cpld.o
diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
new file mode 100644
index 000000000000..228665530745
--- /dev/null
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/G2L MTU3 PWM Timer driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/eu/en/document/mah/rzg2l-group-rzg2lc-group-users-manual-hardware-0?language=en
+ *
+ * Limitations:
+ * - When PWM is disabled, the output is driven to Hi-Z.
+ * - While the hardware supports both polarities, the driver (for now)
+ *   only handles normal polarity.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/mfd/rzg2l-mtu3.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/limits.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/time.h>
+
+#define RZ_MTU3_TMDR1_MD_NORMAL		(0)
+#define RZ_MTU3_TMDR1_MD_PWM_MODE_1	(2)
+
+#define RZ_MTU3_TIOR_OC_RETAIN		(0)
+#define RZ_MTU3_TIOR_OC_0_H_COMP_MATCH	(2)
+#define RZ_MTU3_TIOR_OC_1_TOGGLE	(7)
+
+#define RZ_MTU3_TCR_CCLR_TGRA		(1 << 5)
+#define RZ_MTU3_TCR_CCLR_TGRC		(5 << 5)
+#define RZ_MTU3_TCR_CKEG_RISING		(0 << 3)
+
+#define RZ_MTU3_TCR_TPCS		GENMASK(2, 0)
+
+struct rz_mtu3_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct rzg2l_mtu3_channel *ch;
+	struct mutex lock;
+	u32 user_count;
+	unsigned long rate;
+	bool pwm_enabled_by_bootloader;
+};
+
+static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+}
+
+static u8 rz_mtu3_pwm_calculate_prescale(struct rz_mtu3_pwm_chip *rzg2l_mtu3,
+					 u64 period_cycles)
+{
+	u32 prescaled_period_cycles;
+	u8 prescale;
+
+	prescaled_period_cycles = period_cycles >> 16;
+
+	if (prescaled_period_cycles >= 16)
+		prescale = 3;
+	else
+		prescale = (roundup_pow_of_two(prescaled_period_cycles + 1) + 1) / 2;
+
+	return prescale;
+}
+
+static int rz_mtu3_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	rz_mtu3_pwm->user_count++;
+	mutex_unlock(&rz_mtu3_pwm->lock);
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+
+	mutex_lock(&rz_mtu3_pwm->lock);
+	rz_mtu3_pwm->user_count--;
+	mutex_unlock(&rz_mtu3_pwm->lock);
+}
+
+static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+			      struct pwm_device *pwm)
+{
+	u8 val;
+
+	val = (RZ_MTU3_TIOR_OC_1_TOGGLE << 4) | RZ_MTU3_TIOR_OC_0_H_COMP_MATCH;
+	if (rz_mtu3_pwm->ch->function == RZG2L_MTU3_PWM_MODE_1) {
+		rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TMDR1,
+					 RZ_MTU3_TMDR1_MD_PWM_MODE_1);
+		if (pwm->hwpwm)
+			rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch,
+						 RZG2L_MTU3_TIORL, val);
+		else
+			rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch,
+						 RZG2L_MTU3_TIORH, val);
+
+		rzg2l_mtu3_enable(rz_mtu3_pwm->ch);
+	}
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
+				struct pwm_device *pwm)
+{
+	/* Return to normal mode and disable output pins of MTU3 channel */
+	if (rz_mtu3_pwm->user_count <= 1)
+		rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TMDR1,
+					 RZ_MTU3_TMDR1_MD_NORMAL);
+
+	if (rz_mtu3_pwm->ch->function == RZG2L_MTU3_PWM_MODE_1) {
+		if (pwm->hwpwm)
+			rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch,
+						 RZG2L_MTU3_TIORL,
+						 RZ_MTU3_TIOR_OC_RETAIN);
+		else
+			rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch,
+						 RZG2L_MTU3_TIORH,
+						 RZ_MTU3_TIOR_OC_RETAIN);
+
+		rzg2l_mtu3_disable(rz_mtu3_pwm->ch);
+	}
+}
+
+static int rz_mtu3_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	unsigned long pv, dc;
+	u64 period_cycles;
+	u64 duty_cycles;
+	u8 prescale;
+	int ret;
+	u8 val;
+
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflowing the following
+	 * calculation.
+	 */
+	if (rz_mtu3_pwm->rate > NSEC_PER_SEC)
+		return -EINVAL;
+
+	ret = clk_prepare_enable(rz_mtu3_pwm->clk);
+	if (ret)
+		return ret;
+
+	duty_cycles = state->duty_cycle;
+	if (!state->enabled)
+		duty_cycles = 0;
+
+	period_cycles = mul_u64_u32_div(state->period, rz_mtu3_pwm->rate,
+					NSEC_PER_SEC);
+	prescale = rz_mtu3_pwm_calculate_prescale(rz_mtu3_pwm, period_cycles);
+
+	if (period_cycles >> (2 * prescale) <= U16_MAX)
+		pv = period_cycles >> (2 * prescale);
+	else
+		pv = U16_MAX;
+
+	duty_cycles = mul_u64_u32_div(duty_cycles, rz_mtu3_pwm->rate,
+				      NSEC_PER_SEC);
+	if (duty_cycles >> (2 * prescale) <= U16_MAX)
+		dc = duty_cycles >> (2 * prescale);
+	else
+		dc = U16_MAX;
+
+	val = RZ_MTU3_TCR_CKEG_RISING | prescale;
+	if (pwm->hwpwm) {
+		rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TCR,
+					 RZ_MTU3_TCR_CCLR_TGRC | val);
+		rzg2l_mtu3_16bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TGRD, dc);
+		rzg2l_mtu3_16bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TGRC, pv);
+	} else {
+		rzg2l_mtu3_8bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TCR,
+					 RZ_MTU3_TCR_CCLR_TGRA | val);
+		rzg2l_mtu3_16bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TGRB, dc);
+		rzg2l_mtu3_16bit_ch_write(rz_mtu3_pwm->ch, RZG2L_MTU3_TGRA, pv);
+	}
+
+	clk_disable(rz_mtu3_pwm->clk);
+
+	return 0;
+}
+
+static void rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	u8 prescale, val;
+	u16 dc, pv;
+	u64 tmp;
+
+	clk_prepare_enable(rz_mtu3_pwm->clk);
+	state->enabled = rzg2l_mtu3_is_enabled(rz_mtu3_pwm->ch);
+	if (state->enabled) {
+		val = rzg2l_mtu3_8bit_ch_read(rz_mtu3_pwm->ch, RZG2L_MTU3_TCR);
+		prescale = FIELD_GET(RZ_MTU3_TCR_TPCS, val);
+
+		if (pwm->hwpwm) {
+			dc = rzg2l_mtu3_16bit_ch_read(rz_mtu3_pwm->ch,
+						      RZG2L_MTU3_TGRD);
+			pv = rzg2l_mtu3_16bit_ch_read(rz_mtu3_pwm->ch,
+						      RZG2L_MTU3_TGRC);
+		} else {
+			dc = rzg2l_mtu3_16bit_ch_read(rz_mtu3_pwm->ch,
+						      RZG2L_MTU3_TGRB);
+			pv = rzg2l_mtu3_16bit_ch_read(rz_mtu3_pwm->ch,
+						      RZG2L_MTU3_TGRA);
+		}
+
+		tmp = NSEC_PER_SEC * (u64)pv << (2 * prescale);
+		state->period = DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
+
+		tmp = NSEC_PER_SEC * (u64)dc << (2 * prescale);
+		state->duty_cycle = DIV_ROUND_UP_ULL(tmp, rz_mtu3_pwm->rate);
+
+		if (state->duty_cycle > state->period)
+			state->duty_cycle = state->period;
+	}
+
+	state->polarity = PWM_POLARITY_NORMAL;
+	clk_disable(rz_mtu3_pwm->clk);
+}
+
+static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
+	struct pwm_state cur_state;
+	bool enabled;
+	int ret;
+
+	cur_state = pwm->state;
+	enabled = cur_state.enabled;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	ret = rz_mtu3_pwm_config(chip, pwm, state);
+	if (ret)
+		goto done;
+
+	if (!state->enabled) {
+		if (rz_mtu3_pwm->pwm_enabled_by_bootloader) {
+			/*
+			 * For PWM enabled by bootloader case, decrement the clk
+			 * usage count and set the pwm_enabled_by_bootloader
+			 * variable to false.
+			 */
+			rz_mtu3_pwm->pwm_enabled_by_bootloader = false;
+			clk_disable(rz_mtu3_pwm->clk);
+		}
+
+		if (enabled)
+			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
+		ret = 0;
+		goto done;
+	}
+
+	return rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
+
+done:
+	return ret;
+}
+
+static const struct pwm_ops rz_mtu3_pwm_ops = {
+	.request = rz_mtu3_pwm_request,
+	.free = rz_mtu3_pwm_free,
+	.get_state = rz_mtu3_pwm_get_state,
+	.apply = rz_mtu3_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static const struct of_device_id rz_mtu3_pwm_of_table[] = {
+	{ .compatible = "renesas,rz-mtu3-pwm", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rz_mtu3_pwm_of_table);
+
+static void rz_mtu3_pwm_clk_disable(void *data)
+{
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = data;
+
+	if (rz_mtu3_pwm->pwm_enabled_by_bootloader)
+		clk_disable(rz_mtu3_pwm->clk);
+}
+
+static int rz_mtu3_pwm_probe(struct platform_device *pdev)
+{
+	struct rzg2l_mtu3 *ddata = dev_get_drvdata(pdev->dev.parent);
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
+	struct device *dev = &pdev->dev;
+	u32 ch, tmp;
+	int ret;
+
+	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
+	if (!rz_mtu3_pwm)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(dev->of_node, "reg", &ch);
+	if (ret)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "%pOF: No reg property found\n",
+				     dev->of_node);
+
+	if (ch == RZG2L_MTU5 || ch == RZG2L_MTU8)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "%pOF: Invalid channel '%u'\n",
+				     dev->of_node, ch);
+
+	if (!of_get_property(dev->of_node, "renesas,pwm-mode1", &tmp))
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "%pOF: pwm-mode1 not defined ch='%u'\n",
+				     dev->of_node, ch);
+
+	rz_mtu3_pwm->clk = ddata->clk;
+	rz_mtu3_pwm->ch = &ddata->channels[ch];
+	rz_mtu3_pwm->ch->dev = &pdev->dev;
+	if (rz_mtu3_pwm->ch->function != RZG2L_MTU3_NORMAL)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "channel '%u' is already claimed\n", ch);
+
+	rz_mtu3_pwm->ch->function = RZG2L_MTU3_PWM_MODE_1;
+	rz_mtu3_pwm->rate = clk_get_rate(rz_mtu3_pwm->clk);
+
+	mutex_init(&rz_mtu3_pwm->lock);
+
+	rz_mtu3_pwm->chip.dev = &pdev->dev;
+	rz_mtu3_pwm->chip.ops = &rz_mtu3_pwm_ops;
+	if (ch == RZG2L_MTU1 || ch == RZG2L_MTU2)
+		rz_mtu3_pwm->chip.npwm = 1;
+	else
+		rz_mtu3_pwm->chip.npwm = 2;
+
+	/*
+	 *  We need to keep the clock on, in case the bootloader has enabled the
+	 *  PWM and is running during probe(). A variable pwm_enabled_by_
+	 *  bootloader is set to true in that case and during first
+	 *  pwm_disable(), it is set to false and decrement the clk usage count.
+	 */
+	if (rzg2l_mtu3_is_enabled(rz_mtu3_pwm->ch)) {
+		rz_mtu3_pwm->pwm_enabled_by_bootloader = true;
+		/* Increment clock ref count */
+		ret = clk_prepare_enable(rz_mtu3_pwm->clk);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       rz_mtu3_pwm_clk_disable,
+					       rz_mtu3_pwm);
+		if (ret < 0)
+			return ret;
+	}
+
+	ret = devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+
+	return ret;
+}
+
+static struct platform_driver rz_mtu3_pwm_driver = {
+	.driver = {
+		.name = "pwm-rz-mtu3",
+		.of_match_table = of_match_ptr(rz_mtu3_pwm_of_table),
+	},
+	.probe = rz_mtu3_pwm_probe,
+};
+module_platform_driver(rz_mtu3_pwm_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G2L MTU3 PWM Timer Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pwm-rz-mtu3");
-- 
2.25.1

