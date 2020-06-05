Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9381EF29D
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 10:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbgFEIBp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEIBp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:01:45 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3636C08C5C2;
        Fri,  5 Jun 2020 01:01:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so4563290pfc.5;
        Fri, 05 Jun 2020 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CA32MQ/+vRGTpFh4UZx8UcD1pDZn/aqTDePABuFsMhA=;
        b=SqGNdaF0A6Kq1TcOl0i/w+Mz7gpK3TvBcCVsNXyvakLq/sI1vjH9Gydj55AfUfH9jJ
         aYs3QqCXt5c3d1k0qq13+K2Uv7JyTxshU0RSzrKBrz5OjsFwkKdnw4sOp603IEyQPiDd
         89zCC+yqpR029H2Ew2FnHd4D2aGfwn/ByuodHV7MbX0fUOLBcC+L+d0HKpwtalFHrOEB
         W7zFBO+bNIGPoxHEJ/pt/cjKbfnFtArfKZN1q4p+7CwBZixuqzsXECf0yASthSfR1qP4
         x6e0fswV/QzEtzr5wGL8Fg0je0o+1sIX9ltX0sGRUyXhtDgaDVshsZ/AE8O/vX1i2sQc
         l3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CA32MQ/+vRGTpFh4UZx8UcD1pDZn/aqTDePABuFsMhA=;
        b=tQhZBL41IM3w8TpWbrNo0thO3xjQCM4/3bS4TtQRkQmPR7DCXghWYcx/tMs1Nw+Hlq
         ClCkVI3+Xo7cO3ng4pY3g8epbAiKE5K1w/GbllySasXS4xihir76yR49fLC5DWSn2AbR
         9bIIvg5JX+/WS0pN0xHaOB2fJ+/NUL5/fLOl3o/YvD9VU3D4MFYFIqNfWLAmgJg8b1kA
         eTUothXbD7HyktMKwUNhMvFyzxeFuohorLl1G3k76owzWOBCtM5KGREJO7UIa8mOKgTu
         oTqO/qi5ErEPala2uj7tBphNY3Pz0FQxbg8+LkfdfXqGMUL5kY4huJsfiX3/p6aIueox
         pfBA==
X-Gm-Message-State: AOAM530UkXph9iB3w0lE27/d0XFD3yd9QOFJw/PhYnexb02TgxXEwJAO
        H3IKwZkaMAwiEKTWYRzI5p3/iOcxtPrZLyroYBg=
X-Google-Smtp-Source: ABdhPJxS0gxAXwoiIs/HAxam4Ku1ew3smVf/6LQ9gSPZd/jo5uG/q2I+R8nedzrqQ5RR62x1rVChLyZKWcKjSc0zh2k=
X-Received: by 2002:a62:1792:: with SMTP id 140mr8576341pfx.36.1591344103178;
 Fri, 05 Jun 2020 01:01:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
In-Reply-To: <20200604211039.12689-3-michael@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 11:01:26 +0300
Message-ID: <CAHp75Vd-R3yqhq88-whY6vdDhESpzvFCsbi-ygSTjfXfUzOrtg@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
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

On Fri, Jun 5, 2020 at 12:16 AM Michael Walle <michael@walle.cc> wrote:
>
> Add the core support for the board management controller found on the
> SMARC-sAL28 board. It consists of the following functions:
>  - watchdog
>  - GPIO controller
>  - PWM controller
>  - fan sensor
>  - interrupt controller
>
> At the moment, this controller is used on the Kontron SMARC-sAL28 board.
>
> Please note that the MFD driver is defined as bool in the Kconfig
> because the next patch will add interrupt support.

...

> +config MFD_SL28CPLD
> +       bool "Kontron sl28 core driver"
> +       depends on I2C=y

Why not module?

> +       depends on OF

I didn't find an evidence this is needed.

No Compile Test?

> +       select REGMAP_I2C
> +       select MFD_CORE

...

> +#include <linux/of_platform.h>

No evidence of user of this.
I think you meant mod_devicetable.h.

...

> +static struct i2c_driver sl28cpld_driver = {
> +       .probe_new = sl28cpld_probe,
> +       .driver = {
> +               .name = "sl28cpld",
> +               .of_match_table = of_match_ptr(sl28cpld_of_match),

Drop of_match_ptr(). It has a little sense in this context (depends OF).
It will have a little sense even if you drop depends OF b/c you will
introduce a compiler warning.

> +       },
> +};


-- 
With Best Regards,
Andy Shevchenko
