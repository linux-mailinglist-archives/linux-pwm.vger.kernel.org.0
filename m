Return-Path: <linux-pwm+bounces-4893-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D45A35D11
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 12:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9D0189592C
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 11:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439DD265CA2;
	Fri, 14 Feb 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kWwxQrjT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99B263F2C;
	Fri, 14 Feb 2025 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533825; cv=none; b=rEORddKVbdTDx93FcCQd1qca88Fvga+KMTcgvtZLk1QfTfkWlSZC+1ICS+lOGr9zuPK70RORmjmZ91ctTZP6HpKUNZab2bCDssZTpvWnxTEpQxA2A1VfGPtanb8WIkoPu5RsjJfjfm6+hZTzMmNCb7zmLNAnkdNIM2wzfc9D6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533825; c=relaxed/simple;
	bh=t/EuLZQlpOe/LmOn/GZ77df/7tGyTGkWiw9+9XzVGCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qGek3ueVCCqStY1ij5txNQBOcXrkCtLALIkx7hkV89n+JPJPXMuCOksQ+ULcqEIBD7qmjSLahOsihYu+Jwk8Zh2brHdgxUMSC6APxqZHN81pkwL7iT+gJMDmKEfDuPEDCBFf+Ub3UL9iQjxW17T4C1Et1GJk6Vhe8uaClDk2D0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kWwxQrjT; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E95D44299;
	Fri, 14 Feb 2025 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739533813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhAfL6p2Tu5CbkRFq/4tIEg0OmDK9rfhbiyVWYECfuM=;
	b=kWwxQrjTkeU8P8uyg2zVtlWcs1TVhdU1FzA5WaIufSWq1oVFDjdYAsE0apwQvraHqz5wts
	wbTxCfLkpH/oCKPmLftQH4yRpSQS7lWcF9SOxf8PhYLJMsqHtZQhpcyG41/PP8Cq0cu/V3
	d1vWzWu4oYDMv05AC4CMXb74VLUT6nSU99I66PIVD3vn9519T8HEUAw6M3gv1OCKIhZRQH
	4lD68av5+UOfMfQsqNYtcfS9pddcdIbgtjuj12sz7NHgkZH/00Z4CnpTatx6JCp9MMJd2W
	LKiOiRem58N2ks/fYQtNxgJ5XJnZwMWH5gLSfpKMQQthjVhPtcgXDz/WmMS+6Q==
From: mathieu.dubois-briand@bootlin.com
Date: Fri, 14 Feb 2025 12:49:53 +0100
Subject: [PATCH v4 03/10] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250214-mdb-max7360-support-v4-3-8a35c6dbb966@bootlin.com>
References: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
In-Reply-To: <20250214-mdb-max7360-support-v4-0-8a35c6dbb966@bootlin.com>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kamel Bouhara <kamel.bouhara@bootlin.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Walle <mwalle@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-pwm@vger.kernel.org, andriy.shevchenko@intel.com, 
 =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739533806; l=7974;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=CxMsleng0cZ3BeZymcuuErbxiPnn4kKb8ceRlh9SgXg=;
 b=Xf0beUWgYo9vw+zVjpW9nw5AzwSlbfq7WymEaxfdXlfS9/YO42oRReLTA62OxjSOzw36JU7W/
 4p9p03wKfBWAx2klJz8/khdfvwl4odUMreQ8DuokEv6yWBLflI5htJv
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegleehjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmnecuggftrfgrthhtvghrnhepveehffetteetffeftedvleeltddttdfhvefhgfelheefvdevudduhfehudfgleegnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdefpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepsghrghhlsegsghguvghvrdhplhdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
8 independent PWM outputs.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/pwm/Kconfig       |  10 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-max7360.c | 213 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 224 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..fac811ee46b5 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -745,4 +745,14 @@ config PWM_XILINX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-xilinx.
 
+config PWM_MAX7360
+	tristate "MAX7360 PWMs"
+	depends on MFD_MAX7360
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
index 000000000000..f1257c20add2
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ *
+ * Limitations:
+ * - Only supports normal polarity.
+ * - The period is fixed to 2 ms.
+ * - Only the duty cycle can be changed, new values are applied at the beginning
+ *   of the next cycle.
+ * - When disabled, the output is put in Hi-Z.
+ */
+#include <linux/err.h>
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
+#define MAX7360_PWM_MAX_RES			255
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
+struct max7360_pwm_waveform {
+	u8 duty_steps;
+};
+
+static inline struct max7360_pwm *max7360_pwm_from_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
+
+static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct max7360_pwm *max7360_pwm;
+	int ret;
+
+	max7360_pwm = max7360_pwm_from_chip(chip);
+	ret = max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm, true);
+	if (ret) {
+		dev_warn(&chip->dev, "failed to request pwm-%d\n", pwm->hwpwm);
+		return ret;
+	}
+
+	ret = regmap_write_bits(max7360_pwm->regmap,
+				MAX7360_REG_PWMCFG(pwm->hwpwm),
+				MAX7360_PWM_COMMON_PWN,
+				0);
+	if (ret)
+		return ret;
+
+	return regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_PORTS,
+				 MAX7360_PWM_PORT(pwm->hwpwm),
+				 MAX7360_PWM_PORT(pwm->hwpwm));
+}
+
+static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct max7360_pwm *max7360_pwm;
+
+	max7360_pwm = max7360_pwm_from_chip(chip);
+	max7360_port_pin_request(max7360_pwm->parent, pwm->hwpwm, false);
+}
+
+static int max7360_pwm_round_waveform_tohw(struct pwm_chip *chip,
+					   struct pwm_device *pwm,
+					   const struct pwm_waveform *wf,
+					   void *_wfhw)
+{
+	struct max7360_pwm_waveform *wfhw = _wfhw;
+	u64 duty_steps;
+
+	/*
+	 * Ignore user provided values for period_length_ns and duty_offset_ns:
+	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of
+	 * 0.
+	 */
+
+	duty_steps = mul_u64_u64_div_u64(wf->duty_length_ns, MAX7360_PWM_MAX_RES,
+					 MAX7360_PWM_PERIOD_NS);
+
+	wfhw->duty_steps = min(MAX7360_PWM_MAX_RES, duty_steps);
+
+	return 0;
+}
+
+static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					     const void *_wfhw, struct pwm_waveform *wf)
+{
+	const struct max7360_pwm_waveform *wfhw = _wfhw;
+
+	wf->period_length_ns = MAX7360_PWM_PERIOD_NS;
+	wf->duty_offset_ns = 0;
+	wf->duty_length_ns = DIV64_U64_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIOD_NS,
+						MAX7360_PWM_MAX_RES);
+
+	return 0;
+}
+
+static int max7360_pwm_write_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      const void *_wfhw)
+{
+	const struct max7360_pwm_waveform *wfhw = _wfhw;
+	struct max7360_pwm *max7360_pwm;
+	unsigned int val;
+	int ret;
+
+	max7360_pwm = max7360_pwm_from_chip(chip);
+
+	val = (wfhw->duty_steps == 0) ? 0 : MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm);
+	ret = regmap_write_bits(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL,
+				MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm), val);
+
+	if (!ret && wfhw->duty_steps != 0) {
+		ret = regmap_write(max7360_pwm->regmap, MAX7360_REG_PWM(pwm->hwpwm),
+				   wfhw->duty_steps);
+	}
+
+	return ret;
+}
+
+static int max7360_pwm_read_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     void *_wfhw)
+{
+	struct max7360_pwm_waveform *wfhw = _wfhw;
+	struct max7360_pwm *max7360_pwm;
+	unsigned int val;
+	int ret;
+
+	max7360_pwm = max7360_pwm_from_chip(chip);
+
+	ret = regmap_read(max7360_pwm->regmap, MAX7360_REG_GPIOCTRL, &val);
+	if (ret)
+		return ret;
+
+	if (val & MAX7360_PWM_CTRL_ENABLE(pwm->hwpwm)) {
+		ret = regmap_read(max7360_pwm->regmap, MAX7360_REG_PWM(pwm->hwpwm),
+				  &val);
+		val = wfhw->duty_steps;
+	} else {
+		wfhw->duty_steps = 0;
+	}
+
+	return ret;
+}
+
+static const struct pwm_ops max7360_pwm_ops = {
+	.request = max7360_pwm_request,
+	.free = max7360_pwm_free,
+	.round_waveform_tohw = max7360_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = max7360_pwm_round_waveform_fromhw,
+	.read_waveform = max7360_pwm_read_waveform,
+	.write_waveform = max7360_pwm_write_waveform,
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
+	max7360_pwm = max7360_pwm_from_chip(chip);
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
+		.name = "max7360-pwm",
+	},
+	.probe = max7360_pwm_probe,
+};
+module_platform_driver(max7360_pwm_driver);
+
+MODULE_DESCRIPTION("MAX7360 PWM driver");
+MODULE_AUTHOR("Kamel BOUHARA <kamel.bouhara@bootlin.com>");
+MODULE_AUTHOR("Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>");
+MODULE_LICENSE("GPL");

-- 
2.39.5


