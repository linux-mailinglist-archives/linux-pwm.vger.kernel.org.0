Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 709181F162F
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 12:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgFHKCf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 06:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgFHKCe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 06:02:34 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF17DC08C5C3;
        Mon,  8 Jun 2020 03:02:33 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s10so8571438pgm.0;
        Mon, 08 Jun 2020 03:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2zoo0ERaliX/JjKEGnYqTQZHfKutQDjXGBUR6MxE50E=;
        b=up0PRyxOK9NsFIv2bsBl0byvSjs9TKlq7122/ilkRkEttg+3QL6Te0gWz3TYNBv0vi
         IE21MrMkSmBoOM0mY4Ym6dD4h0fHd8PJqbmjpqRLAoD8EgiLZJlztmdayzlMxvl64uad
         DTmDDiOoifJ+qZNcLaLd2QSV/HmYZnGjko8DYlFAtHLeNrU6eLEN23fhJDEXcZO9k6su
         5btG1FU90NfVPGLZPU9H4xy++nNO22Mb48r9L7eryuGK6DS+fMUjxg5jPDGiU2+oNHCp
         xKXJVPkjQbjd51oijoYnbZKVI1lUIdfoc2nsSSfQ/4wyGgwYugHqOswiCBWgOn9shtpA
         CEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2zoo0ERaliX/JjKEGnYqTQZHfKutQDjXGBUR6MxE50E=;
        b=g+UrNPb+COB2G9HXzGNpVv8bK2+XNK7NVTe7ZrgsXB0MpkLh5baLopiGaSe05kLUc5
         2oImWxAnKyh6dMEHOELibjZk6aDSEiBXCnN0ldjjmcZYoBnERto5hInNOpH24o0rwiX7
         IdjzgubCAKzsLFb5JP4eTMpwAs+iNdVOZAixwelfZmbWXBzBJn0YlN/aPvbQCv0tXYLT
         1zS2tEqhDOl4BgniqlnEbxDY13piiSSf8QO2jWWDdEYmuQBHv3Czyhw16QHGV06i5UOg
         es1YTLlthzxaR2yJj3B3LiiUzbKmxUeSpWHk5Z83c6B2yY7urQj1y+vwZfApL+su+F4U
         ez8g==
X-Gm-Message-State: AOAM530UZqQ/k2LOEI+e4z8ksSnyG7jN5oQUlqwM2BxhETuCr4ymCLnY
        HAOIxbzfL7A+fyLCchobg5qZgG7oeQrj9RbKgVI=
X-Google-Smtp-Source: ABdhPJx86tPKDhVhcYy12URCDzcRNhNuX2MCH50rKMBNeLvTYoOCyhjdRnZsCXkMUtFO7r9gOz6BiOXhGjPZOdlfhLw=
X-Received: by 2002:a63:ff52:: with SMTP id s18mr20149238pgk.203.1591610553061;
 Mon, 08 Jun 2020 03:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200604211039.12689-1-michael@walle.cc> <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell> <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc> <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc> <20200608082827.GB3567@dell>
In-Reply-To: <20200608082827.GB3567@dell>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 13:02:21 +0300
Message-ID: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld management controller
To:     Lee Jones <lee.jones@linaro.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com
Cc:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
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
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

+Cc: some Intel people WRT our internal discussion about similar
problem and solutions.

On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Sat, 06 Jun 2020, Michael Walle wrote:
> > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > Am 2020-06-05 12:50, schrieb Mark Brown:

...

> Right.  I'm suggesting a means to extrapolate complex shared and
> sometimes intertwined batches of register sets to be consumed by
> multiple (sub-)devices spanning different subsystems.
>
> Actually scrap that.  The most common case I see is a single Regmap
> covering all child-devices.

Yes, because often we need a synchronization across the entire address
space of the (parent) device in question.

>  It would be great if there was a way in
> which we could make an assumption that the entire register address
> space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> each of the devices described by its child-nodes.  Probably by picking
> up on the 'simple-mfd' compatible string in the first instance.
>
> Rob, is the above something you would contemplate?
>
> Michael, do your register addresses overlap i.e. are they intermingled
> with one another?  Do multiple child devices need access to the same
> registers i.e. are they shared?
>
> > > > But, there is more in my driver:
> > > >  (1) there is a version check
>
> If we can rid the Regmap dependency, then creating an entire driver to
> conduct a version check is unjustifiable.  This could become an inline
> function which is called by each of the sub-devices instead, for
> example.
>
> > > >  (2) there is another function for which there is no suitable linux
> > > >      subsystem I'm aware of and thus which I'd like to us sysfs
> > > >      attributes for: This controller supports 16 non-volatile
> > > >      configuration bits. (this is still TBD)
>
> There is a place for everything in Linux.
>
> What do these bits configure?
>
> > > TBH I'd also say that the enumeration of the subdevices for this
> > > device should be in the device rather than the DT, they don't
> > > seem to be things that exist outside of this one device.
> >
> > We're going circles here, formerly they were enumerated in the MFD.
> > Yes, they are devices which aren't likely be used outside a
> > "sl28cpld", but there might there might be other versions of the
> > sl28cpld with other components on different base addresses. I
> > don't care if they are enumerated in DT or MFD, actually, I'd
> > prefer the latter. _But_ I would like to have the device tree
> > properties for its subdevices, e.g. the ones for the watchdog or
> > whatever components there might be in the future.
>
> [...]
>
> > MFD core can
> > match a device tree node today; but only one per unique compatible
> > string. So what should I use to differentiate the different
> > subdevices?
>
> Right.  I have been aware of this issue.  The only suitable solution
> to this would be to match on 'reg'.
>
> FYI: I plan to fix this.
>
> If your register map needs to change, then I suggest that this is
> either a new device or at least a different version of the device and
> would also have to be represented as different (sub-)mfd_cell.
>
> > Rob suggested the internal offset, which I did here.
>
> FWIW, I don't like this idea.  DTs should not have to be modified
> (either in the first instance or subsequently) or specifically
> designed to patch inadequacies in any given OS.
>
> > But then, there is less use in duplicating the offsets in the MFD
> > just to have the MFD enumerate the subdevices and then match
> > the device tree nodes against it. I can just use
> > of_platform_populate() to enumerate the children and I won't
> > have to duplicate the base addresses.
>
> Which is fine.  However this causes a different issue for you.  By
> stripping out the MFD code you render the MFD portion seemingly
> superfluous.  Another issue driver authors commonly contend with.

-- 
With Best Regards,
Andy Shevchenko
