Return-Path: <linux-pwm+bounces-5502-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B8FA8A1C9
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 16:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C0B3BD5DA
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Apr 2025 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C432D29E044;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuECLaB1"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BDD29C340;
	Tue, 15 Apr 2025 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728560; cv=none; b=kvq56zKVDb9RFMtGI3mNBMY5aPMIatNUp+rs6gff7cs0ph/Ji6r8oWS11vQ7dkElbhoW95SyA+Ez+lJxmrU4HGd9AtOE3gS5tx4H+DLs7w4/+M14WtFlj17qx9Im7DFmnZGz6UoVHDRknFmDtgn6d5BTvyUttW+PfFAqLT6RooI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728560; c=relaxed/simple;
	bh=+/Kx2RMx4YSrbRKEGjXY5AQXjHRiniCXC51VTwVtfvA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RhrBt+QHTP6iNdcmJQ49e/cRndDUuWdeP75NZ3ewsvFyZjbFOicJmIUQHGjzH6opSQd0ZYr0RnjmLhcYyi2TDBjn5LCv8rx3h0JKBn4M/cWJ97XITBoTmFlkzj6thPqZJSZPEJUZGXYjr0xOlF3jC9/ODzX6aFHJrrhl6OvrgYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuECLaB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB312C4CEEE;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744728559;
	bh=+/Kx2RMx4YSrbRKEGjXY5AQXjHRiniCXC51VTwVtfvA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tuECLaB17lX424Cye5bIP5vq97Xj348SqegFzrAAiTzHOB3+pGtMYtDsoqhmQ3xFg
	 Kk+K0qgWOuP13plk8ZSzCvIcq6gApcrqNKZ0CPFxxAeB+qbzadQ4XMNiN/pqxBHP2C
	 rL+fds0jgKkXxwkUYFf02Az23WyWnG8y6siqjDauv1Jt5lj97Neb3KzcIwFw36sBsA
	 sS99kN8Oro8dcOdJ6c3cYuWdZiX75RQrojtpl8VhM1sY0UxoiEiWDlYQOVMFhOgoZv
	 bZKakbFSEeEX4yjZObZ+gP6X7Y1vi7L4sLezaNcivz9cifuuGs7gOn5edxrVv3+Z3J
	 BLs3O5RDziGew==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3121C369AB;
	Tue, 15 Apr 2025 14:49:19 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Tue, 15 Apr 2025 15:49:27 +0100
Subject: [PATCH v2 11/17] gpio: adp5585: support gpi events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250415-dev-adp5589-fw-v2-11-3a799c3ed812@analog.com>
References: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
In-Reply-To: <20250415-dev-adp5589-fw-v2-0-3a799c3ed812@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744728560; l=8298;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=4SmKExjcf/q4HjHbj86lvcYN3h4qrrepd6xGKyJL+mE=;
 b=1YdKXwPQq6G9BcFoHMUh3R71IDI8+mV5neAetxVBFE70mYVnMxGvKVqZPwt5TG6pjwsBecXwF
 aKY+/btckSpAv20qh9IcZJAI4LSXu8ruLPzPkPsOrykIlUBvzGuTv23
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

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/gpio/Kconfig        |   1 +
 drivers/gpio/gpio-adp5585.c | 178 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 179 insertions(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 975cc95be54255ef5953bc61a8f7a7f174ea2626..73420dda8b4ccff751fa6fcd9ecf1ae60b395bf2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1251,6 +1251,7 @@ config GPIO_ADP5520
 config GPIO_ADP5585
 	tristate "GPIO Support for ADP5585"
 	depends on MFD_ADP5585
+	select GPIOLIB_IRQCHIP
 	help
 	  This option enables support for the GPIO function found in the Analog
 	  Devices ADP5585.
diff --git a/drivers/gpio/gpio-adp5585.c b/drivers/gpio/gpio-adp5585.c
index d8f8d5513d7f6a9acf5bdecccacc89c4615ce237..a97babb2f8985238d8c401955f4cfcc54bd22948 100644
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
@@ -209,12 +215,155 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
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
 
@@ -239,6 +388,7 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->get = adp5585_gpio_get_value;
 	gc->set_rv = adp5585_gpio_set_value;
 	gc->set_config = adp5585_gpio_set_config;
+	gc->init_valid_mask = adp5585_gpio_init_valid_mask;
 	gc->can_sleep = true;
 
 	gc->base = -1;
@@ -246,6 +396,34 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
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
2.49.0



