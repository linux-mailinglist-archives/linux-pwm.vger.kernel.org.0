Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC93E1F4172
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 18:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731289AbgFIQyG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 12:54:06 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:42406 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731206AbgFIQyF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jun 2020 12:54:05 -0400
Received: by mail-il1-f196.google.com with SMTP id 18so20976294iln.9;
        Tue, 09 Jun 2020 09:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KmkTV1fA8j8tDa2ByE5bz4rItMAJ7USXbj2L8eg6OQc=;
        b=ZLXGQTvAdS7kh6hVktmlNQQ8A/Oz+58OjsBXnGRozRq6AYwJeIyfQBTICC01ms4QCf
         dB6tY6JjarD9qglL/Oe+tK+8mZJQxxI/16Z0TDjqUP80MeRnuBZuLefPz+Irv+9uh55u
         PN1ja47tVOu/O3FUe7J9FZry90RhHeOBbJCxYVipB+1a/H5XhDdvB2mZ8ZIWD/mHNMYg
         KvPfwjbVO/xkZ7ngF/JTRkKDY3HaqJPVmykNdZy7HljPmNvLUY/3kHSzgq9y0ugu8gID
         xyr6h0Arl7L0jeZxz+2VlCjOYw0K8+FMr7sn+ergfZGxNGx626U+NxBckcIHxBIpZker
         xW0Q==
X-Gm-Message-State: AOAM531o7HbeR2p0yLYpJ+Eypkyu2Sh4NISOA5lNNW7KGx4XdJn2eC3S
        tWRqrl18ApGPSu9n/pAnTA==
X-Google-Smtp-Source: ABdhPJyxG7y3K+cLyUuJIAZTdZr/u/4CxX3l41yFs/vx7KzsnZpaQg3XY4fT7PITdO9rXJOWTk7gAA==
X-Received: by 2002:a05:6e02:972:: with SMTP id q18mr25848913ilt.60.1591721643763;
        Tue, 09 Jun 2020 09:54:03 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t72sm2432957ilk.23.2020.06.09.09.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 09:54:03 -0700 (PDT)
Received: (nullmailer pid 1059999 invoked by uid 1000);
        Tue, 09 Jun 2020 16:54:01 -0000
Date:   Tue, 9 Jun 2020 10:54:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Michael Walle <michael@walle.cc>, Mark Brown <broonie@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
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
Message-ID: <20200609165401.GB1019634@bogus>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
 <20200608082827.GB3567@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608082827.GB3567@dell>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 08, 2020 at 09:28:27AM +0100, Lee Jones wrote:
> Rob, something for you below.
> 
> On Sat, 06 Jun 2020, Michael Walle wrote:
> > Am 2020-06-06 13:46, schrieb Mark Brown:
> > > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > > 
> > > > > I have no idea what you are thinking of when you say "simple-regmap" so
> > > > > it is difficult to comment.
> > > 
> > > > I guess, Lee is suggesting to be able to create a regmap instance via
> > > > device tree (and populate its child nodes?). Like
> > > >   compatible = "syscon", "simple-mfd";
> > > > but for any regmap, not just MMIO.
> 
> Bingo!
> 
> > > I don't understand why this would be anything separate to
> > > simple-mfd.
> > 
> > Don't just simple-mfd tells the of core, to probe the children this
> > node? Where does the regmap then come from?
> 
> Right.  I'm suggesting a means to extrapolate complex shared and
> sometimes intertwined batches of register sets to be consumed by
> multiple (sub-)devices spanning different subsystems.
> 
> Actually scrap that.  The most common case I see is a single Regmap
> covering all child-devices.  It would be great if there was a way in
> which we could make an assumption that the entire register address
> space for a 'tagged' (MFD) device is to be shared (via Regmap) between
> each of the devices described by its child-nodes.  Probably by picking
> up on the 'simple-mfd' compatible string in the first instance.
> 
> Rob, is the above something you would contemplate?

No. I'd like to just kill off syscon and simple-mfd really. Those are 
just hints meaning a specific compatible is still needed, but I see them 
all the time alone (or combined like above). 'syscon' just serves to 
create a regmap. This could be accomplished just with a list of 
compatibles to register a regmap for. That might be a longish list, but 
wanting a regmap is really a kernel implementation detail and decision.

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

The same register set at a different offset is the same (sub)device.

> 
> > Rob suggested the internal offset, which I did here.
> 
> FWIW, I don't like this idea.  DTs should not have to be modified
> (either in the first instance or subsequently) or specifically
> designed to patch inadequacies in any given OS.

My understanding is there can be differing combinations or number of 
instances of sub devices for this device. That's when having DT sub 
devices makes sense. If the h/w changes, then the DT should change.

Multiple instances of devices require an address to identify them and we 
don't make up numbering if we can avoid it. The earlier revisions just 
had made up indices for addresses.

Rob
