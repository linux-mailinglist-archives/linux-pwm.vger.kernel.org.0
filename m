Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6201F1EE0
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 20:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725283AbgFHSUY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 14:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgFHSUX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 14:20:23 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4923CC08C5C3
        for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2020 11:20:22 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so18476045wrp.2
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 11:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2CJM5g0VuqYFNIM+dUzodFUTj18WAdux3/u8z24zvRA=;
        b=FvaaSm5tyr6RBgjbPNfvrJLlZcAn3DmzQGeyoQrQ5NJotNGMRI+S/WTL4cZGcvbeKQ
         OeiYno6xBUEcQi5WgLfPg1nv7oOkxmoaBpZ6QtIPDVlQPQdk8Xg1KETQTvd/QbsmmRZg
         rKCAizdiGMf2yjrMRJkrYUJTQ8RhPDKv4CF4YBH4XvdeaNYdcf0hTu/38GolQI/FykDN
         4Wtn17IHKjfImnRlO7XuYIJCSylUrNpYSAcVJ0FF2ljUmpkm69oK59PmBzzl1uzp468r
         sdFV0WqzFhOkNZXY3HflI0dAEsSOqMmu2UtExqdHiQfNrXygDGlFgbgtHXGR4oIhwsQF
         uzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2CJM5g0VuqYFNIM+dUzodFUTj18WAdux3/u8z24zvRA=;
        b=htXz4epr7jLYjHn5yOptilnlBGBS/DjL2iHY0t5/yPKuvtDABjThE5YMOkB2mKReTL
         gItYYVdS58wnmhO8pHpm7pW6EHf3/7Fs9jwmLLjsBWJu+WtQFnWMJZTHDBH+qjEd4sXy
         zrJ49H6FmYdbIF+QQVEqxA1zHtMcvFG8zlYizlKXY55pk2732JC9Tdy23hRenRBsu3kM
         DJvkUEqIqsJbLKbU3JdujFTi+RJ8GEh2fFBL7QRhKsORCOBZDGKC/r9+uJp8BOeqgaMA
         rcbGJZh+UqA+7bx/M3KMa8s6BlcYT72xkBBgK85HRu8F/9jyrxdnuRUwDAcwavfvICOh
         Ggmw==
X-Gm-Message-State: AOAM5303FymHzEKYRAvqpeHbUvXh0Ib7XPkAfIPfAPBoHlbnARspNL4H
        /BG79dlN+ucxBvvEyFkinu/EEg==
X-Google-Smtp-Source: ABdhPJxumzJA4nkmctYgB3lMSJVUnSMTyEhafMZJYxSm51uV/tmOYuDxGF7eIqOVSIVmr0U8Lef0xg==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr86707wrx.141.1591640420821;
        Mon, 08 Jun 2020 11:20:20 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id a7sm358274wmh.14.2020.06.08.11.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:20:20 -0700 (PDT)
Date:   Mon, 8 Jun 2020 19:20:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        david.m.ertman@intel.com, shiraz.saleem@intel.com,
        Michael Walle <michael@walle.cc>,
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
Message-ID: <20200608182018.GB4106@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 08 Jun 2020, Andy Shevchenko wrote:

> +Cc: some Intel people WRT our internal discussion about similar
> problem and solutions.
> 
> On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> 
> ...
> 
> > Right.  I'm suggesting a means to extrapolate complex shared and
> > sometimes intertwined batches of register sets to be consumed by
> > multiple (sub-)devices spanning different subsystems.
> >
> > Actually scrap that.  The most common case I see is a single Regmap
> > covering all child-devices.
> 
> Yes, because often we need a synchronization across the entire address
> space of the (parent) device in question.

Exactly.

Because of the reasons in the paragraph above:

 "complex shared and sometimes intertwined batches of register sets to
  be consumed by multiple (sub-)devices spanning different subsystems"

> >  It would be great if there was a way in
> > which we could make an assumption that the entire register address
> > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > each of the devices described by its child-nodes.  Probably by picking
> > up on the 'simple-mfd' compatible string in the first instance.
> >
> > Rob, is the above something you would contemplate?
> >
> > Michael, do your register addresses overlap i.e. are they intermingled
> > with one another?  Do multiple child devices need access to the same
> > registers i.e. are they shared?
> >
> > > > > But, there is more in my driver:
> > > > >  (1) there is a version check
> >
> > If we can rid the Regmap dependency, then creating an entire driver to
> > conduct a version check is unjustifiable.  This could become an inline
> > function which is called by each of the sub-devices instead, for
> > example.
> >
> > > > >  (2) there is another function for which there is no suitable linux
> > > > >      subsystem I'm aware of and thus which I'd like to us sysfs
> > > > >      attributes for: This controller supports 16 non-volatile
> > > > >      configuration bits. (this is still TBD)
> >
> > There is a place for everything in Linux.
> >
> > What do these bits configure?
> >
> > > > TBH I'd also say that the enumeration of the subdevices for this
> > > > device should be in the device rather than the DT, they don't
> > > > seem to be things that exist outside of this one device.
> > >
> > > We're going circles here, formerly they were enumerated in the MFD.
> > > Yes, they are devices which aren't likely be used outside a
> > > "sl28cpld", but there might there might be other versions of the
> > > sl28cpld with other components on different base addresses. I
> > > don't care if they are enumerated in DT or MFD, actually, I'd
> > > prefer the latter. _But_ I would like to have the device tree
> > > properties for its subdevices, e.g. the ones for the watchdog or
> > > whatever components there might be in the future.
> >
> > [...]
> >
> > > MFD core can
> > > match a device tree node today; but only one per unique compatible
> > > string. So what should I use to differentiate the different
> > > subdevices?
> >
> > Right.  I have been aware of this issue.  The only suitable solution
> > to this would be to match on 'reg'.
> >
> > FYI: I plan to fix this.
> >
> > If your register map needs to change, then I suggest that this is
> > either a new device or at least a different version of the device and
> > would also have to be represented as different (sub-)mfd_cell.
> >
> > > Rob suggested the internal offset, which I did here.
> >
> > FWIW, I don't like this idea.  DTs should not have to be modified
> > (either in the first instance or subsequently) or specifically
> > designed to patch inadequacies in any given OS.
> >
> > > But then, there is less use in duplicating the offsets in the MFD
> > > just to have the MFD enumerate the subdevices and then match
> > > the device tree nodes against it. I can just use
> > > of_platform_populate() to enumerate the children and I won't
> > > have to duplicate the base addresses.
> >
> > Which is fine.  However this causes a different issue for you.  By
> > stripping out the MFD code you render the MFD portion seemingly
> > superfluous.  Another issue driver authors commonly contend with.
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
