Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A86637F8E
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Nov 2022 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiKXTRC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Nov 2022 14:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiKXTRC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Nov 2022 14:17:02 -0500
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D98C87A5D;
        Thu, 24 Nov 2022 11:17:00 -0800 (PST)
X-IronPort-AV: E=Sophos;i="5.96,191,1665414000"; 
   d="scan'208";a="143806157"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 25 Nov 2022 04:17:00 +0900
Received: from localhost.localdomain (unknown [10.226.92.56])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 99A6940C6827;
        Fri, 25 Nov 2022 04:16:57 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 3/5] pwm: Add support for RZ/V2M PWM driver
Date:   Thu, 24 Nov 2022 19:16:41 +0000
Message-Id: <20221124191643.3193423-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124191643.3193423-1-biju.das.jz@bp.renesas.com>
References: <20221124191643.3193423-1-biju.das.jz@bp.renesas.com>
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

The RZ/V2{M, MA} PWM Timer supports the following functions:

 * The PWM has 24-bit counters which operate at PWM_CLK (48 MHz).
 * The frequency division ratio for internal counter operation is
   selectable as PWM_CLK divided by 1, 16, 256, or 2048.
 * The period as well as the duty cycle is adjustable.
 * The low-level and high-level order of the PWM signals can be
   inverted.
 * The duty cycle of the PWM signal is selectable in the range from
   0 to 100%.
 * The minimum resolution is 20.83 ns.
 * Three interrupt sources: Rising and falling edges of the PWM signal
   and clearing of the counter
 * Counter operation and the bus interface are asynchronous and both
   can operate independently of the magnitude relationship of the
   respective clock periods.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Replaced devm_reset_control_get_optional_shared->devm_reset_control_get_shared
---
 drivers/pwm/Kconfig     |  11 ++
 drivers/pwm/Makefile    |   1 +
 drivers/pwm/pwm-rzv2m.c | 390 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 402 insertions(+)
 create mode 100644 drivers/pwm/pwm-rzv2m.c

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 60d13a949bc5..4ed68495a611 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -473,6 +473,17 @@ config PWM_RENESAS_TPU
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-renesas-tpu.
 
+config PWM_RZV2M
+       tristate "Renesas RZ/V2M PWM support"
+       depends on ARCH_R9A09G011 || COMPILE_TEST
+       depends on HAS_IOMEM
+       help
+         This driver exposes the PWM controller found in Renesas
+         RZ/V2M like chips through the PWM API.
+
+         To compile this driver as a module, choose M here: the module
+         will be called pwm-rzv2m.
+
 config PWM_ROCKCHIP
 	tristate "Rockchip PWM support"
 	depends on ARCH_ROCKCHIP || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 7bf1a29f02b8..a95aabae9115 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_PWM_PXA)		+= pwm-pxa.o
 obj-$(CONFIG_PWM_RASPBERRYPI_POE)	+= pwm-raspberrypi-poe.o
 obj-$(CONFIG_PWM_RCAR)		+= pwm-rcar.o
 obj-$(CONFIG_PWM_RENESAS_TPU)	+= pwm-renesas-tpu.o
+obj-$(CONFIG_PWM_RZV2M)		+= pwm-rzv2m.o
 obj-$(CONFIG_PWM_ROCKCHIP)	+= pwm-rockchip.o
 obj-$(CONFIG_PWM_SAMSUNG)	+= pwm-samsung.o
 obj-$(CONFIG_PWM_SIFIVE)	+= pwm-sifive.o
diff --git a/drivers/pwm/pwm-rzv2m.c b/drivers/pwm/pwm-rzv2m.c
new file mode 100644
index 000000000000..c377f1a1a100
--- /dev/null
+++ b/drivers/pwm/pwm-rzv2m.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Renesas RZ/V2M PWM Timer (PWM) driver
+ *
+ * Copyright (C) 2022 Renesas Electronics Corporation
+ *
+ * Hardware manual for this IP can be found here
+ * https://www.renesas.com/in/en/document/mah/rzv2m-users-manual-hardware?language=en
+ *
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/reset.h>
+#include <linux/time.h>
+
+#define U24_MASK	GENMASK(23, 0)
+#define U24_MAX		(U24_MASK)
+
+#define RZV2M_PWMCTR	0x0
+#define RZV2M_PWMCYC	0x4
+#define RZV2M_PWMLOW	0x8
+#define RZV2M_PWMCNT	0xc
+
+#define RZV2M_PWMCTR_PWMPS	GENMASK(17, 16)
+#define RZV2M_PWMCTR_PWMHL	BIT(3)
+#define RZV2M_PWMCTR_PWMTM	BIT(2)
+#define RZV2M_PWMCTR_PWME	BIT(1)
+
+#define F2CYCLE_NSEC(f)		(1000000000 / (f))
+
+struct rzv2m_pwm_chip {
+	struct pwm_chip chip;
+	void __iomem *mmio;
+	struct reset_control *rstc;
+	struct clk *apb_clk;
+	struct clk *pwm_clk;
+	unsigned long rate;
+	unsigned long delay;
+};
+
+static const int rzv2m_pwm_freq_div[] = { 1, 16, 256, 2048 };
+
+static inline struct rzv2m_pwm_chip *to_rzv2m_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct rzv2m_pwm_chip, chip);
+}
+
+static void rzv2m_pwm_wait_delay(struct rzv2m_pwm_chip *chip)
+{
+	/* delay timer when change the setting register */
+	ndelay(chip->delay);
+}
+
+static void rzv2m_pwm_write(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg, u32 data)
+{
+	writel(data, rzv2m_pwm->mmio + reg);
+}
+
+static u32 rzv2m_pwm_read(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg)
+{
+	return readl(rzv2m_pwm->mmio + reg);
+}
+
+static void rzv2m_pwm_modify(struct rzv2m_pwm_chip *rzv2m_pwm, u32 reg, u32 clr,
+			     u32 set)
+{
+	rzv2m_pwm_write(rzv2m_pwm, reg,
+			(rzv2m_pwm_read(rzv2m_pwm, reg) & ~clr) | set);
+}
+
+static u8 rzv2m_pwm_calculate_prescale(struct rzv2m_pwm_chip *rzv2m_pwm,
+				       u64 period_cycles)
+{
+	u32 prescaled_period_cycles;
+	u8 prescale;
+
+	prescaled_period_cycles = period_cycles >> 24;
+	if (prescaled_period_cycles >= 256)
+		prescale = 3;
+	else
+		prescale = (fls(prescaled_period_cycles) + 3) / 4;
+
+	return prescale;
+}
+
+static bool rzv2m_pwm_is_ch_enabled(struct rzv2m_pwm_chip *rzv2m_pwm)
+{
+	return !!(rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR) & RZV2M_PWMCTR_PWME);
+}
+
+static int rzv2m_pwm_enable(struct rzv2m_pwm_chip *rzv2m_pwm)
+{
+	int rc;
+
+	rc = pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
+	if (rc)
+		return rc;
+
+	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME,
+			 RZV2M_PWMCTR_PWME);
+	rzv2m_pwm_wait_delay(rzv2m_pwm);
+
+	return 0;
+}
+
+static void rzv2m_pwm_disable(struct rzv2m_pwm_chip *rzv2m_pwm)
+{
+	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWME, 0);
+	rzv2m_pwm_wait_delay(rzv2m_pwm);
+
+	pm_runtime_put_sync(rzv2m_pwm->chip.dev);
+}
+
+static int rzv2m_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm = to_rzv2m_pwm_chip(chip);
+	unsigned long pwm_cyc, pwm_low;
+	u8 prescale;
+	u64 pc, dc;
+	int err;
+
+	/*
+	 * Refuse clk rates > 1 GHz to prevent overflowing the following
+	 * calculation.
+	 */
+	if (rzv2m_pwm->rate > NSEC_PER_SEC)
+		return -EINVAL;
+
+	/*
+	 * Formula for calculating PWM Cycle Setting Register
+	 * PWM cycle = (PWM period(ns) / (PWM_CLK period(ns) × Div ratio)) - 1
+	 */
+
+	pc = mul_u64_u32_div(state->period, rzv2m_pwm->rate, NSEC_PER_SEC);
+	dc = mul_u64_u32_div(state->duty_cycle, rzv2m_pwm->rate, NSEC_PER_SEC);
+	prescale = rzv2m_pwm_calculate_prescale(rzv2m_pwm, pc);
+
+	pwm_cyc = pc / rzv2m_pwm_freq_div[prescale];
+	if (pc / rzv2m_pwm_freq_div[prescale] <= U24_MAX)
+		pwm_cyc = pwm_cyc ? (pwm_cyc - 1) : 0;
+	else
+		pwm_cyc = U24_MAX;
+
+	pwm_low = dc / rzv2m_pwm_freq_div[prescale];
+	if (pwm_low <= U24_MAX)
+		pwm_low = pwm_low ? (pwm_low - 1) : 0;
+	else
+		pwm_low = U24_MAX;
+
+	/*
+	 * If the PWM channel is disabled, make sure to turn on the clock
+	 * before writing the register.
+	 */
+	if (!pwm_is_enabled(pwm)) {
+		err = pm_runtime_resume_and_get(rzv2m_pwm->chip.dev);
+		if (err)
+			return err;
+	}
+
+	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMTM, 0);
+	rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMPS,
+			 FIELD_PREP(RZV2M_PWMCTR_PWMPS, prescale));
+
+	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMCYC, pwm_cyc);
+	rzv2m_pwm_write(rzv2m_pwm, RZV2M_PWMLOW, pwm_low);
+
+	if (state->polarity == PWM_POLARITY_NORMAL)
+		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMHL, 0);
+	else
+		rzv2m_pwm_modify(rzv2m_pwm, RZV2M_PWMCTR, RZV2M_PWMCTR_PWMHL,
+				 RZV2M_PWMCTR_PWMHL);
+
+	rzv2m_pwm_wait_delay(rzv2m_pwm);
+
+	/*
+	 * If the PWM is not enabled, turn the clock off again to save power.
+	 */
+	if (!pwm_is_enabled(pwm))
+		pm_runtime_put(rzv2m_pwm->chip.dev);
+
+	return 0;
+}
+
+static void rzv2m_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				struct pwm_state *state)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm = to_rzv2m_pwm_chip(chip);
+	u8 prescale;
+	u64 tmp;
+	u32 val;
+
+	pm_runtime_get_sync(chip->dev);
+	val = rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCTR);
+	state->enabled = FIELD_GET(RZV2M_PWMCTR_PWME, val);
+	state->polarity = FIELD_GET(RZV2M_PWMCTR_PWMHL, val);
+	prescale = FIELD_GET(RZV2M_PWMCTR_PWMPS, val);
+	val = rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMCYC);
+	val = val ? val + 1 : 0;
+	tmp = DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val, rzv2m_pwm->rate);
+	state->period = tmp * rzv2m_pwm_freq_div[prescale];
+
+	val = rzv2m_pwm_read(rzv2m_pwm, RZV2M_PWMLOW);
+	val = val ? val + 1 : 0;
+	tmp = DIV_ROUND_UP_ULL(NSEC_PER_SEC * (u64)val, rzv2m_pwm->rate);
+	state->duty_cycle = tmp * rzv2m_pwm_freq_div[prescale];
+	pm_runtime_put(chip->dev);
+}
+
+static int rzv2m_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm = to_rzv2m_pwm_chip(chip);
+	bool enabled = pwm->state.enabled;
+	int ret;
+
+	if (!state->enabled) {
+		if (enabled)
+			rzv2m_pwm_disable(rzv2m_pwm);
+
+		return 0;
+	}
+
+	ret = rzv2m_pwm_config(chip, pwm, state);
+	if (ret)
+		return ret;
+
+	if (!enabled)
+		ret = rzv2m_pwm_enable(rzv2m_pwm);
+
+	return ret;
+}
+
+static const struct pwm_ops rzv2m_pwm_ops = {
+	.get_state = rzv2m_pwm_get_state,
+	.apply = rzv2m_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static int rzv2m_pwm_pm_runtime_suspend(struct device *dev)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
+	clk_disable_unprepare(rzv2m_pwm->apb_clk);
+
+	return 0;
+}
+
+static int rzv2m_pwm_pm_runtime_resume(struct device *dev)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm = dev_get_drvdata(dev);
+
+	clk_prepare_enable(rzv2m_pwm->apb_clk);
+	clk_prepare_enable(rzv2m_pwm->pwm_clk);
+
+	return 0;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(rzv2m_pwm_pm_ops,
+				 rzv2m_pwm_pm_runtime_suspend,
+				 rzv2m_pwm_pm_runtime_resume, NULL);
+
+static void rzv2m_pwm_reset_assert_pm_disable(void *data)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm = data;
+
+	clk_prepare_enable(rzv2m_pwm->apb_clk);
+	clk_prepare_enable(rzv2m_pwm->pwm_clk);
+
+	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
+		pm_runtime_put(rzv2m_pwm->chip.dev);
+
+	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
+	clk_disable_unprepare(rzv2m_pwm->apb_clk);
+
+	pm_runtime_disable(rzv2m_pwm->chip.dev);
+	pm_runtime_set_suspended(rzv2m_pwm->chip.dev);
+	reset_control_assert(rzv2m_pwm->rstc);
+}
+
+static int rzv2m_pwm_probe(struct platform_device *pdev)
+{
+	struct rzv2m_pwm_chip *rzv2m_pwm;
+	unsigned long apb_clk_rate;
+	int ret;
+
+	rzv2m_pwm = devm_kzalloc(&pdev->dev, sizeof(*rzv2m_pwm), GFP_KERNEL);
+	if (!rzv2m_pwm)
+		return -ENOMEM;
+
+	rzv2m_pwm->mmio = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(rzv2m_pwm->mmio))
+		return PTR_ERR(rzv2m_pwm->mmio);
+
+	rzv2m_pwm->apb_clk = devm_clk_get(&pdev->dev, "apb");
+	if (IS_ERR(rzv2m_pwm->apb_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->apb_clk),
+				     "cannot get apb clock\n");
+
+	apb_clk_rate = clk_get_rate(rzv2m_pwm->apb_clk);
+	if (!apb_clk_rate)
+		return dev_err_probe(&pdev->dev, -EINVAL, "apb clk rate is 0");
+
+	rzv2m_pwm->pwm_clk = devm_clk_get(&pdev->dev, "pwm");
+	if (IS_ERR(rzv2m_pwm->pwm_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->pwm_clk),
+				     "cannot get pwm clock\n");
+
+	rzv2m_pwm->rate = clk_get_rate(rzv2m_pwm->pwm_clk);
+	if (!rzv2m_pwm->rate)
+		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clk rate is 0");
+
+	/* delay = 6 * PCLK + 9 * PWM_CLK */
+	rzv2m_pwm->delay = F2CYCLE_NSEC(apb_clk_rate) * 6 +
+		F2CYCLE_NSEC(rzv2m_pwm->rate) * 9;
+
+	rzv2m_pwm->rstc = devm_reset_control_get_shared(&pdev->dev, NULL);
+	if (IS_ERR(rzv2m_pwm->rstc))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rzv2m_pwm->rstc),
+				     "get reset failed\n");
+
+	platform_set_drvdata(pdev, rzv2m_pwm);
+	clk_prepare_enable(rzv2m_pwm->apb_clk);
+	clk_prepare_enable(rzv2m_pwm->pwm_clk);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	ret = reset_control_deassert(rzv2m_pwm->rstc);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret,
+			      "cannot deassert reset control\n");
+		goto clk_disable;
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev,
+				       rzv2m_pwm_reset_assert_pm_disable,
+				       rzv2m_pwm);
+	if (ret < 0)
+		goto clk_disable;
+
+	/*
+	 *  We need to keep the clock on, in case the bootloader has enabled the
+	 *  PWM and is running during probe().
+	 */
+	if (rzv2m_pwm_is_ch_enabled(rzv2m_pwm))
+		pm_runtime_get_sync(&pdev->dev);
+
+	rzv2m_pwm->chip.dev = &pdev->dev;
+	rzv2m_pwm->chip.ops = &rzv2m_pwm_ops;
+	rzv2m_pwm->chip.npwm = 1;
+	ret = devm_pwmchip_add(&pdev->dev, &rzv2m_pwm->chip);
+	if (ret) {
+		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
+		goto clk_disable;
+	}
+
+	return 0;
+
+clk_disable:
+	clk_disable_unprepare(rzv2m_pwm->pwm_clk);
+	clk_disable_unprepare(rzv2m_pwm->apb_clk);
+	return ret;
+}
+
+static const struct of_device_id rzv2m_pwm_of_table[] = {
+	{ .compatible = "renesas,rzv2m-pwm", },
+	{ /* Sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, rzv2m_pwm_of_table);
+
+static struct platform_driver rzv2m_pwm_driver = {
+	.driver = {
+		.name = "pwm-rzv2m",
+		.pm = pm_ptr(&rzv2m_pwm_pm_ops),
+		.of_match_table = of_match_ptr(rzv2m_pwm_of_table),
+	},
+	.probe = rzv2m_pwm_probe,
+};
+module_platform_driver(rzv2m_pwm_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/V2M PWM Timer Driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:pwm-rzv2m");
-- 
2.25.1

