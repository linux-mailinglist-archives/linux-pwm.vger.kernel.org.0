Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6173919F128
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2020 09:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDFHsH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 6 Apr 2020 03:48:07 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39532 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgDFHsG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 6 Apr 2020 03:48:06 -0400
Received: by mail-qt1-f193.google.com with SMTP id f20so12107123qtq.6
        for <linux-pwm@vger.kernel.org>; Mon, 06 Apr 2020 00:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=amAF0/6ZAlncZUHeVlhe3w2Ki3z4fhffTcU8qEplQgI=;
        b=TGEztmhV4iB7KyI5BPf8WoTfqW3RCZUlDikAjrf1SR+nN1ZsXwXw2LRG86FQfm7Vmk
         yf7DjN8owLtSCpXTYmdNKugl6ddHr5UviVK0DWckTC+8BSgi4oKm2WkuR1cOfxw1ejTk
         b0sfFieGzMsxgNCHBn7I9YXMZL/47t1Rr/Wh6WRw/08nhG+/naUtTien/aMtfPkJvEp2
         +JSy8a8tR3cOr7obFkgvuGtURmTRVYq++sadK9pcZtZVhgd3ah+/FCTiT6bOhVdZ9R7T
         sJOW+IFFQBDi9XJCU/Wf11AQfeluJniuWM0IZhDfPafDVPHlY5jdVrW1kFw060cL6RgB
         EjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=amAF0/6ZAlncZUHeVlhe3w2Ki3z4fhffTcU8qEplQgI=;
        b=kEiT4l9rUkrv0QdrqZxPtE8v6MKzacKTJy4+GSqcA2YaaEjGYuDlyjmdnzk/t9NHPV
         QDGBDQA/U/EmV69CsrpU3Ltbr9vc6Wnuut0npsZtAzZJdKll+Q7skd8E39IEXWeRh+le
         kKoNbhUtCVwvey7jdddvBLSNCGeQYgkkvd4ceN0n2iootMk8zdVVQD8lhCNRnlQBEbuW
         gyDgq9s4kmgoXKY3XnnUnJ6hzhmfy90a+AHfOAme9nwujZeK9A4ozzbbjLWk7L2OJhaN
         j4LwB2Ku+jw44DRwDC1xa+Mj+ZpIb5LVqc4nUk8NojsIMopyQXL+ogoNqxp2k8yZjDWs
         qQAA==
X-Gm-Message-State: AGi0PubYKyRtcHuc/Ge43c/AuF9VQgw8+xHQS/2tLqcY0nana0gohuKC
        H/SLKwCikCwR9O4rxlLAaCE9DC5ulAvcz3AdCPusxQ==
X-Google-Smtp-Source: APiQypIZh9O39IoVlyPxAsvhWgOsBERW3TzNwd/djolltb8HgtlAHalS0On8dowlQ6zkrSLVBqEdY6ashXn19IuDVN0=
X-Received: by 2002:ac8:5318:: with SMTP id t24mr3914516qtn.208.1586159284935;
 Mon, 06 Apr 2020 00:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200402203656.27047-1-michael@walle.cc> <20200402203656.27047-11-michael@walle.cc>
In-Reply-To: <20200402203656.27047-11-michael@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 6 Apr 2020 09:47:54 +0200
Message-ID: <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
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
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

czw., 2 kwi 2020 o 22:37 Michael Walle <michael@walle.cc> napisa=C5=82(a):
>
> There are quite a lot simple GPIO controller which are using regmap to
> access the hardware. This driver tries to be a base to unify existing
> code into one place. This won't cover everything but it should be a good
> starting point.
>
> It does not implement its own irq_chip because there is already a
> generic one for regmap based devices. Instead, the irq_chip will be
> instanciated in the parent driver and its irq domain will be associate
> to this driver.
>
> For now it consists of the usual registers, like set (and an optional
> clear) data register, an input register and direction registers.
> Out-of-the-box, it supports consecutive register mappings and mappings
> where the registers have gaps between them with a linear mapping between
> GPIO offset and bit position. For weirder mappings the user can register
> its own .xlate().
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Hi Michael,

Thanks for doing this! When looking at other generic drivers:
gpio-mmio and gpio-reg I can see there are some corner-cases and more
specific configuration options we could add but it's not a blocker,
we'll probably be extending this one as we convert more drivers to
using it. Personally I'd love to see gpio-mmio and gpio-reg removed
and replaced by a single, generic regmap interface eventually.

> ---
>  drivers/gpio/Kconfig        |   4 +
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-regmap.c  | 320 ++++++++++++++++++++++++++++++++++++
>  include/linux/gpio-regmap.h |  88 ++++++++++
>  4 files changed, 413 insertions(+)
>  create mode 100644 drivers/gpio/gpio-regmap.c
>  create mode 100644 include/linux/gpio-regmap.h
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 1b96169d84f7..a8e148f4b2e0 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -73,6 +73,10 @@ config GPIO_GENERIC
>         depends on HAS_IOMEM # Only for IOMEM drivers
>         tristate
>
> +config GPIO_REGMAP
> +       depends on REGMAP
> +       tristate
> +
>  # put drivers in the right section, in alphabetical order
>
>  # This symbol is selected by both I2C and SPI expanders
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index b2cfc21a97f3..93e139fdfa57 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_GPIO_SYSFS)      +=3D gpiolib-sysfs.o
>  obj-$(CONFIG_GPIO_ACPI)                +=3D gpiolib-acpi.o
>
>  # Device drivers. Generally keep list sorted alphabetically
> +obj-$(CONFIG_GPIO_REGMAP)      +=3D gpio-regmap.o
>  obj-$(CONFIG_GPIO_GENERIC)     +=3D gpio-generic.o
>
>  # directly supported by gpio-generic
> diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
> new file mode 100644
> index 000000000000..cc4437dc0521
> --- /dev/null
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * regmap based generic GPIO driver
> + *
> + * Copyright 2019 Michael Walle <michael@walle.cc>
> + */
> +
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio-regmap.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +struct gpio_regmap_data {
> +       struct gpio_chip gpio_chip;
> +       struct gpio_regmap *gpio;
> +};
> +
> +/**
> + * gpio_regmap_simple_xlate() - translate base/offset to reg/mask
> + *
> + * Use a simple linear mapping to translate the offset to the bitmask.
> + */
> +int gpio_regmap_simple_xlate(struct gpio_regmap *gpio, unsigned int base=
,
> +                            unsigned int offset,
> +                            unsigned int *reg, unsigned int *mask)
> +{
> +       unsigned int line =3D offset % gpio->ngpio_per_reg;
> +       unsigned int stride =3D offset / gpio->ngpio_per_reg;
> +
> +       *reg =3D base + stride * gpio->reg_stride;
> +       *mask =3D BIT(line);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(gpio_regmap_simple_xlate);

Why does this need to be exported?

> +
> +static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gpio_regmap_data *data =3D gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio =3D data->gpio;
> +       unsigned int base;
> +       unsigned int val, reg, mask;

This can fit on a single line with base. Same elsewhere.

> +       int ret;
> +
> +       /* we might not have an output register if we are input only */
> +       if (gpio->reg_dat_base.valid)
> +               base =3D gpio->reg_dat_base.addr;
> +       else
> +               base =3D gpio->reg_set_base.addr;
> +
> +       ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_read(gpio->regmap, reg, &val);
> +       if (ret)
> +               return ret;
> +
> +       return (val & mask) ? 1 : 0;
> +}
> +
> +static void gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
> +                           int val)
> +{
> +       struct gpio_regmap_data *data =3D gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio =3D data->gpio;
> +       unsigned int base =3D gpio->reg_set_base.addr;
> +       unsigned int reg, mask;
> +
> +       gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       if (val)
> +               regmap_update_bits(gpio->regmap, reg, mask, mask);
> +       else
> +               regmap_update_bits(gpio->regmap, reg, mask, 0);
> +}
> +
> +static void gpio_regmap_set_with_clear(struct gpio_chip *chip,
> +                                      unsigned int offset, int val)
> +{
> +       struct gpio_regmap_data *data =3D gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio =3D data->gpio;
> +       unsigned int base;
> +       unsigned int reg, mask;
> +
> +       if (val)
> +               base =3D gpio->reg_set_base.addr;
> +       else
> +               base =3D gpio->reg_clr_base.addr;
> +
> +       gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       regmap_write(gpio->regmap, reg, mask);
> +}
> +
> +static int gpio_regmap_get_direction(struct gpio_chip *chip,
> +                                    unsigned int offset)
> +{
> +       struct gpio_regmap_data *data =3D gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio =3D data->gpio;
> +       unsigned int val, reg, mask;
> +       unsigned int base;
> +       int invert;
> +       int ret;
> +
> +       if (gpio->reg_dir_out_base.valid) {
> +               base =3D gpio->reg_dir_out_base.addr;
> +               invert =3D 0;
> +       } else if (gpio->reg_dir_in_base.valid) {
> +               base =3D gpio->reg_dir_in_base.addr;
> +               invert =3D 1;
> +       } else {
> +               return GPIO_LINE_DIRECTION_IN;
> +       }
> +
> +       ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D regmap_read(gpio->regmap, reg, &val);
> +       if (ret)
> +               return ret;
> +
> +       if (!!(val & mask) ^ invert)
> +               return GPIO_LINE_DIRECTION_OUT;
> +       else
> +               return GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int gpio_regmap_set_direction(struct gpio_chip *chip,
> +                                    unsigned int offset, bool output)
> +{
> +       struct gpio_regmap_data *data =3D gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio =3D data->gpio;
> +       unsigned int val, reg, mask;
> +       unsigned int base;
> +       int invert;
> +       int ret;
> +
> +       if (gpio->reg_dir_out_base.valid) {
> +               base =3D gpio->reg_dir_out_base.addr;
> +               invert =3D 0;
> +       } else if (gpio->reg_dir_in_base.valid) {
> +               base =3D gpio->reg_dir_in_base.addr;
> +               invert =3D 1;
> +       } else {
> +               return 0;
> +       }
> +
> +       ret =3D gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       if (ret)
> +               return ret;
> +
> +       if (!invert)
> +               val =3D (output) ? mask : 0;
> +       else
> +               val =3D (output) ? 0 : mask;
> +
> +       return regmap_update_bits(gpio->regmap, reg, mask, val);
> +}
> +
> +static int gpio_regmap_direction_input(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       return gpio_regmap_set_direction(chip, offset, false);
> +}
> +
> +static int gpio_regmap_direction_output(struct gpio_chip *chip,
> +                                       unsigned int offset, int value)
> +{
> +       gpio_regmap_set(chip, offset, value);
> +       return gpio_regmap_set_direction(chip, offset, true);
> +}
> +
> +static int gpio_regmap_to_irq(struct gpio_chip *chip, unsigned int offse=
t)
> +{
> +       struct gpio_regmap_data *data =3D gpiochip_get_data(chip);
> +       struct gpio_regmap *gpio =3D data->gpio;
> +
> +       /* the user might have its own .to_irq callback */
> +       if (gpio->to_irq)
> +               return gpio->to_irq(gpio, offset);
> +
> +       return irq_create_mapping(gpio->irq_domain, offset);
> +}
> +
> +/**
> + * gpio_regmap_register() - Register a generic regmap GPIO controller
> + *
> + * @gpio: gpio_regmap device to register
> + *
> + * Returns 0 on success or an errno on failure.
> + */
> +int gpio_regmap_register(struct gpio_regmap *gpio)
> +{
> +       struct gpio_regmap_data *d;
> +       struct gpio_chip *chip;
> +       int ret;
> +
> +       if (!gpio->parent)
> +               return -EINVAL;
> +
> +       if (!gpio->ngpio)
> +               return -EINVAL;
> +
> +       /* we need at least one */
> +       if (!gpio->reg_dat_base.valid && !gpio->reg_set_base.valid)
> +               return -EINVAL;
> +
> +       /* we don't support having both registers simulaniously for now *=
/
> +       if (gpio->reg_dir_out_base.valid && gpio->reg_dir_in_base.valid)
> +               return -EINVAL;
> +
> +       /* if not set, assume they are consecutive */
> +       if (!gpio->reg_stride)
> +               gpio->reg_stride =3D 1;
> +
> +       /* if not set, assume there is only one register */
> +       if (!gpio->ngpio_per_reg)
> +               gpio->ngpio_per_reg =3D gpio->ngpio;
> +
> +       if (!gpio->reg_mask_xlate)
> +               gpio->reg_mask_xlate =3D gpio_regmap_simple_xlate;
> +
> +       d =3D kzalloc(sizeof(*d), GFP_KERNEL);
> +       if (!d)
> +               return -ENOMEM;
> +
> +       gpio->data =3D d;
> +       d->gpio =3D gpio;
> +
> +       chip =3D &d->gpio_chip;
> +       chip->parent =3D gpio->parent;
> +       chip->label =3D gpio->label;
> +       chip->base =3D -1;
> +       chip->ngpio =3D gpio->ngpio;
> +       chip->can_sleep =3D true;
> +       chip->get =3D gpio_regmap_get;
> +
> +       if (!chip->label)
> +               chip->label =3D dev_name(gpio->parent);
> +
> +       if (gpio->reg_set_base.valid && gpio->reg_clr_base.valid)
> +               chip->set =3D gpio_regmap_set_with_clear;
> +       else if (gpio->reg_set_base.valid)
> +               chip->set =3D gpio_regmap_set;
> +
> +       if (gpio->reg_dir_in_base.valid || gpio->reg_dir_out_base.valid) =
{
> +               chip->get_direction =3D gpio_regmap_get_direction;
> +               chip->direction_input =3D gpio_regmap_direction_input;
> +               chip->direction_output =3D gpio_regmap_direction_output;
> +       }
> +
> +       if (gpio->irq_domain)
> +               chip->to_irq =3D gpio_regmap_to_irq;
> +
> +       ret =3D gpiochip_add_data(chip, d);
> +       if (ret < 0)
> +               goto err_alloc;
> +
> +       return 0;
> +
> +err_alloc:
> +       kfree(d);
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(gpio_regmap_register);
> +
> +/**
> + * gpio_regmap_unregister() - Unregister a generic regmap GPIO controlle=
r
> + *
> + * @gpio: gpio_regmap device to unregister
> + */
> +void gpio_regmap_unregister(struct gpio_regmap *gpio)
> +{
> +       gpiochip_remove(&gpio->data->gpio_chip);
> +       kfree(gpio->data);
> +}
> +EXPORT_SYMBOL_GPL(gpio_regmap_unregister);
> +
> +static void devm_gpio_regmap_unregister(struct device *dev, void *res)
> +{
> +       gpio_regmap_unregister(*(struct gpio_regmap **)res);
> +}
> +
> +/**
> + * devm_gpio_regmap_register() - resource managed gpio_regmap_register()
> + *
> + * @dev: device that is registering this GPIO device
> + * @gpio: gpio_regmap device to register
> + *
> + * Managed gpio_regmap_register(). For generic regmap GPIO device regist=
ered by
> + * this function, gpio_regmap_unregister() is automatically called on dr=
iver
> + * detach. See gpio_regmap_register() for more information.
> + */
> +int devm_gpio_regmap_register(struct device *dev, struct gpio_regmap *gp=
io)
> +{
> +       struct gpio_regmap **ptr;
> +       int ret;
> +
> +       ptr =3D devres_alloc(devm_gpio_regmap_unregister, sizeof(*ptr),
> +                          GFP_KERNEL);
> +       if (!ptr)
> +               return -ENOMEM;
> +
> +       ret =3D gpio_regmap_register(gpio);
> +       if (ret) {
> +               devres_free(ptr);
> +               return ret;
> +       }
> +
> +       *ptr =3D gpio;
> +       devres_add(dev, ptr);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(devm_gpio_regmap_register);
> +
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
> new file mode 100644
> index 000000000000..ad63955e0e43
> --- /dev/null
> +++ b/include/linux/gpio-regmap.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _LINUX_GPIO_REGMAP_H
> +#define _LINUX_GPIO_REGMAP_H
> +
> +struct gpio_regmap_addr {
> +       unsigned int addr;
> +       bool valid;
> +};

I'm not quite sure what the meaning behind the valid field here is.
When would we potentially set it to false?

> +#define GPIO_REGMAP_ADDR(_addr) \
> +       ((struct gpio_regmap_addr) { .addr =3D _addr, .valid =3D true })
> +
> +/**
> + * struct gpio_regmap - Description of a generic regmap gpio_chip.
> + *
> + * @parent:            The parent device
> + * @regmap:            The regmap use to access the registers

s/use/used/

> + *                     given, the name of the device is used
> + * @label:             (Optional) Descriptive name for GPIO controller.
> + *                     If not given, the name of the device is used.
> + * @ngpio:             Number of GPIOs
> + * @reg_dat_base:      (Optional) (in) register base address
> + * @reg_set_base:      (Optional) set register base address
> + * @reg_clr_base:      (Optional) clear register base address
> + * @reg_dir_in_base:   (Optional) out setting register base address
> + * @reg_dir_out_base:  (Optional) in setting register base address
> + * @reg_stride:                (Optional) May be set if the registers (o=
f the
> + *                     same type, dat, set, etc) are not consecutive.
> + * @ngpio_per_reg:     Number of GPIOs per register
> + * @irq_domain:                (Optional) IRQ domain if the controller i=
s
> + *                     interrupt-capable
> + * @reg_mask_xlate:     (Optional) Translates base address and GPIO
> + *                     offset to a register/bitmask pair. If not
> + *                     given the default gpio_regmap_simple_xlate()
> + *                     is used.
> + * @to_irq:            (Optional) Maps GPIO offset to a irq number.
> + *                     By default assumes a linear mapping of the
> + *                     given irq_domain.
> + * @driver_data:       Pointer to the drivers private data. Not used by
> + *                     gpio-regmap.
> + *
> + * The reg_mask_xlate translates a given base address and GPIO offset to
> + * register and mask pair. The base address is one of the given reg_*_ba=
se.
> + */
> +struct gpio_regmap {

I'd prefer to follow a pattern seen in other such APIs of calling this
structure gpio_regmap_config and creating another private structure
called gpio_regmap used in callbacks that would only contain necessary
fields.

> +       struct device *parent;
> +       struct regmap *regmap;
> +       struct gpio_regmap_data *data;
> +
> +       const char *label;
> +       int ngpio;
> +
> +       struct gpio_regmap_addr reg_dat_base;
> +       struct gpio_regmap_addr reg_set_base;
> +       struct gpio_regmap_addr reg_clr_base;
> +       struct gpio_regmap_addr reg_dir_in_base;
> +       struct gpio_regmap_addr reg_dir_out_base;
> +       int reg_stride;
> +       int ngpio_per_reg;
> +       struct irq_domain *irq_domain;
> +
> +       int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base=
,
> +                             unsigned int offset, unsigned int *reg,
> +                             unsigned int *mask);
> +       int (*to_irq)(struct gpio_regmap *gpio, unsigned int offset);
> +
> +       void *driver_data;
> +};
> +
> +static inline void gpio_regmap_set_drvdata(struct gpio_regmap *gpio,
> +                                          void *data)
> +{
> +       gpio->driver_data =3D data;
> +}
> +
> +static inline void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
> +{
> +       return gpio->driver_data;
> +}
> +
> +int gpio_regmap_register(struct gpio_regmap *gpio);
> +void gpio_regmap_unregister(struct gpio_regmap *gpio);
> +int devm_gpio_regmap_register(struct device *dev, struct gpio_regmap *gp=
io);
> +int gpio_regmap_simple_xlate(struct gpio_regmap *gpio, unsigned int base=
,
> +                            unsigned int offset,
> +                            unsigned int *reg, unsigned int *mask);
> +
> +#endif /* _LINUX_GPIO_REGMAP_H */
> --
> 2.20.1
>

Overall looks really nice. I'm happy we'll have it in v5.8.

Best regards,
Bartosz Golaszewski
