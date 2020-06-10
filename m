Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB71F59D6
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Jun 2020 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgFJRQZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Jun 2020 13:16:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727938AbgFJRQX (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:23 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5855B20820;
        Wed, 10 Jun 2020 17:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591809382;
        bh=VuG8GFAPexrsYOA4UE1dLrNk0LWRoaPJInTcHfEdbfo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cS9uw1oEysLZyc2hML43CnVBubSlpUYbM9CTxkk9RoQ715TYm/u3Dy8vLeX92YFTE
         IkcqPBTQ3Rx3T8JW4U0T7zi6X4B3yrCgYsmJg7KPfCl1HecKq6oGj5DwWASrzgOSPn
         lQWCOT18fF9z+do35e5vBc/EmNwC2ti6NMhrdwec=
Received: by mail-oi1-f171.google.com with SMTP id p70so2728310oic.12;
        Wed, 10 Jun 2020 10:16:22 -0700 (PDT)
X-Gm-Message-State: AOAM531sjSvLiUglLnibhf+Ypa7+9PxAnKP41begekUUbzwfpVISI/wb
        s/tFxhq730hxlIi/Rqfx4jPGr91NKtjLwreD3Q==
X-Google-Smtp-Source: ABdhPJwHOABuR6AQwMm2KvAS7N8eot1RgRxtzsddB3/K6M8xY7inxghhge+De2OMnh1FR1Xql5mlTOlR1gqOEN6sorU=
X-Received: by 2002:aca:d943:: with SMTP id q64mr3389865oig.147.1591809381607;
 Wed, 10 Jun 2020 10:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc> <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc> <20200609064735.GH4106@dell>
 <32287ac0488f7cbd5a7d1259c284e554@walle.cc> <20200609151941.GM4106@dell>
 <95e6ec9bbdf6af7a9ff9c31786f743f2@walle.cc> <20200609194505.GQ4106@dell>
 <3a6931248f0efcaf8efbb5425a9bd833@walle.cc> <20200610071940.GS4106@dell>
In-Reply-To: <20200610071940.GS4106@dell>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 10 Jun 2020 11:16:10 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
Message-ID: <CAL_JsqKr1aDVzgAMjwwK8E8O_f29vSrx1HXk81FF+rd3sEe==w@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jun 10, 2020 at 1:19 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 10 Jun 2020, Michael Walle wrote:
> > Am 2020-06-09 21:45, schrieb Lee Jones:
> > > On Tue, 09 Jun 2020, Michael Walle wrote:
> > > > > We do not need a 'simple-regmap' solution for your use-case.
> > > > >
> > > > > Since your device's registers are segregated, just split up the
> > > > > register map and allocate each sub-device with it's own slice.
> > > >
> > > > I don't get it, could you make a device tree example for my
> > > > use-case? (see also above)
> > >
> > >     &i2cbus {
> > >         mfd-device@10 {
> > >             compatible =3D "simple-mfd";
> > >             reg =3D <10>;
> > >
> > >             sub-device@10 {
> > >                 compatible =3D "vendor,sub-device";
> > >                 reg =3D <10>;
> > >             };
> > >    };
> > >
> > > The Regmap config would be present in each of the child devices.
> > >
> > > Each child device would call devm_regmap_init_i2c() in .probe().
> >
> > Ah, I see. If I'm not wrong, this still means to create an i2c
> > device driver with the name "simple-mfd".
>
> Yes, it does.

TBC, while fine for a driver to bind on 'simple-mfd', a DT compatible
with that alone is not fine.

> > Besides that, I don't like this, because:
> >  - Rob already expressed its concerns with "simple-mfd" and so on.
>
> Where did this take place?  I'd like to read up on this.
>
> >  - you need to duplicate the config in each sub device
>
> You can have a share a single config.
>
> >  - which also means you are restricting the sub devices to be
> >    i2c only (unless you implement and duplicate other regmap configs,
> >    too). For this driver, SPI and MMIO may be viable options.
>
> You could also have a shared implementation to choose between different
> busses.

I think it is really the syscon mfd driver you want to generalize to
other buses. Though with a quick look at it, there's not really a
whole lot to share. The regmap lookup would be the main thing. You are
going to need a driver instance for each bus type.

> > Thus, I'd rather implement a simple-mfd.c which implement a common
> > I2C driver for now and populate its children using
> > devm_of_platform_populate(). This could be extended to support other
> > type of regmaps like SPI in the future.
> >
> > Also some MFD drivers could be moved to this, a likely candidate is
> > the smsc-ece1099.c. Although I don't really understand its purpose,
> > if don't have CONFIG_OF.
> >
> > Judging from the existing code, this simple-mfd.c wouldn't just be
> > "a list of compatible" strings but also additional quirks and tweaks
> > for particular devices in this list.

Yes, this is why specific compatible strings are required.

> Hold off on the simple-mfd.c idea, as I'm not taken by it yet and
> wouldn't want you to waste your time.  I have another idea which would
> help.  Give me a few days to put something together.
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Senior Technical Lead - Developer Services
> Linaro.org =E2=94=82 Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
