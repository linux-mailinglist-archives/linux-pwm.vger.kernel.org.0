Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7D21BA2E4
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 13:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgD0LpP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 07:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgD0LpO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 07:45:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC26C0610D5;
        Mon, 27 Apr 2020 04:45:14 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT2C4-0001Mi-Mv; Mon, 27 Apr 2020 13:45:00 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 1C40E100606; Mon, 27 Apr 2020 13:45:00 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v3 11/16] gpio: add support for the sl28cpld GPIO controller
In-Reply-To: <20200423174543.17161-12-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-12-michael@walle.cc>
Date:   Mon, 27 Apr 2020 13:45:00 +0200
Message-ID: <87k121qhj7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Michael Walle <michael@walle.cc> writes:
> +struct sl28cpld_gpio {
> +	struct regmap_irq_chip irq_chip;
> +	struct regmap_irq_chip_data *irq_data;
> +};
> +
> +static const struct regmap_irq sl28cpld_gpio_irqs[] = {
> +	REGMAP_IRQ_REG_LINE(0, 8),
> +	REGMAP_IRQ_REG_LINE(1, 8),
> +	REGMAP_IRQ_REG_LINE(2, 8),
> +	REGMAP_IRQ_REG_LINE(3, 8),
> +	REGMAP_IRQ_REG_LINE(4, 8),
> +	REGMAP_IRQ_REG_LINE(5, 8),
> +	REGMAP_IRQ_REG_LINE(6, 8),
> +	REGMAP_IRQ_REG_LINE(7, 8),
> +};

This is exactly the same as the one in the irq chip patch.

> +static int sl28cpld_gpio_irq_init(struct device *dev,
> +				  struct sl28cpld_gpio *gpio,
> +				  struct regmap *regmap, unsigned int base,
> +				  int irq)
> +{
> +	struct regmap_irq_chip *irq_chip = &gpio->irq_chip;
> +
> +	irq_chip->name = "sl28cpld-gpio-irq",
> +	irq_chip->irqs = sl28cpld_gpio_irqs;
> +	irq_chip->num_irqs = ARRAY_SIZE(sl28cpld_gpio_irqs);
> +	irq_chip->num_regs = 1;
> +	irq_chip->status_base = base + GPIO_REG_IP;
> +	irq_chip->mask_base = base + GPIO_REG_IE;
> +	irq_chip->mask_invert = true,
> +	irq_chip->ack_base = base + GPIO_REG_IP;
> +
> +	return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,
> +					   irq, IRQF_SHARED | IRQF_ONESHOT, 0,
> +					   irq_chip, &gpio->irq_data);
> +}

And this looks pretty familiar as well. What's the point of duplicating
that code?

Thanks,

        tglx
