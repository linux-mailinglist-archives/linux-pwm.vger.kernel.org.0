Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F031BA28B
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgD0Lkj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 07:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0Lkj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 07:40:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A343C0610D5;
        Mon, 27 Apr 2020 04:40:39 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT27W-0001FM-LG; Mon, 27 Apr 2020 13:40:18 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 118A3100606; Mon, 27 Apr 2020 13:40:18 +0200 (CEST)
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
Subject: Re: [PATCH v3 06/16] irqchip: add sl28cpld interrupt controller support
In-Reply-To: <20200423174543.17161-7-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-7-michael@walle.cc>
Date:   Mon, 27 Apr 2020 13:40:18 +0200
Message-ID: <87pnbtqhr1.fsf@nanos.tec.linutronix.de>
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

> This patch adds support for the interrupt controller inside the sl28

git grep 'This patch' Documentation/process/

> CPLD management controller.
>
> +static int sl28cpld_intc_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_intc *irqchip;
> +	struct resource *res;
> +	unsigned int irq;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
> +	if (!irqchip)
> +		return -ENOMEM;
> +
> +	irqchip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!irqchip->regmap)
> +		return -ENODEV;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
> +	if (!res)
> +		return -EINVAL;
> +
> +	irqchip->chip.name = "sl28cpld-intc";
> +	irqchip->chip.irqs = sl28cpld_irqs;
> +	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
> +	irqchip->chip.num_regs = 1;
> +	irqchip->chip.status_base = res->start + INTC_IP;
> +	irqchip->chip.mask_base = res->start + INTC_IE;
> +	irqchip->chip.mask_invert = true,
> +	irqchip->chip.ack_base = res->start + INTC_IP;
> +
> +	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
> +				       IRQF_SHARED | IRQF_ONESHOT, 0,

What's the point of IRQF_SHARED | IRQF_ONESHOT here?

> +				       &irqchip->chip, &irqchip->irq_data);

Thanks,

        tglx
