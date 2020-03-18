Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B23AB1897B0
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Mar 2020 10:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727405AbgCRJOd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Mar 2020 05:14:33 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41019 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbgCRJOc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Mar 2020 05:14:32 -0400
Received: by mail-qt1-f195.google.com with SMTP id i26so10248214qtq.8
        for <linux-pwm@vger.kernel.org>; Wed, 18 Mar 2020 02:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=x9Pg5b/7UCKLvbU2YR1I+lNyCYk5/XlTykfp63ga3X8=;
        b=hA5ifeE6sl06h0efKs6Jcc5ITn27o/iVK7q8qUUS98v1gqevUhvKZt7JSTR1x5Ha3F
         ZEEjuJA3WocrkkiysHzeR0LpabPtnQM2tJGLSEo3wyWk4/UCWI4g1BWsp6zRDb02INB9
         RcRCzChAgA+KX7lIl5Um4Dvz92+AgN397o026JXlSCJ6uFwNVoCHDlhEwfQP3ZvFnFfT
         bXaTdykfs/UOYKxJSBPmoGLNk8jIdE/xXpPrtCL/fDdZ2+SMhvtVF9D93eRpVeqzg1xQ
         3kpNeLc38QIqzP0Js11iFUWnkBK/yp638I0bJ3FNfk9+l1ZpWuJKD4qxSa7+dNjYB2lR
         fJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=x9Pg5b/7UCKLvbU2YR1I+lNyCYk5/XlTykfp63ga3X8=;
        b=Q8YdE4crBU0a7IlFHcJJEqMtn7mG0JgbZSAnYLzsBp28cIoPhbEcmMFkpZT7wLVG5G
         nuRcbEe+l1VCM/gI3ybr0cuGZQMd5vegfu2q0Gll/W7THV3nPcPp/eIqsh+WGulr/WGw
         RjQ83EkHjioP2tQ4WQbL6EAaTENb14EDZaNwGc+hJFJUsoG0RVUvhvLd7uCO7jCJ2vQE
         9eueZutA1Oz0xb1MSVFVetCAmDgc5JAWGJK8U1c98aUwnDZwllWNYTuF3vINk4jXr/Jz
         wOrt2pew1tKkbLHKIdL+wgnt97Y+nX5djdJMe8g4fPQZGfgZiYI5UWEk/lRDbaZUqkyP
         Ej7g==
X-Gm-Message-State: ANhLgQ1xUa4EAlDoa70erZk79rka/G+jIPjEgXtwHsWPqCCe9Ls6+0BG
        FjH+IUJWWZ+OnLP3eEVuMICbYo+sJ0jGxD7QjLuGOg==
X-Google-Smtp-Source: ADFU+vt55gCji0ORLCrqulP8yZPC7MtpY2zexYQ9m2gv59PGQ4AOnqIUOPBWBnTqJgH4GDaLR5NFU18Y8CjFiYWO8zk=
X-Received: by 2002:ac8:7257:: with SMTP id l23mr3381022qtp.197.1584522868350;
 Wed, 18 Mar 2020 02:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200317205017.28280-1-michael@walle.cc> <20200317205017.28280-13-michael@walle.cc>
In-Reply-To: <20200317205017.28280-13-michael@walle.cc>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 18 Mar 2020 10:14:16 +0100
Message-ID: <CAMpxmJW770v6JLdveEe1hkgNEJByVyArhorSyUZBYOyFiVyOeg@mail.gmail.com>
Subject: Re: [PATCH 12/18] gpio: add support for the sl28cpld GPIO controller
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
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

wt., 17 mar 2020 o 21:50 Michael Walle <michael@walle.cc> napisa=C5=82(a):
>
> This adds support for the GPIO controller of the sl28 board management
> controller. This driver is part of a multi-function device.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

Hi Michael,

thanks for the driver. Please take a look at some comments below.

> ---
>  drivers/gpio/Kconfig         |  11 ++
>  drivers/gpio/Makefile        |   1 +
>  drivers/gpio/gpio-sl28cpld.c | 332 +++++++++++++++++++++++++++++++++++
>  3 files changed, 344 insertions(+)
>  create mode 100644 drivers/gpio/gpio-sl28cpld.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index 3cbf8882a0dd..516e47017ef5 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1211,6 +1211,17 @@ config GPIO_RC5T583
>           This driver provides the support for driving/reading the gpio p=
ins
>           of RC5T583 device through standard gpio library.
>
> +config GPIO_SL28CPLD
> +       tristate "Kontron sl28 GPIO"
> +       depends on MFD_SL28CPLD
> +       depends on OF_GPIO
> +       select GPIOLIB_IRQCHIP

Please see below - I think both are not needed.

> +       help
> +         This enables support for the GPIOs found on the Kontron sl28 CP=
LD.
> +
> +         This driver can also be built as a module. If so, the module wi=
ll be
> +         called gpio-sl28cpld.
> +
>  config GPIO_STMPE
>         bool "STMPE GPIOs"
>         depends on MFD_STMPE
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 0b571264ddbc..0ca2d52c78e8 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -127,6 +127,7 @@ obj-$(CONFIG_GPIO_SCH311X)          +=3D gpio-sch311x=
.o
>  obj-$(CONFIG_GPIO_SCH)                 +=3D gpio-sch.o
>  obj-$(CONFIG_GPIO_SIFIVE)              +=3D gpio-sifive.o
>  obj-$(CONFIG_GPIO_SIOX)                        +=3D gpio-siox.o
> +obj-$(CONFIG_GPIO_SL28CPLD)            +=3D gpio-sl28cpld.o
>  obj-$(CONFIG_GPIO_SODAVILLE)           +=3D gpio-sodaville.o
>  obj-$(CONFIG_GPIO_SPEAR_SPICS)         +=3D gpio-spear-spics.o
>  obj-$(CONFIG_GPIO_SPRD)                        +=3D gpio-sprd.o
> diff --git a/drivers/gpio/gpio-sl28cpld.c b/drivers/gpio/gpio-sl28cpld.c
> new file mode 100644
> index 000000000000..94f82013882f
> --- /dev/null
> +++ b/drivers/gpio/gpio-sl28cpld.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SMARC-sAL28 GPIO driver.
> + *
> + * Copyright 2019 Kontron Europe GmbH
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/of_address.h>
> +#include <linux/interrupt.h>
> +#include <linux/regmap.h>
> +#include <linux/platform_device.h>
> +#include <linux/gpio/driver.h>
> +
> +#define GPIO_REG_DIR   0
> +#define GPIO_REG_OUT   1
> +#define GPIO_REG_IN    2
> +#define GPIO_REG_IE    3
> +#define GPIO_REG_IP    4

These values would be more clear if they were defined as hex.

> +
> +#define GPI_REG_IN     0
> +
> +#define GPO_REG_OUT    0

Please also use a common prefix even for defines.

> +
> +enum sl28cpld_gpio_type {
> +       sl28cpld_gpio,
> +       sl28cpld_gpi,
> +       sl28cpld_gpo,
> +};

Enum values should be all upper-case.

> +
> +struct sl28cpld_gpio {
> +       struct gpio_chip gpio_chip;
> +       struct irq_chip irq_chip;
> +       struct regmap *regmap;
> +       u32 offset;
> +       struct mutex lock;
> +       u8 ie;
> +};
> +
> +static void sl28cpld_gpio_set_reg(struct gpio_chip *chip, unsigned int r=
eg,
> +                                 unsigned int offset, int value)
> +{
> +       struct sl28cpld_gpio *gpio =3D gpiochip_get_data(chip);
> +       unsigned int mask =3D 1 << offset;
> +       unsigned int val =3D value << offset;
> +
> +       regmap_update_bits(gpio->regmap, gpio->offset + reg, mask, val);
> +}
> +
> +static void sl28cpld_gpio_set(struct gpio_chip *chip, unsigned int offse=
t,
> +                             int value)
> +{
> +       sl28cpld_gpio_set_reg(chip, GPIO_REG_OUT, offset, value);
> +}
> +
> +static void sl28cpld_gpo_set(struct gpio_chip *chip, unsigned int offset=
,
> +                            int value)
> +{
> +       sl28cpld_gpio_set_reg(chip, GPO_REG_OUT, offset, value);
> +}
> +
> +static int sl28cpld_gpio_get_reg(struct gpio_chip *chip, unsigned int re=
g,
> +                                unsigned int offset)
> +{
> +       struct sl28cpld_gpio *gpio =3D gpiochip_get_data(chip);
> +       unsigned int mask =3D 1 << offset;
> +       unsigned int val;
> +       int ret;
> +
> +       ret =3D regmap_read(gpio->regmap, gpio->offset + reg, &val);
> +       if (ret)
> +               return ret;
> +
> +       return (val & mask) ? 1 : 0;
> +}
> +
> +static int sl28cpld_gpio_get(struct gpio_chip *chip, unsigned int offset=
)
> +{
> +       return sl28cpld_gpio_get_reg(chip, GPIO_REG_IN, offset);
> +}
> +
> +static int sl28cpld_gpi_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +       return sl28cpld_gpio_get_reg(chip, GPI_REG_IN, offset);
> +}
> +
> +static int sl28cpld_gpio_get_direction(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       struct sl28cpld_gpio *gpio =3D gpiochip_get_data(chip);
> +       unsigned int reg;
> +       int ret;
> +
> +       ret =3D regmap_read(gpio->regmap, gpio->offset + GPIO_REG_DIR, &r=
eg);
> +       if (ret)
> +               return ret;
> +
> +       if (reg & (1 << offset))
> +               return GPIO_LINE_DIRECTION_OUT;
> +       else
> +               return GPIO_LINE_DIRECTION_IN;
> +}
> +
> +static int sl28cpld_gpio_set_direction(struct gpio_chip *chip,
> +                                      unsigned int offset,
> +                                      bool output)
> +{
> +       struct sl28cpld_gpio *gpio =3D gpiochip_get_data(chip);
> +       unsigned int mask =3D 1 << offset;
> +       unsigned int val =3D (output) ? mask : 0;
> +
> +       return regmap_update_bits(gpio->regmap, gpio->offset + GPIO_REG_D=
IR,
> +                                 mask, val);
> +

Stray newline.

> +}
> +
> +static int sl28cpld_gpio_direction_input(struct gpio_chip *chip,
> +                                        unsigned int offset)
> +{
> +       return sl28cpld_gpio_set_direction(chip, offset, false);
> +}
> +
> +static int sl28cpld_gpio_direction_output(struct gpio_chip *chip,
> +                                         unsigned int offset, int value)
> +{
> +       sl28cpld_gpio_set_reg(chip, GPIO_REG_OUT, offset, value);
> +       return sl28cpld_gpio_set_direction(chip, offset, true);
> +}
> +
> +static void sl28cpld_gpio_irq_lock(struct irq_data *data)
> +{
> +       struct sl28cpld_gpio *gpio =3D
> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +
> +       mutex_lock(&gpio->lock);

How does that actually lock anything? Regmap uses a different lock and
if you want to make sure nobody modifies the GPIO registers than you'd
need to use the same lock. Also: this looks a lot like a task for
regmap_irqchip - maybe you could use it here or in the core mfd
module?

> +}
> +
> +static void sl28cpld_gpio_irq_sync_unlock(struct irq_data *data)
> +{
> +       struct sl28cpld_gpio *gpio =3D
> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +
> +       regmap_write(gpio->regmap, gpio->offset + GPIO_REG_IE, gpio->ie);
> +       mutex_unlock(&gpio->lock);
> +}
> +
> +static void sl28cpld_gpio_irq_disable(struct irq_data *data)
> +{
> +       struct sl28cpld_gpio *gpio =3D
> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +
> +       if (data->hwirq >=3D 8)
> +               return;
> +
> +       gpio->ie &=3D ~(1 << data->hwirq);
> +}
> +
> +static void sl28cpld_gpio_irq_enable(struct irq_data *data)
> +{
> +       struct sl28cpld_gpio *gpio =3D
> +               gpiochip_get_data(irq_data_get_irq_chip_data(data));
> +
> +       if (data->hwirq >=3D 8)
> +               return;
> +
> +       gpio->ie |=3D (1 << data->hwirq);
> +}
> +
> +static int sl28cpld_gpio_irq_set_type(struct irq_data *data, unsigned in=
t type)
> +{
> +       /* only edge triggered interrupts on both edges are supported */
> +       return (type =3D=3D IRQ_TYPE_EDGE_BOTH) ? 0 : -EINVAL;
> +}
> +
> +static irqreturn_t sl28cpld_gpio_irq_thread(int irq, void *data)
> +{
> +       struct sl28cpld_gpio *gpio =3D data;
> +       unsigned int ip;
> +       unsigned int virq;
> +       int pin;
> +       int ret;
> +
> +       ret =3D regmap_read(gpio->regmap, gpio->offset + GPIO_REG_IP, &ip=
);
> +       if (ret)
> +               return IRQ_NONE;
> +
> +       /* mask other pending interrupts which are not enabled */
> +       ip &=3D gpio->ie;
> +
> +       /* ack the interrupts */
> +       regmap_write(gpio->regmap, gpio->offset + GPIO_REG_IP, ip);
> +
> +       /* and handle them */
> +       while (ip) {
> +               pin =3D __ffs(ip);
> +               ip &=3D ~BIT(pin);
> +
> +               virq =3D irq_find_mapping(gpio->gpio_chip.irq.domain, pin=
);
> +               if (virq)
> +                       handle_nested_irq(virq);
> +       }
> +
> +       return IRQ_HANDLED;
> +}

This definitely looks like parts of regmap_irqchip reimplemented.
Please check if you could reuse it - it would save a lot of code.

> +
> +static int sl28_cpld_gpio_irq_init(struct platform_device *pdev, int irq=
)
> +{
> +       struct sl28cpld_gpio *gpio =3D platform_get_drvdata(pdev);
> +       struct irq_chip *irq_chip =3D &gpio->irq_chip;
> +       int ret;
> +
> +       irq_chip->name =3D "sl28cpld-gpio-irq",
> +       irq_chip->irq_bus_lock =3D sl28cpld_gpio_irq_lock,
> +       irq_chip->irq_bus_sync_unlock =3D sl28cpld_gpio_irq_sync_unlock,
> +       irq_chip->irq_disable =3D sl28cpld_gpio_irq_disable,
> +       irq_chip->irq_enable =3D sl28cpld_gpio_irq_enable,
> +       irq_chip->irq_set_type =3D sl28cpld_gpio_irq_set_type,
> +       irq_chip->flags =3D IRQCHIP_SKIP_SET_WAKE,
> +
> +       ret =3D gpiochip_irqchip_add_nested(&gpio->gpio_chip, irq_chip, 0=
,
> +                                         handle_simple_irq, IRQ_TYPE_NON=
E);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D devm_request_threaded_irq(&pdev->dev, irq, NULL,
> +                                       sl28cpld_gpio_irq_thread,
> +                                       IRQF_SHARED | IRQF_ONESHOT,
> +                                       pdev->name, gpio);
> +       if (ret)
> +               return ret;
> +
> +       gpiochip_set_nested_irqchip(&gpio->gpio_chip, irq_chip, irq);
> +
> +       return 0;
> +}
> +
> +static int sl28cpld_gpio_probe(struct platform_device *pdev)
> +{
> +       enum sl28cpld_gpio_type type =3D
> +               platform_get_device_id(pdev)->driver_data;
> +       struct device_node *np =3D pdev->dev.of_node;
> +       struct sl28cpld_gpio *gpio;
> +       struct gpio_chip *chip;
> +       struct resource *res;
> +       bool irq_support =3D false;
> +       int ret;
> +       int irq;
> +
> +       gpio =3D devm_kzalloc(&pdev->dev, sizeof(*gpio), GFP_KERNEL);
> +       if (!gpio)
> +               return -ENOMEM;
> +
> +       if (!pdev->dev.parent)
> +               return -ENODEV;

Why not check this before allocating any memory?

> +
> +       gpio->regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> +       if (!gpio->regmap)
> +               return -ENODEV;
> +
> +       res =3D platform_get_resource(pdev, IORESOURCE_REG, 0);
> +       if (!res)
> +               return -EINVAL;
> +       gpio->offset =3D res->start;
> +

This isn't how IO resources are used. What are you trying to achieve here?

> +       /* initialize struct gpio_chip */
> +       mutex_init(&gpio->lock);
> +       chip =3D &gpio->gpio_chip;
> +       chip->parent =3D &pdev->dev;
> +       chip->label =3D dev_name(&pdev->dev);
> +       chip->owner =3D THIS_MODULE;
> +       chip->can_sleep =3D true;
> +       chip->base =3D -1;
> +       chip->ngpio =3D 8;
> +
> +       switch (type) {
> +       case sl28cpld_gpio:
> +               chip->get_direction =3D sl28cpld_gpio_get_direction;
> +               chip->direction_input =3D sl28cpld_gpio_direction_input;
> +               chip->direction_output =3D sl28cpld_gpio_direction_output=
;
> +               chip->get =3D sl28cpld_gpio_get;
> +               chip->set =3D sl28cpld_gpio_set;
> +               irq_support =3D true;
> +               break;
> +       case sl28cpld_gpo:
> +               chip->set =3D sl28cpld_gpo_set;
> +               chip->get =3D sl28cpld_gpi_get;
> +               break;
> +       case sl28cpld_gpi:
> +               chip->get =3D sl28cpld_gpi_get;
> +               break;
> +       }
> +
> +       ret =3D devm_gpiochip_add_data(&pdev->dev, chip, gpio);
> +       if (ret < 0)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, gpio);
> +
> +       if (irq_support && of_property_read_bool(np, "interrupt-controlle=
r")) {

You're depending on OF_GPIO for this one function. Please switch to
device_property_read_bool() instead.

> +               irq =3D platform_get_irq(pdev, 0);
> +               if (irq < 0)
> +                       return ret;
> +
> +               ret =3D sl28_cpld_gpio_irq_init(pdev, irq);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct platform_device_id sl28cpld_gpio_id_table[] =3D {
> +       {"sl28cpld-gpio", sl28cpld_gpio},
> +       {"sl28cpld-gpi", sl28cpld_gpi},
> +       {"sl28cpld-gpo", sl28cpld_gpo},

Could you explain this a bit more? Is this the same component with
input/output-only lines or three different components?

> +};
> +MODULE_DEVICE_TABLE(platform, sl28cpld_gpio_id_table);
> +
> +static struct platform_driver sl28cpld_gpio_driver =3D {
> +       .probe =3D sl28cpld_gpio_probe,
> +       .id_table =3D sl28cpld_gpio_id_table,
> +       .driver =3D {
> +               .name =3D "sl28cpld-gpio",
> +       },
> +};
> +module_platform_driver(sl28cpld_gpio_driver);
> +
> +MODULE_DESCRIPTION("sl28cpld GPIO Driver");
> +MODULE_LICENSE("GPL");

I think you could use a MODULE_ALIAS() here if you want this module to
be loaded automatically by udev.

> --
> 2.20.1
>

Best regards,
Bartosz Golaszewski
