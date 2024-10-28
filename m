Return-Path: <linux-pwm+bounces-3939-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A07239B2D28
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 11:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31D11C21AF0
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Oct 2024 10:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625CB1D8A04;
	Mon, 28 Oct 2024 10:43:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109921D86E6;
	Mon, 28 Oct 2024 10:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730112226; cv=none; b=NRBRunspxSMlEIR9NZ96VromxSjkadOhtDdOhrufFLogzw8g/DUL+6y4T35ON5vIHZhPvxg8ExzTNm7/fT300IUEXgNMA0GRMGVS+PEpyJBcAozZyFKjZNxTQ8XfSquXAM298fuv8WFEyybVWeSagjcG/3U/8FBmpYpi5chMOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730112226; c=relaxed/simple;
	bh=a8xaoll6lvaHK5mTlo1T2gjP99Y8QL1g6v4s1g0383U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivW2YU39R5YLSkj4xUCoyonijtB2bv39ZxAsFWp9BQ7EZSWenTxM18tkQmsWuhejTWdhvXOeKbnj0DhbTBHK1Xrg0Ih21qxvhp08xdzg7ynNWf2H8MLoUw8fiaG3u4UKxo8pP4+kZxUXzp3FQfXqV1YQM3F85Ifi090R+IWmZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 49SARq4L076965;
	Mon, 28 Oct 2024 18:27:52 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 49SARUCL076726
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Oct 2024 18:27:30 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Mon, 28 Oct 2024
 18:27:31 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, Ben Zong-You Xie <ben717@andestech.com>
Subject: [PATCH 2/2] pwm: atcpit100: add Andes PWM driver support
Date: Mon, 28 Oct 2024 18:27:21 +0800
Message-ID: <20241028102721.1961289-3-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028102721.1961289-1-ben717@andestech.com>
References: <20241028102721.1961289-1-ben717@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 49SARq4L076965

Add PWM driver suuport for Andes atcpit100.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
 MAINTAINERS                 |   1 +
 drivers/pwm/Kconfig         |  17 +++
 drivers/pwm/Makefile        |   1 +
 drivers/pwm/pwm-atcpit100.c | 240 ++++++++++++++++++++++++++++++++++++
 4 files changed, 259 insertions(+)
 create mode 100644 drivers/pwm/pwm-atcpit100.c

diff --git a/MAINTAINERS b/MAINTAINERS
index ebbc7edcf077..39c6e1f21339 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3555,6 +3555,7 @@ ATCPIT100 PWM DRIVER
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
index 000000000000..cf83e8702d60
--- /dev/null
+++ b/drivers/pwm/pwm-atcpit100.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
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
+#define ATCPIT100_CHANNEL_MAX			4
+#define ATCPIT100_CHANNEL_ENABLE		0x1C
+#define ATCPIT100_CHANNEL_ENABLE_PWM(ch)	BIT(3 + (4 * ch))
+#define ATCPIT100_CHANNEL_CTRL(ch)		(0x20 + (0x10 * ch))
+#define ATCPIT100_CHANNEL_CTRL_MODE_PWM		0x04
+#define ATCPIT100_CHANNEL_CTRL_CLK		BIT(3)
+#define ATCPIT100_CHANNEL_CTRL_MASK		GENMASK(4, 0)
+#define ATCPIT100_CHANNEL_RELOAD(ch)		(0x24 + (0x10 * ch))
+#define CLK_EXTERNAL				32768
+#define CLK_APB					60000000
+#define CYCLE_MIN				0x01
+#define CYCLE_MAX				0x010000
+
+struct atcpit100_pwm {
+	struct regmap *regmap;
+	u32 clk_src[ATCPIT100_CHANNEL_MAX];
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
+static int of_atcpit100_pwm_set_clk_src(struct atcpit100_pwm *ap,
+					struct device_node *np)
+{
+	int ret;
+
+	for (int i = 0; i < ATCPIT100_CHANNEL_MAX; i++) {
+		ret = of_property_read_u32_index(np, "andestech,clock-source",
+						 i, &(ap->clk_src[i]));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int atcpit100_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
+				bool enable)
+{
+	unsigned int channel = pwm->hwpwm;
+	unsigned int enable_bit = ATCPIT100_CHANNEL_ENABLE_PWM(channel);
+	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
+
+	pwm->state.enabled = enable;
+	return regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,
+				  enable_bit, enable ? enable_bit : 0);
+}
+
+static int atcpit100_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
+				const struct pwm_state *state)
+{
+	int ret;
+	u64 period_cycle;
+	u64 duty_cycle;
+	u16 pwm_high;
+	u16 pwm_low;
+	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
+	unsigned int ctrl_val = 0;
+	unsigned int channel = pwm->hwpwm;
+	u64 rate = ap->clk_src[channel] ? CLK_APB : CLK_EXTERNAL;
+
+	/* cycle count = clock rate * time */
+	period_cycle = mul_u64_u64_div_u64(rate, state->period, NSEC_PER_SEC);
+	duty_cycle = mul_u64_u64_div_u64(rate, state->duty_cycle,
+					 NSEC_PER_SEC);
+	if (period_cycle < CYCLE_MIN || period_cycle > CYCLE_MAX ||
+	    duty_cycle < CYCLE_MIN || duty_cycle > CYCLE_MAX) {
+		dev_err(pwmchip_parent(chip),
+			"channel%d: period cycles = 0x%llx, duty cycles = 0x%llx\n",
+			channel, period_cycle, duty_cycle);
+		return -EINVAL;
+	}
+
+	/*
+	 * In the PWM mode, the high period is (PWM16_Hi + 1) cycles, and the
+	 * low period is (PWM16_Lo + 1) cycles.
+	 * For example, if period is 30 cycles and duty_cycle is 10 cycles,
+	 * PWM16_Hi = 10 - 1 = 9, PWM16_Lo = 30 - 10 - 1 = 19.
+	 */
+	pwm_high = duty_cycle - 1;
+	pwm_low = period_cycle - duty_cycle - 1;
+
+	/* Set control register. */
+	ctrl_val |= ATCPIT100_CHANNEL_CTRL_MODE_PWM;
+	ctrl_val |= ap->clk_src[channel] ? ATCPIT100_CHANNEL_CTRL_CLK : 0;
+	ret = regmap_update_bits(ap->regmap, ATCPIT100_CHANNEL_CTRL(channel),
+				 ATCPIT100_CHANNEL_CTRL_MASK, ctrl_val);
+	if (ret)
+		return ret;
+
+	/* Set reload register. */
+	ret = regmap_write(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
+			   (pwm_high << 16) | pwm_low);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int atcpit100_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	int ret;
+
+	/* ATCPIT100 PWM driver now only supports normal polarity. */
+	if (state->polarity != PWM_POLARITY_NORMAL) {
+		dev_err(pwmchip_parent(chip),
+			"only supports normal polarity now\n");
+		return -EINVAL;
+	}
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			return atcpit100_pwm_enable(chip, pwm, 0);
+
+		return 0;
+	}
+
+	ret = atcpit100_pwm_config(chip, pwm, state);
+	if (ret)
+		return ret;
+
+	return atcpit100_pwm_enable(chip, pwm, 1);
+}
+
+static int atcpit100_pwm_get_state(struct pwm_chip *chip,
+				   struct pwm_device *pwm,
+				   struct pwm_state *state)
+{
+	int ret;
+	unsigned int reload_val;
+	u16 pwm_high;
+	u16 pwm_low;
+	unsigned int channel = pwm->hwpwm;
+	struct atcpit100_pwm *ap = to_atcpit100_pwm(chip);
+	u64 rate = ap->clk_src[channel] ? CLK_APB : CLK_EXTERNAL;
+
+	state->enabled =
+		regmap_test_bits(ap->regmap, ATCPIT100_CHANNEL_ENABLE,
+				 ATCPIT100_CHANNEL_ENABLE_PWM(channel));
+	state->polarity = PWM_POLARITY_NORMAL;
+	ret = regmap_read(ap->regmap, ATCPIT100_CHANNEL_RELOAD(channel),
+			  &reload_val);
+	if (ret)
+		return ret;
+
+	pwm_high = reload_val >> 16;
+	pwm_low = reload_val & 0xFFFF;
+	state->duty_cycle = mul_u64_u64_div_u64(pwm_high + 1, NSEC_PER_SEC,
+						rate);
+	state->period = mul_u64_u64_div_u64(pwm_low + pwm_high + 1,
+					    NSEC_PER_SEC, rate);
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
+	struct device_node *np = dev->of_node;
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
+
+	/*
+	 * Each channel can select two different clock sources by toggling the
+	 * third bit in its control register. 0 means using an external clock,
+	 * and 1 means using APB clock from APB bus. Select the clock source for
+	 * each channel by DTS.
+	 */
+	ret = of_atcpit100_pwm_set_clk_src(ap, np);
+	if (ret)
+		return ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ap->regmap = devm_regmap_init_mmio(dev, base,
+					   &atcpit100_pwm_regmap_config);
+	if (IS_ERR(ap->regmap))
+		return dev_err_probe(dev, PTR_ERR(ap->regmap),
+				     "failed to init register map\n");
+
+	chip->ops = &atcpit_pwm_ops;
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static const struct of_device_id atcpit100_pwm_dt[] = {
+	{ .compatible = "andestech,atcpit100-pwm" },
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
+MODULE_AUTHOR("Andes Technology Corporation <ben717@andestech.com>");
+MODULE_DESCRIPTION("Andes ATCPIT100 PWM driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1


