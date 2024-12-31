Return-Path: <linux-pwm+bounces-4529-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A70B9FF10C
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 18:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EC3F7A0135
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Dec 2024 17:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB631ACEDF;
	Tue, 31 Dec 2024 17:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="d47ZBUiW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF271ACEB4;
	Tue, 31 Dec 2024 17:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735666841; cv=none; b=pRXqEC7gNSWdLqV+VLz8qPVY8TGa3hAZKXfrHi81Gn8ztJR//PuxFJqyGrloRkJMZToKOYnI3WQEajpnMksqAFlSTUa9Vos/5WiVzZdZkFPaWg11RKYeiW2eBE82STMtqWZysbfsepq8RJ/fzDTyH/oJfNT6DZcm29dAdrWUEEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735666841; c=relaxed/simple;
	bh=9lCljnGczquu/LNS7wEkGPjxFPSw6nrHX3XbgcPVP2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t2OrbL5I+5leqL+sejHWYL7DZ1mcIEAZCpWMdPkFG/BmFdKbJPbXmnRq6MXTJhGpqFwzN8+iR181eJY1a1uNo0VeRfHToMxZMF2zpzre5qUUhVkDb/lP/GVqXA2bgiEgBLY8vlRn9ssUfoAoD7iCqYubrokm1EmxHnHOXnOCaeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=d47ZBUiW; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SgEItDJidmOLwSgEMt79gW; Tue, 31 Dec 2024 18:40:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1735666835;
	bh=s7BjSYy/9eDB6anSYFNlQnpngwkFWR3jdLTYQmRS/54=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=d47ZBUiWp7fs131oo/DV6YwTxnyHsuCtR1BTshBWHATl55leTRSSQknFrMZvi+/qI
	 fCZOvZc+h+Pku7V+yR92a0VKLuHSGqexJydP+Ubpeqew9zSTmJbGBHK5kWdDI2Wqgl
	 6WadI9cO4sxNd9NDo8vxefHSFJe6Rfv8tgekE21VgTEFQHUeNct/h+4nQWfDDZi+bN
	 T6cULYilf9QJF496pnGLscQUBFP+FNuFlhW83IwLe0Wb+jbESlkugdtJENumaoeFnu
	 bVZqyuotJYAAGKkELZFhPlvkJ71XfGDBDPO1XTHu15XWWRt5THk8Tc48eCay4ryNTV
	 Hu02TxsLPNbng==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Tue, 31 Dec 2024 18:40:35 +0100
X-ME-IP: 90.11.132.44
Message-ID: <962d9a8b-8036-434a-9207-fe6dfff33aaa@wanadoo.fr>
Date: Tue, 31 Dec 2024 18:40:29 +0100
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] gpio: max7360: Add MAX7360 gpio support
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kamel Bouhara <kamel.bouhara@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-pwm@vger.kernel.org, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20241223-mdb-max7360-support-v2-0-37a8d22c36ed@bootlin.com>
 <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241223-mdb-max7360-support-v2-4-37a8d22c36ed@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 23/12/2024 à 17:42, Mathieu Dubois-Briand a écrit :
> Add driver for Maxim Integrated MAX7360 GPIO/GPO controller.
> 
> Two sets of GPIOs are provided by the device:
> - Up to 8 GPIOs, shared with the PWM and rotary encoder functionalities.
>    These GPIOs also provide interrupts on input changes.
> - Up to 6 GPOs, on unused keypad columns pins.
> 
> Co-developed-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Kamel Bouhara <kamel.bouhara@bootlin.com>
> Signed-off-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

...

> +static int max7360_gpio_probe(struct platform_device *pdev)
> +{
> +	struct max7360_gpio *max7360_gpio;
> +	struct platform_device *parent;
> +	unsigned int ngpios;
> +	unsigned int outconf;
> +	struct gpio_irq_chip *girq;
> +	unsigned long flags;
> +	int irq;
> +	int ret;
> +
> +	if (!pdev->dev.parent) {
> +		dev_err(&pdev->dev, "no parent device\n");
> +		return -ENODEV;
> +	}
> +	parent = to_platform_device(pdev->dev.parent);
> +
> +	max7360_gpio = devm_kzalloc(&pdev->dev, sizeof(struct max7360_gpio),

sizeof(*max7360_gpio)?

> +				    GFP_KERNEL);
> +	if (!max7360_gpio)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u32(pdev->dev.of_node, "ngpios", &ngpios)) {
> +		dev_err(&pdev->dev, "Missing ngpios OF property\n");
> +		return -ENODEV;
> +	}
> +
> +	max7360_gpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!max7360_gpio->regmap) {
> +		dev_err(&pdev->dev, "could not get parent regmap\n");
> +		return -ENODEV;
> +	}
> +
> +	max7360_gpio->dev = &pdev->dev;
> +	max7360_gpio->chip = max7360_gpio_chip;
> +	max7360_gpio->chip.ngpio = ngpios;
> +	max7360_gpio->chip.parent = &pdev->dev;
> +	max7360_gpio->chip.base = -1;
> +	max7360_gpio->gpio_function = (uintptr_t)device_get_match_data(&pdev->dev);
> +
> +	dev_dbg(&pdev->dev, "gpio count: %d\n", max7360_gpio->chip.ngpio);
> +
> +	if (max7360_gpio->gpio_function == MAX7360_GPIO_PORT) {
> +		/* Port GPIOs: set output mode configuration (constant-current
> +		 * or not).
> +		 * This property is optional.
> +		 */
> +		outconf = 0;
> +		ret = of_property_read_u32(pdev->dev.of_node,
> +					   "maxim,constant-current-disable",
> +					   &outconf);
> +		if (ret && (ret != -EINVAL)) {
> +			dev_err(&pdev->dev,
> +				"Failed to read maxim,constant-current-disable OF property\n");
> +			return -ENODEV;
> +		}
> +
> +	    regmap_write(max7360_gpio->regmap, MAX7360_REG_GPIOOUTM, outconf);
> +	}
> +
> +	if (max7360_gpio->gpio_function == MAX7360_GPIO_PORT &&
> +	    of_property_read_bool(pdev->dev.of_node, "interrupt-controller")) {
> +		/* Port GPIOs: declare IRQ chip, if configuration was provided.
> +		 */
> +		irq = platform_get_irq_byname(parent, "inti");
> +		if (irq < 0)
> +			return dev_err_probe(&pdev->dev, irq,
> +					     "Failed to get IRQ");
> +
> +		flags = IRQF_TRIGGER_LOW | IRQF_ONESHOT | IRQF_SHARED;
> +		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +						max7360_gpio_irq, flags,
> +						"max7360-gpio", max7360_gpio);
> +		if (ret)
> +			return dev_err_probe(&pdev->dev, ret,
> +					     "Failed to register interrupt: %d\n",
> +					     ret);

No need to duplicate ret in the message.

> +
> +		girq = &max7360_gpio->chip.irq;
> +		gpio_irq_chip_set_chip(girq, &max7360_gpio_irqchip);
> +		girq->parent_handler = NULL;
> +		girq->num_parents = 0;
> +		girq->parents = NULL;
> +		girq->threaded = true;
> +		girq->default_type = IRQ_TYPE_NONE;
> +		girq->handler = handle_simple_irq;
> +	}
> +
> +	ret = devm_gpiochip_add_data(&pdev->dev, &max7360_gpio->chip, max7360_gpio);
> +	if (ret) {
> +		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);

return dev_err_probe()?

> +		return ret;
> +	}
> +
> +	return 0;
> +}

CJ

