Return-Path: <linux-pwm+bounces-5911-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761AAB3787
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 14:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1623E7A3545
	for <lists+linux-pwm@lfdr.de>; Mon, 12 May 2025 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011D529551A;
	Mon, 12 May 2025 12:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwyodQl0"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0142951A1;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747053539; cv=none; b=FBinQiOc7EccT8aHKn1q33e+L+BUXLtsiVZ0UX4afUT3q2mrzUmcWtcIgcZOHzMT7WRZIkybFgu8jqYl8KvPuz43/ncrsHiPpBUXuCD88tXYG34Vb2+TTwp7iFfwklsZ7hOA/10kXRLHYx4cn8gLUVMGUKtTTDa9pQls9uwkcbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747053539; c=relaxed/simple;
	bh=DYrU61RdZhGwlbgaaPjdQ95zATYrcHgAI3gDXfzS4S4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jZM5q+ClDKpmKI7umEOiSwQK5nYx2wYtbg+F+X/zdyvvnj4JCLdpNuwyAlImWPovqhDvIFNn7idR2LaN9xR2YBLL4bHZ0UgBfcPInb7ft2sbJwW9huGu/5s4NUnrDYJVPwRt0TshZEkAKAldi+8azk3MoIiDuVWEm+QZHI4AfBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwyodQl0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5527AC4AF4D;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747053539;
	bh=DYrU61RdZhGwlbgaaPjdQ95zATYrcHgAI3gDXfzS4S4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=mwyodQl0HQQr3e/ELtR2XFGfY/pmrK2mMseLPRE1z1mONn/h3QW5FGqhY1p5oD7xk
	 BHPSVaVZSAN53t7kZKpiTynSiBx87zs5DIuh+cYQxow3HkfRrVu4IAwAmkJ8mr/D9V
	 7t+DIfJvxury1DkYtaszQdmKnTICMZfTN3WORAcUcD7ZPODGO+TVMDk4/jCR6R5zRJ
	 a3/aBXZYqdxgyUySr7HMmSNH4FfS37ShzM0AXYSRS6pbKnfNdt+T1wgP+3EB30MvMa
	 PxltwhQuVfhmAgv7CsC8vLQbXMUIYXNOx2yOCW5xvgkzcg8K5QBd2JZ2GAsWV83Akh
	 oAzdJ3Ento/TQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F95C3ABD7;
	Mon, 12 May 2025 12:38:59 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 12 May 2025 13:39:08 +0100
Subject: [PATCH v3 16/22] gpio: adp5585: support gpi events
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250512-dev-adp5589-fw-v3-16-092b14b79a88@analog.com>
References: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
In-Reply-To: <20250512-dev-adp5589-fw-v3-0-092b14b79a88@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1747053537; l=10351;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=UfJ/QHtRHge0c0E99x+02SfGt2SUDADcJP2e64mEtQA=;
 b=FH8Qf6J9wzsrCVA95V+mVbf5PL0DrH/p8Rv12LtG7CEcnXzQt1DyN/cGuZN22wLI5hfVFn0no
 CUkGWqG/le4BGnDJ7jn8OOwHzjMhor29SjxEfSHmWIF0tHblpJiT740
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
 drivers/gpio/gpio-adp5585.c | 205 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 202 insertions(+), 4 deletions(-)

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
index cdf107742579cb44d73cc030646358ba5a23fd97..cd0ddddae7db1f4634680b412b8fcbfa295e87eb 100644
--- a/drivers/gpio/gpio-adp5585.c
+++ b/drivers/gpio/gpio-adp5585.c
@@ -7,10 +7,13 @@
  * Copyright 2025 Analog Devices, Inc.
  */
 
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/gpio/driver.h>
 #include <linux/mfd/adp5585.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/types.h>
@@ -36,20 +39,29 @@
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
+	struct adp5585_ev_handler ev_handler;
 	const struct adp5585_gpio_chip *info;
 	struct regmap *regmap;
+	unsigned long irq_mask;
+	unsigned long irq_en;
+	unsigned long irq_active_high;
+	/* used for irqchip bus locking */
+	struct mutex bus_lock;
 };
 
 static int adp5585_gpio_bank(unsigned int off)
@@ -224,12 +236,163 @@ static int adp5585_gpio_set_config(struct gpio_chip *chip, unsigned int off,
 	};
 }
 
+static int adp5585_gpio_request(struct gpio_chip *chip, unsigned int off)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = gpiochip_get_data(chip);
+	const struct adp5585_gpio_chip *info = adp5585_gpio->info;
+	struct device *dev = chip->parent;
+	struct adp5585_dev *adp5585 = dev_get_drvdata(dev->parent);
+	const struct adp5585_regs *regs = adp5585->info->regs;
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
+static int adp5585_gpio_key_event(struct device *dev, unsigned int key,
+				  unsigned int key_press)
+{
+	struct adp5585_gpio_dev *adp5585_gpio = dev_get_drvdata(dev);
+	unsigned int irq, irq_type;
+	struct irq_data *irqd;
+	bool active_high;
+	unsigned int off;
+
+	/* make sure the event is for me */
+	if (key < adp5585_gpio->info->gpi_ev_min || key > adp5585_gpio->info->gpi_ev_max)
+		return -EINVAL;
+
+	off = key - adp5585_gpio->info->gpi_ev_min;
+	active_high = test_bit(off, &adp5585_gpio->irq_active_high);
+
+	irq = irq_find_mapping(adp5585_gpio->gpio_chip.irq.domain, off);
+	if (!irq)
+		return 0;
+
+	irqd = irq_get_irq_data(irq);
+	if (!irqd) {
+		dev_err(dev, "Could not get irq(%u) data\n", irq);
+		return 0;
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
+
+	return 0;
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
 static int adp5585_gpio_probe(struct platform_device *pdev)
 {
 	struct adp5585_dev *adp5585 = dev_get_drvdata(pdev->dev.parent);
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct adp5585_gpio_dev *adp5585_gpio;
 	struct device *dev = &pdev->dev;
+	struct gpio_irq_chip *girq;
 	struct gpio_chip *gc;
 	int ret;
 
@@ -253,13 +416,41 @@ static int adp5585_gpio_probe(struct platform_device *pdev)
 	gc->get = adp5585_gpio_get_value;
 	gc->set_rv = adp5585_gpio_set_value;
 	gc->set_config = adp5585_gpio_set_config;
+	gc->request = adp5585_gpio_request;
+	gc->free = adp5585_gpio_free;
 	gc->can_sleep = true;
 
 	gc->base = -1;
-	gc->ngpio = adp5585_gpio->info->max_gpio;
+	gc->ngpio = adp5585->info->n_pins;
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
+		adp5585_gpio->ev_handler.dev = dev;
+		adp5585_gpio->ev_handler.handler = adp5585_gpio_key_event;
+		platform_set_drvdata(pdev, adp5585_gpio);
+
+		ret = devm_adp5585_ev_handler_add(adp5585,
+						  &adp5585_gpio->ev_handler);
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
@@ -277,8 +468,11 @@ static const struct adp5585_gpio_chip adp5585_gpio_chip_info = {
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
@@ -290,7 +484,10 @@ static const struct adp5585_gpio_chip adp5589_gpio_chip_info = {
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

-- 
2.49.0



