Return-Path: <linux-pwm+bounces-5405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC2DA82976
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 17:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D90A1C00882
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Apr 2025 15:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7493268C6F;
	Wed,  9 Apr 2025 14:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pwHUjeTv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153D267734;
	Wed,  9 Apr 2025 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210609; cv=none; b=loP8JwYTe2NlFeGbyWwXNFvXGJi2zhSJRm0SDv9Huwm4VCg3AiNmLacE7avccLoVAQewMrKpfrZZzdJm6Vxp3OCruvfV4wHg/pgZX5xDjr1sq8yyPLxVwesG8l4laRdsExA9VKPXACR3yWsC+v+6NAjUeDKOHuy4uoYgjYMxD6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210609; c=relaxed/simple;
	bh=v4M5RqN4jh/rfF3SqZZtVesuUi+EattJDTE38f2JPzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mCeQyLWclxzrtG42SWFktPy1Zet2ysRbaSMvypSojBSBR+ZWYM4SnWEikqx4GxVraFPtEJwsmiAH7KfS8ka6ieI5Li2yFYDF8ksSIG4FRv1oNSJOeaAqcc50CupNXec4QSXuG+ake46IfH3WlJENoqhUljz0ggjHEgKSSz3GjEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pwHUjeTv; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54C052057D;
	Wed,  9 Apr 2025 14:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744210605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9KDj6aCw5uztdYHUAun2AXsc2PRX7JSjl8/13fkmtU=;
	b=pwHUjeTvg4CkowTDn6FaD80z9Gh0WtlzQf/iNcuSOzrj8XSRLa2vZnoN8gC2gUUjwmhgDV
	BXOhgTAJ/lsF82U92rJ7FIzLKN6ksKZuE1E7y2Qlg6EAvq31hBPZ8W34uqBXwpIKT8JzUL
	15rJ/nPTWeeQ4wEb1cGg/jVM9LbcYXVnhCOMJev3OBWH6iwH1V+H0f5igLZ1xg/G6+T5Kh
	oW57+TecmkrKsfkxtrSm/LdUlvm2KWHo27NRh9xBNpA9xDfydxWF2oi8DIDIGDNNmyq/Ry
	1yTrdvjjpAT5D+esLh+hylCZFyV52pL93HF7usvF+5wM5c/PyBvPGP0L/9T7zw==
From: mathieu.dubois-briand@bootlin.com
Date: Wed, 09 Apr 2025 16:55:51 +0200
Subject: [PATCH v6 04/12] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-mdb-max7360-support-v6-4-7a2535876e39@bootlin.com>
References: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
In-Reply-To: <20250409-mdb-max7360-support-v6-0-7a2535876e39@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744210599; l=7230;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=sPO/KhQ+wiqRt14TAgbUVmmxAFPY32GLSfL/yPGbiv0=;
 b=DDMy0Y+amL2YZowgqeoct1GtcFR5+++5YHZKiGjVBnWQJMLvxKrX9D7BH/KBzi36K/0Z7MX/E
 /93PCoDtK9IBsjD2hzX2xCsxl0LXriKcjDhbkaygTE6E/HmgiX/QnGK
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtdeivdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhenucggtffrrghtthgvrhhnpeevheffteettefffeetvdelledttddthfevhffgleehfedvveduudfhhedugfelgeenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehthhhomhgrshdrphgvthgriiiiohhnihessghoohhtlhhinhdrtghomhdprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhhoohhnihgvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigq
 dhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhgphhiohesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguvghvihgtvghtrhgvvgesvhhgvghrrdhkvghrnhgvlhdrohhrgh
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
 drivers/pwm/pwm-max7360.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 4731d5b90d7e..0b22141cbf85 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -755,4 +755,14 @@ config PWM_XILINX
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
index 539e0def3f82..9c7701d8070b 100644
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
index 000000000000..e68a5a0c69e6
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,190 @@
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
+	int ret;
+
+	regmap = pwmchip_get_drvdata(chip);
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
+	val = wfhw->enabled ? BIT(pwm->hwpwm) : 0;
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
+		if (!ret)
+			wfhw->duty_steps = val;
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
+	regmap = dev_get_regmap(dev->parent, NULL);
+	if (!regmap)
+		return dev_err_probe(dev, -ENODEV, "could not get parent regmap\n");
+
+	device_set_of_node_from_dev(dev, dev->parent);
+	chip = devm_pwmchip_alloc(dev, MAX7360_NUM_PWMS, 0);
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	chip->ops = &max7360_pwm_ops;
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


