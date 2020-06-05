Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAC61EF6F4
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 14:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFEMBB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 08:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbgFEMBA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 08:01:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BCC08C5C2;
        Fri,  5 Jun 2020 05:01:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s88so2644973pjb.5;
        Fri, 05 Jun 2020 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Xf0VKrmkHeAJFwaoucbXABKRmsaGZeECCqgdfD3J2s=;
        b=tYaQ3fCRjkKhBvGrmDqpWE015RUF+OhT+4CSQYciswYQW+XoCZjEZxlXAum1/YUKrd
         K9PHXdqnhMWsxWT7E2CSDhXqBR3tg/yhSKxI94MXIuQoY/fILsKhYTaQzpiSWoM/6MSr
         GzXXsAB8LdUIVivCc1r7cqFsi8/FhhiHSrjA9+0Q1lWgc/pI6EFFaITTwv13WiEYNPZl
         HyFPB3z+YmFLc3j0k1IE+6d1yM+8jDF8Ws7GcuIYPQiVhSYjeYdhnODyb+XxiuSYGNYp
         QkvwXV3krpkE6XWNsMUyXCTpXXMKBYxgMxz7osqQKgnZV3nU1AQzKKS6AAHq4GDexQVL
         lf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Xf0VKrmkHeAJFwaoucbXABKRmsaGZeECCqgdfD3J2s=;
        b=Veyf5mWJOxPRaAaR9oCG78gY1MUZd+kwE2BLM3DNofTroO8PTOJetD99L/zxPzgBjd
         UG41pRI6X9h+xWxkvIgm70WggVe7Av2tuktKiCI7gp3ISvHKlujvvr/5IQ73X9LaNDPg
         29uUbSKySLGruCq8JQOhCJiJ9yj+QXeF9zOaEIXUIzsdOv6rAqzScC2Qln/aueb428px
         WIdRRurxBaUsi0pT7T5N70cER6STGqpQ/5mIy/aiRroZPZt6K84noi4IQv8O04skZXCR
         EzQCe1SVzGknrCdE6KljBOWyy8QPn6S3nfZzIbZy09KqjuREpliNHNt4cWPZ771dDwJN
         JlCA==
X-Gm-Message-State: AOAM530qYNBPKNVtUfsF5I3eX5MclXHBKfletVelx0DwAsHtJCaap9TC
        Ea2h/LxfpL3V6gs2YT2nkQ8BFxYZDTa8ElJB/dI=
X-Google-Smtp-Source: ABdhPJwACy0B38AavuEf6WMnT76KysnsvN8UpWw4wnOgQGpEezjfzKwDqPqc7U2vaZTzr539FT2ktvxUQOnmdxD8EuY=
X-Received: by 2002:a17:90a:ac05:: with SMTP id o5mr2734229pjq.228.1591358460238;
 Fri, 05 Jun 2020 05:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-7-michael@walle.cc>
In-Reply-To: <20200604211039.12689-7-michael@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 15:00:48 +0300
Message-ID: <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
Subject: Re: [PATCH v4 06/11] gpio: add support for the sl28cpld GPIO controller
To:     Michael Walle <michael@walle.cc>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:

> Add support for the GPIO controller of the sl28 board management
> controller. This driver is part of a multi-function device.
>
> A controller has 8 lines. There are three different flavors:
> full-featured GPIO with interrupt support, input-only and output-only.

...

> +#include <linux/of_device.h>

I think also not needed.
But wait...

> +       return devm_regmap_add_irq_chip_np(dev, dev_of_node(dev), regmap,

It seems regmap needs to be converted to use fwnode.

> +                                          irq, IRQF_SHARED | IRQF_ONESHOT, 0,
> +                                          irq_chip, &gpio->irq_data);

...

> +       if (!pdev->dev.parent)
> +               return -ENODEV;

Are we expecting to get shot into foot? I mean why we need this check?

> +       dev_id = platform_get_device_id(pdev);
> +       if (dev_id)
> +               type = dev_id->driver_data;

Oh, no. In new code we don't need this. We have facilities to provide
platform data in a form of fwnode.

> +       else
> +               type = (uintptr_t)of_device_get_match_data(&pdev->dev);

So does this. device_get_match_data().

> +       if (!type)
> +               return -ENODEV;

...

> +       if (irq_support &&

Why do you need this flag? Can't simple IRQ number be sufficient?

> +           device_property_read_bool(&pdev->dev, "interrupt-controller")) {
> +               irq = platform_get_irq(pdev, 0);
> +               if (irq < 0)
> +                       return irq;
> +
> +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
> +                                            base, irq);
> +               if (ret)
> +                       return ret;
> +
> +               config.irq_domain = regmap_irq_get_domain(gpio->irq_data);
> +       }

...

> +static const struct of_device_id sl28cpld_gpio_of_match[] = {

> +       { .compatible = "kontron,sl28cpld-gpio",
> +         .data = (void *)SL28CPLD_GPIO },
> +       { .compatible = "kontron,sl28cpld-gpi",
> +         .data = (void *)SL28CPLD_GPI },
> +       { .compatible = "kontron,sl28cpld-gpo",
> +         .data = (void *)SL28CPLD_GPO },

All above can be twice less LOCs.

> +       {},

No comma.

> +};


...

> +               .name = KBUILD_MODNAME,

This actually not good idea in long term. File name can change and break an ABI.

-- 
With Best Regards,
Andy Shevchenko
