Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F16E18A118
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 18:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgCRRGV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 13:06:21 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:38449 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbgCRRGU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 13:06:20 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0B25323E23;
        Wed, 18 Mar 2020 18:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584551176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+BzEmMtMkIm9pkTWsaE8j06DDMEY6BVuLsFQGlnKcJ0=;
        b=JbQK6/uyWu+wXuG4LMc3Czk4oN6bNCGoRTGV4FgIJ+Da0Ixwllyo6pL7iT/iynMiv4myfR
        pgzGQMsrZyhrOilkRSGJ8ABf+H3KdDVaOMok58DDupsTHqFqVh58oJfgP1he+JUeffsAL8
        xZwd9d2c4cOoABs8aiJCyWy5FLgD61w=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 18 Mar 2020 18:06:15 +0100
From:   Michael Walle <michael@walle.cc>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 06/18] irqchip: add sl28cpld interrupt controller support
In-Reply-To: <d204c3b0-c3d0-0422-75d9-07718ba2134e@roeck-us.net>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-7-michael@walle.cc>
 <d204c3b0-c3d0-0422-75d9-07718ba2134e@roeck-us.net>
Message-ID: <b9661afeda9fc6413b2fe392f254c685@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 0B25323E23
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[22];
         NEURAL_HAM(-0.00)[-0.616];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,baylibre.com,kernel.org,suse.com,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-03-18 17:53, schrieb Guenter Roeck:
> On 3/17/20 1:50 PM, Michael Walle wrote:
>> This patch adds support for the interrupt controller inside the sl28
>> CPLD management controller.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  drivers/irqchip/Kconfig        |  3 ++
>>  drivers/irqchip/Makefile       |  1 +
>>  drivers/irqchip/irq-sl28cpld.c | 92 
>> ++++++++++++++++++++++++++++++++++
>>  drivers/mfd/Kconfig            |  4 +-
>>  4 files changed, 98 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/irqchip/irq-sl28cpld.c
>> 
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 24fe08702ef7..3fd7415c8b55 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -246,6 +246,9 @@ config RENESAS_RZA1_IRQC
>>  	  Enable support for the Renesas RZ/A1 Interrupt Controller, to use 
>> up
>>  	  to 8 external interrupts with configurable sense select.
>> 
>> +config SL28CPLD_INTC
>> +	bool
>> +
>>  config ST_IRQCHIP
>>  	bool
>>  	select REGMAP
>> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
>> index eae0d78cbf22..0f4a37782609 100644
>> --- a/drivers/irqchip/Makefile
>> +++ b/drivers/irqchip/Makefile
>> @@ -105,3 +105,4 @@ obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
>>  obj-$(CONFIG_LS1X_IRQ)			+= irq-ls1x.o
>>  obj-$(CONFIG_TI_SCI_INTR_IRQCHIP)	+= irq-ti-sci-intr.o
>>  obj-$(CONFIG_TI_SCI_INTA_IRQCHIP)	+= irq-ti-sci-inta.o
>> +obj-$(CONFIG_SL28CPLD_INTC)		+= irq-sl28cpld.o
>> diff --git a/drivers/irqchip/irq-sl28cpld.c 
>> b/drivers/irqchip/irq-sl28cpld.c
>> new file mode 100644
>> index 000000000000..fa52ed79137b
>> --- /dev/null
>> +++ b/drivers/irqchip/irq-sl28cpld.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * SMARC-sAL28 Interrupt core driver.
>> + *
>> + * Copyright 2019 Kontron Europe GmbH
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_platform.h>
>> +#include <linux/i2c.h>
>> +#include <linux/regmap.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/mfd/core.h>
>> +
>> +#define INTC_IE 0
>> +#define INTC_IP 1
>> +
>> +static const struct regmap_irq sl28cpld_irqs[] = {
>> +	REGMAP_IRQ_REG_LINE(0, 8),
>> +	REGMAP_IRQ_REG_LINE(1, 8),
>> +	REGMAP_IRQ_REG_LINE(2, 8),
>> +	REGMAP_IRQ_REG_LINE(3, 8),
>> +	REGMAP_IRQ_REG_LINE(4, 8),
>> +	REGMAP_IRQ_REG_LINE(5, 8),
>> +	REGMAP_IRQ_REG_LINE(6, 8),
>> +	REGMAP_IRQ_REG_LINE(7, 8),
>> +};
>> +
>> +struct sl28cpld_intc {
>> +	struct regmap *regmap;
>> +	struct regmap_irq_chip chip;
>> +	struct regmap_irq_chip_data *irq_data;
>> +};
>> +
>> +static int sl28cpld_intc_probe(struct platform_device *pdev)
>> +{
>> +	struct sl28cpld_intc *irqchip;
>> +	struct resource *res;
>> +	unsigned int irq;
>> +	int ret;
>> +
>> +	irqchip = devm_kzalloc(&pdev->dev, sizeof(*irqchip), GFP_KERNEL);
>> +	if (!irqchip)
>> +		return -ENOMEM;
>> +
>> +	if (!pdev->dev.parent)
>> +		return -ENODEV;
>> +
>> +	irqchip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +	if (!irqchip->regmap)
>> +		return -ENODEV;
>> +
>> +	irq = platform_get_irq(pdev, 0);
>> +	if (irq < 0)
>> +		return irq;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_REG, 0);
>> +	if (!res)
>> +		return -EINVAL;
>> +
>> +	irqchip->chip.name = "sl28cpld-intc";
>> +	irqchip->chip.irqs = sl28cpld_irqs;
>> +	irqchip->chip.num_irqs = ARRAY_SIZE(sl28cpld_irqs);
>> +	irqchip->chip.num_regs = 1;
>> +	irqchip->chip.status_base = res->start + INTC_IP;
>> +	irqchip->chip.mask_base = res->start + INTC_IE;
>> +	irqchip->chip.mask_invert = true,
>> +	irqchip->chip.ack_base = res->start + INTC_IP;
>> +
>> +	ret = devm_regmap_add_irq_chip(&pdev->dev, irqchip->regmap, irq,
>> +				       IRQF_SHARED | IRQF_ONESHOT, 0,
>> +				       &irqchip->chip, &irqchip->irq_data);
>> +	if (ret)
>> +		return ret;
>> +	dev_info(&pdev->dev, "registered IRQ %d\n", irq);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver sl28cpld_intc_driver = {
>> +	.probe	= sl28cpld_intc_probe,
>> +	.driver = {
>> +		.name = "sl28cpld-intc",
>> +	}
>> +};
>> +module_platform_driver(sl28cpld_intc_driver);
>> +
>> +MODULE_DESCRIPTION("sl28cpld Interrupt Controller Driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 01588c366476..4f741d640705 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -2060,12 +2060,12 @@ config SGI_MFD_IOC3
>>  	  then say Y. Otherwise say N.
>> 
>>  config MFD_SL28CPLD
>> -	tristate "Kontron sl28 core driver"
>> +	bool "Kontron sl28 core driver"
> 
> This is .... unusual. Why declare it tristate only to re-declare it
> bool in the next patch ?

I though it was a good idea to have that gradually build up, esp. since
these patches might go through different reviewers/trees. That being 
said,
I'll change it though.

> It does explain the I2C=y, but I really think it should be bool from
> the start if it ends up
> there.

Ok.

> 
>>  	depends on I2C=y
>>  	depends on OF
>>  	select REGMAP_I2C
>>  	select REGMAP_IRQ
>> -	select SL28CPLD_IRQ
>> +	select SL28CPLD_INTC
> 
> What is the point of introducing SL28CPLD_IRQ in the first place ?

oh damn. this is a left-over which slipped through. There should just
be a SL28CPLD_INTC.

-michael

> 
>>  	select MFD_CORE
>>  	help
>>  	  This option enables support for the board management controller
>> 
