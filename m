Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 984991F344C
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 08:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgFIGrl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 02:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgFIGrk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 02:47:40 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D81C08C5C4
        for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2020 23:47:40 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f185so1886928wmf.3
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 23:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=AwtDdz17DFDmRBPEGuRAOpx0vtQ2m9UoLoRBSQqsyp0=;
        b=f0FgM4Vro6vfvlNeSVfc1iBcrhCl+E0gwx58KhDVXNN908yZbqUz+mMshmPtCEnlmR
         VwW2GNhT56ZYbGOa1IoMFhQ73ta0IpXBTP+UnYFqFIqeYSD8Q+KmHWAe9EUQkVP/Ti54
         2XsWxtT9M+slp4+imVCL4xcL/NqM/6mxNI8M3B+BWoOxSuhJuafxLu/sZkpSqDM/DOJ/
         rGB3oVrbVqO7RWvp+yWo1R+iT3pmyikiZZmMzq6MGzQC6rPJSiovGWM2xWLq4hKl1H0Z
         /bougyij11X7OPIzVjdnCIsdwnbNAwC3aiABpVHKE4o5DP2Fj70XHrncpk+OoU1zAf64
         asXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=AwtDdz17DFDmRBPEGuRAOpx0vtQ2m9UoLoRBSQqsyp0=;
        b=R3b1kNMoL4VvyqZGFPpSky9Tqd6KS+DlLubPKic2kcafGeJ1irKQNhfXiXNsXXWji+
         YZNmlUZIpPeA0Fo9kbIY6QGHnkgKlvb7hgksoH+UfjpG2knNBVkL7JZw2aHPeRqZ/CjL
         Xl5UFSWD2OUF+64qUCKqGHVx41EtDvzpqJa/jYOw2I7IG7QzIg6cZ2fNc3SkJbc/Xovt
         hqFB6AshLHw7N2wZBb26f1IWSIe+tTAlnYSc031Tk1P7FL33bQn7fgrGYRON9Ifu38qA
         sx/MODy7+7KQ9SfvMyTyXAUbSvqC1vgUDGMM2Hb4iFdOSkFO3mGYEQOGoNq6qiA2brb8
         102g==
X-Gm-Message-State: AOAM532RoNdR3JAZi8Nbs3KR3DCkuyBPIcPF5JCpvD58Mvh43VxAYWt8
        h95fBuC3qoR+dvHiXpR6+zIbnQ==
X-Google-Smtp-Source: ABdhPJyLJRU7T7hP/+Yp6Xb+G+8dn3OI3DNS03pAkr/nWuDA1Spa9xboardProc7fDE8512XGawIOA==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr2371607wmk.28.1591685258604;
        Mon, 08 Jun 2020 23:47:38 -0700 (PDT)
Received: from dell ([2.27.167.101])
        by smtp.gmail.com with ESMTPSA id x205sm1818570wmx.21.2020.06.08.23.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 23:47:37 -0700 (PDT)
Date:   Tue, 9 Jun 2020 07:47:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Rob Herring <robh+dt@kernel.org>,
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
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 02/11] mfd: Add support for Kontron sl28cpld
 management controller
Message-ID: <20200609064735.GH4106@dell>
References: <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
 <20200608185651.GD4106@dell>
 <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32231f26f7028d62aeda8fdb3364faf1@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 08 Jun 2020, Michael Walle wrote:

> Am 2020-06-08 20:56, schrieb Lee Jones:
> > On Mon, 08 Jun 2020, Michael Walle wrote:
> > 
> > > Am 2020-06-08 12:02, schrieb Andy Shevchenko:
> > > > +Cc: some Intel people WRT our internal discussion about similar
> > > > problem and solutions.
> > > >
> > > > On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > > > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > > >
> > > > ...
> > > >
> > > > > Right.  I'm suggesting a means to extrapolate complex shared and
> > > > > sometimes intertwined batches of register sets to be consumed by
> > > > > multiple (sub-)devices spanning different subsystems.
> > > > >
> > > > > Actually scrap that.  The most common case I see is a single Regmap
> > > > > covering all child-devices.
> > > >
> > > > Yes, because often we need a synchronization across the entire address
> > > > space of the (parent) device in question.
> > > >
> > > > >  It would be great if there was a way in
> > > > > which we could make an assumption that the entire register address
> > > > > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > > > > each of the devices described by its child-nodes.  Probably by picking
> > > > > up on the 'simple-mfd' compatible string in the first instance.
> > > > >
> > > > > Rob, is the above something you would contemplate?
> > > > >
> > > > > Michael, do your register addresses overlap i.e. are they intermingled
> > > > > with one another?  Do multiple child devices need access to the same
> > > > > registers i.e. are they shared?
> > > 
> > > No they don't overlap, expect for maybe the version register, which is
> > > just there once and not per function block.
> > 
> > Then what's stopping you having each device Regmap their own space?
> 
> Because its just one I2C device, AFAIK thats not possible, right?

Not sure what (if any) the restrictions are.

I can't think of any reasons why not, off the top of my head.

Does Regmap only deal with shared accesses from multiple devices
accessing a single register map, or can it also handle multiple
devices communicating over a single I2C channel?

One for Mark perhaps.

> > The issues I wish to resolve using 'simple-mfd' are when sub-devices
> > register maps overlap and intertwine.

[...]

> > > > > What do these bits configure?
> > > 
> > > - hardware strappings which have to be there before the board powers
> > > up,
> > >   like clocking mode for different SerDes settings
> > > - "keep-in-reset" bits for onboard peripherals if you want to save
> > > power
> > > - disable watchdog bits (there is a watchdog which is active right
> > > from
> > >   the start and supervises the bootloader start and switches to
> > > failsafe
> > >   mode if it wasn't successfully started)
> > > - special boot modes, like eMMC, etc.
> > > 
> > > Think of it as a 16bit configuration word.
> > 
> > And you wish for users to be able to view these at run-time?
> 
> And esp. change them.
> 
> > Can they adapt any of them on-the-fly or will the be RO?
> 
> They are R/W but only will only affect the board behavior after a reset.

I see.  Makes sense.  This is board controller territory.  Perhaps
suitable for inclusion into drivers/soc or drivers/platform.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
