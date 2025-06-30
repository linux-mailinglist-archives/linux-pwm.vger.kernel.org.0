Return-Path: <linux-pwm+bounces-6596-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5A5AEDBCC
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 13:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C6251898267
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Jun 2025 11:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF322853F7;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoEv/41j"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55572285049;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284366; cv=none; b=TgTnBswH74gIkYW7RAHHl6xizaOkK7oxjYuM9AlKl51cbnTz6VZsV2HmBdGtjVKWc/v+PP9oBwJ/4yz7gqEW55kAlDDDUXbTGDdyidQNUdSDLA2uGwNKWoyB11foNENVMv6xvUh78vtcZOlagupQir4YXqdaGAp5gYaVNyJN8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284366; c=relaxed/simple;
	bh=PYid22U/FzP28zSIfgIVVdU3UoNM+QU+uf8vuMcEd7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4o+MdC1XOUL+UBIVYpibs3KP0uvd6IhoJo618v3TSc0O/+lh1mbWmnzm954HDpaOcoUUsQBkOMXFohCupr54locHZ4FEoRziLU0foJwN/nCgFlIhdTnTvu73E0sK8VJKi+98phNHj+A4Y/R3VvxR8w656XP31pMwHrHc5a0BiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoEv/41j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2842EC116B1;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751284366;
	bh=PYid22U/FzP28zSIfgIVVdU3UoNM+QU+uf8vuMcEd7k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GoEv/41ji0BaPTQheinvy47w0b3mR+oc7Bke1/HvPK1r9c99PDNx8psGL6vw4mdpm
	 PubCtejzn9OjKY69RHAPrShCNXTd1JXJhH2F9yvy8DICQdZXEQG8Nt9A6o/Kcn8cO/
	 /bdbqAvjIXZGu2EY8ctp2ZGbRdOkKCtWVvH6wDRADrSesvgaOj22to7vvIn52o7w22
	 YIIZ+A8/boRgXXW1Ou1f509Gj+hYr6bF+dI+PBLtnI2fmMKlew5b1owvUFb3AcIg5R
	 R5PfdD0adtVD/01edo+gU8ooLU4gowNeqRS4AnFwaXPdV3jLb5zjpW9P7NcEXRzTs5
	 rOsWGG+WGsw3w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBF3C83030;
	Mon, 30 Jun 2025 11:52:46 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 30 Jun 2025 12:53:06 +0100
Subject: [PATCH v6 15/20] gpio: adp5585: support gpi events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250630-dev-adp5589-fw-v6-15-a0f392a0ba91@analog.com>
References: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
In-Reply-To: <20250630-dev-adp5589-fw-v6-0-a0f392a0ba91@analog.com>
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
 Liu Ying <victor.liu@nxp.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751284374; l=11547;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=Y1cpTL76zANlANeWeZWtxlkek0SKaNscfzt4YTOeX2U=;
 b=AZkB7QIFerpj3lSUqYkDDqIxO32jaiHVonKhTN/aYipNqwQANZHBe3q0GtyFQxBnYXR13UPZW
 5ifQ/onqBbfCech4QYRUiTVDLAqXCl83VedHWJpZzPMMMOUCOCD2YEM
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

As part of this change, we now implement .request() and .free() as we can't
blindly consume all available pins as GPIOs (example: some pins can be
used for forming a keymap matrix).

Also note that the number of pins can now be obtained from the parent,
top level device. Hence the 'max_gpio' variable can be removed.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-adp5585.c | 221 +++++++++++++++++++++++++++++++++++++++++++-
 include/linux/mfd/adp5585.h |   2 +
 3 files changed, 220 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 9ae806f45e19c1494d156b7f04b1882be68d3e3f..0b85d07ccb0b8a41f33fd3d930eb74f70787355d 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1259,6 +1259,7 @@ config GPIO_ADP5520
 config GPIO_ADP5585
 	tristate "GPIO Support for ADP5585"
 	depends on MFD_ADP5585
+	select GPIOLIB_IRQCHIP
 	help
 	  This option enables support for the GPIO function found in the Analog
 	  Devices ADP5585.
diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index cdf107742579cb44d73cc030646358ba5a23fd97..b2c8836c5f8477ebeea516b4eedc7d3d2aad59dd 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -7,10 +7,15 @@
  * Copyright 2025 Analog Devices, Inc.
  */
 
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/container_of.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/notifier.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
@@ -36,20 +41,29 @@
 struct adp5585_gpio_chip {
 	int (*bank)(unsigned int off);
 	int (*bit)(unsigned int off);
-	unsigned int max_gpio;
 	unsigned int debounce_dis_a;
 	unsigned int rpull_cfg_a;
 	unsigned int gpo_data_a;
 	unsigned int gpo_out_a;
 	unsigned int gpio_dir_a;
 	unsigned int gpi_stat_a;
+	unsigned int gpi_int_lvl_a;
+	unsigned int gpi_ev_a;
+	unsigned int gpi_ev_min;
+	unsigned int gpi_ev_max;
 	bool has_bias_hole;
 };
 
 struct adp5585_gpio_dev {
 	struct gpio_chip gpio_chip;
+	struct notifier_block nb;
 	const struct adp5585_gpio_chip *info;
 	struct regmap *regmap;
+	unsigned long irq_mask;
+	unsigned long irq_en;
+	unsigned long irq_active_high;
+	/* used for irqchip bus locking */
+	struct mutex bus_lock;
 };
 
 static int adp5585_gpio_bank(unsigned int off)
@@ -224,12 +238,175 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
 	};
 }
 
+static int adp5585_gpio_request(struct gpio_chip *chip, unsigned int off)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	struct device *dev = chip->parent;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+	const struct adp5585_regs *regs = adp5585->regs;
+	int ret;
+
+	ret = test_and_set_bit(off, adp5585->pin_usage);
+	if (ret)
+		return -EBUSY;
+
+	/* make sure it's configured for GPIO */
+	return regmap_clear_bits(adp5585_gpio->regmap,
+				 regs->pin_cfg_a + info->bank(off),
+				 info->bit(off));
+}
+
+static void adp5585_gpio_free(struct gpio_chip *chip, unsigned int off)
+{
+	struct device *dev = chip->parent;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+
+	clear_bit(off, adp5585->pin_usage);
+}
+
+static int adp5585_gpio_key_event(struct notifier_block *nb, unsigned long key,
+				  void *data)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = container_of(nb, struct adp5585_gpio_dev, nb);
+	struct device *dev = adp5585_gpio->gpio_chip.parent;
+	unsigned long key_press = (unsigned long)data;
+	unsigned int irq, irq_type;
+	struct irq_data *irqd;
+	bool active_high;
+	unsigned int off;
+
+	/* make sure the event is for me */
+	if (key < adp5585_gpio->info->gpi_ev_min || key > adp5585_gpio->info->gpi_ev_max)
+		return NOTIFY_DONE;
+
+	off = key - adp5585_gpio->info->gpi_ev_min;
+	active_high = test_bit(off, &adp5585_gpio->irq_active_high);
+
+	irq = irq_find_mapping(adp5585_gpio->gpio_chip.irq.domain, off);
+	if (!irq)
+		return NOTIFY_BAD;
+
+	irqd = irq_get_irq_data(irq);
+	if (!irqd) {
+		dev_err(dev, "Could not get irq(%u) data\n", irq);
+		return NOTIFY_BAD;
+	}
+
+	dev_dbg_ratelimited(dev, "gpio-keys event(%u) press=%lu, a_high=%u\n",
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
+
+	return NOTIFY_STOP;
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
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
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
+	regmap_update_bits(adp5585_gpio->regmap, info->gpi_int_lvl_a + bank, bit,
+			   active_high ? bit : 0);
+	regmap_update_bits(adp5585_gpio->regmap, info->gpi_ev_a + bank, bit,
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
+static void adp5585_gpio_unreg_notifier(void *data)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = data;
+	struct device *dev = adp5585_gpio->gpio_chip.parent;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+
+	blocking_notifier_chain_unregister(&adp5585->event_notifier,
+					   &adp5585_gpio->nb);
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
 
@@ -253,13 +430,43 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->get = adp5585_gpio_get_value;
 	gc->set_rv = adp5585_gpio_set_value;
 	gc->set_config = adp5585_gpio_set_config;
+	gc->request = adp5585_gpio_request;
+	gc->free = adp5585_gpio_free;
 	gc->can_sleep = true;
 
 	gc->base = -1;
-	gc->ngpio = adp5585_gpio->info->max_gpio;
+	gc->ngpio = adp5585->n_pins;
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
+		adp5585_gpio->nb.notifier_call = adp5585_gpio_key_event;
+		ret = blocking_notifier_chain_register(&adp5585->event_notifier,
+						       &adp5585_gpio->nb);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, adp5585_gpio_unreg_notifier,
+					       adp5585_gpio);
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
 	ret = devm_gpiochip_add_data(dev, &adp5585_gpio->gpio_chip,
 				     adp5585_gpio);
 	if (ret)
@@ -277,8 +484,11 @@ static const struct adp5585_gpio_chip adp5585_gpio_chip_info = {
 	.gpo_out_a = ADP5585_GPO_OUT_MODE_A,
 	.gpio_dir_a = ADP5585_GPIO_DIRECTION_A,
 	.gpi_stat_a = ADP5585_GPI_STATUS_A,
-	.max_gpio = ADP5585_PIN_MAX,
 	.has_bias_hole = true,
+	.gpi_ev_min = ADP5585_GPI_EVENT_START,
+	.gpi_ev_max = ADP5585_GPI_EVENT_END,
+	.gpi_int_lvl_a = ADP5585_GPI_INT_LEVEL_A,
+	.gpi_ev_a = ADP5585_GPI_EVENT_EN_A,
 };
 
 static const struct adp5585_gpio_chip adp5589_gpio_chip_info = {
@@ -290,7 +500,10 @@ static const struct adp5585_gpio_chip adp5589_gpio_chip_info = {
 	.gpo_out_a = ADP5589_GPO_OUT_MODE_A,
 	.gpio_dir_a = ADP5589_GPIO_DIRECTION_A,
 	.gpi_stat_a = ADP5589_GPI_STATUS_A,
-	.max_gpio = ADP5589_PIN_MAX,
+	.gpi_ev_min = ADP5589_GPI_EVENT_START,
+	.gpi_ev_max = ADP5589_GPI_EVENT_END,
+	.gpi_int_lvl_a = ADP5589_GPI_INT_LEVEL_A,
+	.gpi_ev_a = ADP5589_GPI_EVENT_EN_A,
 };
 
 static const struct platform_device_id adp5585_gpio_id_table[] = {
diff --git a/include/linux/mfd/adp5585.h b/include/linux/mfd/adp5585.h
index 41c5d2e1cc7ca40aa5192296ecc5ff8d737cb3e6..5237da6b4a9f2f3424e5f0c4814c5d08aebf080e 100644
--- a/include/linux/mfd/adp5585.h
+++ b/include/linux/mfd/adp5585.h
@@ -136,6 +136,8 @@
 #define ADP5589_GPI_STATUS_A		0x16
 #define ADP5589_GPI_STATUS_C		0x18
 #define ADP5589_RPULL_CONFIG_A		0x19
+#define ADP5589_GPI_INT_LEVEL_A		0x1e
+#define ADP5589_GPI_EVENT_EN_A		0x21
 #define ADP5589_DEBOUNCE_DIS_A		0x27
 #define ADP5589_GPO_DATA_OUT_A		0x2a
 #define ADP5589_GPO_OUT_MODE_A		0x2d

-- 
2.50.0



