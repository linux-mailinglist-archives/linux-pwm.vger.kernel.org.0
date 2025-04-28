Return-Path: <linux-pwm+bounces-5736-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDBA9EFE2
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 13:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AAD47A6DD0
	for <lists+linux-pwm@lfdr.de>; Mon, 28 Apr 2025 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2995266B62;
	Mon, 28 Apr 2025 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BuHcLSfP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F45263F52;
	Mon, 28 Apr 2025 11:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745841468; cv=none; b=BjvkQ6jBKGZDLJUYNciDIJH56bCHJHnBjFrx3BefzFE6dMG3S/yjhB2rGM+Vh9Cuu/Py0NdbwYKsYS1thxJsfRkmb5fa271pGM1CsqON55m9arLLqaUGTZK96CyGZuHJAHY8WCK+u8rGw+7BppLYo+oyGUBOomDu3jMXHE6MVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745841468; c=relaxed/simple;
	bh=u5pnB7cadfBX4H5bU1b/z5pLKJ2gfPHq+HKfI5WbCcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XpsHNGDalx7zPLMIMhmeZFBGguKhjj93nyRSChTl899tf3hyUN5kOxSE+JrAwuCMDxOZVvL4mcg9t7k0JitL7xG02tRbwsdmk917lEPGDEUHvoaOrMagz3Gite8JAnQZaCDNvSQhlNeuZ8RNWGRMlQ1XOcBvX7GTLAbC0/dutf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BuHcLSfP; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13D0643A12;
	Mon, 28 Apr 2025 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1745841463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=abVVd9von3uIh9L0cX5lRwU+BSIW5JOFHdHbk5he66k=;
	b=BuHcLSfPYIfUIDJTw957zM7LQIgS/8Otz6QFWZlu+Pw85e0Cvu8St71sz9kJHAwQ8LmVwo
	ZeAni7YXQHTZD3QbowFeKF435zTE3kmnmStakgAvGAJivNsrMVbpuCPJEZki3gCXEuBQsL
	EppLF9X6A7JjfC+7CnrRexA5kihUq9rpn0wm2QLljFYICXMdnVbRXFn66Wlw7KuqjCeID7
	OsutQ+mobbahFlUj9Pi86cyyXfDHcFPvFx8AmRhVQN02Je2A3hxfaKmgXJGxd5nRPdrFeO
	tvgXSIqZZGSPHum33ooSjVYsBAf3tyHeaz0LTIHvw/BaLOTZFh3ZFHgQEeXjyQ==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Mon, 28 Apr 2025 13:57:24 +0200
Subject: [PATCH v7 06/11] gpio: regmap: Allow to allocate regmap-irq device
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-mdb-max7360-support-v7-6-4e0608d0a7ff@bootlin.com>
References: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
In-Reply-To: <20250428-mdb-max7360-support-v7-0-4e0608d0a7ff@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745841456; l=3984;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=u5pnB7cadfBX4H5bU1b/z5pLKJ2gfPHq+HKfI5WbCcc=;
 b=lgu+AwtqON1Wo2TD695i9hfhdm9w4WAhJv48UR8FV4FCjoPZgU4Te9yCGy+nPa9PGJCIlJotH
 cGcbWT2gAdzDIfVwGNsyJwo+OFqSa7O1MMOCscY1GDBUvweBdYet2l0
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedtkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopehlvggvsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehukhhlvghinhgvkheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggvvhhitggvthhrvggvsehvghgvrhdrk
 hgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhorhihrdgtlhgvmhgvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepughmihhtrhihrdhtohhrohhkhhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhhsrdifrghllhgvihhjsehlihhnrghrohdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

GPIO controller often have support for IRQ: allow to easily allocate
both gpio-regmap and regmap-irq in one operation.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/base/regmap/regmap-irq.c |  5 +++--
 drivers/gpio/gpio-regmap.c       | 21 +++++++++++++++++++--
 include/linux/gpio/regmap.h      | 11 +++++++++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index c1b0dcd7280f..707b8692fb34 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -6,12 +6,12 @@
 //
 // Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
 
-#include <linux/array_size.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/overflow.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -911,7 +911,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 		if (ret < 0)
 			goto err_alloc;
 
-		memcpy(d->prev_status_buf, d->status_buf, array_size(d->prev_status_buf));
+		memcpy(d->prev_status_buf, d->status_buf,
+		       array_size(d->chip->num_regs, sizeof(d->prev_status_buf[0])));
 	}
 
 	ret = regmap_irq_create_domain(fwnode, irq_base, chip, d);
diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 87c4225784cf..9cbbbaf82609 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -215,6 +215,7 @@ EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
  */
 struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config)
 {
+	struct irq_domain *irq_domain;
 	struct gpio_regmap *gpio;
 	struct gpio_chip *chip;
 	int ret;
@@ -295,8 +296,24 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (ret < 0)
 		goto err_free_gpio;
 
-	if (config->irq_domain) {
-		ret = gpiochip_irqchip_add_domain(chip, config->irq_domain);
+#ifdef CONFIG_REGMAP_IRQ
+	if (config->regmap_irq_chip) {
+		struct regmap_irq_chip_data *irq_chip_data;
+
+		ret = devm_regmap_add_irq_chip_fwnode(config->parent, dev_fwnode(config->parent),
+						      config->regmap, config->regmap_irq_line,
+						      config->regmap_irq_flags, 0,
+						      config->regmap_irq_chip, &irq_chip_data);
+		if (ret)
+			goto err_free_gpio;
+
+		irq_domain = regmap_irq_get_domain(irq_chip_data);
+	} else
+#endif
+	irq_domain = config->irq_domain;
+
+	if (irq_domain) {
+		ret = gpiochip_irqchip_add_domain(chip, irq_domain);
 		if (ret)
 			goto err_remove_gpiochip;
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


