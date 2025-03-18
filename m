Return-Path: <linux-pwm+bounces-5222-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 776A7A67984
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 17:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BE701B601AC
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Mar 2025 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED55211A00;
	Tue, 18 Mar 2025 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="L+Qjx/Re"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154862101B7;
	Tue, 18 Mar 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315215; cv=none; b=mIClhC3ESRbTxgrP4ZQ7btMnAF63fDsvN0vkugMQ2sujkN5rTEIh2WCCwhkIiojKBkXGrNnwBXbJPTfOP67KHPs+0F8zLQt+W+j78wNauNK7Pdzxfb0jiRosAhnXoDAs2Hqa6YMEr/dV7afOttBk98/HemR1VFF1evavWEDaoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315215; c=relaxed/simple;
	bh=1aZ5SeL9dmlcV83w3pXE14jysIrgWamw7qIHSqoiucY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hfJKeC4XNHHCfLRQyDS4xrlFnkhMWuWv6gWU+dhmyE5EtBMKd9gIdzoMBr1PjP+78d3PKk3QT6l5IeDPrq8YHqDVd8tPGgisBdBdG1xjy3uVIBYLRsa6HYWB20Loq4uLA2NEyZYGW/jX/X6zoG7/xnnQwv7NjT+Ut84pAP6aUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=L+Qjx/Re; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6DE80442A0;
	Tue, 18 Mar 2025 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742315210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=br4WDuBqbSkQwrK6ODtn1sR/0+hHrz4k1ltJdUKep70=;
	b=L+Qjx/RefoM5SIh9BqdwB7u6wf3KRIxIpt8Wzmwg1rqU+Q0A4USnQp+p+YHgxySBAD1Ynq
	WKyoWrF/HSG/erqeSqPeXA+jmLpUZ2P8vYNKFRYr7hObdfUUcnNvdXqYD89FtqM2OR6QYd
	bT3rXE86S+1XXXiGtDSLs+ekBVI/eSdNsJ08mvAIFRGeKjZCgkjpdMlrRJ8IPwFZQ/a5ql
	CBdrIJ6Y8LaQWmJEB9TSy0exdqHygEF0IsCgvt79Jfd0VhU4XSzHaXFY4sz8O40nDhHjOX
	0KE3qUr4+T8MMthKMe7Qeib1V20Zp/aWKi7En4dc+bFn4HDBFG7VqNwrumFYxg==
From: mathieu.dubois-briand@bootlin.com
Date: Tue, 18 Mar 2025 17:26:20 +0100
Subject: [PATCH v5 04/11] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-mdb-max7360-support-v5-4-fb20baf97da0@bootlin.com>
References: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
In-Reply-To: <20250318-mdb-max7360-support-v5-0-fb20baf97da0@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742315204; l=7349;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=3RTRIQmYtvDWRlHfagCEXEb+TegKR8ZL/FprwHOKB0M=;
 b=JJnUyl/fcO0OpvZ8JupJ/okKobhjgjqQ2AT9qi2OktiTpSWjl125m5E4R3B4SawvYlEsdqMZ5
 rNMDqNchGk+A4k23P93fHDdayNLFEn+NWaFHceCbdn+rWV6BYxUsy/D
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvledvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhenucggtffrrghtthgvrhhnpeevheffteettefffeetvdelledttddthfevhffgleehfedvveduudfhhedugfelgeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrrghfrggvlheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrthhhihgvu
 hdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrmhgvlhdrsghouhhhrghrrgessghoohhtlhhinhdrtghomhdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehmfigrlhhlvgeskhgvrhhnvghlrdhorhhg
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

From: Kamel Bouhara <kamel.bouhara@bootlin.com>

Add driver for Maxim Integrated MAX7360 PWM controller, supporting up to
8 independent PWM outputs.

Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
Co-developed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/pwm/Kconfig       |  11 +++
 drivers/pwm/Makefile      |   1 +
 drivers/pwm/pwm-max7360.c | 194 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 206 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 0915c1e7df16..930cc7c61b82 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -745,4 +745,15 @@ config PWM_XILINX
 	  To compile this driver as a module, choose M here: the module
 	  will be called pwm-xilinx.
 
+config PWM_MAX7360
+	tristate "MAX7360 PWMs"
+	depends on MFD_MAX7360
+	select PINCTRL_MAX7360
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
index 000000000000..059b39df791d
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Bootlin
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
+#define MAX7360_PWM_MAX_RES			255
+#define MAX7360_PWM_PERIOD_NS			(2 * NSEC_PER_MSEC)
+
+struct max7360_pwm_waveform {
+	u8 duty_steps;
+	bool enabled;
+};
+
+static int max7360_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct regmap *regmap;
+	struct device *dev;
+	int ret;
+
+	regmap = pwmchip_get_drvdata(chip);
+	dev = regmap_get_device(regmap);
+
+	ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(pwm->hwpwm),
+				MAX7360_PORT_CFG_COMMON_PWM, 0);
+	if (ret)
+		return ret;
+
+	return regmap_write_bits(regmap, MAX7360_REG_PORTS, BIT(pwm->hwpwm), BIT(pwm->hwpwm));
+}
+
+static void max7360_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
+{
+	struct regmap *regmap;
+	struct device *dev;
+
+	regmap = pwmchip_get_drvdata(chip);
+	dev = regmap_get_device(regmap);
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
+	 */
+	duty_steps = mul_u64_u64_div_u64(wf->duty_length_ns, MAX7360_PWM_MAX_RES,
+					 MAX7360_PWM_PERIOD_NS);
+
+	wfhw->duty_steps = min(MAX7360_PWM_MAX_RES, duty_steps);
+	wfhw->enabled = (wf->duty_length_ns != 0);
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
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	regmap = pwmchip_get_drvdata(chip);
+	val = (wfhw->enabled) ? BIT(pwm->hwpwm) : 0;
+	ret = regmap_write_bits(regmap, MAX7360_REG_GPIOCTRL, BIT(pwm->hwpwm), val);
+	if (ret)
+		return ret;
+
+	if (wfhw->duty_steps)
+		return regmap_write(regmap, MAX7360_REG_PWM(pwm->hwpwm), wfhw->duty_steps);
+
+	return 0;
+}
+
+static int max7360_pwm_read_waveform(struct pwm_chip *chip,
+				     struct pwm_device *pwm,
+				     void *_wfhw)
+{
+	struct max7360_pwm_waveform *wfhw = _wfhw;
+	struct regmap *regmap;
+	unsigned int val;
+	int ret;
+
+	regmap = pwmchip_get_drvdata(chip);
+
+	ret = regmap_read(regmap, MAX7360_REG_GPIOCTRL, &val);
+	if (ret)
+		return ret;
+
+	if (val & BIT(pwm->hwpwm)) {
+		wfhw->enabled = true;
+		ret = regmap_read(regmap, MAX7360_REG_PWM(pwm->hwpwm), &val);
+		wfhw->duty_steps = val;
+	} else {
+		wfhw->enabled = false;
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
+	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
+	struct regmap *regmap;
+	int ret;
+
+	if (!dev->parent)
+		return dev_err_probe(dev, -ENODEV, "no parent device\n");
+
+	chip = devm_pwmchip_alloc(dev->parent, MAX7360_NUM_PWMS, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->ops = &max7360_pwm_ops;
+
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
+
+	pwmchip_set_drvdata(chip, regmap);
+
+	ret = devm_pwmchip_add(dev, chip);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to add PWM chip\n");
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


