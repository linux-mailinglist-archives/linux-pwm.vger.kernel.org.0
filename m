Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4B1CF4C5
	for <lists+linux-pwm@lfdr.de>; Tue, 12 May 2020 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgELMsl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 May 2020 08:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729461AbgELMsj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 May 2020 08:48:39 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443BAC061A0C
        for <linux-pwm@vger.kernel.org>; Tue, 12 May 2020 05:48:39 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 190so7765086qki.1
        for <linux-pwm@vger.kernel.org>; Tue, 12 May 2020 05:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VjtW18trSHOOQ++iWlwEWrR0XUPVdV8/Se9flzmcddU=;
        b=VDjCkcy744H4FUDc+3CK+CCNWBxtS8oooYdO73NxXTzs0vH05D1k+ZyGgm5P37+ei0
         /WDDcrP5sdHuopYQ0wGI4lH+cvg9XvEqhYDbygWeM9T3izl8OFPytZL1hRfydIlW5EWW
         6ZXw42jBkkm9xEeUB3DrPHQoQPYEmdFaGyYmEGC/Ogrd14GwV9V2eWwI6r5G1YL0M3Bl
         VisJEDF+mD7RcV9UIqo5RR6GBraQdarrW2U6KHdpyRG1ffiDID089zYWWUZKWjj+opzp
         dNRE9ELS9n3/WzDDI/xuoFhDRXiVCWmbaQ53O7G+kn8MtxcfgeC42A2r+PEQCZEdJN45
         xpxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VjtW18trSHOOQ++iWlwEWrR0XUPVdV8/Se9flzmcddU=;
        b=OGO7sosMAe8rEkEyQKPAK8dJk5E0zcOfsKd4zHZcp8JzhUYHSe6CKPmIz0xwwyriti
         qqrRIYiPIeebUfgpQZucVKjuKwKWBZTC/s935yr4v8icvLra+ABm/157ScVChUVgjrnt
         U0JsEjmuXwdDoSQNCkn4dUFUD/4b8ZH3ZHLSFLg/1zeEIfL898G9Hyh/7nx/3Yvelf8S
         C2oBoz/u8m79kvlLk8z5ZYJY4uxdD9Rd1YELPsb+MaPkmywPPW30R8iP0h02Fn99MwEL
         xtkxk6Njz/bP1qrzxksJT0PZDAxuofEFYKW7t1WDNdXPNsCbIMm82tngZiaQJnUXbtcK
         yLRA==
X-Gm-Message-State: AOAM530A1gFwDsjToIvUIUsh+4FA+zqYUuZZD643WKymT9oaFZ5E7Zkn
        ZU7IaGYTDaRaTcoqgDJlrWg9JjdaoO0wJDBmBAvV7w==
X-Google-Smtp-Source: ABdhPJypfSLdSXb97/x4iYLpOr03nuCvuTkApoi503zg7GYi87aDkvdl/FNkhSV0p2F06CJhcuItiCx/mthD9grVnJg=
X-Received: by 2002:a05:620a:6bc:: with SMTP id i28mr4012799qkh.330.1589287718069;
 Tue, 12 May 2020 05:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200423174543.17161-1-michael@walle.cc> <20200423174543.17161-11-michael@walle.cc>
In-Reply-To: <20200423174543.17161-11-michael@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 12 May 2020 14:48:27 +0200
Message-ID: <CAMpxmJV3XTOxuoKeV-z2d75qWqHkgvV9419tfe3idDeKwoeoLA@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] gpio: add a reusable generic gpio_chip using regmap
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
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

czw., 23 kwi 2020 o 19:46 Michael Walle <michael@walle.cc> napisa=C5=82(a):
>
> There are quite a lot simple GPIO controller which are using regmap to
> access the hardware. This driver tries to be a base to unify existing
> code into one place. This won't cover everything but it should be a good
> starting point.
>
> It does not implement its own irq_chip because there is already a
> generic one for regmap based devices. Instead, the irq_chip will be
> instantiated in the parent driver and its irq domain will be associate
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
> ---

This looks good to me. Please see some nits below.

>  drivers/gpio/Kconfig        |   4 +
>  drivers/gpio/Makefile       |   1 +
>  drivers/gpio/gpio-regmap.c  | 343 ++++++++++++++++++++++++++++++++++++
>  include/linux/gpio-regmap.h |  69 ++++++++
>  4 files changed, 417 insertions(+)
>  create mode 100644 drivers/gpio/gpio-regmap.c
>  create mode 100644 include/linux/gpio-regmap.h
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 8ef2179fb999..ae3a49a2e970 100644
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
> index 000000000000..04939c0a22f9
> --- /dev/null
> +++ b/drivers/gpio/gpio-regmap.c
> @@ -0,0 +1,343 @@
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
> +struct gpio_regmap {
> +       struct device *parent;
> +       struct regmap *regmap;
> +       struct gpio_chip gpio_chip;
> +
> +       int reg_stride;
> +       int ngpio_per_reg;
> +       unsigned int reg_dat_base;
> +       unsigned int reg_set_base;
> +       unsigned int reg_clr_base;
> +       unsigned int reg_dir_in_base;
> +       unsigned int reg_dir_out_base;
> +
> +       int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base=
,
> +                             unsigned int offset, unsigned int *reg,
> +                             unsigned int *mask);
> +
> +       void *driver_data;
> +};
> +
> +static unsigned int gpio_regmap_addr(unsigned int addr)
> +{
> +       return (addr =3D=3D GPIO_REGMAP_ADDR_ZERO) ? 0 : addr;
> +}
> +
> +/**
> + * gpio_regmap_simple_xlate() - translate base/offset to reg/mask
> + *
> + * Use a simple linear mapping to translate the offset to the bitmask.
> + */
> +static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
> +                                   unsigned int base, unsigned int offse=
t,
> +                                   unsigned int *reg, unsigned int *mask=
)
> +{
> +       unsigned int line =3D offset % gpio->ngpio_per_reg;
> +       unsigned int stride =3D offset / gpio->ngpio_per_reg;
> +
> +       *reg =3D base + stride * gpio->reg_stride;
> +       *mask =3D BIT(line);
> +
> +       return 0;
> +}
> +
> +static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +       unsigned int base, val, reg, mask;
> +       int ret;
> +
> +       /* we might not have an output register if we are input only */
> +       if (gpio->reg_dat_base)
> +               base =3D gpio_regmap_addr(gpio->reg_dat_base);
> +       else
> +               base =3D gpio_regmap_addr(gpio->reg_set_base);
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
> +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +       unsigned int base =3D gpio_regmap_addr(gpio->reg_set_base);
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
> +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +       unsigned int base, reg, mask;
> +
> +       if (val)
> +               base =3D gpio_regmap_addr(gpio->reg_set_base);
> +       else
> +               base =3D gpio_regmap_addr(gpio->reg_clr_base);
> +
> +       gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
> +       regmap_write(gpio->regmap, reg, mask);
> +}
> +
> +static int gpio_regmap_get_direction(struct gpio_chip *chip,
> +                                    unsigned int offset)
> +{
> +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +       unsigned int base, val, reg, mask;
> +       int invert, ret;
> +
> +       if (gpio->reg_dir_out_base) {
> +               base =3D gpio_regmap_addr(gpio->reg_dir_out_base);
> +               invert =3D 0;
> +       } else if (gpio->reg_dir_in_base) {
> +               base =3D gpio_regmap_addr(gpio->reg_dir_in_base);
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
> +       struct gpio_regmap *gpio =3D gpiochip_get_data(chip);
> +       unsigned int base, val, reg, mask;
> +       int invert, ret;
> +
> +       if (gpio->reg_dir_out_base) {
> +               base =3D gpio_regmap_addr(gpio->reg_dir_out_base);
> +               invert =3D 0;
> +       } else if (gpio->reg_dir_in_base) {
> +               base =3D gpio_regmap_addr(gpio->reg_dir_in_base);
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
> +
> +       return gpio_regmap_set_direction(chip, offset, true);
> +}
> +
> +void gpio_regmap_set_drvdata(struct gpio_regmap *gpio, void *data)
> +{
> +       gpio->driver_data =3D data;
> +}
> +EXPORT_SYMBOL_GPL(gpio_regmap_set_drvdata);
> +
> +void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
> +{
> +       return gpio->driver_data;
> +}
> +EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
> +
> +/**
> + * gpio_regmap_register() - Register a generic regmap GPIO controller
> + *
> + * @gpio: gpio_regmap device to register
> + *
> + * Returns 0 on success or an errno on failure.
> + */
> +struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config=
 *config)
> +{
> +       struct gpio_regmap *gpio;
> +       struct gpio_chip *chip;
> +       int ret;
> +
> +       if (!config->parent)
> +               return ERR_PTR(-EINVAL);
> +
> +       if (!config->ngpio)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* we need at least one */
> +       if (!config->reg_dat_base && !config->reg_set_base)
> +               return ERR_PTR(-EINVAL);
> +
> +       /* we don't support having both registers simulaniously for now *=
/
> +       if (config->reg_dir_out_base && config->reg_dir_in_base)
> +               return ERR_PTR(-EINVAL);
> +
> +       gpio =3D kzalloc(sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return ERR_PTR(-ENOMEM);
> +
> +       gpio->parent =3D config->parent;
> +       gpio->regmap =3D config->regmap;
> +       gpio->ngpio_per_reg =3D config->ngpio_per_reg;
> +       gpio->reg_stride =3D config->reg_stride;
> +       gpio->reg_mask_xlate =3D config->reg_mask_xlate;
> +       gpio->reg_set_base =3D config->reg_set_base;
> +       gpio->reg_clr_base =3D config->reg_clr_base;
> +       gpio->reg_dir_in_base =3D config->reg_dir_in_base;
> +       gpio->reg_dir_out_base =3D config->reg_dir_out_base;
> +
> +       /* if not set, assume there is only one register */
> +       if (!gpio->ngpio_per_reg)
> +               gpio->ngpio_per_reg =3D config->ngpio;
> +
> +       /* if not set, assume they are consecutive */
> +       if (!gpio->reg_stride)
> +               gpio->reg_stride =3D 1;
> +
> +       if (!gpio->reg_mask_xlate)
> +               gpio->reg_mask_xlate =3D gpio_regmap_simple_xlate;
> +
> +       chip =3D &gpio->gpio_chip;
> +       chip->parent =3D config->parent;
> +       chip->base =3D -1;
> +       chip->ngpio =3D config->ngpio;
> +       chip->can_sleep =3D true;
> +
> +       if (!chip->label)
> +               chip->label =3D dev_name(config->parent);
> +       else
> +               chip->label =3D config->label;
> +
> +       chip->get =3D gpio_regmap_get;
> +       if (gpio->reg_set_base && gpio->reg_clr_base)
> +               chip->set =3D gpio_regmap_set_with_clear;
> +       else if (gpio->reg_set_base)
> +               chip->set =3D gpio_regmap_set;
> +
> +       if (gpio->reg_dir_in_base || gpio->reg_dir_out_base) {
> +               chip->get_direction =3D gpio_regmap_get_direction;
> +               chip->direction_input =3D gpio_regmap_direction_input;
> +               chip->direction_output =3D gpio_regmap_direction_output;
> +       }
> +
> +       ret =3D gpiochip_add_data(chip, gpio);
> +       if (ret < 0) {
> +               kfree(gpio);

Maybe add a second label at the end of the function?

> +               return ERR_PTR(ret);
> +       }
> +
> +       if (config->irq_domain) {
> +               ret =3D gpiochip_irqchip_add_domain(chip, config->irq_dom=
ain);
> +               if (ret < 0)
> +                       goto err;
> +       }
> +
> +       return gpio;
> +
> +err:
> +       gpiochip_remove(chip);
> +       kfree(gpio);
> +       return ERR_PTR(ret);
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
> +       gpiochip_remove(&gpio->gpio_chip);
> +       kfree(gpio);
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
> +struct gpio_regmap *devm_gpio_regmap_register(struct device *dev,
> +                                             const struct gpio_regmap_co=
nfig *config)
> +{
> +       struct gpio_regmap **ptr, *gpio;
> +
> +       ptr =3D devres_alloc(devm_gpio_regmap_unregister, sizeof(*ptr),
> +                          GFP_KERNEL);
> +       if (!ptr)
> +               return ERR_PTR(-ENOMEM);
> +
> +       gpio =3D gpio_regmap_register(config);
> +
> +       if (!IS_ERR(gpio)) {
> +               *ptr =3D gpio;
> +               devres_add(dev, ptr);
> +       } else {
> +               devres_free(ptr);
> +       }
> +
> +       return gpio;
> +}
> +EXPORT_SYMBOL_GPL(devm_gpio_regmap_register);
> +
> +MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
> +MODULE_DESCRIPTION("GPIO generic regmap driver core");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/gpio-regmap.h b/include/linux/gpio-regmap.h
> new file mode 100644
> index 000000000000..a868cbcde6e9
> --- /dev/null
> +++ b/include/linux/gpio-regmap.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _LINUX_GPIO_REGMAP_H
> +#define _LINUX_GPIO_REGMAP_H
> +
> +struct gpio_regmap;
> +
> +#define GPIO_REGMAP_ADDR_ZERO ((unsigned long)(-1))
> +#define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
> +

What if the addr is actually 0? Maybe drop GPIO_REGMAP_ADDR and
require users to set unused registers to GPIO_REGMAP_ADDR_ZERO?

> +/**
> + * struct gpio_regmap_config - Description of a generic regmap gpio_chip=
.
> + *
> + * @parent:            The parent device
> + * @regmap:            The regmap used to access the registers
> + *                     given, the name of the device is used
> + * @label:             (Optional) Descriptive name for GPIO controller.
> + *                     If not given, the name of the device is used.
> + * @ngpio:             Number of GPIOs
> + * @reg_dat_base:      (Optional) (in) register base address
> + * @reg_set_base:      (Optional) set register base address
> + * @reg_clr_base:      (Optional) clear register base address
> + * @reg_dir_in_base:   (Optional) out setting register base address
> + * @reg_dir_out_base:  (Optional) in setting register base address

The two above are inverted I think? Also: why the limitation of only
supporting one at a time?

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
> + *
> + * The reg_mask_xlate translates a given base address and GPIO offset to
> + * register and mask pair. The base address is one of the given reg_*_ba=
se.
> + *
> + * All base addresses may have the special value GPIO_REGMAP_ADDR_ZERO
> + * which forces the address to the value 0.
> + */
> +struct gpio_regmap_config {
> +       struct device *parent;
> +       struct regmap *regmap;
> +
> +       const char *label;
> +       int ngpio;
> +
> +       unsigned int reg_dat_base;
> +       unsigned int reg_set_base;
> +       unsigned int reg_clr_base;
> +       unsigned int reg_dir_in_base;
> +       unsigned int reg_dir_out_base;
> +       int reg_stride;
> +       int ngpio_per_reg;
> +       struct irq_domain *irq_domain;
> +
> +       int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base=
,
> +                             unsigned int offset, unsigned int *reg,
> +                             unsigned int *mask);
> +};
> +
> +struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config=
 *config);
> +void gpio_regmap_unregister(struct gpio_regmap *gpio);
> +struct gpio_regmap *devm_gpio_regmap_register(struct device *dev,
> +                                             const struct gpio_regmap_co=
nfig *config);
> +void gpio_regmap_set_drvdata(struct gpio_regmap *gpio, void *data);
> +void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
> +
> +#endif /* _LINUX_GPIO_REGMAP_H */
> --
> 2.20.1
>
