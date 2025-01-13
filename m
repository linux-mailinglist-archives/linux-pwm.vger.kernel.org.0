Return-Path: <linux-pwm+bounces-4598-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98831A0B741
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 13:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 311F03A49E0
	for <lists+linux-pwm@lfdr.de>; Mon, 13 Jan 2025 12:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC41B235BE2;
	Mon, 13 Jan 2025 12:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Fv8VQVZ2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B3922F15D;
	Mon, 13 Jan 2025 12:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736772193; cv=none; b=MzUMqxz/p1hU1HFmxa2uGLMNOcbOsdZEcIyDuddsR5xwp5+vFBH6QEFMPRPkBJLdwC2psN3NaYcTNvNybG7qijLOZkL28KJHpNAYU4JjnRCLFVSku3pv016Jn1Zq61jHFvXgsd+mPJ0qU5B8qIN0Qyd1J7buO7UODYkk3/gF0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736772193; c=relaxed/simple;
	bh=SmqAUM9cJ7WEIY8jbUlLLa/1ShmnfQEX0jTevTMoJog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CK+kLg33bF02C4qUutRkCaEZjpmm3MWlXvpNjXubn79YyslDqnAbql4uiY99Q4aAU94Edxjpx0Hwy4GI/iU9RIJMUHvu4qzWVHPOccfQZKKeU4MyUDM6yZdFiERSGRjKfEnorktR4xypFSvpahNBb35H8qgDl4m+PkQYnL7utrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Fv8VQVZ2; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id DE8C6240012;
	Mon, 13 Jan 2025 12:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736772188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Tbgqb9yrAAPah5rh+GWMrpYMx/As4sdg6PfNmDROkbA=;
	b=Fv8VQVZ2PqfokfDwLxpXcK2W7PlwoIt9qZjXjnpkj6IGYNkMfHxsFuRfiWCztrG5LXxHLN
	1o1DrsghDybP80wvbCWvUSCyrjPVkGEukfHjDNh91SRHweQ1En3VvmEb4q4bsCa9n6hhoM
	7e1SLq+pBMsTnAyfc0VKb2T0godyyO0Ie5ia43ohDbM2iAA2A/TqJeKLoApOq22wV7w6Ha
	wGBgCXrf9v8fuyinGkvvRPARB1EKyppJlADScaHCjUAf0uOC9Uqa7s33nN7zapJfebxmI2
	hprGG0hVXummm7gknS788bYYtLI8USTQ7pd7+lzsrVz4OQ91uebiET+Mnp/JSA==
From: mathieu.dubois-briand@bootlin.com
Date: Mon, 13 Jan 2025 13:42:27 +0100
Subject: [PATCH v3 3/7] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250113-mdb-max7360-support-v3-3-9519b4acb0b1@bootlin.com>
References: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
In-Reply-To: <20250113-mdb-max7360-support-v3-0-9519b4acb0b1@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736772185; l=7937;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=N8SDpazWZmto/z3HvCnJAM2ANVXJpOJDUQ/hmaNsSmc=;
 b=wa7jbgeTGLN8SfdtPV5GA+T1tz6GPSYXjLttEqD+muN2OkZtdIB5ptANzStge+mYa8B+77jzj
 8BLeLNC8BviAzLdcIGN+vUwrtX8uggYv6/kATnskJUOrtIeGQqixf3V
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
8 independent PWM outputs.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/pwm/Kconfig       |  11 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-max7360.c | 220 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 232 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..399dc3f76e92 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -745,4 +745,15 @@ config PWM_XILINX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-xilinx.
 
+config PWM_MAX7360
+	tristate "MAX7360 PWMs"
+	depends on MFD_MAX7360
+	depends on OF_GPIO
+	help
+	  PWM driver for Maxim Integrated MAX7360 multifunction device, with
+	  support for up to 8 PWM outputs.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pwm-max7360.
+
 endif
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 9081e0c0e9e0..ae8908ffc892 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MAX7360)	+= pwm-max7360.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MICROCHIP_CORE)	+= pwm-microchip-core.o
diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
new file mode 100644
index 000000000000..e76a8aa05fc4
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
+ *
+ * Limitations:
+ * - Only supports normal polarity.
+ * - The period is fixed to 2 ms.
+ * - Only the duty cycle can be changed, new values are applied at the beginning
+ *   of the next cycle.
+ * - When disabled, the output is put in Hi-Z.
+ */
+#include <linux/math.h>
+#include <linux/mfd/max7360.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+
+#define MAX7360_NUM_PWMS			8
+#define MAX7360_PWM_MAX_RES			256
+#define MAX7360_PWM_PERIOD_NS			2000000 /* 500 Hz */
+#define MAX7360_PWM_COMMON_PWN			BIT(5)
+#define MAX7360_PWM_CTRL_ENABLE(n)		BIT(n)
+#define MAX7360_PWM_PORT(n)			BIT(n)
+
+struct max7360_pwm {
+	struct device *parent;
+	struct regmap *regmap;
+};
+
+static inline struct max7360_pwm *to_max7360_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct max7360_pwm *max7360_pwm;
+	int ret;
+
+	max7360_pwm = to_max7360_pwm(chip);
+	ret = max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm,
+				       true);
+	if (ret) {
+		dev_warn(&chip->dev, "failed to request pwm-%d\n", pwm->hwpwm);
+		return ret;
+	}
+
+	ret = regmap_write_bits(max7360_pwm->regmap,
+				MAX7360_REG_PWMCFG + pwm->hwpwm,
+				MAX7360_PWM_COMMON_PWN,
+				0);
+	if (ret) {
+		dev_warn(&chip->dev,
+			 "failed to write pwm-%d cfg register, error %d\n",
+			 pwm->hwpwm, ret);
+		return ret;
+	}
+
+	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_PORTS,
+				MAX7360_PWM_PORT(pwm->hwpwm),
+				MAX7360_PWM_PORT(pwm->hwpwm));
+	if (ret) {
+		dev_warn(&chip->dev,
+			 "failed to write pwm-%d ports register, error %d\n",
+			 pwm->hwpwm, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct max7360_pwm *max7360_pwm;
+	int ret;
+
+	max7360_pwm = to_max7360_pwm(chip);
+	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
+				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
+				0);
+	if (ret)
+		dev_warn(&chip->dev, "failed to disable pwm-%d , error %d\n",
+			 pwm->hwpwm, ret);
+
+	max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm,
+				 false);
+}
+
+static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct max7360_pwm *max7360_pwm;
+	u64 duty_steps;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (state->period != MAX7360_PWM_PERIOD_NS) {
+		dev_warn(&chip->dev,
+			 "unsupported pwm period: %llu, should be %u\n",
+			 state->period, MAX7360_PWM_PERIOD_NS);
+		return -EINVAL;
+	}
+
+	duty_steps = mul_u64_u64_div_u64(state->duty_cycle, MAX7360_PWM_MAX_RES,
+					 MAX7360_PWM_PERIOD_NS);
+
+	max7360_pwm = to_max7360_pwm(chip);
+	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
+				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
+				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
+	if (ret) {
+		dev_warn(&chip->dev, "failed to enable pwm-%d , error %d\n",
+			 pwm->hwpwm, ret);
+		return ret;
+	}
+
+	ret = regmap_write(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->hwpwm,
+			   duty_steps >= 255 ? 255 : duty_steps);
+	if (ret) {
+		dev_warn(&chip->dev,
+			 "failed to apply pwm duty_cycle %llu on pwm-%d, error %d\n",
+			 duty_steps, pwm->hwpwm, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int max7360_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				 struct pwm_state *state)
+{
+	struct max7360_pwm *max7360_pwm;
+	unsigned int val;
+	int ret;
+
+	max7360_pwm = to_max7360_pwm(chip);
+
+	state->period = MAX7360_PWM_PERIOD_NS;
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	ret = regmap_read(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL, &val);
+	if (ret) {
+		dev_warn(&chip->dev,
+			 "failed to read pwm configuration on pwm-%d, error %d\n",
+			 pwm->hwpwm, ret);
+		return ret;
+	}
+	state->enabled = !!(val & MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
+
+	ret = regmap_read(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->hwpwm,
+			  &val);
+	if (ret) {
+		dev_warn(&chip->dev,
+			 "failed to read pwm duty_cycle on pwm-%d, error %d\n",
+			 pwm->hwpwm, ret);
+		return ret;
+	}
+	state->duty_cycle = mul_u64_u64_div_u64(val, MAX7360_PWM_PERIOD_NS,
+						MAX7360_PWM_MAX_RES);
+
+	return 0;
+}
+
+static const struct pwm_ops max7360_pwm_ops = {
+	.request = max7360_pwm_request,
+	.free = max7360_pwm_free,
+	.apply = max7360_pwm_apply,
+	.get_state = max7360_pwm_get_state,
+};
+
+static int max7360_pwm_probe(struct platform_device *pdev)
+{
+	struct max7360_pwm *max7360_pwm;
+	struct pwm_chip *chip;
+	int ret;
+
+	if (!pdev->dev.parent)
+		return dev_err_probe(&pdev->dev, -ENODEV, "no parent device\n");
+
+	chip = devm_pwmchip_alloc(pdev->dev.parent, MAX7360_NUM_PWMS,
+				  sizeof(*max7360_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->ops = &max7360_pwm_ops;
+
+	max7360_pwm = to_max7360_pwm(chip);
+	max7360_pwm->parent = pdev->dev.parent;
+
+	max7360_pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!max7360_pwm->regmap)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "could not get parent regmap\n");
+
+	ret = devm_pwmchip_add(&pdev->dev, chip);
+	if (ret != 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to add PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver max7360_pwm_driver = {
+	.driver = {
+		.name = MAX7360_DRVNAME_PWM,
+	},
+	.probe = max7360_pwm_probe,
+};
+module_platform_driver(max7360_pwm_driver);
+
+MODULE_DESCRIPTION("MAX7360 PWM driver");
+MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
+MODULE_ALIAS("platform:" MAX7360_DRVNAME_PWM);
+MODULE_LICENSE("GPL");

-- 
2.39.5


