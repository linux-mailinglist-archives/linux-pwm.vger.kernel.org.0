Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C39C1EF705
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 14:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFEMGr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 08:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgFEMGr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 08:06:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30175C08C5C2;
        Fri,  5 Jun 2020 05:06:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so5087439pgk.1;
        Fri, 05 Jun 2020 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tg2EERYeGqRpBqYybMZ9XMQjf0DjL2pwtOCU5se6BJ8=;
        b=n0Tl0XWLTlt+ec1Ce3+UyjsRVYhekGd2rIJCCsUGrX0inZZIrW8Og57IIHkVPMIdSS
         u2/jhU1iS1KrEVZPT4pBgmgs/JkArzGh3Q48Mf3w/Ujrz260alNvIp543RyaaFSV4qBD
         dJmJwkwootDjm8pJ5RlB41X92cs19NbKJd+H7LRJZ6h6iYUo9o37qwc6mQzgqLzwrDMI
         FdlPjBFRXcK98KZCzWyAOcuuRfoe6SN00oED5RqU1I4Jh4rHt3Nt/FAy/e+EEpzvYPqa
         DRgb3VM8DmAfSwGBO0+sXRNxpQjywc8NcMHQpNlIQAQlaP3xgzra2NXDxUSDLu9PyQD4
         oEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tg2EERYeGqRpBqYybMZ9XMQjf0DjL2pwtOCU5se6BJ8=;
        b=YXPooyLHB0Cm8pD001k6Ik8NIXb1x8AahmyJ62LBDUnxWhpRwIjwQ5furPqmgB1frr
         d/qwFYzyPBO9FzIyuh1pPbm0PoqPMXLXklsbPF4j1CTiZ0pNEmr/BIT678nQQDm2oZue
         r2qHdZg8aw2tPgBb4l9W6O/JW/Mkdj28oGZZnPt0HLiX0qh/Xmxn7N+7YoSSRtXDExXs
         2ebBZTQw4ugWygH8DOatE+r7e4fqwsu5wHphPcOTADdQwE5QRWaHSBK2jy+VS7zlno6H
         JzpDoYshFZB8iK4vaskVyveDSPUMV5vbuIpaacaJ/HAmXAGKIIxJuR8eQvArwciysIxL
         60dw==
X-Gm-Message-State: AOAM533m0CFq8N3ptniMOJ6JDB6nqoWxvdrvjSBRTvW5kK7zquCMjpdk
        qPct5rB54VEnaCsP/qCbh8TpQbxpUhkjSN+giMw=
X-Google-Smtp-Source: ABdhPJxvhp+S0ILJ9P3oJuQGbD3SgEjJ+VvYOPiQ2EEF2EeVita727gg2YseqMdm5hdUfsulh7j3lVjYD8g1pnc9qAg=
X-Received: by 2002:a63:545a:: with SMTP id e26mr9043326pgm.4.1591358806690;
 Fri, 05 Jun 2020 05:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-8-michael@walle.cc>
In-Reply-To: <20200604211039.12689-8-michael@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 15:06:35 +0300
Message-ID: <CAHp75Vd00VeL94S=U77NCm9-WNF6ZLAn4U9oUSov1R1QU4DjDg@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] hwmon: add support for the sl28cpld hardware
 monitoring controller
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
>
> Add support for the hardware monitoring controller of the sl28cpld board
> management controller. This driver is part of a multi-function device.

...

> +#include <linux/of_device.h>

mod_devicetable.h ?

...


> +       hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +                               "sl28cpld_hwmon", hwmon,
> +                               &sl28cpld_hwmon_chip_info, NULL);
> +       if (IS_ERR(hwmon_dev)) {
> +               dev_err(&pdev->dev, "failed to register as hwmon device");

> +               return PTR_ERR(hwmon_dev);
> +       }
> +
> +       return 0;

PTR_ERR_OR_ZERO() ?

...

> +static const struct of_device_id sl28cpld_hwmon_of_match[] = {
> +       { .compatible = "kontron,sl28cpld-fan" },

> +       {},

No comma.

> +};

-- 
With Best Regards,
Andy Shevchenko
