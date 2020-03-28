Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF02196816
	for <lists+linux-pwm@lfdr.de>; Sat, 28 Mar 2020 18:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgC1RUY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 28 Mar 2020 13:20:24 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51369 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgC1RUX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 28 Mar 2020 13:20:23 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3828623058;
        Sat, 28 Mar 2020 18:20:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585416019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v0cezBNVL/WJ3daZ5cBul1gFbKy30uqvfk30zxNUGng=;
        b=YkxH5C3lzwqFCH74ys2ZZSfPnnfK3Wem8tDcwhGWojcMnVNK4L0RiYJ+PI6A+e4LasGlHh
        k0W4aFiANK04a4fESOj+62ztvwrYJnSEhIJ5KADQljf24VQH0298PEEylDgOCUs55Kzk3R
        6iWGuLBbEryzz36o7M8f3tMNCjQoKFQ=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sat, 28 Mar 2020 18:20:17 +0100
From:   Michael Walle <michael@walle.cc>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     linux-gpio <linux-gpio@vger.kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
In-Reply-To: <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
Message-ID: <ffd7a0863a6667b85d024f82904f853e@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: 3828623058
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[21];
         NEURAL_HAM(-0.00)[-0.581];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Am 2020-03-18 10:14, schrieb Bartosz Golaszewski:
> wt., 17 mar 2020 o 21:50 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> This adds support for the GPIO controller of the sl28 board management
>> controller. This driver is part of a multi-function device.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Hi Michael,
> 
> thanks for the driver. Please take a look at some comments below.
> 
>> ---
>>  drivers/gpio/Kconfig         |  11 ++
>>  drivers/gpio/Makefile        |   1 +
>>  drivers/gpio/gpio-sl28cpld.c | 332 
>> +++++++++++++++++++++++++++++++++++
>>  3 files changed, 344 insertions(+)
>>  create mode 100644 drivers/gpio/gpio-sl28cpld.c
>> 
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 3cbf8882a0dd..516e47017ef5 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -1211,6 +1211,17 @@ config GPIO_RC5T583
>>           This driver provides the support for driving/reading the 
>> gpio pins
>>           of RC5T583 device through standard gpio library.
>> 
>> +config GPIO_SL28CPLD
>> +       tristate "Kontron sl28 GPIO"
>> +       depends on MFD_SL28CPLD
>> +       depends on OF_GPIO
>> +       select GPIOLIB_IRQCHIP
> 
> Please see below - I think both are not needed.
> 
>> +       help
>> +         This enables support for the GPIOs found on the Kontron sl28 
>> CPLD.
>> +
>> +         This driver can also be built as a module. If so, the module 
>> will be
>> +         called gpio-sl28cpld.
>> +
>>  config GPIO_STMPE
>>         bool "STMPE GPIOs"
>>         depends on MFD_STMPE
>> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>> index 0b571264ddbc..0ca2d52c78e8 100644
>> --- a/drivers/gpio/Makefile
>> +++ b/drivers/gpio/Makefile
>> @@ -127,6 +127,7 @@ obj-$(CONFIG_GPIO_SCH311X)          += 
>> gpio-sch311x.o
>>  obj-$(CONFIG_GPIO_SCH)                 += gpio-sch.o
>>  obj-$(CONFIG_GPIO_SIFIVE)              += gpio-sifive.o
>>  obj-$(CONFIG_GPIO_SIOX)                        += gpio-siox.o
>> +obj-$(CONFIG_GPIO_SL28CPLD)            += gpio-sl28cpld.o
>>  obj-$(CONFIG_GPIO_SODAVILLE)           += gpio-sodaville.o
>>  obj-$(CONFIG_GPIO_SPEAR_SPICS)         += gpio-spear-spics.o
>>  obj-$(CONFIG_GPIO_SPRD)                        += gpio-sprd.o
>> diff --git a/drivers/gpio/gpio-sl28cpld.c 
>> b/drivers/gpio/gpio-sl28cpld.c
>> new file mode 100644
>> index 000000000000..94f82013882f
>> --- /dev/null
>> +++ b/drivers/gpio/gpio-sl28cpld.c
>> @@ -0,0 +1,332 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * SMARC-sAL28 GPIO driver.
>> + *
>> + * Copyright 2019 Kontron Europe GmbH
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_address.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/regmap.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/gpio/driver.h>
>> +
>> +#define GPIO_REG_DIR   0
>> +#define GPIO_REG_OUT   1
>> +#define GPIO_REG_IN    2
>> +#define GPIO_REG_IE    3
>> +#define GPIO_REG_IP    4
> 
> These values would be more clear if they were defined as hex.
> 
>> +
>> +#define GPI_REG_IN     0
>> +
>> +#define GPO_REG_OUT    0
> 
> Please also use a common prefix even for defines.
> 
>> +
>> +enum sl28cpld_gpio_type {
>> +       sl28cpld_gpio,
>> +       sl28cpld_gpi,
>> +       sl28cpld_gpo,
>> +};
> 
> Enum values should be all upper-case.
> 
>> +
>> +struct sl28cpld_gpio {
>> +       struct gpio_chip gpio_chip;
>> +       struct irq_chip irq_chip;
>> +       struct regmap *regmap;
>> +       u32 offset;
>> +       struct mutex lock;
>> +       u8 ie;
>> +};
>> +
>> +static void sl28cpld_gpio_set_reg(struct gpio_chip *chip, unsigned 
>> int reg,
>> +                                 unsigned int offset, int value)
>> +{
>> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> +       unsigned int mask = 1 << offset;
>> +       unsigned int val = value << offset;
>> +
>> +       regmap_update_bits(gpio->regmap, gpio->offset + reg, mask, 
>> val);
>> +}
>> +
>> +static void sl28cpld_gpio_set(struct gpio_chip *chip, unsigned int 
>> offset,
>> +                             int value)
>> +{
>> +       sl28cpld_gpio_set_reg(chip, GPIO_REG_OUT, offset, value);
>> +}
>> +
>> +static void sl28cpld_gpo_set(struct gpio_chip *chip, unsigned int 
>> offset,
>> +                            int value)
>> +{
>> +       sl28cpld_gpio_set_reg(chip, GPO_REG_OUT, offset, value);
>> +}
>> +
>> +static int sl28cpld_gpio_get_reg(struct gpio_chip *chip, unsigned int 
>> reg,
>> +                                unsigned int offset)
>> +{
>> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> +       unsigned int mask = 1 << offset;
>> +       unsigned int val;
>> +       int ret;
>> +
>> +       ret = regmap_read(gpio->regmap, gpio->offset + reg, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return (val & mask) ? 1 : 0;
>> +}
>> +
>> +static int sl28cpld_gpio_get(struct gpio_chip *chip, unsigned int 
>> offset)
>> +{
>> +       return sl28cpld_gpio_get_reg(chip, GPIO_REG_IN, offset);
>> +}
>> +
>> +static int sl28cpld_gpi_get(struct gpio_chip *chip, unsigned int 
>> offset)
>> +{
>> +       return sl28cpld_gpio_get_reg(chip, GPI_REG_IN, offset);
>> +}
>> +
>> +static int sl28cpld_gpio_get_direction(struct gpio_chip *chip,
>> +                                      unsigned int offset)
>> +{
>> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> +       unsigned int reg;
>> +       int ret;
>> +
>> +       ret = regmap_read(gpio->regmap, gpio->offset + GPIO_REG_DIR, 
>> &reg);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (reg & (1 << offset))
>> +               return GPIO_LINE_DIRECTION_OUT;
>> +       else
>> +               return GPIO_LINE_DIRECTION_IN;
>> +}
>> +
>> +static int sl28cpld_gpio_set_direction(struct gpio_chip *chip,
>> +                                      unsigned int offset,
>> +                                      bool output)
>> +{
>> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> +       unsigned int mask = 1 << offset;
>> +       unsigned int val = (output) ? mask : 0;
>> +
>> +       return regmap_update_bits(gpio->regmap, gpio->offset + 
>> GPIO_REG_DIR,
>> +                                 mask, val);
>> +
> 
> Stray newline.
> 
>> +}
>> +
>> +static int sl28cpld_gpio_direction_input(struct gpio_chip *chip,
>> +                                        unsigned int offset)
>> +{
>> +       return sl28cpld_gpio_set_direction(chip, offset, false);
>> +}
>> +
>> +static int sl28cpld_gpio_direction_output(struct gpio_chip *chip,
>> +                                         unsigned int offset, int 
>> value)
>> +{
>> +       sl28cpld_gpio_set_reg(chip, GPIO_REG_OUT, offset, value);
>> +       return sl28cpld_gpio_set_direction(chip, offset, true);
>> +}
>> +
>> +static void sl28cpld_gpio_irq_lock(struct irq_data *data)
>> +{
>> +       struct sl28cpld_gpio *gpio =
>> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> +
>> +       mutex_lock(&gpio->lock);
> 
> How does that actually lock anything? Regmap uses a different lock and
> if you want to make sure nobody modifies the GPIO registers than you'd
> need to use the same lock. Also: this looks a lot like a task for
> regmap_irqchip - maybe you could use it here or in the core mfd
> module?
> 
>> +}
>> +
>> +static void sl28cpld_gpio_irq_sync_unlock(struct irq_data *data)
>> +{
>> +       struct sl28cpld_gpio *gpio =
>> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> +
>> +       regmap_write(gpio->regmap, gpio->offset + GPIO_REG_IE, 
>> gpio->ie);
>> +       mutex_unlock(&gpio->lock);
>> +}
>> +
>> +static void sl28cpld_gpio_irq_disable(struct irq_data *data)
>> +{
>> +       struct sl28cpld_gpio *gpio =
>> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> +
>> +       if (data->hwirq >= 8)
>> +               return;
>> +
>> +       gpio->ie &= ~(1 << data->hwirq);
>> +}
>> +
>> +static void sl28cpld_gpio_irq_enable(struct irq_data *data)
>> +{
>> +       struct sl28cpld_gpio *gpio =
>> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> +
>> +       if (data->hwirq >= 8)
>> +               return;
>> +
>> +       gpio->ie |= (1 << data->hwirq);
>> +}
>> +
>> +static int sl28cpld_gpio_irq_set_type(struct irq_data *data, unsigned 
>> int type)
>> +{
>> +       /* only edge triggered interrupts on both edges are supported 
>> */
>> +       return (type == IRQ_TYPE_EDGE_BOTH) ? 0 : -EINVAL;
>> +}
>> +
>> +static irqreturn_t sl28cpld_gpio_irq_thread(int irq, void *data)
>> +{
>> +       struct sl28cpld_gpio *gpio = data;
>> +       unsigned int ip;
>> +       unsigned int virq;
>> +       int pin;
>> +       int ret;
>> +
>> +       ret = regmap_read(gpio->regmap, gpio->offset + GPIO_REG_IP, 
>> &ip);
>> +       if (ret)
>> +               return IRQ_NONE;
>> +
>> +       /* mask other pending interrupts which are not enabled */
>> +       ip &= gpio->ie;
>> +
>> +       /* ack the interrupts */
>> +       regmap_write(gpio->regmap, gpio->offset + GPIO_REG_IP, ip);
>> +
>> +       /* and handle them */
>> +       while (ip) {
>> +               pin = __ffs(ip);
>> +               ip &= ~BIT(pin);
>> +
>> +               virq = irq_find_mapping(gpio->gpio_chip.irq.domain, 
>> pin);
>> +               if (virq)
>> +                       handle_nested_irq(virq);
>> +       }
>> +
>> +       return IRQ_HANDLED;
>> +}
> 
> This definitely looks like parts of regmap_irqchip reimplemented.
> Please check if you could reuse it - it would save a lot of code.
> 
>> +
>> +static int sl28_cpld_gpio_irq_init(struct platform_device *pdev, int 
>> irq)
>> +{
>> +       struct sl28cpld_gpio *gpio = platform_get_drvdata(pdev);
>> +       struct irq_chip *irq_chip = &gpio->irq_chip;
>> +       int ret;
>> +
>> +       irq_chip->name = "sl28cpld-gpio-irq",
>> +       irq_chip->irq_bus_lock = sl28cpld_gpio_irq_lock,
>> +       irq_chip->irq_bus_sync_unlock = sl28cpld_gpio_irq_sync_unlock,
>> +       irq_chip->irq_disable = sl28cpld_gpio_irq_disable,
>> +       irq_chip->irq_enable = sl28cpld_gpio_irq_enable,
>> +       irq_chip->irq_set_type = sl28cpld_gpio_irq_set_type,
>> +       irq_chip->flags = IRQCHIP_SKIP_SET_WAKE,
>> +
>> +       ret = gpiochip_irqchip_add_nested(&gpio->gpio_chip, irq_chip, 
>> 0,
>> +                                         handle_simple_irq, 
>> IRQ_TYPE_NONE);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>> +                                       sl28cpld_gpio_irq_thread,
>> +                                       IRQF_SHARED | IRQF_ONESHOT,
>> +                                       pdev->name, gpio);
>> +       if (ret)
>> +               return ret;
>> +
>> +       gpiochip_set_nested_irqchip(&gpio->gpio_chip, irq_chip, irq);
>> +
>> +       return 0;
>> +}
>> +
>> +static int sl28cpld_gpio_probe(struct platform_device *pdev)
>> +{
>> +       enum sl28cpld_gpio_type type =
>> +               platform_get_device_id(pdev)->driver_data;
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct sl28cpld_gpio *gpio;
>> +       struct gpio_chip *chip;
>> +       struct resource *res;
>> +       bool irq_support = false;
>> +       int ret;
>> +       int irq;
>> +
>> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>> +       if (!gpio)
>> +               return -ENOMEM;
>> +
>> +       if (!pdev->dev.parent)
>> +               return -ENODEV;
> 
> Why not check this before allocating any memory?
> 
>> +
>> +       gpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> +       if (!gpio->regmap)
>> +               return -ENODEV;
>> +
>> +       res = platform_get_resource(pdev, IORESOURCE_REG, 0);
>> +       if (!res)
>> +               return -EINVAL;
>> +       gpio->offset = res->start;
>> +
> 
> This isn't how IO resources are used. What are you trying to achieve 
> here?
> 
>> +       /* initialize struct gpio_chip */
>> +       mutex_init(&gpio->lock);
>> +       chip = &gpio->gpio_chip;
>> +       chip->parent = &pdev->dev;
>> +       chip->label = dev_name(&pdev->dev);
>> +       chip->owner = THIS_MODULE;
>> +       chip->can_sleep = true;
>> +       chip->base = -1;
>> +       chip->ngpio = 8;
>> +
>> +       switch (type) {
>> +       case sl28cpld_gpio:
>> +               chip->get_direction = sl28cpld_gpio_get_direction;
>> +               chip->direction_input = sl28cpld_gpio_direction_input;
>> +               chip->direction_output = 
>> sl28cpld_gpio_direction_output;
>> +               chip->get = sl28cpld_gpio_get;
>> +               chip->set = sl28cpld_gpio_set;
>> +               irq_support = true;
>> +               break;
>> +       case sl28cpld_gpo:
>> +               chip->set = sl28cpld_gpo_set;
>> +               chip->get = sl28cpld_gpi_get;
>> +               break;
>> +       case sl28cpld_gpi:
>> +               chip->get = sl28cpld_gpi_get;
>> +               break;
>> +       }
>> +
>> +       ret = devm_gpiochip_add_data(&pdev->dev, chip, gpio);
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       platform_set_drvdata(pdev, gpio);
>> +
>> +       if (irq_support && of_property_read_bool(np, 
>> "interrupt-controller")) {
> 
> You're depending on OF_GPIO for this one function. Please switch to
> device_property_read_bool() instead.
> 
>> +               irq = platform_get_irq(pdev, 0);
>> +               if (irq < 0)
>> +                       return ret;
>> +
>> +               ret = sl28_cpld_gpio_irq_init(pdev, irq);
>> +               if (ret)
>> +                       return ret;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static const struct platform_device_id sl28cpld_gpio_id_table[] = {
>> +       {"sl28cpld-gpio", sl28cpld_gpio},
>> +       {"sl28cpld-gpi", sl28cpld_gpi},
>> +       {"sl28cpld-gpo", sl28cpld_gpo},
> 
> Could you explain this a bit more? Is this the same component with
> input/output-only lines or three different components?
> 
>> +};
>> +MODULE_DEVICE_TABLE(platform, sl28cpld_gpio_id_table);
>> +
>> +static struct platform_driver sl28cpld_gpio_driver = {
>> +       .probe = sl28cpld_gpio_probe,
>> +       .id_table = sl28cpld_gpio_id_table,
>> +       .driver = {
>> +               .name = "sl28cpld-gpio",
>> +       },
>> +};
>> +module_platform_driver(sl28cpld_gpio_driver);
>> +
>> +MODULE_DESCRIPTION("sl28cpld GPIO Driver");
>> +MODULE_LICENSE("GPL");
> 
> I think you could use a MODULE_ALIAS() here if you want this module to
> be loaded automatically by udev.

Turns out MODULE_ALIAS("platform:..") isn't working with mfd and
OF_MFD_CELL(), because the match is done on "of:.." module aliases.
So I guess I'll need a of_device_id array after all, although the
matching for the mfd is via the platform driver name.

-michael
