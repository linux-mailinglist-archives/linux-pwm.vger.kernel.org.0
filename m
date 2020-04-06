Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F363819F350
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2020 12:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgDFKKl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Apr 2020 06:10:41 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45937 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgDFKKk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Apr 2020 06:10:40 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id B240D22708;
        Mon,  6 Apr 2020 12:10:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1586167836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGs2ilNzlbTshBgZnXNTi4wWIfxGUFEV3ms8E/SIckY=;
        b=jvDQjpktVU2In8W/4X9yaRMv4zW5QFkVJG5Gtf6/BvG7Bgz7ina7W7jwfU0eNxSPkdtCH8
        x4jtDyRPxw6hOO3PGjHkXkadiwaWqnL4rTPzDJuZ+czU+HzxW2iwwdAhhTPOt6cOUGYFwX
        IkZ/DnneCsVl2BtBKLDYEek8M85WrEs=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 06 Apr 2020 12:10:29 +0200
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
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
In-Reply-To: <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
Message-ID: <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Spam-Level: *
X-Rspamd-Server: web
X-Spam-Status: No, score=1.40
X-Spam-Score: 1.40
X-Rspamd-Queue-Id: B240D22708
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         NEURAL_HAM(-0.00)[-1.044];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,linaro.org,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Bartosz, Hi Mark Brown,

Am 2020-04-06 09:47, schrieb Bartosz Golaszewski:
> czw., 2 kwi 2020 o 22:37 Michael Walle <michael@walle.cc> napisał(a):
>> 
>> There are quite a lot simple GPIO controller which are using regmap to
>> access the hardware. This driver tries to be a base to unify existing
>> code into one place. This won't cover everything but it should be a 
>> good
>> starting point.
>> 
>> It does not implement its own irq_chip because there is already a
>> generic one for regmap based devices. Instead, the irq_chip will be
>> instanciated in the parent driver and its irq domain will be associate
>> to this driver.
>> 
>> For now it consists of the usual registers, like set (and an optional
>> clear) data register, an input register and direction registers.
>> Out-of-the-box, it supports consecutive register mappings and mappings
>> where the registers have gaps between them with a linear mapping 
>> between
>> GPIO offset and bit position. For weirder mappings the user can 
>> register
>> its own .xlate().
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Hi Michael,
> 
> Thanks for doing this! When looking at other generic drivers:
> gpio-mmio and gpio-reg I can see there are some corner-cases and more
> specific configuration options we could add

I didn't want to copy every bit without being able to test it.

> but it's not a blocker,
> we'll probably be extending this one as we convert more drivers to
> using it.

correct, that was also my plan.

> Personally I'd love to see gpio-mmio and gpio-reg removed
> and replaced by a single, generic regmap interface eventually.

agreed.


>> ---
>>  drivers/gpio/Kconfig        |   4 +
>>  drivers/gpio/Makefile       |   1 +
>>  drivers/gpio/gpio-regmap.c  | 320 
>> ++++++++++++++++++++++++++++++++++++
>>  include/linux/gpio-regmap.h |  88 ++++++++++
>>  4 files changed, 413 insertions(+)
>>  create mode 100644 drivers/gpio/gpio-regmap.c
>>  create mode 100644 include/linux/gpio-regmap.h
>> 
>> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
>> index 1b96169d84f7..a8e148f4b2e0 100644
>> --- a/drivers/gpio/Kconfig
>> +++ b/drivers/gpio/Kconfig
>> @@ -73,6 +73,10 @@ config GPIO_GENERIC
>>         depends on HAS_IOMEM # Only for IOMEM drivers
>>         tristate
>> 
>> +config GPIO_REGMAP
>> +       depends on REGMAP
>> +       tristate
>> +
>>  # put drivers in the right section, in alphabetical order
>> 
>>  # This symbol is selected by both I2C and SPI expanders
>> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
>> index b2cfc21a97f3..93e139fdfa57 100644
>> --- a/drivers/gpio/Makefile
>> +++ b/drivers/gpio/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_GPIO_SYSFS)      += gpiolib-sysfs.o
>>  obj-$(CONFIG_GPIO_ACPI)                += gpiolib-acpi.o
>> 
>>  # Device drivers. Generally keep list sorted alphabetically
>> +obj-$(CONFIG_GPIO_REGMAP)      += gpio-regmap.o
>>  obj-$(CONFIG_GPIO_GENERIC)     += gpio-generic.o
>> 
>>  # directly supported by gpio-generic
>> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
>> new file mode 100644
>> index 000000000000..cc4437dc0521
>> --- /dev/null
>> +++ b/drivers/gpio/gpio-regmap.c
>> @@ -0,0 +1,320 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * regmap based generic GPIO driver
>> + *
>> + * Copyright 2019 Michael Walle <michael@walle.cc>
>> + */
>> +
>> +#include <linux/gpio/driver.h>
>> +#include <linux/gpio-regmap.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +
>> +struct gpio_regmap_data {
>> +       struct gpio_chip gpio_chip;
>> +       struct gpio_regmap *gpio;
>> +};
>> +
>> +/**
>> + * gpio_regmap_simple_xlate() - translate base/offset to reg/mask
>> + *
>> + * Use a simple linear mapping to translate the offset to the 
>> bitmask.
>> + */
>> +int gpio_regmap_simple_xlate(struct gpio_regmap *gpio, unsigned int 
>> base,
>> +                            unsigned int offset,
>> +                            unsigned int *reg, unsigned int *mask)
>> +{
>> +       unsigned int line = offset % gpio->ngpio_per_reg;
>> +       unsigned int stride = offset / gpio->ngpio_per_reg;
>> +
>> +       *reg = base + stride * gpio->reg_stride;
>> +       *mask = BIT(line);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(gpio_regmap_simple_xlate);
> 
> Why does this need to be exported?

Mh, the idea was that a user could also set this xlate() by himself (for
whatever reason). But since it is the default, it is not really 
necessary.
That being said, I don't care if its only local to this module.

>> +
>> +static int gpio_regmap_get(struct gpio_chip *chip, unsigned int 
>> offset)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +       unsigned int base;
>> +       unsigned int val, reg, mask;
> 
> This can fit on a single line with base. Same elsewhere.
> 
>> +       int ret;
>> +
>> +       /* we might not have an output register if we are input only 
>> */
>> +       if (gpio->reg_dat_base.valid)
>> +               base = gpio->reg_dat_base.addr;
>> +       else
>> +               base = gpio->reg_set_base.addr;
>> +
>> +       ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = regmap_read(gpio->regmap, reg, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return (val & mask) ? 1 : 0;
>> +}
>> +
>> +static void gpio_regmap_set(struct gpio_chip *chip, unsigned int 
>> offset,
>> +                           int val)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +       unsigned int base = gpio->reg_set_base.addr;
>> +       unsigned int reg, mask;
>> +
>> +       gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>> +       if (val)
>> +               regmap_update_bits(gpio->regmap, reg, mask, mask);
>> +       else
>> +               regmap_update_bits(gpio->regmap, reg, mask, 0);
>> +}
>> +
>> +static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
>> +                                      unsigned int offset, int val)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +       unsigned int base;
>> +       unsigned int reg, mask;
>> +
>> +       if (val)
>> +               base = gpio->reg_set_base.addr;
>> +       else
>> +               base = gpio->reg_clr_base.addr;
>> +
>> +       gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>> +       regmap_write(gpio->regmap, reg, mask);
>> +}
>> +
>> +static int gpio_regmap_get_direction(struct gpio_chip *chip,
>> +                                    unsigned int offset)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +       unsigned int val, reg, mask;
>> +       unsigned int base;
>> +       int invert;
>> +       int ret;
>> +
>> +       if (gpio->reg_dir_out_base.valid) {
>> +               base = gpio->reg_dir_out_base.addr;
>> +               invert = 0;
>> +       } else if (gpio->reg_dir_in_base.valid) {
>> +               base = gpio->reg_dir_in_base.addr;
>> +               invert = 1;
>> +       } else {
>> +               return GPIO_LINE_DIRECTION_IN;
>> +       }
>> +
>> +       ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>> +       if (ret)
>> +               return ret;
>> +
>> +       ret = regmap_read(gpio->regmap, reg, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!!(val & mask) ^ invert)
>> +               return GPIO_LINE_DIRECTION_OUT;
>> +       else
>> +               return GPIO_LINE_DIRECTION_IN;
>> +}
>> +
>> +static int gpio_regmap_set_direction(struct gpio_chip *chip,
>> +                                    unsigned int offset, bool output)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +       unsigned int val, reg, mask;
>> +       unsigned int base;
>> +       int invert;
>> +       int ret;
>> +
>> +       if (gpio->reg_dir_out_base.valid) {
>> +               base = gpio->reg_dir_out_base.addr;
>> +               invert = 0;
>> +       } else if (gpio->reg_dir_in_base.valid) {
>> +               base = gpio->reg_dir_in_base.addr;
>> +               invert = 1;
>> +       } else {
>> +               return 0;
>> +       }
>> +
>> +       ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (!invert)
>> +               val = (output) ? mask : 0;
>> +       else
>> +               val = (output) ? 0 : mask;
>> +
>> +       return regmap_update_bits(gpio->regmap, reg, mask, val);
>> +}
>> +
>> +static int gpio_regmap_direction_input(struct gpio_chip *chip,
>> +                                      unsigned int offset)
>> +{
>> +       return gpio_regmap_set_direction(chip, offset, false);
>> +}
>> +
>> +static int gpio_regmap_direction_output(struct gpio_chip *chip,
>> +                                       unsigned int offset, int 
>> value)
>> +{
>> +       gpio_regmap_set(chip, offset, value);
>> +       return gpio_regmap_set_direction(chip, offset, true);
>> +}
>> +
>> +static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int 
>> offset)
>> +{
>> +       struct gpio_regmap_data *data = gpiochip_get_data(chip);
>> +       struct gpio_regmap *gpio = data->gpio;
>> +
>> +       /* the user might have its own .to_irq callback */
>> +       if (gpio->to_irq)
>> +               return gpio->to_irq(gpio, offset);
>> +
>> +       return irq_create_mapping(gpio->irq_domain, offset);
>> +}
>> +
>> +/**
>> + * gpio_regmap_register() - Register a generic regmap GPIO controller
>> + *
>> + * @gpio: gpio_regmap device to register
>> + *
>> + * Returns 0 on success or an errno on failure.
>> + */
>> +int gpio_regmap_register(struct gpio_regmap *gpio)
>> +{
>> +       struct gpio_regmap_data *d;
>> +       struct gpio_chip *chip;
>> +       int ret;
>> +
>> +       if (!gpio->parent)
>> +               return -EINVAL;
>> +
>> +       if (!gpio->ngpio)
>> +               return -EINVAL;
>> +
>> +       /* we need at least one */
>> +       if (!gpio->reg_dat_base.valid && !gpio->reg_set_base.valid)
>> +               return -EINVAL;
>> +
>> +       /* we don't support having both registers simulaniously for 
>> now */
>> +       if (gpio->reg_dir_out_base.valid && 
>> gpio->reg_dir_in_base.valid)
>> +               return -EINVAL;
>> +
>> +       /* if not set, assume they are consecutive */
>> +       if (!gpio->reg_stride)
>> +               gpio->reg_stride = 1;
>> +
>> +       /* if not set, assume there is only one register */
>> +       if (!gpio->ngpio_per_reg)
>> +               gpio->ngpio_per_reg = gpio->ngpio;
>> +
>> +       if (!gpio->reg_mask_xlate)
>> +               gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
>> +
>> +       d = kzalloc(sizeof(*d), GFP_KERNEL);
>> +       if (!d)
>> +               return -ENOMEM;
>> +
>> +       gpio->data = d;
>> +       d->gpio = gpio;
>> +
>> +       chip = &d->gpio_chip;
>> +       chip->parent = gpio->parent;
>> +       chip->label = gpio->label;
>> +       chip->base = -1;
>> +       chip->ngpio = gpio->ngpio;
>> +       chip->can_sleep = true;
>> +       chip->get = gpio_regmap_get;
>> +
>> +       if (!chip->label)
>> +               chip->label = dev_name(gpio->parent);
>> +
>> +       if (gpio->reg_set_base.valid && gpio->reg_clr_base.valid)
>> +               chip->set = gpio_regmap_set_with_clear;
>> +       else if (gpio->reg_set_base.valid)
>> +               chip->set = gpio_regmap_set;
>> +
>> +       if (gpio->reg_dir_in_base.valid || 
>> gpio->reg_dir_out_base.valid) {
>> +               chip->get_direction = gpio_regmap_get_direction;
>> +               chip->direction_input = gpio_regmap_direction_input;
>> +               chip->direction_output = gpio_regmap_direction_output;
>> +       }
>> +
>> +       if (gpio->irq_domain)
>> +               chip->to_irq = gpio_regmap_to_irq;
>> +
>> +       ret = gpiochip_add_data(chip, d);
>> +       if (ret < 0)
>> +               goto err_alloc;
>> +
>> +       return 0;
>> +
>> +err_alloc:
>> +       kfree(d);
>> +       return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(gpio_regmap_register);
>> +
>> +/**
>> + * gpio_regmap_unregister() - Unregister a generic regmap GPIO 
>> controller
>> + *
>> + * @gpio: gpio_regmap device to unregister
>> + */
>> +void gpio_regmap_unregister(struct gpio_regmap *gpio)
>> +{
>> +       gpiochip_remove(&gpio->data->gpio_chip);
>> +       kfree(gpio->data);
>> +}
>> +EXPORT_SYMBOL_GPL(gpio_regmap_unregister);
>> +
>> +static void devm_gpio_regmap_unregister(struct device *dev, void 
>> *res)
>> +{
>> +       gpio_regmap_unregister(*(struct gpio_regmap **)res);
>> +}
>> +
>> +/**
>> + * devm_gpio_regmap_register() - resource managed 
>> gpio_regmap_register()
>> + *
>> + * @dev: device that is registering this GPIO device
>> + * @gpio: gpio_regmap device to register
>> + *
>> + * Managed gpio_regmap_register(). For generic regmap GPIO device 
>> registered by
>> + * this function, gpio_regmap_unregister() is automatically called on 
>> driver
>> + * detach. See gpio_regmap_register() for more information.
>> + */
>> +int devm_gpio_regmap_register(struct device *dev, struct gpio_regmap 
>> *gpio)
>> +{
>> +       struct gpio_regmap **ptr;
>> +       int ret;
>> +
>> +       ptr = devres_alloc(devm_gpio_regmap_unregister, sizeof(*ptr),
>> +                          GFP_KERNEL);
>> +       if (!ptr)
>> +               return -ENOMEM;
>> +
>> +       ret = gpio_regmap_register(gpio);
>> +       if (ret) {
>> +               devres_free(ptr);
>> +               return ret;
>> +       }
>> +
>> +       *ptr = gpio;
>> +       devres_add(dev, ptr);
>> +
>> +       return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_gpio_regmap_register);
>> +
>> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
>> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
>> +MODULE_LICENSE("GPL");
>> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
>> new file mode 100644
>> index 000000000000..ad63955e0e43
>> --- /dev/null
>> +++ b/include/linux/gpio-regmap.h
>> @@ -0,0 +1,88 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +
>> +#ifndef _LINUX_GPIO_REGMAP_H
>> +#define _LINUX_GPIO_REGMAP_H
>> +
>> +struct gpio_regmap_addr {
>> +       unsigned int addr;
>> +       bool valid;
>> +};
> 
> I'm not quite sure what the meaning behind the valid field here is.
> When would we potentially set it to false?

Some base addresses are optional, but on the other hand, a base address
of 0 could also be valid. So I cannot use 0 as an indicator whether a
base address is set or not. The generic mmio driver has some special
case for the ack base, where there is a use_ack flag which forces to
use the ack register even if its zero. So I've had a look at the kernel
if there is a better idiom for that, but I haven't found anything.

So the best from a user perspective I've could come up with was:

   ->base_reg = GPIO_REGMAP_ADDR(addr);

I'm open for suggestions.

> 
>> +#define GPIO_REGMAP_ADDR(_addr) \
>> +       ((struct gpio_regmap_addr) { .addr = _addr, .valid = true })
>> +
>> +/**
>> + * struct gpio_regmap - Description of a generic regmap gpio_chip.
>> + *
>> + * @parent:            The parent device
>> + * @regmap:            The regmap use to access the registers
> 
> s/use/used/
> 
>> + *                     given, the name of the device is used
>> + * @label:             (Optional) Descriptive name for GPIO 
>> controller.
>> + *                     If not given, the name of the device is used.
>> + * @ngpio:             Number of GPIOs
>> + * @reg_dat_base:      (Optional) (in) register base address
>> + * @reg_set_base:      (Optional) set register base address
>> + * @reg_clr_base:      (Optional) clear register base address
>> + * @reg_dir_in_base:   (Optional) out setting register base address
>> + * @reg_dir_out_base:  (Optional) in setting register base address
>> + * @reg_stride:                (Optional) May be set if the registers 
>> (of the
>> + *                     same type, dat, set, etc) are not consecutive.
>> + * @ngpio_per_reg:     Number of GPIOs per register
>> + * @irq_domain:                (Optional) IRQ domain if the 
>> controller is
>> + *                     interrupt-capable
>> + * @reg_mask_xlate:     (Optional) Translates base address and GPIO
>> + *                     offset to a register/bitmask pair. If not
>> + *                     given the default gpio_regmap_simple_xlate()
>> + *                     is used.
>> + * @to_irq:            (Optional) Maps GPIO offset to a irq number.
>> + *                     By default assumes a linear mapping of the
>> + *                     given irq_domain.
>> + * @driver_data:       Pointer to the drivers private data. Not used 
>> by
>> + *                     gpio-regmap.
>> + *
>> + * The reg_mask_xlate translates a given base address and GPIO offset 
>> to
>> + * register and mask pair. The base address is one of the given 
>> reg_*_base.
>> + */
>> +struct gpio_regmap {
> 
> I'd prefer to follow a pattern seen in other such APIs of calling this
> structure gpio_regmap_config and creating another private structure
> called gpio_regmap used in callbacks that would only contain necessary
> fields.

something like the following?

struct gpio_regmap *gpio_regmap_register(struct gpio_regmap_config *)

but if that structure is private, how can a callback access individual
elements? Or do you mean private in "local to the gpio drivers"?

Also I was unsure about the naming, eg. some use
stuff_register()/stuff_unregister() and some stuff_add()/stuff_remove().

> 
>> +       struct device *parent;
>> +       struct regmap *regmap;
>> +       struct gpio_regmap_data *data;
>> +
>> +       const char *label;
>> +       int ngpio;
>> +
>> +       struct gpio_regmap_addr reg_dat_base;
>> +       struct gpio_regmap_addr reg_set_base;
>> +       struct gpio_regmap_addr reg_clr_base;
>> +       struct gpio_regmap_addr reg_dir_in_base;
>> +       struct gpio_regmap_addr reg_dir_out_base;
>> +       int reg_stride;
>> +       int ngpio_per_reg;
>> +       struct irq_domain *irq_domain;
>> +
>> +       int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int 
>> base,
>> +                             unsigned int offset, unsigned int *reg,
>> +                             unsigned int *mask);
>> +       int (*to_irq)(struct gpio_regmap *gpio, unsigned int offset);
>> +
>> +       void *driver_data;
>> +};
>> +
>> +static inline void gpio_regmap_set_drvdata(struct gpio_regmap *gpio,
>> +                                          void *data)
>> +{
>> +       gpio->driver_data = data;
>> +}
>> +
>> +static inline void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
>> +{
>> +       return gpio->driver_data;
>> +}
>> +
>> +int gpio_regmap_register(struct gpio_regmap *gpio);
>> +void gpio_regmap_unregister(struct gpio_regmap *gpio);
>> +int devm_gpio_regmap_register(struct device *dev, struct gpio_regmap 
>> *gpio);
>> +int gpio_regmap_simple_xlate(struct gpio_regmap *gpio, unsigned int 
>> base,
>> +                            unsigned int offset,
>> +                            unsigned int *reg, unsigned int *mask);
>> +
>> +#endif /* _LINUX_GPIO_REGMAP_H */
>> --
>> 2.20.1
>> 
> 
> Overall looks really nice. I'm happy we'll have it in v5.8.

Thanks, one thing I'm uncertain about is the regmap_irq change and if 
that
is acceptable. So Mark would need to comment on that.

-michael
