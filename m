Return-Path: <linux-pwm+bounces-7156-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9673B32FC1
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 13:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9F2447F44
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Aug 2025 11:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A4E72DA74A;
	Sun, 24 Aug 2025 11:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Um4AWP+l"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900A2D9EDB;
	Sun, 24 Aug 2025 11:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756036693; cv=none; b=h+mdt/8isbPyKbYyN8poNaluYj8mgGTVp9QZH8FQTSF97Nsy5AGKmexy9xYZg21gpT8AovvMkvlyZC4t3XjcWbpGS1XiMHoHaNN4iRzml4y5zSeLuKcEp6mtWToOdKr+uYC+MSSfCgFoJqgWUS6OZaFMqddXEDY2wLWSpexb088=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756036693; c=relaxed/simple;
	bh=GI6EEwiaCxoQ0CfeJpmOMrDgX7dL9Npnw2htYukp1Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=He3BNjcz8okv5neh3yJdmYXUKujJEcviBP8/miiiBexFy8AaglREZRXSVvCobzNX7OgVa2WOEvVfz4thX3mtls0BL0qwaq6NadJtBrShV+6AKeClLZoZF+GL5RbVtxmcFOnhAx8c7v9Wg/xxHi4+avZIl789SWZvSKy7fS8jUpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Um4AWP+l; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 970CE4E40C35;
	Sun, 24 Aug 2025 11:58:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 707D1605F1;
	Sun, 24 Aug 2025 11:58:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B39791C22D16F;
	Sun, 24 Aug 2025 13:58:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756036689; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=c8ATT8p3q1I3R9dnhjH56Ixk6yh3ilCPWov9z+gTEbs=;
	b=Um4AWP+lgF1jcf01TYP7IQGw4SFjyD5DFqJ3yi3msEK2DPVN0Xo5H5lP8blWBzN9vLgW8R
	h8kgqMn/Oq53LW3maLeZCY3XGp57xtQJE+hPoz6nwvZ7JRCBOcGR59dcqdnellNKAJGl5l
	9tKTiQukejluZyP07MFC+/3fqMPFv2AjhDXpXnZl9da6U0YFWPubtyejc+gkySlj/Sxvee
	RWOVkvIBjk2OpqpOm2aNsCO8qlICxmUg0H5bNDcdL5vJc6acXGbt+2mr0/ebpa3Zd6cuyg
	M8ChpbUnnfqAhGZZjECGaxd/BsL2AyQE6NZnb1A0MExBpYi5EkF02AwkzoCZEw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Sun, 24 Aug 2025 13:57:24 +0200
Subject: [PATCH v14 05/10] gpio: regmap: Allow to allocate regmap-irq
 device
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-mdb-max7360-support-v14-5-435cfda2b1ea@bootlin.com>
References: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
In-Reply-To: <20250824-mdb-max7360-support-v14-0-435cfda2b1ea@bootlin.com>
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756036647; l=3757;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=GI6EEwiaCxoQ0CfeJpmOMrDgX7dL9Npnw2htYukp1Qg=;
 b=eHDE4omwUZBMrONS/MUtmHeFrT2CrXf9rliSGF6Wk8MrhqWLK4Xlh+l8sJDd0gchvJ64cy1ND
 /N6ZsNrQJDgAMfWXHqi5LchhlPUmQac3G61fpQP8uQu7JcjZ7g3Nwro
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-Last-TLS-Session-Version: TLSv1.3

GPIO controller often have support for IRQ: allow to easily allocate
both gpio-regmap and regmap-irq in one operation.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/gpio/gpio-regmap.c  | 29 +++++++++++++++++++++++++++--
 include/linux/gpio/regmap.h | 11 +++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index e8a32dfebdcb..e1944931ee7c 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -32,6 +32,11 @@ struct gpio_regmap {
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
 
+#ifdef CONFIG_REGMAP_IRQ
+	int regmap_irq_line;
+	struct regmap_irq_chip_data *irq_chip_data;
+#endif
+
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);
@@ -215,6 +220,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
  */
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
 {
+	struct irq_domain *irq_domain;
 	struct gpio_regmap *gpio;
 	struct gpio_chip *chip;
 	int ret;
@@ -295,8 +301,22 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (ret < 0)
 		goto err_free_gpio;
 
-	if (config->irq_domain) {
-		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);
+#ifdef CONFIG_REGMAP_IRQ
+	if (config->regmap_irq_chip) {
+		gpio->regmap_irq_line = config->regmap_irq_line;
+		ret = regmap_add_irq_chip_fwnode(dev_fwnode(config->parent), config->regmap,
+						 config->regmap_irq_line, config->regmap_irq_flags,
+						 0, config->regmap_irq_chip, &gpio->irq_chip_data);
+		if (ret)
+			goto err_free_gpio;
+
+		irq_domain = regmap_irq_get_domain(gpio->irq_chip_data);
+	} else
+#endif
+	irq_domain = config->irq_domain;
+
+	if (irq_domain) {
+		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
 		if (ret)
 			goto err_remove_gpiochip;
 	}
@@ -317,6 +337,11 @@ EXPORT_SYMBOL_GPL(gpio_regmap_register);
  */
 void gpio_regmap_unregister(struct gpio_regmap *gpio)
 {
+#ifdef CONFIG_REGMAP_IRQ
+	if (gpio->irq_chip_data)
+		regmap_del_irq_chip(gpio->regmap_irq_line, gpio->irq_chip_data);
+#endif
+
 	gpiochip_remove(&gpio->gpio_chip);
 	kfree(gpio);
 }
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index c722c67668c6..19b52ac03a5d 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -40,6 +40,11 @@ struct regmap;
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
+ * @regmap_irq_chip:	(Optional) Pointer on an regmap_irq_chip structure. If
+ *			set, a regmap-irq device will be created and the IRQ
+ *			domain will be set accordingly.
+ * @regmap_irq_line	(Optional) The IRQ the device uses to signal interrupts.
+ * @regmap_irq_flags	(Optional) The IRQF_ flags to use for the interrupt.
  *
  * The ->reg_mask_xlate translates a given base address and GPIO offset to
  * register and mask pair. The base address is one of the given register
@@ -78,6 +83,12 @@ struct gpio_regmap_config {
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
 
+#ifdef CONFIG_REGMAP_IRQ
+	struct regmap_irq_chip *regmap_irq_chip;
+	int regmap_irq_line;
+	unsigned long regmap_irq_flags;
+#endif
+
 	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
 			      unsigned int offset, unsigned int *reg,
 			      unsigned int *mask);

-- 
2.39.5


