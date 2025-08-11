Return-Path: <linux-pwm+bounces-6993-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA42B20635
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6315D16032F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 10:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1265527E077;
	Mon, 11 Aug 2025 10:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VzL+S+li"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CA274FE0;
	Mon, 11 Aug 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909227; cv=none; b=folu2E+xY0GT918egf5H2P8cbVls/v0JD2n2KfTdwRYH3JuhzJ8cV+WlNqkV7BMQ6PjS/FDMx+udFUJSzNTtc8ys+nw+XO/eKiE0YswBW/EHJzoRyDOEzn+zNpW0Qz6zkGloHwsCLOlrz31f16wIlcKq8xJnWajYlUbhpuhHy0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909227; c=relaxed/simple;
	bh=GI6EEwiaCxoQ0CfeJpmOMrDgX7dL9Npnw2htYukp1Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rb3i9h9S6uqYWYXk7K4OMg1oWSbcD8VDi3+llu30Qbb0/ju/x0MisGl66PXkJgDTIuI7gPfoncG9RKEv4oUYoVIhBhkG3KGnCPJrEC4jO9ZAB3xsES/jrdxp3vgaBD7VHMxwsXkgO2w525ZaSUXsFaEyv+iFHH8KJsbtivjaRJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VzL+S+li; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 78DAB438A0;
	Mon, 11 Aug 2025 10:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1754909216;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c8ATT8p3q1I3R9dnhjH56Ixk6yh3ilCPWov9z+gTEbs=;
	b=VzL+S+liK6OY7R9KrTdK0pYEpgb6dF/+1WX98t3m3PdDm36FRza5jbwPmYd3P6nz4kZsSp
	JzBFwacNKIu71JT1aD+S4r+1OjA00DatG25o9DqXTSimCN87iCfXwTbaSSe7INnmRe23Iy
	6fjrbi0GntviBAOqqORRyg+E0jrvyAxsS7sqYExytdnWS83vt5d8cSqzsekLM5F6DexmXC
	5mO2dhLotzoWPGXCOvJNW286V8iihj/0Ow7inS430UpaaL7pW5ZVi3sP4x0AJNagdbPt3j
	Ihot9iwWz8LUcFfDbHV6RfJylPShKvUsXSHlTn3N8cZoHp0UXs1upxwDVwoypg==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 11 Aug 2025 12:46:23 +0200
Subject: [PATCH v13 05/10] gpio: regmap: Allow to allocate regmap-irq
 device
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-mdb-max7360-support-v13-5-e79fcabff386@bootlin.com>
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
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754909209; l=3757;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=GI6EEwiaCxoQ0CfeJpmOMrDgX7dL9Npnw2htYukp1Qg=;
 b=ymcGGDletXKUOfdxo2uMtQBVrNJqwhCRqawcvnPwyZXUt1byOEgN92Ly7rsudTa3odQ8fgdDX
 CJp82+TQYWmDBjc7SNOX1pSl8BTok9tjJPjL0Jx4TJGtS8G+ZSP31AJ
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvvdehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvhedprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnughrihihrdhshhgvvhgthhgvnhhkoheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopehli
 hhnuhigqdhpfihmsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhinhhpuhhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepghhrvghgohhrhidrtghlvghmvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

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


