Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D13632B4F4
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Mar 2021 06:55:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbhCCFqy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 3 Mar 2021 00:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444836AbhCBMiJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Mar 2021 07:38:09 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346C5C061225;
        Tue,  2 Mar 2021 04:37:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id b15so1857983pjb.0;
        Tue, 02 Mar 2021 04:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVRmaqPQAp3LJKqemLxg1VHT1FIeHyDhRZDxgWlTEGE=;
        b=gFLT4Ps6csWEik84/YLqEaaI7m9rudSbjPifRUX5k9cK9yNxau533Dgg6XA5jVa463
         Ik28paO/mQgyhadfIz3XhGXP5BNpVUsBo1sqdSZiWpFjCNHO6YlAkFAyM65Kv0gvCBwQ
         NT5DptnclkmWMsktJHJvVOGX2kuycjAx/w56AYtZ/zl2PheJh3LyYYJyIjMRs3eThnoM
         kOgcXnuar4aS/B84ywrMO7dWAVVtlKMEc0gJ5rbHCqA/Mpd3u5etFIAz3fNMwRSXBclE
         MiSXDYbEOP/064n0ej3RAnFGCOjc3ynWEaGVE8SeOLI/Q3/XoZXQ1GfMTgMSGBEEV3pq
         uCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eVRmaqPQAp3LJKqemLxg1VHT1FIeHyDhRZDxgWlTEGE=;
        b=T/CEbl9tGaGAIWsaGFngv/RlnScFCVmSK8O1vSy3k0Ax1WZpuiEJv9hzuhmS4l3Lzc
         Ukimo80b+w7VC3PRnh3d5YF/12LNDgbneb04AnZmpOhHZ+C5AnY/JaxDPudeFvLzrpTe
         cOPpUia9KjJ2YPD4dApw75iZf4XzR0dqTaEwDEz/Ubc53KQHLAJ09+QjIhXENidCkbJz
         YDpXq84e88ZzXI+ywmd3s2YRONQvnCfk/uMTQ8e8AFon1D5Z1cBscDM0Zel0DfijaTzQ
         FPWTz5tTQlNFX/PI+nFoBHj3xjshR89CnVVHXdM38YQpZ3jxAZmXG2SdaoL9LauI7zyM
         YBAw==
X-Gm-Message-State: AOAM533/Y0w6njkQN7B3ZuQSgQknnoTaw9h9FRvRuNu1JAUi1hUDiLDd
        jyzAWu2n37aCT5+ktMpq9g==
X-Google-Smtp-Source: ABdhPJynvjEoAi7b/7jXjMJapACFMwzEmlucIj2Qd5bUWxwM7I2Um5TFV6U1Qpt2p0+MEs5D7nxQpw==
X-Received: by 2002:a17:90a:1d0a:: with SMTP id c10mr4485257pjd.142.1614688663697;
        Tue, 02 Mar 2021 04:37:43 -0800 (PST)
Received: from INTERNET-129.allwinnertech.com ([223.197.233.48])
        by smtp.gmail.com with ESMTPSA id k63sm22079276pfd.48.2021.03.02.04.37.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 04:37:43 -0800 (PST)
From:   Ban Tao <fengzheng923@gmail.com>
X-Google-Original-From: Ban Tao
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, mripard@kernel.org, wens@csie.org
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ban Tao <fengzheng923@gmail.com>
Subject: [PATCH v3 1/2] pwm: sunxi: Add Allwinner SoC PWM controller driver
Date:   Tue,  2 Mar 2021 20:37:37 +0800
Message-Id: <20210302123737.1867-1-fengzheng923@gmail.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ban Tao <fengzheng923@gmail.com>

The Allwinner R818, A133, R329, V536 and V833 has a new PWM controller
IP compared to the older Allwinner SoCs.

Signed-off-by: Ban Tao <fengzheng923@gmail.com>

---
v1->v2:
1.delete unnecessary code.
2.using a named define for some constants.
3.Add comment in sun50i_pwm_config function.
4.using dev_err_probe() for error handling.
5.disable the clock after pwmchip_remove().
---
v2->v3:
1.fix all emitted warnings when PWM_DEBUG enabled.
2.modify the name of file pwm-sun50i to pwm-sun8i-v536.
3.fix "sun50i_pwm_from_chip" -> "to_sun8i_pwm_chip".
4.delete some unnecessary "compatible".
---
 MAINTAINERS                  |   6 +
 drivers/pwm/Kconfig          |  11 +
 drivers/pwm/Makefile         |   1 +
 drivers/pwm/pwm-sun8i-v536.c | 401 +++++++++++++++++++++++++++++++++++
 4 files changed, 419 insertions(+)
 create mode 100644 drivers/pwm/pwm-sun8i-v536.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e73636b75f29..387e187c635c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -737,6 +737,12 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/staging/media/sunxi/cedrus/
 
+ALLWINNER PWM DRIVER
+M:	Ban Tao <fengzheng923@gmail.com>
+L:	linux-pwm@vger.kernel.org
+S:	Maintained
+F:	drivers/pwm/pwm-sun8i-v536.c
+
 ALPHA PORT
 M:	Richard Henderson <rth@twiddle.net>
 M:	Ivan Kokshaysky <ink@jurassic.park.msu.ru>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 9a4f66ae8070..3418b5b898a9 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -552,6 +552,17 @@ config PWM_SUN4I
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-sun4i.
 
+config PWM_SUN8I_V536
+	tristate "Allwinner SUN8I_V536 PWM support"
+	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on HAS_IOMEM && COMMON_CLK
+	help
+	  Enhanced PWM framework driver for Allwinner R818, A133, R329,
+	  V536 and V833 SoCs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-sun8i-v536.
+
 config PWM_TEGRA
 	tristate "NVIDIA Tegra PWM support"
 	depends on ARCH_TEGRA || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 6374d3b1d6f3..380d6b107308 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -51,6 +51,7 @@ obj-$(CONFIG_PWM_STM32)		+= pwm-stm32.o
 obj-$(CONFIG_PWM_STM32_LP)	+= pwm-stm32-lp.o
 obj-$(CONFIG_PWM_STMPE)		+= pwm-stmpe.o
 obj-$(CONFIG_PWM_SUN4I)		+= pwm-sun4i.o
+obj-$(CONFIG_PWM_SUN8I_V536)	+= pwm-sun8i-v536.o
 obj-$(CONFIG_PWM_TEGRA)		+= pwm-tegra.o
 obj-$(CONFIG_PWM_TIECAP)	+= pwm-tiecap.o
 obj-$(CONFIG_PWM_TIEHRPWM)	+= pwm-tiehrpwm.o
diff --git a/drivers/pwm/pwm-sun8i-v536.c b/drivers/pwm/pwm-sun8i-v536.c
new file mode 100644
index 000000000000..52101df6bd41
--- /dev/null
+++ b/drivers/pwm/pwm-sun8i-v536.c
@@ -0,0 +1,401 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Allwinner sun8i-v536 Pulse Width Modulation Controller
+ *
+ * Copyright (C) 2021 Ban Tao <fengzheng923@gmail.com>
+ *
+ *
+ * Limitations:
+ * - When PWM is disabled, the output is driven to inactive.
+ * - If the register is reconfigured while PWM is running,
+ *   it does not complete the currently running period.
+ * - If the user input duty is beyond acceptible limits,
+ *   -EINVAL is returned.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pwm.h>
+#include <linux/clk.h>
+#include <linux/reset.h>
+
+#define PWM_GET_CLK_OFFSET(chan)	(0x20 + ((chan >> 1) * 0x4))
+#define PWM_CLK_APB_SCR			BIT(7)
+#define PWM_DIV_M			0
+#define PWM_DIV_M_MASK			GENMASK(3, PWM_DIV_M)
+
+#define PWM_CLK_REG			0x40
+#define PWM_CLK_GATING			BIT(0)
+
+#define PWM_ENABLE_REG			0x80
+#define PWM_EN				BIT(0)
+
+#define PWM_CTL_REG(chan)		(0x100 + 0x20 * chan)
+#define PWM_ACT_STA			BIT(8)
+#define PWM_PRESCAL_K			0
+#define PWM_PRESCAL_K_MASK		GENMASK(7, PWM_PRESCAL_K)
+
+#define PWM_PERIOD_REG(chan)		(0x104 + 0x20 * chan)
+#define PWM_ENTIRE_CYCLE			16
+#define PWM_ENTIRE_CYCLE_MASK		GENMASK(31, PWM_ENTIRE_CYCLE)
+#define PWM_ACT_CYCLE			0
+#define PWM_ACT_CYCLE_MASK		GENMASK(15, PWM_ACT_CYCLE)
+
+#define BIT_CH(bit, chan)		((bit) << (chan))
+#define SET_BITS(shift, mask, reg, val) \
+	    (((reg) & ~mask) | (val << (shift)))
+
+#define PWM_OSC_CLK			24000000
+#define PWM_PRESCALER_MAX		256
+#define PWM_CLK_DIV_M__MAX		9
+#define PWM_ENTIRE_CYCLE_MAX		65536
+
+struct sun8i_pwm_data {
+	unsigned int npwm;
+};
+
+struct sun8i_pwm_chip {
+	struct pwm_chip chip;
+	struct clk *clk;
+	struct reset_control *rst_clk;
+	void __iomem *base;
+	const struct sun8i_pwm_data *data;
+};
+
+static inline struct sun8i_pwm_chip *to_sun8i_pwm_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct sun8i_pwm_chip, chip);
+}
+
+static inline u32 sun8i_pwm_readl(struct sun8i_pwm_chip *chip,
+				   unsigned long offset)
+{
+	return readl(chip->base + offset);
+}
+
+static inline void sun8i_pwm_writel(struct sun8i_pwm_chip *chip,
+				     u32 val, unsigned long offset)
+{
+	writel(val, chip->base + offset);
+}
+
+static void sun8i_pwm_get_state(struct pwm_chip *chip,
+				 struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct sun8i_pwm_chip *pc = to_sun8i_pwm_chip(chip);
+	u64 clk_rate;
+	u32 tmp, entire_cycles, active_cycles;
+	unsigned int prescaler, div_m;
+
+	tmp = sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	if (tmp & PWM_CLK_APB_SCR)
+		clk_rate = clk_get_rate(pc->clk);
+	else
+		clk_rate = PWM_OSC_CLK;
+
+	tmp = sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	div_m = 0x1 << (tmp & PWM_DIV_M_MASK);
+
+	tmp = sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
+	prescaler = (tmp & PWM_PRESCAL_K_MASK) + 1;
+
+	tmp = sun8i_pwm_readl(pc, PWM_PERIOD_REG(pwm->hwpwm));
+	entire_cycles = (tmp >> PWM_ENTIRE_CYCLE) + 1;
+	active_cycles = (tmp & PWM_ACT_CYCLE_MASK);
+
+	/* (clk / div_m / prescaler) / entire_cycles = NSEC_PER_SEC / period_ns. */
+	state->period = DIV_ROUND_CLOSEST_ULL(entire_cycles * NSEC_PER_SEC,
+					      clk_rate) * div_m * prescaler;
+	/* duty_ns / period_ns = active_cycles / entire_cycles. */
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(active_cycles * state->period,
+						  entire_cycles);
+
+	/* parsing polarity */
+	tmp = sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
+	if (tmp & PWM_ACT_STA)
+		state->polarity = PWM_POLARITY_NORMAL;
+	else
+		state->polarity = PWM_POLARITY_INVERSED;
+
+	/* parsing enabled */
+	tmp = sun8i_pwm_readl(pc, PWM_ENABLE_REG);
+	if (tmp & BIT_CH(PWM_EN, pwm->hwpwm))
+		state->enabled = true;
+	else
+		state->enabled = false;
+
+	dev_dbg(chip->dev, "duty_ns=%lld period_ns=%lld polarity=%s enabled=%s.\n",
+				state->duty_cycle, state->period,
+				state->polarity ? "inversed":"normal",
+				state->enabled ? "true":"false");
+}
+
+static void sun8i_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				    enum pwm_polarity polarity)
+{
+	struct sun8i_pwm_chip *pc = to_sun8i_pwm_chip(chip);
+	u32 temp;
+
+	temp = sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
+
+	if (polarity == PWM_POLARITY_NORMAL)
+		temp |= PWM_ACT_STA;
+	else
+		temp &= ~PWM_ACT_STA;
+
+	sun8i_pwm_writel(pc, temp, PWM_CTL_REG(pwm->hwpwm));
+}
+
+static int sun8i_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct sun8i_pwm_chip *pc = to_sun8i_pwm_chip(chip);
+	unsigned long long c;
+	unsigned long entire_cycles, active_cycles;
+	unsigned int div_m, prescaler;
+	u64 duty_ns = state->duty_cycle, period_ns = state->period;
+	u32 config;
+	int ret = 0;
+
+	if (period_ns > 334) {
+		/* if freq < 3M, then select 24M clock */
+		c = PWM_OSC_CLK;
+		config = sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+		config &= ~PWM_CLK_APB_SCR;
+		sun8i_pwm_writel(pc, config, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	} else {
+		/* if freq > 3M, then select APB as clock */
+		c = clk_get_rate(pc->clk);
+		config = sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+		config |= PWM_CLK_APB_SCR;
+		sun8i_pwm_writel(pc, config, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	}
+
+	dev_dbg(chip->dev, "duty_ns=%lld period_ns=%lld c =%llu.\n",
+			duty_ns, period_ns, c);
+
+	/*
+	 * (clk / div_m / prescaler) / entire_cycles = NSEC_PER_SEC / period_ns.
+	 * So, entire_cycles = clk * period_ns / NSEC_PER_SEC / div_m / prescaler.
+	 */
+	c = c * period_ns;
+	c = DIV_ROUND_CLOSEST_ULL(c, NSEC_PER_SEC);
+	for (div_m = 0; div_m < PWM_CLK_DIV_M__MAX; div_m++) {
+		for (prescaler = 0; prescaler < PWM_PRESCALER_MAX; prescaler++) {
+			/*
+			 * actual prescaler = prescaler(reg value) + 1.
+			 * actual div_m = 0x1 << div_m(reg value).
+			 */
+			entire_cycles = ((unsigned long)c >> div_m)/(prescaler + 1);
+			if (entire_cycles <= PWM_ENTIRE_CYCLE_MAX)
+				goto calc_end;
+		}
+	}
+	ret = -EINVAL;
+	goto exit;
+
+calc_end:
+	/*
+	 * duty_ns / period_ns = active_cycles / entire_cycles.
+	 * So, active_cycles = entire_cycles * duty_ns / period_ns.
+	 */
+	c = (unsigned long long)entire_cycles * duty_ns;
+	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
+	active_cycles = c;
+	if (entire_cycles == 0)
+		entire_cycles++;
+
+	/* config  clk div_m*/
+	config = sun8i_pwm_readl(pc, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+	config = SET_BITS(PWM_DIV_M, PWM_DIV_M_MASK, config, div_m);
+	sun8i_pwm_writel(pc, config, PWM_GET_CLK_OFFSET(pwm->hwpwm));
+
+	/* config prescaler */
+	config = sun8i_pwm_readl(pc, PWM_CTL_REG(pwm->hwpwm));
+	config = SET_BITS(PWM_PRESCAL_K, PWM_PRESCAL_K_MASK, config, prescaler);
+	sun8i_pwm_writel(pc, config, PWM_CTL_REG(pwm->hwpwm));
+
+	/* config active and period cycles */
+	config = sun8i_pwm_readl(pc, PWM_PERIOD_REG(pwm->hwpwm));
+	config = SET_BITS(PWM_ACT_CYCLE, PWM_ACT_CYCLE_MASK, config, active_cycles);
+	config = SET_BITS(PWM_ENTIRE_CYCLE, PWM_ENTIRE_CYCLE_MASK,
+			config, (entire_cycles - 1));
+	sun8i_pwm_writel(pc, config, PWM_PERIOD_REG(pwm->hwpwm));
+
+	dev_dbg(chip->dev, "active_cycles=%lu entire_cycles=%lu prescaler=%u div_m=%u\n",
+			   active_cycles, entire_cycles, prescaler, div_m);
+
+exit:
+	return ret;
+}
+
+static void sun8i_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+			     bool enable)
+{
+	struct sun8i_pwm_chip *pc = to_sun8i_pwm_chip(chip);
+	u32 clk, pwm_en;
+
+	clk = sun8i_pwm_readl(pc, PWM_CLK_REG);
+	pwm_en = sun8i_pwm_readl(pc, PWM_ENABLE_REG);
+
+	if (enable) {
+		clk |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+		sun8i_pwm_writel(pc, clk, PWM_CLK_REG);
+
+		pwm_en |= BIT_CH(PWM_EN, pwm->hwpwm);
+		sun8i_pwm_writel(pc, pwm_en, PWM_ENABLE_REG);
+	} else {
+		pwm_en &= ~BIT_CH(PWM_EN, pwm->hwpwm);
+		sun8i_pwm_writel(pc, pwm_en, PWM_ENABLE_REG);
+
+		clk &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+		sun8i_pwm_writel(pc, clk, PWM_CLK_REG);
+	}
+}
+
+static int sun8i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	struct pwm_state curstate;
+	int ret;
+
+	pwm_get_state(pwm, &curstate);
+
+	ret = sun8i_pwm_config(chip, pwm, state);
+
+	if (state->polarity != curstate.polarity)
+		sun8i_pwm_set_polarity(chip, pwm, state->polarity);
+
+	if (state->enabled != curstate.enabled)
+		sun8i_pwm_enable(chip, pwm, state->enabled);
+
+	return ret;
+}
+
+static const struct pwm_ops sun8i_pwm_ops = {
+	.get_state = sun8i_pwm_get_state,
+	.apply = sun8i_pwm_apply,
+	.owner = THIS_MODULE,
+};
+
+static const struct sun8i_pwm_data sun8i_pwm_data_c9 = {
+	.npwm = 9,
+};
+
+static const struct sun8i_pwm_data sun50i_pwm_data_c16 = {
+	.npwm = 16,
+};
+
+static const struct of_device_id sun8i_pwm_dt_ids[] = {
+	{
+		.compatible = "allwinner,sun8i-v536-pwm",
+		.data = &sun8i_pwm_data_c9,
+	}, {
+		.compatible = "allwinner,sun50i-r818-pwm",
+		.data = &sun50i_pwm_data_c16,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, sun8i_pwm_dt_ids);
+
+static int sun8i_pwm_probe(struct platform_device *pdev)
+{
+	struct sun8i_pwm_chip *pc;
+	int ret;
+
+	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
+	if (!pc)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "memory allocation failed\n");
+
+	pc->data = of_device_get_match_data(&pdev->dev);
+	if (!pc->data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "can't get match data\n");
+
+	pc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pc->base))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->base),
+				     "can't remap pwm resource\n");
+
+	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(pc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
+				     "get clock failed\n");
+
+	pc->rst_clk = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(pc->rst_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->rst_clk),
+				     "get reset failed\n");
+
+	/* Deassert reset */
+	ret = reset_control_deassert(pc->rst_clk);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "cannot deassert reset control\n");
+
+	ret = clk_prepare_enable(pc->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot prepare and enable clk %pe\n",
+			ERR_PTR(ret));
+		goto err_clk;
+	}
+
+	pc->chip.dev = &pdev->dev;
+	pc->chip.ops = &sun8i_pwm_ops;
+	pc->chip.npwm = pc->data->npwm;
+	pc->chip.of_xlate = of_pwm_xlate_with_flags;
+	pc->chip.base = -1;
+	pc->chip.of_pwm_n_cells = 3;
+
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
+		goto err_pwm_add;
+	}
+
+	platform_set_drvdata(pdev, pc);
+
+	return 0;
+
+err_pwm_add:
+	clk_disable_unprepare(pc->clk);
+err_clk:
+	reset_control_assert(pc->rst_clk);
+
+	return ret;
+}
+
+static int sun8i_pwm_remove(struct platform_device *pdev)
+{
+	struct sun8i_pwm_chip *pc = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&pc->chip);
+	if (ret)
+		return ret;
+
+	clk_disable_unprepare(pc->clk);
+	reset_control_assert(pc->rst_clk);
+
+	return 0;
+}
+
+static struct platform_driver sun8i_pwm_driver = {
+	.driver = {
+		.name = "sun8i-pwm-v536",
+		.of_match_table = sun8i_pwm_dt_ids,
+	},
+	.probe = sun8i_pwm_probe,
+	.remove = sun8i_pwm_remove,
+};
+module_platform_driver(sun8i_pwm_driver);
+
+MODULE_ALIAS("platform:sun8i-v536-pwm");
+MODULE_AUTHOR("Ban Tao <fengzheng923@gmail.com>");
+MODULE_DESCRIPTION("Allwinner sun8i-v536 PWM driver");
+MODULE_LICENSE("GPL v2");
-- 
2.29.0

