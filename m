Return-Path: <linux-pwm+bounces-6865-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8BAB0E1B6
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 18:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37C9216B0D3
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Jul 2025 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A0627E7DA;
	Tue, 22 Jul 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EhmMYKje"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7901627AC5C;
	Tue, 22 Jul 2025 16:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753201451; cv=none; b=L7UzXp/zuwNszLgePaSJiaZDgTZYsO2VkZLHB2cB+VT0Wq3n8Rz+QiXkd5+PeLHZYf/95svmy3E9h2vxk6u0P6yaUPH3jHLivYMBWzsg4CODkBiYHmQCgDulchyOrhzhbE9u3zUfy1K2DRq0Bqv1qkkH0LnA7OtCOeReWTucK6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753201451; c=relaxed/simple;
	bh=B59nQRM4OCJKfHLvX2oaTSXwxhw78E4Kff9lIuci+5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFmSPy/rl47mIC/qxVR5MEAfkFL74twpQhOU/D3yD7TXZY9o7Tulf5jBnKYiCSx/4Vwj7W4GJ0d7jloaTS2xjKb8Z1rJNbz81+KXLI1oeqSZR8UL4qOkorq1vlOKLpTr4WjTKj1gMLAXpOqWtLEXoBvWpu5oL/dEVg3PLp8wG7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EhmMYKje; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C671143292;
	Tue, 22 Jul 2025 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1753201446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jBMjx8v8dFWA7l8aFxli1l7Noq+zfsEDhaB6354aIiA=;
	b=EhmMYKjewtnzADA/n669HNXzXjchAWoMbQ3fmwjxZh/Qb5eAn9gb9ZfR4ENWrTzRYnga9g
	8ER+PC1LognSafR8gnseRt19YTmuT0etUdOiM29SDiB+wRFpp7qxQw5+xUjFgNQ21X9LYQ
	9h1ZqrAAQpBPmYIBtE11Jc/TJkXgzunMQpYzWauvPQaF0eBL05RBqHaMKEZikweq2a2D5U
	r9AiMueNnndFfmc5/XXakg1bEblhdLyNRNFXI+pGlbP2tO7I3zgoG496khL9I9E8al00Zx
	hPB/BkBCHFhLRKDId5ZH4gwaDujuDP2PjpfK1K1e+bNIU9dRYQkMwy+gUaNJjw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Tue, 22 Jul 2025 18:23:48 +0200
Subject: [PATCH v12 04/10] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-mdb-max7360-support-v12-4-3747721a8d02@bootlin.com>
References: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
In-Reply-To: <20250722-mdb-max7360-support-v12-0-3747721a8d02@bootlin.com>
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
 Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753201440; l=8231;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=y0xadsyuEhq8dPG/0EBjvPHdE0OxVl29OXK2WOiCV8k=;
 b=JQwQEEBbQHmCgl9N0lSZ0OQR0pjRiV2PH2Z37gZBLyVCekKRj0RG3mgUxyRD09eaI+kofUZgQ
 FVEqJBx/j2TB/V3nGupML4Vc4rVAr/kxU4QopBjIQRWsWoqjFP751Ds
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejheefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeforghthhhivghuucffuhgsohhishdquehrihgrnhguuceomhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjeeliefghefhvdekgeeuveehieejteetudejieethefhvdeghffgtefhkeeukeetnecuffhomhgrihhnpegrnhgrlhhoghdrtghomhenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvgedprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhor
 hhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkohesihhnthgvlhdrtghomhdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
8 independent PWM outputs.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pwm/Kconfig       |  10 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-max7360.c | 206 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 217 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index d9bcd1e8413e..c8352e503e3b 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -423,6 +423,16 @@ config PWM_LPSS_PLATFORM
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-lpss-platform.
 
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
 config PWM_MC33XS2410
 	tristate "MC33XS2410 PWM support"
 	depends on OF
diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
index 96160f4257fc..7e30f30bec50 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MAX7360)	+= pwm-max7360.o
 obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
new file mode 100644
index 000000000000..e3743c8dd20f
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
+ *
+ * Author: Kamel BOUHARA <kamel.bouhara@bootlin.com>
+ * Author: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
+ *
+ * PWM functionality of the MAX7360 multi-function device.
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/MAX7360.pdf
+ *
+ * Limitations:
+ * - Only supports normal polarity.
+ * - The period is fixed to 2 ms.
+ * - Only the duty cycle can be changed, new values are applied at the beginning
+ *   of the next cycle.
+ * - When disabled, the output is put in Hi-Z immediately.
+ */
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/err.h>
+#include <linux/math64.h>
+#include <linux/mfd/max7360.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/time.h>
+#include <linux/types.h>
+
+#define MAX7360_NUM_PWMS			8
+#define MAX7360_PWM_MAX				255
+#define MAX7360_PWM_STEPS			256
+#define MAX7360_PWM_PERIOD_NS			(2 * NSEC_PER_MSEC)
+
+struct max7360_pwm_waveform {
+	u8 duty_steps;
+	bool enabled;
+};
+
+static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+
+	/*
+	 * Make sure we use the individual PWM configuration register and not
+	 * the global one.
+	 * We never need to use the global one, so there is no need to revert
+	 * that in the .free() callback.
+	 */
+	return regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
+				 MAX7360_PORT_CFG_COMMON_PWM, 0);
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
+	 * we only support fixed period of MAX7360_PWM_PERIOD_NS and offset of 0.
+	 * Values from 0 to 254 as duty_steps will provide duty cycles of 0/256
+	 * to 254/256, while value 255 will provide a duty cycle of 100%.
+	 */
+	if (wf->duty_length_ns >= MAX7360_PWM_PERIOD_NS) {
+		duty_steps = MAX7360_PWM_MAX;
+	} else {
+		duty_steps = (u32)wf->duty_length_ns * MAX7360_PWM_STEPS / MAX7360_PWM_PERIOD_NS;
+		if (duty_steps == MAX7360_PWM_MAX)
+			duty_steps = MAX7360_PWM_MAX - 1;
+	}
+
+	wfhw->duty_steps = min(MAX7360_PWM_MAX, duty_steps);
+	wfhw->enabled = !!wf->period_length_ns;
+
+	return 0;
+}
+
+static int max7360_pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					     const void *_wfhw, struct pwm_waveform *wf)
+{
+	const struct max7360_pwm_waveform *wfhw = _wfhw;
+
+	wf->period_length_ns = wfhw->enabled ? MAX7360_PWM_PERIOD_NS : 0;
+	wf->duty_offset_ns = 0;
+
+	if (wfhw->enabled) {
+		if (wfhw->duty_steps == MAX7360_PWM_MAX)
+			wf->duty_length_ns = MAX7360_PWM_PERIOD_NS;
+		else
+			wf->duty_length_ns = DIV_ROUND_UP(wfhw->duty_steps * MAX7360_PWM_PERIOD_NS,
+							  MAX7360_PWM_STEPS);
+	} else {
+		wf->duty_length_ns = 0;
+	}
+
+	return 0;
+}
+
+static int max7360_pwm_write_waveform(struct pwm_chip *chip,
+				      struct pwm_device *pwm,
+				      const void *_wfhw)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	const struct max7360_pwm_waveform *wfhw = _wfhw;
+	unsigned int val;
+	int ret;
+
+	if (wfhw->enabled) {
+		ret = regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_steps);
+		if (ret)
+			return ret;
+	}
+
+	val = wfhw->enabled ? BIT(pwm->hwpwm) : 0;
+	return regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm), val);
+}
+
+static int max7360_pwm_read_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     void *_wfhw)
+{
+	struct regmap *regmap = pwmchip_get_drvdata(chip);
+	struct max7360_pwm_waveform *wfhw = _wfhw;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
+	if (ret)
+		return ret;
+
+	if (val & BIT(pwm->hwpwm)) {
+		wfhw->enabled = true;
+		ret = regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
+		if (ret)
+			return ret;
+
+		wfhw->duty_steps = val;
+	} else {
+		wfhw->enabled = false;
+		wfhw->duty_steps = 0;
+	}
+
+	return 0;
+}
+
+static const struct pwm_ops max7360_pwm_ops = {
+	.request = max7360_pwm_request,
+	.round_waveform_tohw = max7360_pwm_round_waveform_tohw,
+	.round_waveform_fromhw = max7360_pwm_round_waveform_fromhw,
+	.read_waveform = max7360_pwm_read_waveform,
+	.write_waveform = max7360_pwm_write_waveform,
+};
+
+static int max7360_pwm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct regmap *regmap;
+	int ret;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "Could not get parent regmap\n");
+
+	/*
+	 * This MFD sub-device does not have any associated device tree node:
+	 * properties are stored in the device node of the parent (MFD) device
+	 * and this same node is used in phandles of client devices.
+	 * Reuse this device tree node here, as otherwise the PWM subsystem
+	 * would be confused by this topology.
+	 */
+	device_set_of_node_from_dev(dev, dev->parent);
+
+	chip = devm_pwmchip_alloc(dev, MAX7360_NUM_PWMS, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->ops = &max7360_pwm_ops;
+
+	pwmchip_set_drvdata(chip, regmap);
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add PWM chip\n");
+
+	return 0;
+}
+
+static struct platform_driver max7360_pwm_driver = {
+	.driver = {
+		.name = "max7360-pwm",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
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


