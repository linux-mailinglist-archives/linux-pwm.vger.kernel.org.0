Return-Path: <linux-pwm+bounces-4725-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A03BBA1AAF4
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 21:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71042188E402
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jan 2025 20:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54CCE1B6CE4;
	Thu, 23 Jan 2025 20:11:37 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E521E1C5F34;
	Thu, 23 Jan 2025 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737663097; cv=none; b=U7eUPZGDFItvO3yKuix5+5GKxrfJQ/ZQ1JaQewtTrn/QdS7y9jwOJ3mbHl3ANn69pJkJtxZcmDWUcU4rdpOohGkH+k+4DewE8CbIC1zlAGSUPYUNuhdaRZxhatxLeRi3nI50AEo4x2udx5TNZeeNFLQaX3xLLZq4SeWdUFaIwPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737663097; c=relaxed/simple;
	bh=eFXvkO4r2LVrpfPqOlchfChhnYsksuCNDvziwLKBG/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=brqSHfbBkWuhnp9hRsdmftPruMYjSeVF6/RxMaI8paIQFi5UdGXOEwc8YThPCjZ3lmyWvZ6xaxXdFwujaeQl4Gnp/twCqXGF8bdX061DH7rHL18NgXRbK6fdaAfAJ0iSY4/4mpsim5w6966jYlLbe8zJ18jg+zVLYU6AU5fzYTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 50NJa327004974;
	Fri, 24 Jan 2025 03:36:03 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 50NJZf5m004792
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 03:35:41 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 24 Jan 2025
 03:35:41 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [v3 2/2] pwm: atcpit100: add Andes PWM driver support
Date: Fri, 24 Jan 2025 03:35:34 +0800
Message-ID: <20250123193534.874256-3-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123193534.874256-1-ben717@andestech.com>
References: <20250123193534.874256-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 50NJa327004974

Add PWM driver support for atcpit100 on Andes AE350 platform.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS                 |   1 +
 drivers/pwm/Kconfig         |  17 +++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-atcpit100.c | 296 ++++++++++++++++++++++++++++++++++++
 4 files changed, 315 insertions(+)
 create mode 100644 drivers/pwm/pwm-atcpit100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index bc54216d1835..04cb6f1d3638 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3592,6 +3592,7 @@ ATCPIT100 PWM DRIVER
 M:	Ben Zong-You Xie <ben717@andestech.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/pwm/andestech,atcpit100-pwm.yaml
+F:	drivers/pwm/pwm-atcpit100.c
 
 ATHEROS 71XX/9XXX GPIO DRIVER
 M:	Alban Bedel <albeu@free.fr>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..f45ff74fb44e 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -66,6 +66,23 @@ config PWM_APPLE
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-apple.
 
+config PWM_ATCPIT100
+	tristate "Andes ATCPIT100 PWM support"
+	depends on OF && HAS_IOMEM
+	depends on RISCV || COMPILE_TEST
+	select REGMAP_MMIO
+	help
+	  Generic PWM framework driver for ATCPIT100 on Andes AE350 platform
+
+	  The ATCPIT100 Programmable Interval Timer (PIT) is a set of compact
+	  multi-function timers, which can be used as pulse width
+	  modulators (PWM) as well as simple timers. ATCPIT100 supports up to 4
+	  PIT channels. Each PIT channel can be a simple timer or PWM, or a
+	  combination of timer and PWM.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-atcpit100.
+
 config PWM_ATMEL
 	tristate "Atmel PWM support"
 	depends on ARCH_AT91 || COMPILE_TEST
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..ad6e803f12d0 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -3,6 +3,7 @@ obj-$(CONFIG_PWM)		+= core.o
 obj-$(CONFIG_PWM_AB8500)	+= pwm-ab8500.o
 obj-$(CONFIG_PWM_ADP5585)	+= pwm-adp5585.o
 obj-$(CONFIG_PWM_APPLE)		+= pwm-apple.o
+obj-$(CONFIG_PWM_ATCPIT100)	+= pwm-atcpit100.o
 obj-$(CONFIG_PWM_ATMEL)		+= pwm-atmel.o
 obj-$(CONFIG_PWM_ATMEL_HLCDC_PWM)	+= pwm-atmel-hlcdc.o
 obj-$(CONFIG_PWM_ATMEL_TCB)	+= pwm-atmel-tcb.o
diff --git a/drivers/pwm/pwm-atcpit100.c b/drivers/pwm/pwm-atcpit100.c
new file mode 100644
index 000000000000..d24858844540
--- /dev/null
+++ b/drivers/pwm/pwm-atcpit100.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PWM driver for ATCPIT100 on Andes AE350 platform
+ *
+ * Copyright (C) 2025 Andes Technology Corporation.
+ *
+ * Limitations:
+ * - When disabling a channel, the current period will not be completed, and the
+ *   output will be constant zero.
+ * - The current period will be completed first if reconfiguring.
+ * - Further, if the reconfiguration changes the clock source, the output will
+ *   not be the old one nor the new one. And the output will be the new one
+ *   once writing to the reload register.
+ * - The hardware can neither do a 0% nor a 100% relative duty cycle.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define ATCPIT100_CHANNEL_ENABLE		0x1C
+#define ATCPIT100_CHANNEL_ENABLE_PWM(ch)	BIT(3 + (4 * ch))
+
+#define ATCPIT100_CHANNEL_CTRL(ch)		(0x20 + (0x10 * ch))
+#define ATCPIT100_CHANNEL_CTRL_MODE_PWM		0x04
+#define ATCPIT100_CHANNEL_CTRL_CLK		BIT(3)
+#define ATCPIT100_CHANNEL_CTRL_MASK		GENMASK(4, 0)
+
+#define ATCPIT100_CHANNEL_RELOAD(ch)		(0x24 + (0x10 * ch))
+#define ATCPIT100_CHANNEL_RELOAD_HIGH		GENMASK(31, 16)
+#define ATCPIT100_CHANNEL_RELOAD_LOW		GENMASK(15, 0)
+
+#define ATCPIT100_CHANNEL_MAX			4
+#define ATCPIT100_CYCLE_MIN			1
+#define ATCPIT100_CYCLE_MAX			0x10000
+#define ATCPIT100_IS_VALID_PERIOD(p)		\
+		in_range(p, min_period, max_period - min_period + 1)
+
+enum atcpit100_clk {
+	ATCPIT100_CLK_EXT = 0,
+	ATCPIT100_CLK_APB,
+	NUM_ATCPIT100_CLK
+};
+
+struct atcpit100_pwm {
+	unsigned long clk_rate[NUM_ATCPIT100_CLK];
+	struct regmap *regmap;
+	struct clk *ext_clk;
+	struct clk *apb_clk;
+};
+
+static const struct regmap_config atcpit100_pwm_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+};
+
+static inline struct atcpit100_pwm *to_atcpit100_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int atcpit100_pwm_enable(struct pwm_chip *chip, unsigned int channel,
+				bool enable)
+{
+	unsigned int enable_bit = ATCPIT100_CHANNEL_ENABLE_PWM(channel);
+	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
+
+	return regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,
+				  enable_bit, enable ? enable_bit : 0);
+}
+
+static int atcpit100_pwm_config(struct pwm_chip *chip, unsigned int channel,
+				const struct pwm_state *state)
+{
+	int clk;
+	int ret;
+	unsigned int reload_val;
+	u64 max_period;
+	u64 min_period;
+	u64 high_cycle;
+	u64 low_cycle;
+	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
+	unsigned int ctrl_val = ATCPIT100_CHANNEL_CTRL_MODE_PWM;
+	u64 high_period = state->duty_cycle;
+	u64 low_period = state->period - high_period;
+
+	/*
+	 * Reload register for PWM mode:
+	 *
+	 *		31 : 16    15 : 0
+	 *		PWM16_Hi | PWM16_Lo
+	 *
+	 * In the PWM mode, the high period is (PWM16_Hi + 1) cycles, and the
+	 * low period is (PWM16_Lo + 1) cycles. Since we need to write
+	 * "numcycles - 1" to the register, the valid range of numcycles will
+	 * be between 1 to 0x10000. Calculate the possible periods that satisfy
+	 * the above restriction:
+	 *
+	 *	Let m = 1, M = 0x10000,
+	 *	m <= floor(cycle) <= M
+	 * <=>	m <= floor(rate * period / NSEC_PER_SEC) <= M
+	 * <=>	m <= rate * period / NSEC_PER_SEC < M + 1
+	 * <=>	m * NSEC_PER_SEC / rate <= period < (M + 1) * NSEC_PER_SEC / rate
+	 * <=>	ceil(m * NSEC_PER_SEC / rate) <= period <= ceil((M + 1) * NSEC_PER_SEC / rate) - 1
+	 *
+	 * Since there are two clock sources for ATCPIT100 on AE350 platform, if
+	 * the period is not valid for the first clock source, then the second
+	 * clock source will be checked. Reject the request when both clock
+	 * sources are not valid for the settings.
+	 */
+	for (clk = ATCPIT100_CLK_EXT; clk < NUM_ATCPIT100_CLK; clk++) {
+		if (ap->clk_rate[clk] == 0)
+			continue;
+
+		max_period =
+			DIV64_U64_ROUND_UP((ATCPIT100_CYCLE_MAX + 1) *
+					   NSEC_PER_SEC, ap->clk_rate[clk]) - 1;
+		min_period =
+			DIV64_U64_ROUND_UP(ATCPIT100_CYCLE_MIN * NSEC_PER_SEC,
+					   ap->clk_rate[clk]);
+
+		if (ATCPIT100_IS_VALID_PERIOD(high_period) &&
+		    ATCPIT100_IS_VALID_PERIOD(low_period))
+			break;
+	}
+
+	if (clk == NUM_ATCPIT100_CLK)
+		return -EINVAL;
+
+	/*
+	 * Once changing the clock source here, the output will be neither the
+	 * old one nor the new one until writing to the reload register.
+	 */
+	ctrl_val |= clk ? ATCPIT100_CHANNEL_CTRL_CLK : 0;
+	ret = regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_CTRL(channel),
+				 ATCPIT100_CHANNEL_CTRL_MASK, ctrl_val);
+	if (ret)
+		return ret;
+
+	high_cycle = mul_u64_u64_div_u64(ap->clk_rate[clk], high_period,
+					 NSEC_PER_SEC);
+	low_cycle = mul_u64_u64_div_u64(ap->clk_rate[clk], low_period,
+					NSEC_PER_SEC);
+	reload_val = FIELD_PREP(ATCPIT100_CHANNEL_RELOAD_HIGH, high_cycle - 1) |
+		     FIELD_PREP(ATCPIT100_CHANNEL_RELOAD_LOW, low_cycle - 1);
+
+	return regmap_write(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
+			    reload_val);
+}
+
+static int atcpit100_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	int ret;
+	unsigned int channel = pwm->hwpwm;
+
+	/* ATCPIT100 PWM driver now only supports normal polarity. */
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			return atcpit100_pwm_enable(chip, channel, false);
+
+		return 0;
+	}
+
+	ret = atcpit100_pwm_config(chip, channel, state);
+	if (ret)
+		return ret;
+
+	return atcpit100_pwm_enable(chip, channel, true);
+}
+
+static int atcpit100_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	int clk;
+	int ret;
+	unsigned int ctrl_val;
+	unsigned int reload_val;
+	u16 pwm_high;
+	u16 pwm_low;
+	unsigned int channel = pwm->hwpwm;
+	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
+
+	ret = regmap_read(ap->regmap, ATCPIT100_CHANNEL_CTRL(channel),
+			  &ctrl_val);
+	if (ret)
+		return ret;
+
+	clk = (ctrl_val & ATCPIT100_CHANNEL_CTRL_CLK) ? ATCPIT100_CLK_APB
+						      : ATCPIT100_CLK_EXT;
+	state->enabled =
+		regmap_test_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,
+				 ATCPIT100_CHANNEL_ENABLE_PWM(channel));
+	state->polarity = PWM_POLARITY_NORMAL;
+	ret = regmap_read(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
+			  &reload_val);
+	if (ret)
+		return ret;
+
+	pwm_high = FIELD_GET(ATCPIT100_CHANNEL_RELOAD_HIGH, reload_val);
+	pwm_low = FIELD_GET(ATCPIT100_CHANNEL_RELOAD_LOW, reload_val);
+	state->duty_cycle =
+		DIV64_U64_ROUND_UP((pwm_high + 1) * NSEC_PER_SEC,
+				   ap->clk_rate[clk]);
+	state->period =
+		state->duty_cycle +
+		DIV64_U64_ROUND_UP((pwm_low + 1) * NSEC_PER_SEC,
+				   ap->clk_rate[clk]);
+
+	return 0;
+}
+
+static const struct pwm_ops atcpit_pwm_ops = {
+	.apply = atcpit100_pwm_apply,
+	.get_state = atcpit100_pwm_get_state,
+};
+
+static int atcpit100_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct atcpit100_pwm *ap;
+	struct pwm_chip *chip;
+	void __iomem *base;
+	int ret;
+
+	chip = devm_pwmchip_alloc(dev, ATCPIT100_CHANNEL_MAX, sizeof(*ap));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	ap = to_atcpit100_pwm(chip);
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ap->ext_clk = devm_clk_get_enabled(dev, "ext");
+	ap->clk_rate[ATCPIT100_CLK_EXT] = ap->ext_clk ?
+					  clk_get_rate(ap->ext_clk) : 0;
+	ap->apb_clk = devm_clk_get_enabled(dev, "apb");
+	ap->clk_rate[ATCPIT100_CLK_APB] = ap->apb_clk ?
+					  clk_get_rate(ap->apb_clk) : 0;
+	if (IS_ERR(ap->ext_clk) && IS_ERR(ap->apb_clk)) {
+		return dev_err_probe(dev, PTR_ERR(ap->ext_clk),
+				     "failed to obtain any clock\n");
+	}
+
+	if (ap->clk_rate[ATCPIT100_CLK_EXT] > NSEC_PER_SEC ||
+	    ap->clk_rate[ATCPIT100_CLK_APB] > NSEC_PER_SEC)
+		return dev_err_probe(dev, -EINVAL, "pwm clock out of range\n");
+
+	ap->regmap = devm_regmap_init_mmio(dev, base,
+					   &atcpit100_pwm_regmap_config);
+	if (IS_ERR(ap->regmap)) {
+		return dev_err_probe(dev, PTR_ERR(ap->regmap),
+				     "failed to init register map\n");
+	}
+
+	chip->ops = &atcpit_pwm_ops;
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add pwm chip\n");
+
+	dev_info(dev, "pwm driver probed\n");
+	return 0;
+}
+
+static const struct of_device_id atcpit100_pwm_dt[] = {
+	{ .compatible = "andestech,atcpit100" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, atcpit100_pwm_dt);
+
+static struct platform_driver atcpit100_pwm_driver = {
+	.driver = {
+		.name = "atcpit100-pwm",
+		.of_match_table = atcpit100_pwm_dt,
+	},
+	.probe = atcpit100_pwm_probe,
+};
+module_platform_driver(atcpit100_pwm_driver);
+
+MODULE_AUTHOR("Ben Zong-You Xie <ben717@andestech.com>");
+MODULE_DESCRIPTION("Andes ATCPIT100 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


