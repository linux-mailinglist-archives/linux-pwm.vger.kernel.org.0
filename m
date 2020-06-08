Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFD5D1F1F56
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 20:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgFHS45 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 14:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgFHS4z (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 14:56:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F98C08C5C4
        for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2020 11:56:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g10so543628wmh.4
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bbezwn5gwDlTS6iFB4r9mviI0BHif4uVVFtQV600W10=;
        b=bYuLeFsFLMkDx3qZeqjTwTuymeICsPggctKvZNcicEBsCT6pD6pMA7MDedxcCgxxxv
         DaXRWn69Tos6NjXf9n4UhHrwGd5gC47tLeiiskVQVlVn7tUdf+gKVD++b2pSx6mjt0Wt
         /GROQLIkv8ERRIXfaTl+IBNn5ySBixDUBCavUZXD4GOr2RPx8jv98AlcXxuFAvV8TSzH
         uUzKSnqPFAIyr30pkKt7Dm8kolIvPkY4GfLVcdkgaBEz6LXVbdJwTjtf+/4f8Isg7P1S
         KORdnXpCjh3OH33CQNPDcXraPiI3zvS0de9sedU66a7jPu3xIf4o9mtqTrhWJsUZrxQa
         4t6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bbezwn5gwDlTS6iFB4r9mviI0BHif4uVVFtQV600W10=;
        b=Rgl1IVIXOQaYL/X33diZMQBqmavcIClthwjxKz5UisGTgce6TfjNyWYUx9JmxjSfI6
         hpH17p519aD90TLQGExl8vxgg+JIDmeXCQ1oxYgYWsHL1KEcCWr58nDqpDZ9xzvJpfQQ
         iewujVhNY9TiWNfQD/T2NubNc3pw0CebwoSqtNnLU0o/l+ZlYTa3XuMMF2E/teX00EGp
         IoKRUm3zrrImV0slO07/bEAqOsOHwijgUzckvs0UawylzvINRLjjDGQNZejMq8k/NKJR
         15GADhsJbc1T8srItlIrYQtUtxGP8//LvlqIs6zavkvIHnjLZM1iuNTgtvSM0cg6SQzC
         HcEA==
X-Gm-Message-State: AOAM5321kte0yslc7OWBf9VgJ+gahD7+w/UGcwLURaeN4QpiHaBPS+xm
        nDA01u0hJFJR/9IjQeOxyNfULQ==
X-Google-Smtp-Source: ABdhPJyiWUVMEiOfAXAeFrqmYgqJgRJgWv1aBrPn0d5IckEE0fOBQCHvZfLUDwPo686MnqwrE6u1gg==
X-Received: by 2002:a1c:80d4:: with SMTP id b203mr135522wmd.138.1591642613825;
        Mon, 08 Jun 2020 11:56:53 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id l17sm431519wmi.16.2020.06.08.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 11:56:53 -0700 (PDT)
Date:   Mon, 8 Jun 2020 19:56:51 +0100
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
Message-ID: <20200608185651.GD4106@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
 <CAHp75VdiH=J-ovCdh1RFJDW_bJM8=pbXRaHmB691GLb-5oBmYQ@mail.gmail.com>
 <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d7feb374cbf5a587dc1ce65fc3ad672@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, 08 Jun 2020, Michael Walle wrote:

> Am 2020-06-08 12:02, schrieb Andy Shevchenko:
> > +Cc: some Intel people WRT our internal discussion about similar
> > problem and solutions.
> > 
> > On Mon, Jun 8, 2020 at 11:30 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Sat, 06 Jun 2020, Michael Walle wrote:
> > > > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > 
> > ...
> > 
> > > Right.  I'm suggesting a means to extrapolate complex shared and
> > > sometimes intertwined batches of register sets to be consumed by
> > > multiple (sub-)devices spanning different subsystems.
> > > 
> > > Actually scrap that.  The most common case I see is a single Regmap
> > > covering all child-devices.
> > 
> > Yes, because often we need a synchronization across the entire address
> > space of the (parent) device in question.
> > 
> > >  It would be great if there was a way in
> > > which we could make an assumption that the entire register address
> > > space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> > > each of the devices described by its child-nodes.  Probably by picking
> > > up on the 'simple-mfd' compatible string in the first instance.
> > > 
> > > Rob, is the above something you would contemplate?
> > > 
> > > Michael, do your register addresses overlap i.e. are they intermingled
> > > with one another?  Do multiple child devices need access to the same
> > > registers i.e. are they shared?
> 
> No they don't overlap, expect for maybe the version register, which is
> just there once and not per function block.

Then what's stopping you having each device Regmap their own space?

The issues I wish to resolve using 'simple-mfd' are when sub-devices
register maps overlap and intertwine.

> > > > > > But, there is more in my driver:
> > > > > >  (1) there is a version check
> > > 
> > > If we can rid the Regmap dependency, then creating an entire driver to
> > > conduct a version check is unjustifiable.  This could become an inline
> > > function which is called by each of the sub-devices instead, for
> > > example.
> 
> sounds good to me. (although there would then be a probe fail per sub-device
> if the version is not supported)

I don't see an issue with that.  I would put that check inside a
shared call though, complete with support for locking.

> > > > > >  (2) there is another function for which there is no suitable linux
> > > > > >      subsystem I'm aware of and thus which I'd like to us sysfs
> > > > > >      attributes for: This controller supports 16 non-volatile
> > > > > >      configuration bits. (this is still TBD)
> > > 
> > > There is a place for everything in Linux.
> > > 
> > > What do these bits configure?
> 
> - hardware strappings which have to be there before the board powers up,
>   like clocking mode for different SerDes settings
> - "keep-in-reset" bits for onboard peripherals if you want to save power
> - disable watchdog bits (there is a watchdog which is active right from
>   the start and supervises the bootloader start and switches to failsafe
>   mode if it wasn't successfully started)
> - special boot modes, like eMMC, etc.
> 
> Think of it as a 16bit configuration word.

And you wish for users to be able to view these at run-time?

Can they adapt any of them on-the-fly or will the be RO?

> > > > > TBH I'd also say that the enumeration of the subdevices for this
> > > > > device should be in the device rather than the DT, they don't
> > > > > seem to be things that exist outside of this one device.
> > > >
> > > > We're going circles here, formerly they were enumerated in the MFD.
> > > > Yes, they are devices which aren't likely be used outside a
> > > > "sl28cpld", but there might there might be other versions of the
> > > > sl28cpld with other components on different base addresses. I
> > > > don't care if they are enumerated in DT or MFD, actually, I'd
> > > > prefer the latter. _But_ I would like to have the device tree
> > > > properties for its subdevices, e.g. the ones for the watchdog or
> > > > whatever components there might be in the future.
> > > 
> > > [...]
> > > 
> > > > MFD core can
> > > > match a device tree node today; but only one per unique compatible
> > > > string. So what should I use to differentiate the different
> > > > subdevices?
> > > 
> > > Right.  I have been aware of this issue.  The only suitable solution
> > > to this would be to match on 'reg'.
> 
> see below (1)
> 
> > > 
> > > FYI: I plan to fix this.
> > > 
> > > If your register map needs to change, then I suggest that this is
> > > either a new device or at least a different version of the device and
> > > would also have to be represented as different (sub-)mfd_cell.
> > > 
> > > > Rob suggested the internal offset, which I did here.
> > > 
> > > FWIW, I don't like this idea.  DTs should not have to be modified
> > > (either in the first instance or subsequently) or specifically
> > > designed to patch inadequacies in any given OS.
> 
> How does (1) play together with this? What do you propose the "reg"
> property should contain?

Whatever is in the 'reg' property contained in the Device Tree node.
Either the full address or an offset would be suitable.

Caveat: All this thinking has been done on-the-fly.  I would need to
look at some examples of existing devices and start coding before I
could really think the solution through.

Happy to discuss and/or take recommendations though.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
