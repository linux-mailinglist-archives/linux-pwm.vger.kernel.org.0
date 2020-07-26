Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803A622DD9E
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgGZJRD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 05:17:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:10437 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGZJRC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 26 Jul 2020 05:17:02 -0400
IronPort-SDR: OgWPkqgRFMxAk4rgL+8N0p6+IjP3b+ZbihiXJ33/SYcBxcuyTQR1Dqtc+QI4sQ0TWTb2WTqw2b
 QxMQ+nEQz2fA==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="212416230"
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="212416230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 02:17:01 -0700
IronPort-SDR: ZgSPk1ssu/xiZu9maGPN2yybs16U4fdeE2KItTzKSLVwKU+Huoi3hKe7JY76INlceA0JhcrSvq
 v6AyoUowyULA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,398,1589266800"; 
   d="scan'208";a="433543550"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2020 02:16:55 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jzcm5-0045ra-Vj; Sun, 26 Jul 2020 12:16:53 +0300
Date:   Sun, 26 Jul 2020 12:16:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v6 07/13] gpio: add support for the sl28cpld GPIO
 controller
Message-ID: <20200726091653.GK3703480@smile.fi.intel.com>
References: <20200725231834.25642-1-michael@walle.cc>
 <20200725231834.25642-8-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725231834.25642-8-michael@walle.cc>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jul 26, 2020 at 01:18:28AM +0200, Michael Walle wrote:
> Add support for the GPIO controller of the sl28 board management
> controller. This driver is part of a multi-function device.
> 
> A controller has 8 lines. There are three different flavors:
> full-featured GPIO with interrupt support, input-only and output-only.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Michael Walle <michael@walle.cc>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes since v5:
>  - added "select REGMAP_IRQ"
> 
> Changes since v4:
>  - update copyright year
>  - remove #include <linux/of_device.h>, suggested by Andy.
>  - use device_get_match_data(), suggested by Andy.
>  - drop the irq_support variable, instead call _init_irq() directly,
>    suggested by Andy.
>  - also move the irq code a bit around to make it look nicer
>  - drop "struct sl28cpld_gpio". We don't need to actually store the
>    irq_chip and irq_chip_data, everything is device resource managed.
>  - use 100 chars line limit, suggested by Andy.
>  - remove the platform device table
>  - don't use KBUID_MODNAME
> 
> Changes since v3:
>  - see cover letter
> 
>  drivers/gpio/Kconfig         |  12 +++
>  drivers/gpio/Makefile        |   1 +
>  drivers/gpio/gpio-sl28cpld.c | 161 +++++++++++++++++++++++++++++++++++
>  3 files changed, 174 insertions(+)
>  create mode 100644 drivers/gpio/gpio-sl28cpld.c
> 
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8030fd91a3cc..f6a547b76432 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1223,6 +1223,18 @@ config GPIO_RC5T583
>  	  This driver provides the support for driving/reading the gpio pins
>  	  of RC5T583 device through standard gpio library.
>  
> +config GPIO_SL28CPLD
> +	tristate "Kontron sl28cpld GPIO support"
> +	select MFD_SIMPLE_MFD_I2C
> +	select GPIO_REGMAP
> +	select GPIOLIB_IRQCHIP
> +	select REGMAP_IRQ
> +	help
> +	  This enables support for the GPIOs found on the Kontron sl28 CPLD.
> +
> +	  This driver can also be built as a module. If so, the module will be
> +	  called gpio-sl28cpld.
> +
>  config GPIO_STMPE
>  	bool "STMPE GPIOs"
>  	depends on MFD_STMPE
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 4f9abff4f2dc..c3a4e7c94a91 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -132,6 +132,7 @@ obj-$(CONFIG_GPIO_SCH311X)		+= gpio-sch311x.o
>  obj-$(CONFIG_GPIO_SCH)			+= gpio-sch.o
>  obj-$(CONFIG_GPIO_SIFIVE)		+= gpio-sifive.o
>  obj-$(CONFIG_GPIO_SIOX)			+= gpio-siox.o
> +obj-$(CONFIG_GPIO_SL28CPLD)		+= gpio-sl28cpld.o
>  obj-$(CONFIG_GPIO_SODAVILLE)		+= gpio-sodaville.o
>  obj-$(CONFIG_GPIO_SPEAR_SPICS)		+= gpio-spear-spics.o
>  obj-$(CONFIG_GPIO_SPRD)			+= gpio-sprd.o
> diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
> new file mode 100644
> index 000000000000..889b8f5622c2
> --- /dev/null
> +++ b/drivers/gpio/gpio-sl28cpld.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * sl28cpld GPIO driver
> + *
> + * Copyright 2020 Michael Walle <michael@walle.cc>
> + */
> +
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/regmap.h>
> +#include <linux/interrupt.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +/* GPIO flavor */
> +#define GPIO_REG_DIR	0x00
> +#define GPIO_REG_OUT	0x01
> +#define GPIO_REG_IN	0x02
> +#define GPIO_REG_IE	0x03
> +#define GPIO_REG_IP	0x04
> +
> +/* input-only flavor */
> +#define GPI_REG_IN	0x00
> +
> +/* output-only flavor */
> +#define GPO_REG_OUT	0x00
> +
> +enum sl28cpld_gpio_type {
> +	SL28CPLD_GPIO = 1,
> +	SL28CPLD_GPI,
> +	SL28CPLD_GPO,
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
> +
> +static int sl28cpld_gpio_irq_init(struct platform_device *pdev,
> +				  unsigned int base,
> +				  struct gpio_regmap_config *config)
> +{
> +	struct regmap_irq_chip_data *irq_data;
> +	struct regmap_irq_chip *irq_chip;
> +	struct device *dev = &pdev->dev;
> +	int irq, ret;
> +
> +	if (!device_property_read_bool(dev, "interrupt-controller"))
> +		return 0;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
> +	if (!irq_chip)
> +		return -ENOMEM;
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
> +	ret = devm_regmap_add_irq_chip_fwnode(dev, dev_fwnode(dev),
> +					      config->regmap, irq,
> +					      IRQF_SHARED | IRQF_ONESHOT,
> +					      0, irq_chip, &irq_data);
> +	if (ret)
> +		return ret;
> +
> +	config->irq_domain = regmap_irq_get_domain(irq_data);
> +
> +	return 0;
> +}
> +
> +static int sl28cpld_gpio_probe(struct platform_device *pdev)
> +{
> +	struct gpio_regmap_config config = {0};
> +	enum sl28cpld_gpio_type type;
> +	struct regmap *regmap;
> +	u32 base;
> +	int ret;
> +
> +	if (!pdev->dev.parent)
> +		return -ENODEV;
> +
> +	type = (uintptr_t)device_get_match_data(&pdev->dev);
> +	if (!type)
> +		return -ENODEV;
> +
> +	ret = device_property_read_u32(&pdev->dev, "reg", &base);
> +	if (ret)
> +		return -EINVAL;
> +
> +	regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!regmap)
> +		return -ENODEV;
> +
> +	config.regmap = regmap;
> +	config.parent = &pdev->dev;
> +	config.ngpio = 8;
> +
> +	switch (type) {
> +	case SL28CPLD_GPIO:
> +		config.reg_dat_base = base + GPIO_REG_IN;
> +		config.reg_set_base = base + GPIO_REG_OUT;
> +		/* reg_dir_out_base might be zero */
> +		config.reg_dir_out_base = GPIO_REGMAP_ADDR(base + GPIO_REG_DIR);
> +
> +		/* This type supports interrupts */
> +		ret = sl28cpld_gpio_irq_init(pdev, base, &config);
> +		if (ret)
> +			return ret;
> +		break;
> +	case SL28CPLD_GPO:
> +		config.reg_set_base = base + GPO_REG_OUT;
> +		break;
> +	case SL28CPLD_GPI:
> +		config.reg_dat_base = base + GPI_REG_IN;
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "unknown type %d\n", type);
> +		return -ENODEV;
> +	}
> +
> +	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(&pdev->dev, &config));
> +}
> +
> +static const struct of_device_id sl28cpld_gpio_of_match[] = {
> +	{ .compatible = "kontron,sl28cpld-gpio", .data = (void *)SL28CPLD_GPIO },
> +	{ .compatible = "kontron,sl28cpld-gpi", .data = (void *)SL28CPLD_GPI },
> +	{ .compatible = "kontron,sl28cpld-gpo", .data = (void *)SL28CPLD_GPO },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, sl28cpld_gpio_of_match);
> +
> +static struct platform_driver sl28cpld_gpio_driver = {
> +	.probe = sl28cpld_gpio_probe,
> +	.driver = {
> +		.name = "sl28cpld-gpio",
> +		.of_match_table = sl28cpld_gpio_of_match,
> +	},
> +};
> +module_platform_driver(sl28cpld_gpio_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld GPIO Driver");
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_LICENSE("GPL");
> -- 
> 2.20.1
> 

-- 
With Best Regards,
Andy Shevchenko


