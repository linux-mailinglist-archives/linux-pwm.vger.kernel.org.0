Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686531BA2CD
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Apr 2020 13:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgD0LmV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 27 Apr 2020 07:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727045AbgD0LmV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 27 Apr 2020 07:42:21 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF8C0610D5;
        Mon, 27 Apr 2020 04:42:21 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jT29J-0001JG-W7; Mon, 27 Apr 2020 13:42:10 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 66B12100606; Mon, 27 Apr 2020 13:42:09 +0200 (CEST)
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
Subject: Re: [PATCH v3 09/16] gpiolib: Introduce gpiochip_irqchip_add_domain()
In-Reply-To: <20200423174543.17161-10-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-10-michael@walle.cc>
Date:   Mon, 27 Apr 2020 13:42:09 +0200
Message-ID: <87mu6xqhny.fsf@nanos.tec.linutronix.de>
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
> This connects an IRQ domain to a gpiochip and reuses
> gpiochip_to_irq().

A little bit more context and explanation why this function is useful
would be appreciated.

> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/gpio/gpiolib.c      | 20 ++++++++++++++++++++
>  include/linux/gpio/driver.h |  3 +++
>  2 files changed, 23 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 40f2d7f69be2..7b3d7f496b9a 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -2722,6 +2722,26 @@ int gpiochip_irqchip_add_key(struct gpio_chip *gc,
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_irqchip_add_key);
>  
> +/**
> + * gpiochip_irqchip_add_key() - adds an irqdomain to a gpiochip

Copy & paste is wonderful

> + * @gc: the gpiochip to add the irqchip to
> + * @domain: the irqdomain to add to the gpiochip
> + *
> + * This function adds an IRQ domain to the gpiochip.
> + */
> +int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
> +				struct irq_domain *domain)
> +{
> +	if (!domain)
> +		return -EINVAL;
> +
> +	gc->to_irq = gpiochip_to_irq;
> +	gc->irq.domain = domain;
> +
> +	return 0;
> +}

Thanks,

        tglx
