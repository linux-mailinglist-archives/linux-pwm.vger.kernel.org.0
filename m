Return-Path: <linux-pwm+bounces-4406-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F519F7F6B
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE9C1888956
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Dec 2024 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40990228C98;
	Thu, 19 Dec 2024 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZlxOxTOY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C0E226551;
	Thu, 19 Dec 2024 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625321; cv=none; b=ULd1ZQQSczXtc3JZvQQAaiCktDh+sPmJqfcOEIbv2xg4nxWRzelq98JqqE802nI9MG56Pv4nXv/5mLRyWpPAPns92mlt555H8udxfDVzoUs+20ZgAYuhomq7BMXFY7C1Rhlv0eo9vWR94mrWjJH4jvrqpennbsgiccIpPUwQAYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625321; c=relaxed/simple;
	bh=j/ZH98b7v/Dl8/WqhzlTaqw670w2ll3yf24VM/OuYrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cq/mYr6vo15iqCikoKtLqnO1u1rJBJYqY1rn7MnzeoHsCgexlDJXv4MogOLQDFEISIuNY7VAsmh4XMB5BURW7E/u6zQekuXMYncI3e92YQSxfzUWIOYulxPP95dj/NNl/NQSJQy85zEOicfvJr2kwNdY7VQH12kGdUZ4GQYBp9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZlxOxTOY; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D2B296000A;
	Thu, 19 Dec 2024 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734625311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=75o1demuGRTQhL28lBh4mm+iaPhJKlrwWjt0l8twc0g=;
	b=ZlxOxTOYBJ+kW5qF1ZulXGR+GdkMf6iBqgKZxrjeW3NP71CR0QIowqF3EBQLuQrzvdz41R
	ZjfOpJvLxc9Yut/4z+Uq4yonsD2NizlRBbTBX9lOHBxb5XYiCqVRRSAcjcOqPYZLHKK3cR
	OI4n7oHea/hpqm3k8ZOr/YNv6Li3fPwzH+cskSGHwdWSEv0feSHKysbCqwIw40/Wt55Qgr
	PSmjWYMmeose2sC3k4mdY1WBcUTDyAHGEaj2hXoqsyJw9PH9p0/kGR+AsNrSwlEgwnKBty
	zToqi0lgAuLJ9/uME2t19vCBHlJeTJvutlxU0ts/GzliTQGpdimy+EuXI9ZqSg==
From: mathieu.dubois-briand@bootlin.com
Date: Thu, 19 Dec 2024 17:21:21 +0100
Subject: [PATCH 4/8] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-mdb-max7360-support-v1-4-8e8317584121@bootlin.com>
References: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
In-Reply-To: <20241219-mdb-max7360-support-v1-0-8e8317584121@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734625307; l=6535;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=5JoN1j4Oackj65AqCNXP+34lE11Fh2kGLi9vl055Ecg=;
 b=Zbj0Zy9H9aJSPuFT5R3WeTcyln/ZpWn2Z8yyN8UBytSU7vsh4LqFLWN4h0ocIeQrhW2n63lOz
 0duXmoXK0kGDLR19nMQlRMnmsSjHs6K2vhwpU+cW06ZhlwljE08gux/
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
 drivers/pwm/pwm-max7360.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 185 insertions(+)

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
index 000000000000..b1cde3e86864
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,173 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
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
+	struct device *dev;
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
+	ret = max7360_port_pin_request(max7360_pwm->dev->parent, pwm->hwpwm,
+				       true);
+	if (ret) {
+		dev_err(&chip->dev, "failed to request pwm-%d\n", pwm->hwpwm);
+		return ret;
+	}
+
+	ret = regmap_write_bits(max7360_pwm->regmap,
+				MAX7360_REG_PWMCFG + pwm->hwpwm,
+				MAX7360_PWM_COMMON_PWN,
+				0);
+	if (ret) {
+		dev_err(&chip->dev, "failed to write pwm-%d cfg register, error %d\n",
+			pwm->hwpwm, ret);
+		return ret;
+	}
+
+	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_PORTS,
+				MAX7360_PWM_PORT(pwm->hwpwm),
+				MAX7360_PWM_PORT(pwm->hwpwm));
+	if (ret) {
+		dev_err(&chip->dev, "failed to write pwm-%d ports register, error %d\n",
+			pwm->hwpwm, ret);
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
+		dev_err(&chip->dev, "failed to enable pwm-%d , error %d\n",
+			pwm->hwpwm, ret);
+
+	max7360_port_pin_request(max7360_pwm->dev->parent, pwm->hwpwm,
+				 false);
+}
+
+static int max7360_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	struct max7360_pwm *max7360_pwm;
+	u64 duty_steps = state->duty_cycle * MAX7360_PWM_MAX_RES;
+	int ret;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	max7360_pwm = to_max7360_pwm(chip);
+	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
+				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm),
+				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm));
+	if (ret) {
+		dev_err(&chip->dev, "failed to enable pwm-%d , error %d\n",
+			pwm->hwpwm, ret);
+		return ret;
+	}
+
+	do_div(duty_steps, MAX7360_PWM_PERIOD_NS);
+
+	ret = regmap_write(max7360_pwm->regmap, MAX7360_REG_PWMBASE + pwm->hwpwm,
+			   duty_steps >= 255 ? 255 : duty_steps);
+	if (ret) {
+		dev_err(&chip->dev,
+			"failed to apply pwm duty_cycle %llu on pwm-%d, error %d\n",
+			duty_steps, pwm->hwpwm, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops max7360_pwm_ops = {
+	.request = max7360_pwm_request,
+	.free = max7360_pwm_free,
+	.apply = max7360_pwm_apply,
+};
+
+static int max7360_pwm_probe(struct platform_device *pdev)
+{
+	struct max7360_pwm *max7360_pwm;
+	struct pwm_chip *chip;
+
+	if (!pdev->dev.parent) {
+		dev_err(&pdev->dev, "no parent device\n");
+		return -ENODEV;
+	}
+
+	chip = devm_pwmchip_alloc(&pdev->dev, MAX7360_NUM_PWMS,
+				  sizeof(*max7360_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->ops = &max7360_pwm_ops;
+
+	max7360_pwm = to_max7360_pwm(chip);
+	max7360_pwm->dev = &pdev->dev;
+
+	max7360_pwm->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!max7360_pwm->regmap) {
+		dev_err(&pdev->dev, "could not get parent regmap\n");
+		return -ENODEV;
+	}
+
+	return devm_pwmchip_add(&pdev->dev, chip);
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id max7360_pwm_of_match[] = {
+	{ .compatible = "maxim,max7360-pwm", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max7360_pwm_of_match);
+#endif
+
+static struct platform_driver max7360_pwm_driver = {
+	.driver = {
+		.name = "max7360-pwm",
+		.of_match_table = of_match_ptr(max7360_pwm_of_match),
+	},
+	.probe = max7360_pwm_probe,
+};
+module_platform_driver(max7360_pwm_driver);
+
+MODULE_DESCRIPTION("MAX7360 PWM driver");
+MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
+MODULE_ALIAS("platform:max7360-pwm");
+MODULE_LICENSE("GPL");

-- 
2.39.5


