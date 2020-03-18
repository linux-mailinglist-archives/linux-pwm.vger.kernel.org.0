Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 280CC18A0F2
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCRQxu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 12:53:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37476 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgCRQxt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 12:53:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id 3so6356166pff.4;
        Wed, 18 Mar 2020 09:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7LfwQXhbFrUqlwQcnjQoVTn7klfITq4kPV7C2/NOAmg=;
        b=YF4kumhAa8nTqBQq0SAjBccwGOveO+DyqGxfe9wBnMyIGPOnmEOyqJVRk82xrMd1RO
         dYD31xPQNGAMCMxbLn1IkzFmISLGi7xoFKGoAr0nFbpoRvFwbHYU9e6GhrFlRwW0D6Ga
         746POumRtaqgflG4K3cQSmlpjqqjSfaiE48tPiQSyk6p/eBrsQ7myng7VxhjCv6BshOr
         eCFTpk/YVAPjSfwmMRpl0IJ3ZT1xnVraCTK8GZUrxC47anJ6E2vnRfoBld2wCzB8v85F
         Si0xvD51Ho+P/K2wGT+yu7ZGlwUYOswcVQlwxeAOQukocjcqustP14qyWtH5mKVUs/XX
         4/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=7LfwQXhbFrUqlwQcnjQoVTn7klfITq4kPV7C2/NOAmg=;
        b=UgS0Rb8xRoEsocksSciyDNQbyLWSilRIioesiKEQnFJpT7ImHy0UKj9i2+iwwj7q+D
         BpAQmR3DBlUl11DWUtSA/pIK0V4acab6u16xis+8SEJYd9OyOL1C9k4qnp1O5Qt6cGod
         Uqsg8vo+5pb9yTvq36VFho2aKEggnkg/0QF1HnnOOo47ySG8RkuOvVf4O3GspfiRWGfa
         VJjGgdT7TiVR7MUHMlFfycQj2P1fnnTYnhIEuRnxcemQTX2uZHuPjgt1rtUul9+zZcPG
         GfwdbVrpBEbthWKmBIcS3mC1mbv+HXmejsG4zlRi9/x6+AOBRDAAGi3ES6vsA/+gGZzj
         WV1Q==
X-Gm-Message-State: ANhLgQ04zBplFPKu1uMEZWqo0PMmkwPoRylpdv5Byfihpr28rgi/yF7j
        L3ocIi95Qm6K0cuY8KLO3r8=
X-Google-Smtp-Source: ADFU+vsedoAklqRQM9llMcWDisTTSnvHxMvODhCIDy8OYgkSrZ+E+J5l/O7upchoHAzezykeb53NAA==
X-Received: by 2002:a63:2ec1:: with SMTP id u184mr5279906pgu.446.1584550428095;
        Wed, 18 Mar 2020 09:53:48 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m2sm6161190pge.81.2020.03.18.09.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 09:53:47 -0700 (PDT)
Subject: Re: [PATCH 06/18] irqchip: add sl28cpld interrupt controller support
To:     Michael Walle <michael@walle.cc>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-7-michael@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d204c3b0-c3d0-0422-75d9-07718ba2134e@roeck-us.net>
Date:   Wed, 18 Mar 2020 09:53:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200317205017.28280-7-michael@walle.cc>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 3/17/20 1:50 PM, Michael Walle wrote:
> This patch adds support for the interrupt controller inside the sl28
> CPLD management controller.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  drivers/irqchip/Kconfig        |  3 ++
>  drivers/irqchip/Makefile       |  1 +
>  drivers/irqchip/irq-sl28cpld.c | 92 ++++++++++++++++++++++++++++++++++
>  drivers/mfd/Kconfig            |  4 +-
>  4 files changed, 98 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/irqchip/irq-sl28cpld.c
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 24fe08702ef7..3fd7415c8b55 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -246,6 +246,9 @@ config RENESAS_RZA1_IRQC
>  	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use up
>  	  to 8 external interrupts with configurable sense select.
>  
> +config SL28CPLD_INTC
> +	bool
> +
>  config ST_IRQCHIP
>  	bool
>  	select REGMAP
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index eae0d78cbf22..0f4a37782609 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -105,3 +105,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
> +obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
> diff --git a/drivers/irqchip/irq-sl28cpld.c b/drivers/irqchip/irq-sl28cpld.c
> new file mode 100644
> index 000000000000..fa52ed79137b
> --- /dev/null
> +++ b/drivers/irqchip/irq-sl28cpld.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SMARC-sAL28 Interrupt core driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_platform.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/core.h>
> +
> +#define INTC_IE 0
> +#define INTC_IP 1
> +
> +static const struct regmap_irq sl28cpld_irqs[] = {
> +	REGMAP_IRQ_REG_LINE(0, 8),
> +	REGMAP_IRQ_REG_LINE(1, 8),
> +	REGMAP_IRQ_REG_LINE(2, 8),
> +	REGMAP_IRQ_REG_LINE(3, 8),
> +	REGMAP_IRQ_REG_LINE(4, 8),
> +	REGMAP_IRQ_REG_LINE(5, 8),
> +	REGMAP_IRQ_REG_LINE(6, 8),
> +	REGMAP_IRQ_REG_LINE(7, 8),
> +};
> +
> +struct sl28cpld_intc {
> +	struct regmap *regmap;
> +	struct regmap_irq_chip chip;
> +	struct regmap_irq_chip_data *irq_data;
> +};
> +
> +static int sl28cpld_intc_probe(struct platform_device *pdev)
> +{
> +	struct sl28cpld_intc *irqchip;
> +	struct resource *res;
> +	unsigned int irq;
> +	int ret;
> +
> +	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
> +	if (!irqchip)
> +		return -ENOMEM;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
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
> +				       &irqchip->chip, &irqchip->irq_data);
> +	if (ret)
> +		return ret;
> +	dev_info(&pdev->dev, "registered IRQ %d\n", irq);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver sl28cpld_intc_driver = {
> +	.probe	= sl28cpld_intc_probe,
> +	.driver = {
> +		.name = "sl28cpld-intc",
> +	}
> +};
> +module_platform_driver(sl28cpld_intc_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld Interrupt Controller Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 01588c366476..4f741d640705 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2060,12 +2060,12 @@ config SGI_MFD_IOC3
>  	  then say Y. Otherwise say N.
>  
>  config MFD_SL28CPLD
> -	tristate "Kontron sl28 core driver"
> +	bool "Kontron sl28 core driver"

This is .... unusual. Why declare it tristate only to re-declare it bool in the next patch ?
It does explain the I2C=y, but I really think it should be bool from the start if it ends up
there.

>  	depends on I2C=y
>  	depends on OF
>  	select REGMAP_I2C
>  	select REGMAP_IRQ
> -	select SL28CPLD_IRQ
> +	select SL28CPLD_INTC

What is the point of introducing SL28CPLD_IRQ in the first place ?

>  	select MFD_CORE
>  	help
>  	  This option enables support for the board management controller
> 

