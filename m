Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82E11EF2BD
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 10:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgFEIHt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFEIHt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 04:07:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F1C08C5C2;
        Fri,  5 Jun 2020 01:07:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m2so2404756pjv.2;
        Fri, 05 Jun 2020 01:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mh4Ou1kljVhmduS90PzlDrAXnymKkFPOJ7HMxIuD1Kw=;
        b=ooV6D/FPWvYy0szimNsEbMVLx4ELEjsAq6byLimowmFrpxqQOOnGvbGhMR9bBWXX+H
         rsS/Z/gP8h2jLc7FvWubJLY4ouB+hb7PbdRl3uqWatLg1z9wjEOhfekVDH3u0+GYkp4b
         mNUVgP3DzqQ5ipr3hMG4iWbNbaA0zmL08KVHfWfQiDMT/In9+o3QfSgQ8ScQPPCkNqlZ
         WuPaBoCowYeyAHNhrYJ4euXf0b8vKiOtJtwO6Wj+w2sdFw8VgkF+Qmzz0rT5TktKtUeB
         C6lCJCvuk3uPzweD1gpoHmpODgP2ppvphW7rJMppm2pyjDNMpZ+fLlrLc6g22StiXcA9
         7dxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh4Ou1kljVhmduS90PzlDrAXnymKkFPOJ7HMxIuD1Kw=;
        b=dMk8Qx0edR84yIg+wpzgyR0F3MgoTL3Dbnd2+jRHH7lJ7DNo3ZoZ1cIR4eTl0lhbHu
         9rgDg0G7BTxkGmfhxz4tVnTlIzNJwPaPKlocoGN3l2iQOkGkRhCmbf7jrxEJCCG6yZco
         Lz935zdR9pnymshzgXc0aF3aX2xF7RGCRYYkhEX1jAti+VW4ak54cSOp33p9BAo7Qno3
         P5bttYvukyyTdyiK0JoD9+aPG6y4PaCVfHTqrIXEJ/gnxawc/Of+eXjU8Pn0xU1cN8uT
         lGLOXG+hixI2LD5VOFyUjgYzWhQCA1X0nm5hE5GJ+mcfh1ZY9U38kEXZTRrO85I1DTar
         5qiA==
X-Gm-Message-State: AOAM531cWFhT4NspKMxJu9bTePYEsWyU6k4YYPZCdHMc+93gfR5Xo+fO
        1OGZ+MFI3Tz156eyAdqjsg6rp3gwho/FHkNh8oQ=
X-Google-Smtp-Source: ABdhPJyxNexTfAEaebDSZO4i7E1Zrn1WbnacURd4rREtFFQ7AxnFLe4wpe5cp8So8FlFIxnRiJLHBWwprn7jbMq6GlQ=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr1570669pjd.181.1591344468760;
 Fri, 05 Jun 2020 01:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-4-michael@walle.cc>
In-Reply-To: <20200604211039.12689-4-michael@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 5 Jun 2020 11:07:32 +0300
Message-ID: <CAHp75VfMSbAMPg2ZLO6kE-9vkQCt0a+=Lji8V5ngY7xdUbfiMQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/11] irqchip: add sl28cpld interrupt controller support
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

On Fri, Jun 5, 2020 at 12:13 AM Michael Walle <michael@walle.cc> wrote:
>
> Add support for the interrupt controller inside the sl28 CPLD management
> controller.
>
> The interrupt controller can handle at most 8 interrupts and is really
> simplistic and consists only of an interrupt mask and an interrupt
> pending register.

...

> +config SL28CPLD_INTC
> +       bool

Same Q: Why not module?

...

> +static const struct of_device_id sl28cpld_intc_of_match[] = {
> +       { .compatible = "kontron,sl28cpld-intc" },

> +       {},

There is no point to have comma in terminator line.

> +};


-- 
With Best Regards,
Andy Shevchenko
