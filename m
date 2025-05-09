Return-Path: <linux-pwm+bounces-5859-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A206EAB0E88
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 110B64E33FA
	for <lists+linux-pwm@lfdr.de>; Fri,  9 May 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 595ED27A462;
	Fri,  9 May 2025 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lo/802+h"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AD9277022;
	Fri,  9 May 2025 09:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782094; cv=none; b=TkfuM/FUsTlhasp+EQTAMd+sEhp5Z02N0M4QyCqgs4xa7THb6VyE4SVsFy2oyRsq+xVs74vLWEd4WRuS9O39mSicXKseZ7f2Y6b7xNbVOlnxcUvMAwLfM2yVdiVuLVMi7e+JvG014kiwaqfeZliRbZS2SuFd/8W0OUHok2ml6aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782094; c=relaxed/simple;
	bh=JA+/ABK+d6/PwBt/x/ghKSUpxzD2D+hC+RaedoxvwHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bzuUI0wmllnzA7FQIjutSrqw5GTdqt04yR5pQZ6hzyPqvyg4vdRwPOdBKFVu1voQiotmJ1C+ds12BRvCG0FlTdGkCWixv8oodE1wwsSSllCZ6kgphCR9bk8Px2WNJtifqdpvDGgO5SLjBjYanon8IvJ9zMwN0b4ChI4zbRKM6lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lo/802+h; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CCD2A1FCED;
	Fri,  9 May 2025 09:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1746782089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=62nCa38zlyHvu4+rkDbxxjv8Ggs3mpE6yRSfCXC476k=;
	b=Lo/802+hPpKxQrPsiMGsTJvl99ecVWGCrvxbrJA23owQWqrV+0BubroCVIQjQ3kxpxyUb5
	12VV5nWvirrhW7JekK9W5xF9IfTwmmm+rFaiOks8dhLvlylD89D/+BUBTlp5Ruec7PUEQw
	kVLojKFiQIvKAUkP6kMC29O7hnnS1uTPdVIVCad2oIr80VyowHXwnD7f2EBbq8J2lrnwo5
	B8xewAitb9stmXqTgO7BMiGQLYfDrCYjmz6Kb2PilHTkU+XqQDqNyp4l8b5NpeHoUq3itB
	V1q0AHFJF7ZgwjGuMZ/VafVK4suc7g4SDKM0PGDLj3zlHkv8xXLcHgU7gztdkw==
From: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Date: Fri, 09 May 2025 11:14:40 +0200
Subject: [PATCH v8 06/11] gpio: regmap: Allow to allocate regmap-irq device
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-mdb-max7360-support-v8-6-bbe486f6bcb7@bootlin.com>
References: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
In-Reply-To: <20250509-mdb-max7360-support-v8-0-bbe486f6bcb7@bootlin.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746782082; l=3825;
 i=mathieu.dubois-briand@bootlin.com; s=20241219; h=from:subject:message-id;
 bh=JA+/ABK+d6/PwBt/x/ghKSUpxzD2D+hC+RaedoxvwHA=;
 b=ZO693jZVTBUXqC/RK0pP4TV9hD5hPNk89Kr6NV6uGm1kwAyxwXsGUMDoozVMdMtMXO/dCK8ZM
 m6KdKVlrkqeBmPPAKkzSYfPwqtwQw3Z1KnNhB+tMXxio0xbM884SAEY
X-Developer-Key: i=mathieu.dubois-briand@bootlin.com; a=ed25519;
 pk=1PVTmzPXfKvDwcPUzG0aqdGoKZJA3b9s+3DqRlm0Lww=
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvvdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomhepofgrthhhihgvuhcuffhusghoihhsqdeurhhirghnugcuoehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedthfegtedvvdehjeeiheehheeuteejleektdefheehgfefgeelhfetgedttdfhteenucfkphepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeinecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehinhgvthepvdgrtddumegtsgdugeemheehieemjegrtddtmeeffhgtfhemfhgstdgumeduvdeivdemvdgvjeeipdhhvghloheplgduvdejrddtrddurddungdpmhgrihhlfhhrohhmpehmrghthhhivghurdguuhgsohhishdqsghrihgrnhgusegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvfedprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghthhhivghurdguuhgsohhishdqs
 ghrihgrnhgusegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhhinhhugidqphifmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhushdrfigrlhhlvghijheslhhinhgrrhhordhorhhgpdhrtghpthhtohepuhhklhgvihhnvghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-GND-Sasl: mathieu.dubois-briand@bootlin.com

GPIO controller often have support for IRQ: allow to easily allocate
both gpio-regmap and regmap-irq in one operation.

Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
---
 drivers/base/regmap/regmap-irq.c |  4 +++-
 drivers/gpio/gpio-regmap.c       | 21 +++++++++++++++++++--
 include/linux/gpio/regmap.h      | 11 +++++++++++
 3 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index c1b0dcd7280f..45299d29fd0b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
+#include <linux/overflow.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -911,7 +912,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
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


