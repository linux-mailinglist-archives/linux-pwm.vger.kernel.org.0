Return-Path: <linux-pwm+bounces-5162-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7AA5F7A5
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 15:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A602119C3911
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Mar 2025 14:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BDD268FC7;
	Thu, 13 Mar 2025 14:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS0IlNwH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AA7268C4A;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741875559; cv=none; b=GYUxc8rLOs5SZ5uKLxAqNflU51CupmUCz3KrAHg9iI/yiAJOIgZhbaGoGAOLjaJKNVJM7bQMr+T3CsZVyk4z7wH8h8aYGDDVN7R6dHvQbMq0+ZzNaAPn6uJimzCF3supEmmlqQdQd4UM1QZcnSltOdiv/iBXw9bOAebAgf9eCqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741875559; c=relaxed/simple;
	bh=HEAWSjMeUzmTyL+OFTVxnVs/A4wI2T7AEfQ4ou+0IhU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j+hHut3J2NpJoezPBWSRM39SPjM93dqkiaw1eehQ7T1Chsm3+15a1aP2EiXv92wMuto/Pn3D1YduSD5P57E6NlGEbc97oJtwtrGJUgqYv3PoucFYDRhqvvbgieIrdlm3Bkl8hjDHYoNCQwPmdVt3WOuffsxiPfmJSvF+AVU+sl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS0IlNwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E83EC2BCB5;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741875558;
	bh=HEAWSjMeUzmTyL+OFTVxnVs/A4wI2T7AEfQ4ou+0IhU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XS0IlNwHtBWwZ3wGIKuZx5wIFI7Jbh7DXV62Uv0++BMAdoQWNwam9YXHGVjg/quip
	 X/AHZnlj6eJMCYx83h+g1EjfipUOyTEbjtfmN0M9pKa6CH4ARbyxRVy9+3ySSxaQgq
	 ACMdLODKUe79KxcNhVdUyN5FnMsk1J1wdzEuJVkkwXElZb2lWykWbKjteGjXC+J4IX
	 XCZtvdkszc51iJra4ZkTFFLD9TGt4Htgsg9Igol9g8qF7LsZp/ibxkuzOowDdtg/vk
	 fxXheFRkSKnQ8Z8xFaRSU2TPuvuM61oOJKccUSOk9d9VlhwXRM1qulOUlYLyAlsqc5
	 3jPUA99CiJOHA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EB5C282EC;
	Thu, 13 Mar 2025 14:19:18 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 13 Mar 2025 14:19:28 +0000
Subject: [PATCH 11/18] gpio: adp5585: support gpi events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250313-dev-adp5589-fw-v1-11-20e80d4bd4ea@analog.com>
References: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
In-Reply-To: <20250313-dev-adp5589-fw-v1-0-20e80d4bd4ea@analog.com>
To: linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-input@vger.kernel.org
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Liu Ying <victor.liu@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741875561; l=8240;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=5L3mKC5ksfSHBHoQXthkKPYdBIjhSE+HLAOYPQ/rbnI=;
 b=EoxlMFWo88cbjalZ0Jo7/kllIBcRA8V2GU967PiK5f0TbCpab/HT6+5IFlvB+RK08RsZgLxRn
 JI25gtyddNSB3rr48+OC5HAMhIMRwcj0pF1QNveJjmHLmRPjV1hJMdg
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sá <nuno.sa@analog.com>

Add support for adding GPIs to the event FIFO. This is done by adding
irq_chip support. Like this, one can use the input gpio_keys driver as a
"frontend" device and input handler.

As part of this change, we now implement .init_valid_mask() as we can't
blindly consume all available pins as GPIOs (example: some pins can be
used for forming a keymap matrix).

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-adp5585.c | 178 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 98b4d1633b258b93d05ba66d53f647e7ec6ac364..e8dc5cb9df0f62b111810d90ae67ce68b382d434 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1238,6 +1238,7 @@ config GPIO_ADP5520
 config GPIO_ADP5585
 	tristate "GPIO Support for ADP5585"
 	depends on MFD_ADP5585
+	select GPIOLIB_IRQCHIP
 	help
 	  This option enables support for the GPIO function found in the Analog
 	  Devices ADP5585.
diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index fded9ff35a59fc1a0ce173c58dbd7b6af176958f..cfd0aab1f7414f76287714eda44184c615491194 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -11,6 +11,7 @@
 #include <linux/gpio/driver.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
@@ -27,6 +28,11 @@ struct adp5585_gpio_dev {
 	const struct adp5585_gpio_chip *info;
 	struct regmap *regmap;
 	const struct adp5585_regs *regs;
+	unsigned long irq_mask;
+	unsigned long irq_en;
+	unsigned long irq_active_high;
+	/* used for irqchip bus locking */
+	struct mutex bus_lock;
 };
 
 static int adp5585_gpio_bank(unsigned int off)
@@ -208,12 +214,155 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
 	};
 }
 
+static int adp5585_gpio_init_valid_mask(struct gpio_chip *chip,
+					unsigned long *valid_mask,
+					unsigned int ngpios)
+{
+	struct device *dev = chip->parent;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+
+	bitmap_complement(valid_mask, adp5585->keypad, ngpios);
+	/*
+	 * the keypad won't have (nor can't) have any special pin enabled which
+	 * means bitmap_complement() will set them to 1. Make sure we clear them.
+	 */
+	if (adp5585->has_pwm)
+		__clear_bit(ADP5585_ROW3, valid_mask);
+	if (adp5585->nkeys_reset1)
+		__clear_bit(ADP5585_ROW4, valid_mask);
+	if (adp5585->nkeys_reset2)
+		__clear_bit(adp5585->info->max_rows + ADP5585_COL4, valid_mask);
+	if (!adp5585->info->has_row5)
+		__clear_bit(ADP5585_ROW5, valid_mask);
+
+	return 0;
+}
+
+static void adp5585_gpio_key_event(struct device *dev, unsigned int off,
+				   bool key_press)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = dev_get_drvdata(dev);
+	bool active_high = test_bit(off, &adp5585_gpio->irq_active_high);
+	unsigned int irq, irq_type;
+	struct irq_data *irqd;
+
+	irq = irq_find_mapping(adp5585_gpio->gpio_chip.irq.domain, off);
+	if (!irq)
+		return;
+
+	irqd = irq_get_irq_data(irq);
+	if (!irqd) {
+		dev_err(dev, "Could not get irq(%u) data\n", irq);
+		return;
+	}
+
+	dev_dbg_ratelimited(dev, "gpio-keys event(%u) press=%u, a_high=%u\n",
+			    off, key_press, active_high);
+
+	if (!active_high)
+		key_press = !key_press;
+
+	irq_type = irqd_get_trigger_type(irqd);
+
+	if ((irq_type & IRQ_TYPE_EDGE_RISING && key_press) ||
+	    (irq_type & IRQ_TYPE_EDGE_FALLING && !key_press))
+		handle_nested_irq(irq);
+}
+
+static void adp5585_irq_bus_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(gc);
+
+	mutex_lock(&adp5585_gpio->bus_lock);
+}
+
+static void adp5585_irq_bus_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	const struct adp5585_regs *regs = adp5585_gpio->regs;
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+	bool active_high = test_bit(hwirq, &adp5585_gpio->irq_active_high);
+	bool enabled = test_bit(hwirq, &adp5585_gpio->irq_en);
+	bool masked = test_bit(hwirq, &adp5585_gpio->irq_mask);
+	unsigned int bank = adp5585_gpio->info->bank(hwirq);
+	unsigned int bit = adp5585_gpio->info->bit(hwirq);
+
+	if (masked && !enabled)
+		goto out_unlock;
+	if (!masked && enabled)
+		goto out_unlock;
+
+	regmap_update_bits(adp5585_gpio->regmap, regs->gpi_int_lvl_a + bank, bit,
+			   active_high ? bit : 0);
+	regmap_update_bits(adp5585_gpio->regmap, regs->gpi_ev_a + bank, bit,
+			   masked ? 0 : bit);
+	assign_bit(hwirq, &adp5585_gpio->irq_en, !masked);
+
+out_unlock:
+	mutex_unlock(&adp5585_gpio->bus_lock);
+}
+
+static void adp5585_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	__set_bit(hwirq, &adp5585_gpio->irq_mask);
+	gpiochip_disable_irq(gc, hwirq);
+}
+
+static void adp5585_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	gpiochip_enable_irq(gc, hwirq);
+	__clear_bit(hwirq, &adp5585_gpio->irq_mask);
+}
+
+static int adp5585_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(gc);
+	irq_hw_number_t hwirq = irqd_to_hwirq(d);
+
+	if (!(type & IRQ_TYPE_EDGE_BOTH))
+		return -EINVAL;
+
+	assign_bit(hwirq, &adp5585_gpio->irq_active_high,
+		   type == IRQ_TYPE_EDGE_RISING);
+
+	irq_set_handler_locked(d, handle_edge_irq);
+	return 0;
+}
+
+static const struct irq_chip adp5585_irq_chip = {
+	.name = "adp5585",
+	.irq_mask = adp5585_irq_mask,
+	.irq_unmask = adp5585_irq_unmask,
+	.irq_bus_lock = adp5585_irq_bus_lock,
+	.irq_bus_sync_unlock = adp5585_irq_bus_sync_unlock,
+	.irq_set_type = adp5585_irq_set_type,
+	.flags = IRQCHIP_SKIP_SET_WAKE | IRQCHIP_IMMUTABLE,
+	GPIOCHIP_IRQ_RESOURCE_HELPERS,
+};
+
+static void adp5585_gpio_ev_handle_clean(void *adp5585)
+{
+	adp5585_gpio_ev_handle_set(adp5585, NULL, NULL);
+}
+
 static int adp5585_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct adp5585_gpio_dev *adp5585_gpio;
 	struct device *dev = &pdev->dev;
+	struct gpio_irq_chip *girq;
 	struct gpio_chip *gc;
 	int ret;
 
@@ -238,6 +387,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->get = adp5585_gpio_get_value;
 	gc->set = adp5585_gpio_set_value;
 	gc->set_config = adp5585_gpio_set_config;
+	gc->init_valid_mask = adp5585_gpio_init_valid_mask;
 	gc->can_sleep = true;
 
 	gc->base = -1;
@@ -245,6 +395,34 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->label = pdev->name;
 	gc->owner = THIS_MODULE;
 
+	if (device_property_present(dev->parent, "interrupt-controller")) {
+		if (!adp5585->irq)
+			return dev_err_probe(dev, -EINVAL,
+					     "Unable to serve as interrupt controller without IRQ\n");
+
+		girq = &adp5585_gpio->gpio_chip.irq;
+		gpio_irq_chip_set_chip(girq, &adp5585_irq_chip);
+		girq->handler = handle_bad_irq;
+		girq->threaded = true;
+
+		platform_set_drvdata(pdev, adp5585_gpio);
+		adp5585_gpio_ev_handle_set(adp5585, adp5585_gpio_key_event,
+					   dev);
+
+		ret = devm_add_action_or_reset(dev,
+					       adp5585_gpio_ev_handle_clean,
+					       adp5585);
+		if (ret)
+			return ret;
+	}
+
+	/* everything masked by default */
+	adp5585_gpio->irq_mask = ~0UL;
+
+	ret = devm_mutex_init(dev, &adp5585_gpio->bus_lock);
+	if (ret)
+		return ret;
+
 	ret = devm_gpiochip_add_data(dev, &adp5585_gpio->gpio_chip,
 				     adp5585_gpio);
 	if (ret)

-- 
2.48.1



