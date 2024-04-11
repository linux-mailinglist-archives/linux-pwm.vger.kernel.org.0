Return-Path: <linux-pwm+bounces-1884-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEE8A0C14
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 11:16:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0A42283D9A
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Apr 2024 09:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F02144305;
	Thu, 11 Apr 2024 09:16:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A031442FE;
	Thu, 11 Apr 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712827006; cv=none; b=VBK2gcL5SVHFJqgOyrN+QWK0Tg/6MmwPv3aq9sJyVnhoEVe1xLOCajUzJ1iPWXqfib2vFLsQcLWngnR1kjZ3BCCJEwDHjtCMempz8W4lg6/ece8BCf16ERGZQ29dSiUUz+ZAWxjRZi28WXTv/RJSZxNDwsl6wcsQPKfGCkGgEOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712827006; c=relaxed/simple;
	bh=vMEv7n9sPLR33IUQeR5rnvgeWswXo9QMV8q33DfrZCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1254OfONRZ7on6PGW1xdajpdD/OyhJ1c/hOi/iflYiaERRHFWJnDMQnp8GctuW3RifQlzSWxFnlwN2/sHJ0H3HxCLNLGIlQe0ML4k35qWfD73dr7MWn1148MpJtj+QHW2U7t+RNZ7NVANAkwRCOlmmdqcZ4Q8bLqjx0/lGE1NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8AxDLt6qhdmWsQlAA--.5307S3;
	Thu, 11 Apr 2024 17:16:42 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8Cx6xJyqhdmmvV3AA--.37435S4;
	Thu, 11 Apr 2024 17:16:40 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Juxin Gao <gaojuxin@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	loongson-kernel@lists.loongnix.cn,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 2/2] pwm: Add Loongson PWM controller support
Date: Thu, 11 Apr 2024 17:16:23 +0800
Message-ID: <6a37f0eda2880d9a763c89a7b1929b908d8fc4fe.1712732719.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712732719.git.zhoubinbin@loongson.cn>
References: <cover.1712732719.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8Cx6xJyqhdmmvV3AA--.37435S4
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW3ZF4UZry3Gr4DtryUKr1DCFX_yoWkJr15pF
	y5A34YgF43Ar1UCws8ZrZYyrn8Z34fZFZxJFWfGw1DCF98t3ykZr95K3Z7GwsFyr1kJr10
	qFWfGFWUGF4UGFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUAVWUtwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU82jg7UUUUU==

This commit adds a generic PWM framework driver for the PWM controller
found on Loongson family chips.

Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 MAINTAINERS                |   1 +
 drivers/pwm/Kconfig        |  10 ++
 drivers/pwm/Makefile       |   1 +
 drivers/pwm/pwm-loongson.c | 300 +++++++++++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)
 create mode 100644 drivers/pwm/pwm-loongson.c

diff --git a/MAINTAINERS b/MAINTAINERS
index cd0d4e2d02ff..fef232ae8cca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12762,6 +12762,7 @@ M:	Binbin Zhou <zhoubinbin@loongson.cn>
 L:	linux-pwm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pwm/loongson,ls7a-pwm.yaml
+F:	drivers/pwm/pwm-loongson.c
 
 LOONGSON-2 SOC SERIES CLOCK DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4b956d661755..bb163c65e5ae 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -324,6 +324,16 @@ config PWM_KEEMBAY
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-keembay.
 
+config PWM_LOONGSON
+	tristate "Loongson PWM support"
+	depends on MACH_LOONGSON64
+	help
+	  Generic PWM framework driver for Loongson family.
+	  It can be found on Loongson-2K series cpu and Loongson LS7A bridge chips.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-loongson.
+
 config PWM_LP3943
 	tristate "TI/National Semiconductor LP3943 PWM support"
 	depends on MFD_LP3943
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index c5ec9e168ee7..bffa49500277 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_PWM_INTEL_LGM)	+= pwm-intel-lgm.o
 obj-$(CONFIG_PWM_IQS620A)	+= pwm-iqs620a.o
 obj-$(CONFIG_PWM_JZ4740)	+= pwm-jz4740.o
 obj-$(CONFIG_PWM_KEEMBAY)	+= pwm-keembay.o
+obj-$(CONFIG_PWM_LOONGSON)	+= pwm-loongson.o
 obj-$(CONFIG_PWM_LP3943)	+= pwm-lp3943.o
 obj-$(CONFIG_PWM_LPC18XX_SCT)	+= pwm-lpc18xx-sct.o
 obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
diff --git a/drivers/pwm/pwm-loongson.c b/drivers/pwm/pwm-loongson.c
new file mode 100644
index 000000000000..0afae42113a5
--- /dev/null
+++ b/drivers/pwm/pwm-loongson.c
@@ -0,0 +1,300 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Loongson PWM driver
+ *
+ * Author: Juxin Gao <gaojuxin@loongson.cn>
+ * Further cleanup and restructuring by:
+ *         Binbin Zhou <zhoubinbin@loongson.cn>
+ *
+ * Copyright (C) 2017-2024 Loongson Technology Corporation Limited.
+ */
+
+#include <linux/acpi.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/units.h>
+
+/* Loongson PWM registers */
+#define PWM_DUTY	0x4 /* Low Pulse Buffer Register */
+#define PWM_PERIOD	0x8 /* Pulse Period Buffer Register */
+#define PWM_CTRL	0xc /* Control Register */
+
+/* Control register bits */
+#define PWM_CTRL_EN	BIT(0)  /* Counter Enable Bit */
+#define PWM_CTRL_OE	BIT(3)  /* Pulse Output Enable Control Bit, Valid Low */
+#define PWM_CTRL_SINGLE	BIT(4)  /* Single Pulse Control Bit */
+#define PWM_CTRL_INTE	BIT(5)  /* Interrupt Enable Bit */
+#define PWM_CTRL_INT	BIT(6)  /* Interrupt Bit */
+#define PWM_CTRL_RST	BIT(7)  /* Counter Reset Bit */
+#define PWM_CTRL_CAPTE	BIT(8)  /* Measurement Pulse Enable Bit */
+#define PWM_CTRL_INVERT	BIT(9)  /* Output flip-flop Enable Bit */
+#define PWM_CTRL_DZONE	BIT(10) /* Anti-dead Zone Enable Bit */
+
+#define PWM_FREQ_STD       (50 * HZ_PER_KHZ)
+
+struct pwm_loongson_ddata {
+	struct pwm_chip	chip;
+	struct clk	*clk;
+	void __iomem	*base;
+	/* The following for PM */
+	u32		ctrl;
+	u32		duty;
+	u32		period;
+};
+
+static inline struct pwm_loongson_ddata *to_pwm_loongson_ddata(struct pwm_chip *chip)
+{
+	return container_of(chip, struct pwm_loongson_ddata, chip);
+}
+
+static inline u32 pwm_loongson_readl(struct pwm_loongson_ddata *ddata, u64 offset)
+{
+	return readl(ddata->base + offset);
+}
+
+static inline void pwm_loongson_writel(struct pwm_loongson_ddata *ddata,
+				       u32 val, u64 offset)
+{
+	writel(val, ddata->base + offset);
+}
+
+static int pwm_loongson_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
+				     enum pwm_polarity polarity)
+{
+	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
+	u16 val;
+
+	val = pwm_loongson_readl(ddata, PWM_CTRL);
+
+	if (polarity == PWM_POLARITY_INVERSED)
+		/* Duty cycle defines LOW period of PWM */
+		val |= PWM_CTRL_INVERT;
+	else
+		/* Duty cycle defines HIGH period of PWM */
+		val &= ~PWM_CTRL_INVERT;
+
+	pwm_loongson_writel(ddata, val, PWM_CTRL);
+	return 0;
+}
+
+static void pwm_loongson_disable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
+	u32 val;
+
+	if (pwm->state.polarity == PWM_POLARITY_NORMAL)
+		pwm_loongson_writel(ddata, ddata->period, PWM_DUTY);
+	else if (pwm->state.polarity == PWM_POLARITY_INVERSED)
+		pwm_loongson_writel(ddata, 0, PWM_DUTY);
+
+	val = pwm_loongson_readl(ddata, PWM_CTRL);
+	val &= ~PWM_CTRL_EN;
+	pwm_loongson_writel(ddata, val, PWM_CTRL);
+}
+
+static int pwm_loongson_enable(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
+	u32 val;
+
+	pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
+	pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
+
+	val = pwm_loongson_readl(ddata, PWM_CTRL);
+	val |= PWM_CTRL_EN;
+	pwm_loongson_writel(ddata, val, PWM_CTRL);
+
+	return 0;
+}
+
+static u32 pwm_loongson_set_config(struct pwm_loongson_ddata *ddata, int ns,
+				   u64 clk_rate, u64 offset)
+{
+	u32 val;
+	u64 c;
+
+	c = clk_rate * ns;
+	do_div(c, NSEC_PER_SEC);
+	val = c < 1 ? 1 : c;
+
+	pwm_loongson_writel(ddata, val, offset);
+
+	return val;
+}
+
+static int pwm_loongson_config(struct pwm_chip *chip, struct pwm_device *pwm,
+			       int duty_ns, int period_ns)
+{
+	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
+	struct device *dev = chip->dev;
+	u64 clk_rate;
+
+	if (period_ns > NANOHZ_PER_HZ || duty_ns > NANOHZ_PER_HZ)
+		return -ERANGE;
+
+	clk_rate = has_acpi_companion(dev) ? PWM_FREQ_STD
+		 : clk_get_rate(ddata->clk);
+
+	ddata->period = pwm_loongson_set_config(ddata, period_ns,
+						clk_rate, PWM_PERIOD);
+	ddata->duty = pwm_loongson_set_config(ddata, duty_ns, clk_rate, PWM_DUTY);
+
+	return 0;
+}
+
+static int pwm_loongson_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			pwm_loongson_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = pwm_loongson_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			pwm_loongson_disable(chip, pwm);
+		return 0;
+	}
+
+	err = pwm_loongson_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!enabled)
+		err = pwm_loongson_enable(chip, pwm);
+
+	return err;
+}
+
+static int pwm_loongson_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pwm_loongson_ddata *ddata = to_pwm_loongson_ddata(chip);
+	u32 period, duty, ctrl;
+	u64 ns;
+
+	period = pwm_loongson_readl(ddata, PWM_PERIOD);
+	ns = period * NSEC_PER_SEC;
+	state->period = do_div(ns, period);
+
+	duty = pwm_loongson_readl(ddata, PWM_DUTY);
+	ns = duty * NSEC_PER_SEC;
+	state->duty_cycle = do_div(ns, duty);
+
+	ctrl = pwm_loongson_readl(ddata, PWM_CTRL);
+	state->polarity = (ctrl & PWM_CTRL_INVERT) ? PWM_POLARITY_INVERSED
+			: PWM_POLARITY_NORMAL;
+	state->enabled = (ctrl & PWM_CTRL_EN) ? true : false;
+
+	ddata->ctrl = ctrl;
+	ddata->duty = pwm_loongson_readl(ddata, PWM_DUTY);
+	ddata->period = pwm_loongson_readl(ddata, PWM_PERIOD);
+
+	return 0;
+}
+
+static const struct pwm_ops pwm_loongson_ops = {
+	.apply = pwm_loongson_apply,
+	.get_state = pwm_loongson_get_state,
+};
+
+static int pwm_loongson_probe(struct platform_device *pdev)
+{
+	struct pwm_loongson_ddata *ddata;
+	struct device *dev = &pdev->dev;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	ddata->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ddata->base))
+		return PTR_ERR(ddata->base);
+
+	if (!has_acpi_companion(dev)) {
+		ddata->clk = devm_clk_get_enabled(dev, NULL);
+		if (IS_ERR(ddata->clk))
+			return PTR_ERR(ddata->clk);
+	}
+
+	ddata->chip.dev = dev;
+	ddata->chip.ops = &pwm_loongson_ops;
+	ddata->chip.npwm = 1;
+	platform_set_drvdata(pdev, ddata);
+
+	return devm_pwmchip_add(dev, &ddata->chip);
+}
+
+static int pwm_loongson_suspend(struct device *dev)
+{
+	struct pwm_loongson_ddata *ddata = dev_get_drvdata(dev);
+
+	ddata->ctrl = pwm_loongson_readl(ddata, PWM_CTRL);
+	ddata->duty = pwm_loongson_readl(ddata, PWM_DUTY);
+	ddata->period = pwm_loongson_readl(ddata, PWM_PERIOD);
+
+	clk_disable_unprepare(ddata->clk);
+
+	return 0;
+}
+
+static int pwm_loongson_resume(struct device *dev)
+{
+	struct pwm_loongson_ddata *ddata = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(ddata->clk);
+	if (ret)
+		return ret;
+
+	pwm_loongson_writel(ddata, ddata->ctrl, PWM_CTRL);
+	pwm_loongson_writel(ddata, ddata->duty, PWM_DUTY);
+	pwm_loongson_writel(ddata, ddata->period, PWM_PERIOD);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(pwm_loongson_pm_ops, pwm_loongson_suspend,
+				pwm_loongson_resume);
+
+static const struct acpi_device_id pwm_loongson_acpi_ids[] = {
+	{ "LOON0006" },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, pwm_loongson_acpi_ids);
+
+static const struct of_device_id pwm_loongson_of_ids[] = {
+	{ .compatible = "loongson,ls7a-pwm" },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, pwm_loongson_of_ids);
+
+static struct platform_driver pwm_loongson_driver = {
+	.probe  = pwm_loongson_probe,
+	.driver = {
+		.name   = "loongson-pwm",
+		.pm	= pm_ptr(&pwm_loongson_pm_ops),
+		.of_match_table   = pwm_loongson_of_ids,
+		.acpi_match_table = pwm_loongson_acpi_ids,
+	},
+};
+module_platform_driver(pwm_loongson_driver);
+
+MODULE_DESCRIPTION("Loongson PWM driver");
+MODULE_AUTHOR("Loongson Technology Corporation Limited.");
+MODULE_LICENSE("GPL");
-- 
2.43.0


