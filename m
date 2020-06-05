Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8079E1F0171
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Jun 2020 23:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgFEVT2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Jun 2020 17:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgFEVT2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Jun 2020 17:19:28 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8ACC08C5C2;
        Fri,  5 Jun 2020 14:19:27 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id 5so3352028pjd.0;
        Fri, 05 Jun 2020 14:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wpIJ/pCsCHfvMrUjgnLtjwLHPcHaPzmZRezwzKb361g=;
        b=D9uEVO9pBGBuM5rac9wGkOcr0GyHQpJh+pyiTwwl4iR+n8MT0M8tnX76R8O3Erohyt
         EgCEGnv4Mz82lsf7a9akAwu34HW2vqe7iywOWhpUtUkLfpZmBZfDKKpeROyYLIz/Q/9a
         rVVTBUC8cb7ary8XzT2Axnq/WuPSe3OfTb+cx54B1Sd0kslAc3h6S2iBStuNex94GU7b
         mDrIor/QDPWPPok3o1LPVI9hc+jsBy3DbeNpEIKujOSXLRYqUlg9Yzqck5pY8r5bnHMx
         KahFrX/fv73aD5HFjXluO9dCAmxd4zhpoKXGu/oj1o/ZfE0bEOXanH6mfuhV60ZDBRI6
         dWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wpIJ/pCsCHfvMrUjgnLtjwLHPcHaPzmZRezwzKb361g=;
        b=XdbHsrSsgW8R9qaKOQWwqVSOb4cW9DlsgIWQw8QraWHauKLTjiRrvQql30XKNURWQg
         COYrLaIycu4VvhhGkya14+EYAuGJmCSV54ikKruxTKJvcrO2TjJKWcURqMoNH8uvFj8j
         txOKipFbeac6c4GisFSMn1qGXlEYDj3BmkVcGxSWk7VZcj7kxdqE6Kf/g9FFr0QE5Rps
         DyPI7WFOhhZohNWjEdpr1TYHlGfUz0NxOuULrUSm9teG0xNHDIQEsxPhmUlP4hMcdT+K
         szYIwKbAEt5LawJCCq+oMumJD0vfeodDVBl3/gY791+Kw7h+thUVjlYjRrZS9sPGQC35
         DkWw==
X-Gm-Message-State: AOAM533petZ5ZCYxdAjH+wpjFwgHZ9eVHBaNQ3m0swH73hSHzR80dCKC
        zKZ3tBu63Yi3I8ZrdYcy1zjxGdc+f1yt3aJXgiY=
X-Google-Smtp-Source: ABdhPJxXNB8ca/IQamWPxX4c7rhF1Ss/vRoiBGn2rbgdaO/EsyN0ZDTBvKrDVxNQzxgEJDIyY06sXaaxVufze1JWhZE=
X-Received: by 2002:a17:90a:1704:: with SMTP id z4mr4991653pjd.181.1591391967317;
 Fri, 05 Jun 2020 14:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-7-michael@walle.cc>
 <CAHp75VfRhL1f-XD=PMbqd3BLeJQzQMFAupSzqAvx0g7-X_2VhQ@mail.gmail.com>
 <216db3154b46bd80202873df055bb3f3@walle.cc> <20200605131525.GK2428291@smile.fi.intel.com>
 <bf587fc3f907d58609a0ea3d65cd5b37@walle.cc>
In-Reply-To: <bf587fc3f907d58609a0ea3d65cd5b37@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Jun 2020 00:19:10 +0300
Message-ID: <CAHp75Vcqv8rdqfBdttLb2vgj12AOUAOFK+ya7MZtRT+0_U+rYA@mail.gmail.com>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jun 5, 2020 at 9:44 PM Michael Walle <michael@walle.cc> wrote:
> Am 2020-06-05 15:15, schrieb Andy Shevchenko:
> > On Fri, Jun 05, 2020 at 02:42:53PM +0200, Michael Walle wrote:
> >> Am 2020-06-05 14:00, schrieb Andy Shevchenko:
> >> > On Fri, Jun 5, 2020 at 12:14 AM Michael Walle <michael@walle.cc> wrote:

...

> >> > > +       if (irq_support &&
> >> >
> >> > Why do you need this flag? Can't simple IRQ number be sufficient?
> >>
> >> I want to make sure, the is no misconfiguration. Eg. only GPIO
> >> flavors which has irq_support set, have the additional interrupt
> >> registers.
> >
> > In gpio-dwapb, for example, we simple check two things: a) hardware
> > limitation
> > (if IRQ is assigned to a proper port) and b) if there is any IRQ comes
> > from DT,
> > ACPI, etc.
>
> I can't follow you here. irq_support is like your (a); or the
> "pp->idx == 0" in your example.

And you have type already. Why do you need to duplicate it? Moreover,
is it protection from wrong type to have interrupts?

You can move this all stuff under corresponding switch-case.

> >> > > +           device_property_read_bool(&pdev->dev,
> >> > > "interrupt-controller")) {
> >> > > +               irq = platform_get_irq(pdev, 0);
> >> > > +               if (irq < 0)
> >> > > +                       return irq;
> >> > > +
> >> > > +               ret = sl28cpld_gpio_irq_init(&pdev->dev, gpio, regmap,
> >> > > +                                            base, irq);
> >> > > +               if (ret)
> >> > > +                       return ret;
> >> > > +
> >> > > +               config.irq_domain =
> >> > > regmap_irq_get_domain(gpio->irq_data);


-- 
With Best Regards,
Andy Shevchenko
