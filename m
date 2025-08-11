Return-Path: <linux-pwm+bounces-6992-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FAB20634
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 12:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AB977B057B
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 10:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E0B27E04B;
	Mon, 11 Aug 2025 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RnMKVMjM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED42580D1;
	Mon, 11 Aug 2025 10:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909227; cv=none; b=hocpi7GxU0Ix0xUN6mjkmMDgsmeOfOmaDxOK5leBBG9bLa7xcxw8kUsYWlRbdbQY6nILRaO4j9hrIjov85RQm4B4DdTy7xnwk64ORoNGB5hgUzjXXG9UAeiNMshSy7Q4nQAEVIgF6MKFeBrmsx7456ry2XkaT9igm7Xr6kytWts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909227; c=relaxed/simple;
	bh=m9GbVzpzMwU3kZF9RqH0tnfIkcNkSVMmghcWHCbaWb0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G4Eb/N0Ehi4ugLaI2mrepVLARyXO1eGCNHkDBgiPW1r+TuLyILhCctBZAtfWtTvJ3Cu36SHY7Ida/PFYHSUNYNeZEQsRKBpbgGTgdYyeIeExe+ZgLgPvOQgWY/HLuc43Npjd/lDBdLiiyEE8sIkb/7nOILWf5ypGUTK12w/HXJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RnMKVMjM; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 725B14389D;
	Mon, 11 Aug 2025 10:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754909215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BhF0rjoQDVNfMi55bWiCri+2Ue8pJhFBkEZi8tBqJcs=;
	b=RnMKVMjM6vs6S0SsWF688FdSfRNVigCsQA1Sgcis9PAepfrxYKkA5Wh/jETEW/ikmLd3Jx
	PvN15bwwY+6wbeHWycKevFN0BrN0KPX8UZkIWTHwg+G/rwjLBlxWyHvph9lpxDp4MfFwfN
	WFXvj9T847GkxhS2SLEcj9pLPS3KP4rU3y7KUpHi/M8UBj16X8jTsto0NUiU1ToVAPEf+D
	It0GvfMW6Wk/JOC7ywwVgQcmqbl15VO5sTPvxbf9W7G7vLVWZq5+RhVftGXAolSzGZHkKk
	5rN1ZEgRSm7vbRe/+KYEEUw0K5bHZgxocKoUIJM0dbM7fhhYJnzj55maicqylQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 11 Aug 2025 12:46:22 +0200
Subject: [PATCH v13 04/10] pwm: max7360: Add MAX7360 PWM support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-mdb-max7360-support-v13-4-e79fcabff386@bootlin.com>
References: <20250811-mdb-max7360-support-v13-0-e79fcabff386@bootlin.com>
In-Reply-To: <20250811-mdb-max7360-support-v13-0-e79fcabff386@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909209; l=8307;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=b+7YKpxbZjewh84DjMAWMlLpDmJpLxHzkw2AL+/nVTI=;
 b=EM/Kop7a56opJKdSL4qKPmTU1BB1DlqZrtWaNWmTtgItwEDw6Vil/HlX1raQAghc9F98mdx3O
 IRsm8eyzjMVBReZnL9KXOy1ibeiNMpXkY6cHeuD4ej9LWM5dQhOQFdu
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeejleeigfehhfdvkeegueevheeijeettedujeeiteehhfdvgefhgfethfekueekteenucffohhmrghinheprghnrghlohhgrdgtohhmnecukfhppedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudegmeehheeimeejrgdttdemfehftghfmehfsgdtugemuddviedvmedvvgejiedphhgvlhhopegluddvjedrtddruddrudgnpdhmrghilhhfrhhomhepmhgrthhhihgvuhdrughusghoihhsqdgsrhhirghnugessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvdegpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnhgurhhihidrshhhvghvtghhvghnkhhosehlihhnuhigr
 dhinhhtvghlrdgtohhmpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrghdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhm
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
 drivers/pwm/pwm-max7360.c | 209 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index f00ce973dddf..f2b1ce47de7f 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -432,6 +432,16 @@ config PWM_LPSS_PLATFORM
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
index ff4f47e5fb7a..dfa8b4966ee1 100644
--- a/drivers/pwm/Makefile
+++ b/drivers/pwm/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PWM_LPC32XX)	+= pwm-lpc32xx.o
 obj-$(CONFIG_PWM_LPSS)		+= pwm-lpss.o
 obj-$(CONFIG_PWM_LPSS_PCI)	+= pwm-lpss-pci.o
 obj-$(CONFIG_PWM_LPSS_PLATFORM)	+= pwm-lpss-platform.o
+obj-$(CONFIG_PWM_MAX7360)	+= pwm-max7360.o
 obj-$(CONFIG_PWM_MC33XS2410)	+= pwm-mc33xs2410.o
 obj-$(CONFIG_PWM_MEDIATEK)	+= pwm-mediatek.o
 obj-$(CONFIG_PWM_MESON)		+= pwm-meson.o
diff --git a/drivers/pwm/pwm-max7360.c b/drivers/pwm/pwm-max7360.c
new file mode 100644
index 000000000000..5a0c10d2320e
--- /dev/null
+++ b/drivers/pwm/pwm-max7360.c
@@ -0,0 +1,209 @@
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
+	if (wf->period_length_ns < MAX7360_PWM_PERIOD_NS)
+		return 1;
+	else
+		return 0;
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


