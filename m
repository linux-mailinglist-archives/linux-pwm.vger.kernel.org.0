Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB41194842
	for <lists+linux-pwm@lfdr.de>; Thu, 26 Mar 2020 21:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgCZUGG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 26 Mar 2020 16:06:06 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45133 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgCZUGF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 26 Mar 2020 16:06:05 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DA8F82222E;
        Thu, 26 Mar 2020 21:05:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1585253161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6Su5YbX7HX5TxViPoYjV7m52PeSCqZzDYRmf1SJwLiQ=;
        b=mytuH9Rsozp23uOCtqTLsuIxKzxIv3pikEjfuolYqQAWHnTTK4Q3bH4DgbOFT3BB8K2zRm
        1leCC+kAJw9QIwlV3IG4F1Ntn/0PuVoTapAptLv8ArOB6AfQV9IRTGmi8WRch0GZaa071m
        51MNI7pIr714EcxPTxuv7pOqYrdddGw=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 26 Mar 2020 21:05:51 +0100
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
In-Reply-To: <CAMpxmJXmD-M+Wbj6=wgFgP2aDxbqDN=ceHi1XDun4iwdLm55Zg@mail.gmail.com>
References: <20200317205017.28280-1-michael@walle.cc>
 <20200317205017.28280-13-michael@walle.cc>
 <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
 <9c310f2a11913d4d089ef1b07671be00@walle.cc>
 <CAMpxmJXmD-M+Wbj6=wgFgP2aDxbqDN=ceHi1XDun4iwdLm55Zg@mail.gmail.com>
Message-ID: <22944c9b62aa69da418de7766b7741bd@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: DA8F82222E
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[21];
         NEURAL_HAM(-0.00)[-0.467];
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

Hi Bartosz,

Am 2020-03-25 12:50, schrieb Bartosz Golaszewski:
> śr., 18 mar 2020 o 13:45 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> Hi Bartosz,
>> 
>> Am 2020-03-18 10:14, schrieb Bartosz Golaszewski:
>> > wt., 17 mar 2020 o 21:50 Michael Walle <michael@walle.cc> napisał(a):
>> >>
>> >> This adds support for the GPIO controller of the sl28 board management
>> >> controller. This driver is part of a multi-function device.
>> >>
>> >> Signed-off-by: Michael Walle <michael@walle.cc>
>> >
>> > Hi Michael,
>> >
>> > thanks for the driver. Please take a look at some comments below.
>> 
>> well, thank you for the very fast review!
>> 
>> >> ---
>> >>  drivers/gpio/Kconfig         |  11 ++
>> >>  drivers/gpio/Makefile        |   1 +
>> >>  drivers/gpio/gpio-sl28cpld.c | 332
>> >> +++++++++++++++++++++++++++++++++++
>> >>  3 files changed, 344 insertions(+)
>> >>  create mode 100644 drivers/gpio/gpio-sl28cpld.c
>> >>
>> >> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> >> index 3cbf8882a0dd..516e47017ef5 100644
>> >> --- a/drivers/gpio/Kconfig
>> >> +++ b/drivers/gpio/Kconfig
>> >> @@ -1211,6 +1211,17 @@ config GPIO_RC5T583
>> >>           This driver provides the support for driving/reading the
>> >> gpio pins
>> >>           of RC5T583 device through standard gpio library.
>> >>
>> >> +config GPIO_SL28CPLD
>> >> +       tristate "Kontron sl28 GPIO"
>> >> +       depends on MFD_SL28CPLD
>> >> +       depends on OF_GPIO
>> >> +       select GPIOLIB_IRQCHIP
>> >
>> > Please see below - I think both are not needed.
>> >
>> >> +       help
>> >> +         This enables support for the GPIOs found on the Kontron sl28
>> >> CPLD.
>> >> +
>> >> +         This driver can also be built as a module. If so, the module
>> >> will be
>> >> +         called gpio-sl28cpld.
>> >> +
>> >>  config GPIO_STMPE
>> >>         bool "STMPE GPIOs"
>> >>         depends on MFD_STMPE
>> >> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>> >> index 0b571264ddbc..0ca2d52c78e8 100644
>> >> --- a/drivers/gpio/Makefile
>> >> +++ b/drivers/gpio/Makefile
>> >> @@ -127,6 +127,7 @@ obj-$(CONFIG_GPIO_SCH311X)          +=
>> >> gpio-sch311x.o
>> >>  obj-$(CONFIG_GPIO_SCH)                 += gpio-sch.o
>> >>  obj-$(CONFIG_GPIO_SIFIVE)              += gpio-sifive.o
>> >>  obj-$(CONFIG_GPIO_SIOX)                        += gpio-siox.o
>> >> +obj-$(CONFIG_GPIO_SL28CPLD)            += gpio-sl28cpld.o
>> >>  obj-$(CONFIG_GPIO_SODAVILLE)           += gpio-sodaville.o
>> >>  obj-$(CONFIG_GPIO_SPEAR_SPICS)         += gpio-spear-spics.o
>> >>  obj-$(CONFIG_GPIO_SPRD)                        += gpio-sprd.o
>> >> diff --git a/drivers/gpio/gpio-sl28cpld.c
>> >> b/drivers/gpio/gpio-sl28cpld.c
>> >> new file mode 100644
>> >> index 000000000000..94f82013882f
>> >> --- /dev/null
>> >> +++ b/drivers/gpio/gpio-sl28cpld.c
>> >> @@ -0,0 +1,332 @@
>> >> +// SPDX-License-Identifier: GPL-2.0-only
>> >> +/*
>> >> + * SMARC-sAL28 GPIO driver.
>> >> + *
>> >> + * Copyright 2019 Kontron Europe GmbH
>> >> + */
>> >> +
>> >> +#include <linux/kernel.h>
>> >> +#include <linux/module.h>
>> >> +#include <linux/of.h>
>> >> +#include <linux/of_device.h>
>> >> +#include <linux/of_address.h>
>> >> +#include <linux/interrupt.h>
>> >> +#include <linux/regmap.h>
>> >> +#include <linux/platform_device.h>
>> >> +#include <linux/gpio/driver.h>
>> >> +
>> >> +#define GPIO_REG_DIR   0
>> >> +#define GPIO_REG_OUT   1
>> >> +#define GPIO_REG_IN    2
>> >> +#define GPIO_REG_IE    3
>> >> +#define GPIO_REG_IP    4
>> >
>> > These values would be more clear if they were defined as hex.
>> >
>> >> +
>> >> +#define GPI_REG_IN     0
>> >> +
>> >> +#define GPO_REG_OUT    0
>> >
>> > Please also use a common prefix even for defines.
>> 
>> ok
>> 
>> >
>> >> +
>> >> +enum sl28cpld_gpio_type {
>> >> +       sl28cpld_gpio,
>> >> +       sl28cpld_gpi,
>> >> +       sl28cpld_gpo,
>> >> +};
>> >
>> > Enum values should be all upper-case.
>> 
>> ok
>> 
>> >> +
>> >> +struct sl28cpld_gpio {
>> >> +       struct gpio_chip gpio_chip;
>> >> +       struct irq_chip irq_chip;
>> >> +       struct regmap *regmap;
>> >> +       u32 offset;
>> >> +       struct mutex lock;
>> >> +       u8 ie;
>> >> +};
>> >> +
>> >> +static void sl28cpld_gpio_set_reg(struct gpio_chip *chip, unsigned
>> >> int reg,
>> >> +                                 unsigned int offset, int value)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> >> +       unsigned int mask = 1 << offset;
>> >> +       unsigned int val = value << offset;
>> >> +
>> >> +       regmap_update_bits(gpio->regmap, gpio->offset + reg, mask,
>> >> val);
>> >> +}
>> >> +
>> >> +static void sl28cpld_gpio_set(struct gpio_chip *chip, unsigned int
>> >> offset,
>> >> +                             int value)
>> >> +{
>> >> +       sl28cpld_gpio_set_reg(chip, GPIO_REG_OUT, offset, value);
>> >> +}
>> >> +
>> >> +static void sl28cpld_gpo_set(struct gpio_chip *chip, unsigned int
>> >> offset,
>> >> +                            int value)
>> >> +{
>> >> +       sl28cpld_gpio_set_reg(chip, GPO_REG_OUT, offset, value);
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_get_reg(struct gpio_chip *chip, unsigned int
>> >> reg,
>> >> +                                unsigned int offset)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> >> +       unsigned int mask = 1 << offset;
>> >> +       unsigned int val;
>> >> +       int ret;
>> >> +
>> >> +       ret = regmap_read(gpio->regmap, gpio->offset + reg, &val);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       return (val & mask) ? 1 : 0;
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_get(struct gpio_chip *chip, unsigned int
>> >> offset)
>> >> +{
>> >> +       return sl28cpld_gpio_get_reg(chip, GPIO_REG_IN, offset);
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpi_get(struct gpio_chip *chip, unsigned int
>> >> offset)
>> >> +{
>> >> +       return sl28cpld_gpio_get_reg(chip, GPI_REG_IN, offset);
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_get_direction(struct gpio_chip *chip,
>> >> +                                      unsigned int offset)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> >> +       unsigned int reg;
>> >> +       int ret;
>> >> +
>> >> +       ret = regmap_read(gpio->regmap, gpio->offset + GPIO_REG_DIR,
>> >> &reg);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       if (reg & (1 << offset))
>> >> +               return GPIO_LINE_DIRECTION_OUT;
>> >> +       else
>> >> +               return GPIO_LINE_DIRECTION_IN;
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_set_direction(struct gpio_chip *chip,
>> >> +                                      unsigned int offset,
>> >> +                                      bool output)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio = gpiochip_get_data(chip);
>> >> +       unsigned int mask = 1 << offset;
>> >> +       unsigned int val = (output) ? mask : 0;
>> >> +
>> >> +       return regmap_update_bits(gpio->regmap, gpio->offset +
>> >> GPIO_REG_DIR,
>> >> +                                 mask, val);
>> >> +
>> >
>> > Stray newline.
>> ok
>> 
>> >
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_direction_input(struct gpio_chip *chip,
>> >> +                                        unsigned int offset)
>> >> +{
>> >> +       return sl28cpld_gpio_set_direction(chip, offset, false);
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_direction_output(struct gpio_chip *chip,
>> >> +                                         unsigned int offset, int
>> >> value)
>> >> +{
>> >> +       sl28cpld_gpio_set_reg(chip, GPIO_REG_OUT, offset, value);
>> >> +       return sl28cpld_gpio_set_direction(chip, offset, true);
>> >> +}
>> >> +
>> >> +static void sl28cpld_gpio_irq_lock(struct irq_data *data)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio =
>> >> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> >> +
>> >> +       mutex_lock(&gpio->lock);
>> >
>> > How does that actually lock anything?
>> 
>> TBH, I took that from gpio-pcf857x.c. But that
>>   (1) don't uses regmap
>>   (2) also uses that lock on other places.
>> 
>> I'll dig deeper into that and try to understand why there is a lock at
>> all and why this callback is actually called _irq_lock() because that
>> made me wonder.
>> 
>> > Regmap uses a different lock and
>> > if you want to make sure nobody modifies the GPIO registers than you'd
>> > need to use the same lock. Also: this looks a lot like a task for
>> > regmap_irqchip - maybe you could use it here or in the core mfd
>> > module?
>> 
>> regmap_irqchip will register the interrupt controller on the device
>> which owns the regmap, ie. the parent. So (1) the phandle would need 
>> to
>> point to the parent device instead of the GPIO subnode and (2) I'm
>> already using the regmap_irqchip for the interrupt controller. I don't
>> know if you can actually have that multiple times.
>> 
>> there was a discussion which might apply partly to (1):
>>   https://lore.kernel.org/patchwork/patch/802608/
>> 
> 
> In that case maybe you should use the disable_locking option in
> regmap_config and provide your own callbacks that you can use in the
> irqchip code too?

But how would that solve problem (1). And keep in mind, that the
reqmap_irqchip is actually used for the interrupt controller, which
is not this gpio controller.

Ie. the interrupt controller of the sl28cpld uses the regmap_irqchip
and all interrupt phandles pointing to the interrupt controller will
reference the toplevel node. Any phandles pointing to the gpio
controller will reference the GPIO subnode.

> 
>> >
>> >> +}
>> >> +
>> >> +static void sl28cpld_gpio_irq_sync_unlock(struct irq_data *data)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio =
>> >> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> >> +
>> >> +       regmap_write(gpio->regmap, gpio->offset + GPIO_REG_IE,
>> >> gpio->ie);
>> >> +       mutex_unlock(&gpio->lock);
>> >> +}
>> >> +
>> >> +static void sl28cpld_gpio_irq_disable(struct irq_data *data)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio =
>> >> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> >> +
>> >> +       if (data->hwirq >= 8)
>> >> +               return;
>> >> +
>> >> +       gpio->ie &= ~(1 << data->hwirq);
>> >> +}
>> >> +
>> >> +static void sl28cpld_gpio_irq_enable(struct irq_data *data)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio =
>> >> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
>> >> +
>> >> +       if (data->hwirq >= 8)
>> >> +               return;
>> >> +
>> >> +       gpio->ie |= (1 << data->hwirq);
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_irq_set_type(struct irq_data *data, unsigned
>> >> int type)
>> >> +{
>> >> +       /* only edge triggered interrupts on both edges are supported
>> >> */
>> >> +       return (type == IRQ_TYPE_EDGE_BOTH) ? 0 : -EINVAL;
>> >> +}
>> >> +
>> >> +static irqreturn_t sl28cpld_gpio_irq_thread(int irq, void *data)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio = data;
>> >> +       unsigned int ip;
>> >> +       unsigned int virq;
>> >> +       int pin;
>> >> +       int ret;
>> >> +
>> >> +       ret = regmap_read(gpio->regmap, gpio->offset + GPIO_REG_IP,
>> >> &ip);
>> >> +       if (ret)
>> >> +               return IRQ_NONE;
>> >> +
>> >> +       /* mask other pending interrupts which are not enabled */
>> >> +       ip &= gpio->ie;
>> >> +
>> >> +       /* ack the interrupts */
>> >> +       regmap_write(gpio->regmap, gpio->offset + GPIO_REG_IP, ip);
>> >> +
>> >> +       /* and handle them */
>> >> +       while (ip) {
>> >> +               pin = __ffs(ip);
>> >> +               ip &= ~BIT(pin);
>> >> +
>> >> +               virq = irq_find_mapping(gpio->gpio_chip.irq.domain,
>> >> pin);
>> >> +               if (virq)
>> >> +                       handle_nested_irq(virq);
>> >> +       }
>> >> +
>> >> +       return IRQ_HANDLED;
>> >> +}
>> >
>> > This definitely looks like parts of regmap_irqchip reimplemented.
>> > Please check if you could reuse it - it would save a lot of code.
>> 
>> See above. I'd be happy to reuse the code though.
>> 
>> >
>> >> +
>> >> +static int sl28_cpld_gpio_irq_init(struct platform_device *pdev, int
>> >> irq)
>> >> +{
>> >> +       struct sl28cpld_gpio *gpio = platform_get_drvdata(pdev);
>> >> +       struct irq_chip *irq_chip = &gpio->irq_chip;
>> >> +       int ret;
>> >> +
>> >> +       irq_chip->name = "sl28cpld-gpio-irq",
>> >> +       irq_chip->irq_bus_lock = sl28cpld_gpio_irq_lock,
>> >> +       irq_chip->irq_bus_sync_unlock = sl28cpld_gpio_irq_sync_unlock,
>> >> +       irq_chip->irq_disable = sl28cpld_gpio_irq_disable,
>> >> +       irq_chip->irq_enable = sl28cpld_gpio_irq_enable,
>> >> +       irq_chip->irq_set_type = sl28cpld_gpio_irq_set_type,
>> >> +       irq_chip->flags = IRQCHIP_SKIP_SET_WAKE,
>> >> +
>> >> +       ret = gpiochip_irqchip_add_nested(&gpio->gpio_chip, irq_chip,
>> >> 0,
>> >> +                                         handle_simple_irq,
>> >> IRQ_TYPE_NONE);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
>> >> +                                       sl28cpld_gpio_irq_thread,
>> >> +                                       IRQF_SHARED | IRQF_ONESHOT,
>> >> +                                       pdev->name, gpio);
>> >> +       if (ret)
>> >> +               return ret;
>> >> +
>> >> +       gpiochip_set_nested_irqchip(&gpio->gpio_chip, irq_chip, irq);
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +
>> >> +static int sl28cpld_gpio_probe(struct platform_device *pdev)
>> >> +{
>> >> +       enum sl28cpld_gpio_type type =
>> >> +               platform_get_device_id(pdev)->driver_data;
>> >> +       struct device_node *np = pdev->dev.of_node;
>> >> +       struct sl28cpld_gpio *gpio;
>> >> +       struct gpio_chip *chip;
>> >> +       struct resource *res;
>> >> +       bool irq_support = false;
>> >> +       int ret;
>> >> +       int irq;
>> >> +
>> >> +       gpio = devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
>> >> +       if (!gpio)
>> >> +               return -ENOMEM;
>> >> +
>> >> +       if (!pdev->dev.parent)
>> >> +               return -ENODEV;
>> >
>> > Why not check this before allocating any memory?
>> 
>> I'll change that, you're not the first one which notices that. My 
>> reason
>> was to have the check together with the dev_get_regmap() which uses 
>> the
>> parent, expecting that the error case only happen exceptionally.
>> 
>> >
>> >> +
>> >> +       gpio->regmap = dev_get_regmap(pdev->dev.parent, NULL);
>> >> +       if (!gpio->regmap)
>> >> +               return -ENODEV;
>> >> +
>> >> +       res = platform_get_resource(pdev, IORESOURCE_REG, 0);
>> >> +       if (!res)
>> >> +               return -EINVAL;
>> >> +       gpio->offset = res->start;
>> >> +
>> >
>> > This isn't how IO resources are used. What are you trying to achieve
>> > here?
>> 
>> Mh are you sure? The blueprint for this were the regulators in
>> drivers/regulators/, eg the wm831x-ldo.c. IORESOURCE_REG isn't used
>> that often. But here is what I want to achieve (for which I haven't
>> found any existing drivers for now):
>>   (1) the individual blocks of the overall sl28cpld may be used
>>       multiple times, eg. this driver only has the offset to a
>>       base address. So if there are two blocks, this mfd core
>>       driver will register two devices for this driver with
>>       different base offsets, which are passed by IORESOURCE_REG
>>   (2) I wanted to avoid having a private mfd include with some
>>       kind of "proprietary" method how to get that offset
>>   (3) the mfd core driver is the one knowing the offset, thus it
>>       is possible to have different flavours of the sl28cpld
>> 
> 
> Ok, now I see it's documented in the bindings. Thanks for the 
> explanation.
> 
>> 
>> >
>> >> +       /* initialize struct gpio_chip */
>> >> +       mutex_init(&gpio->lock);
>> >> +       chip = &gpio->gpio_chip;
>> >> +       chip->parent = &pdev->dev;
>> >> +       chip->label = dev_name(&pdev->dev);
>> >> +       chip->owner = THIS_MODULE;
>> >> +       chip->can_sleep = true;
>> >> +       chip->base = -1;
>> >> +       chip->ngpio = 8;
>> >> +
>> >> +       switch (type) {
>> >> +       case sl28cpld_gpio:
>> >> +               chip->get_direction = sl28cpld_gpio_get_direction;
>> >> +               chip->direction_input = sl28cpld_gpio_direction_input;
>> >> +               chip->direction_output =
>> >> sl28cpld_gpio_direction_output;
>> >> +               chip->get = sl28cpld_gpio_get;
>> >> +               chip->set = sl28cpld_gpio_set;
>> >> +               irq_support = true;
>> >> +               break;
>> >> +       case sl28cpld_gpo:
>> >> +               chip->set = sl28cpld_gpo_set;
>> >> +               chip->get = sl28cpld_gpi_get;
>> >> +               break;
>> >> +       case sl28cpld_gpi:
>> >> +               chip->get = sl28cpld_gpi_get;
>> >> +               break;
>> >> +       }
>> >> +
>> >> +       ret = devm_gpiochip_add_data(&pdev->dev, chip, gpio);
>> >> +       if (ret < 0)
>> >> +               return ret;
>> >> +
>> >> +       platform_set_drvdata(pdev, gpio);
>> >> +
>> >> +       if (irq_support && of_property_read_bool(np,
>> >> "interrupt-controller")) {
>> >
>> > You're depending on OF_GPIO for this one function. Please switch to
>> > device_property_read_bool() instead.
>> 
>> ok
>> 
>> 
>> >
>> >> +               irq = platform_get_irq(pdev, 0);
>> >> +               if (irq < 0)
>> >> +                       return ret;
>> >> +
>> >> +               ret = sl28_cpld_gpio_irq_init(pdev, irq);
>> >> +               if (ret)
>> >> +                       return ret;
>> >> +       }
>> >> +
>> >> +       return 0;
>> >> +}
>> >> +
>> >> +static const struct platform_device_id sl28cpld_gpio_id_table[] = {
>> >> +       {"sl28cpld-gpio", sl28cpld_gpio},
>> >> +       {"sl28cpld-gpi", sl28cpld_gpi},
>> >> +       {"sl28cpld-gpo", sl28cpld_gpo},
>> >
>> > Could you explain this a bit more? Is this the same component with
>> > input/output-only lines or three different components?
>> 
>> These are actually three different components. Ie. you could have a
>> flavour where you have one GPIO (sl28cpld-gpio) and two output-only
>> ones (sl28cpld-gpo). Is that what you wanted to know?
>> 
> 
> Yes, thanks. This could use some documentation in the bindings though.

ok. thats easy ;)

-michael

> Bartosz
> 
>> >
>> >> +};
>> >> +MODULE_DEVICE_TABLE(platform, sl28cpld_gpio_id_table);
>> >> +
>> >> +static struct platform_driver sl28cpld_gpio_driver = {
>> >> +       .probe = sl28cpld_gpio_probe,
>> >> +       .id_table = sl28cpld_gpio_id_table,
>> >> +       .driver = {
>> >> +               .name = "sl28cpld-gpio",
>> >> +       },
>> >> +};
>> >> +module_platform_driver(sl28cpld_gpio_driver);
>> >> +
>> >> +MODULE_DESCRIPTION("sl28cpld GPIO Driver");
>> >> +MODULE_LICENSE("GPL");
>> >
>> > I think you could use a MODULE_ALIAS() here if you want this module to
>> > be loaded automatically by udev.
>> 
>> ok, I'll look into that.
>> 
>> thanks,
>> -michael
>> 
>> >
>> >> --
>> >> 2.20.1
>> >>
>> >
>> > Best regards,
>> > Bartosz Golaszewski
