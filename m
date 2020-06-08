Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9071F1471
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgFHI2c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgFHI2c (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Jun 2020 04:28:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5C0C08C5C3
        for <linux-pwm@vger.kernel.org>; Mon,  8 Jun 2020 01:28:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h5so16384768wrc.7
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jun 2020 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Kba7qPUxHVUKOanqaaBgtcI9IxnJIhKLPI39GydfXUw=;
        b=o7x0iQeSI/uwP7xJ7s/u2wJNQdANwPbv2ta24+Sx1h0vxNF5HxpC3+25MhA0PQ8Gjl
         dKjm7vb2Ht1j7Gzu0kjzTdTBOdMnvlhGwosvxfPaDbiMq618LrkYB1ynOAiejE+KDUNt
         i+5NbQDjhNNpiCSMFE6TklC8DDvCNHDn4SfaILmPmsRiPxYivhSSIYqkRzoa5427VdA6
         lW+ze0WQ0JYHLZqvZB6IdbmgY6PPkzBJgypm9ki3yPY7YSf5EXjbhfVEjHE6wR+qbo6I
         dvp+IK2TyP9Nzuiun7EUGStVXIWuMjnL7q5BMOz+/5eHr+0DeFgljiQZMgpG6R9pGRYw
         12XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Kba7qPUxHVUKOanqaaBgtcI9IxnJIhKLPI39GydfXUw=;
        b=J4lWB1x4D/RPgSgBnkAl18Ho5iWmJU4cut4Nnetyx9biUA1y/mpKvSbP5cx6wNZR89
         pVGjXgafvSwqboAyjODiU3kQVFY7Tk3Tzw7cQ9KEOFR9PRYZTHkuNvd+xs3UtlsC9bNF
         i7BW4hNB8j1oPinW+H5UXUdXzG/PgGd/j+/JzE6oqNlaaqfNfB7sYWUG3iI494ya9317
         jRzXSLw3pnLbM3dhPVAT7MF2/E1k8LSIljn7o02iX1jqkTVW1YqSDHi7zU0zNAwNuwPS
         NHRVjU4ONFcRaxTwwwFBtigkrOI1qN9eyTX70iIw2lvPXGNRdDClRgGp8KqpipByDiJg
         7F+Q==
X-Gm-Message-State: AOAM531ifP8oyPg1RkRU7Xn6k0EU2ijnUrIb0gi4qCik2N1W489A32w4
        v39F9iGqL0t0H7sr7Ohs8iorbg==
X-Google-Smtp-Source: ABdhPJwynnrOTei83pcLfW4D02VO6Er3aYpLlO//t7+3zbz9KWHvX2TYAeyuYi6k74iArY5EinOp8Q==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr22217026wrw.295.1591604910095;
        Mon, 08 Jun 2020 01:28:30 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id v27sm23608100wrv.81.2020.06.08.01.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 01:28:29 -0700 (PDT)
Date:   Mon, 8 Jun 2020 09:28:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20200608082827.GB3567@dell>
References: <20200604211039.12689-1-michael@walle.cc>
 <20200604211039.12689-3-michael@walle.cc>
 <20200605065709.GD3714@dell>
 <20200605105026.GC5413@sirena.org.uk>
 <c5632bfab3956265e90fc2fb6c0b3cae@walle.cc>
 <20200606114645.GB2055@sirena.org.uk>
 <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc052a5c77171014ecc465b1da8b7ef8@walle.cc>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Rob, something for you below.

On Sat, 06 Jun 2020, Michael Walle wrote:
> Am 2020-06-06 13:46, schrieb Mark Brown:
> > On Fri, Jun 05, 2020 at 10:07:36PM +0200, Michael Walle wrote:
> > > Am 2020-06-05 12:50, schrieb Mark Brown:
> > 
> > > > I have no idea what you are thinking of when you say "simple-regmap" so
> > > > it is difficult to comment.
> > 
> > > I guess, Lee is suggesting to be able to create a regmap instance via
> > > device tree (and populate its child nodes?). Like
> > >   compatible = "syscon", "simple-mfd";
> > > but for any regmap, not just MMIO.

Bingo!

> > I don't understand why this would be anything separate to
> > simple-mfd.
> 
> Don't just simple-mfd tells the of core, to probe the children this
> node? Where does the regmap then come from?

Right.  I'm suggesting a means to extrapolate complex shared and
sometimes intertwined batches of register sets to be consumed by
multiple (sub-)devices spanning different subsystems.

Actually scrap that.  The most common case I see is a single Regmap
covering all child-devices.  It would be great if there was a way in
which we could make an assumption that the entire register address
space for a 'tagged' (MFD) device is to be shared (via Regmap) between
each of the devices described by its child-nodes.  Probably by picking
up on the 'simple-mfd' compatible string in the first instance.

Rob, is the above something you would contemplate?

Michael, do your register addresses overlap i.e. are they intermingled
with one another?  Do multiple child devices need access to the same
registers i.e. are they shared?

> > > But, there is more in my driver:
> > >  (1) there is a version check

If we can rid the Regmap dependency, then creating an entire driver to
conduct a version check is unjustifiable.  This could become an inline
function which is called by each of the sub-devices instead, for
example.

> > >  (2) there is another function for which there is no suitable linux
> > >      subsystem I'm aware of and thus which I'd like to us sysfs
> > >      attributes for: This controller supports 16 non-volatile
> > >      configuration bits. (this is still TBD)

There is a place for everything in Linux.

What do these bits configure?

> > TBH I'd also say that the enumeration of the subdevices for this
> > device should be in the device rather than the DT, they don't
> > seem to be things that exist outside of this one device.
> 
> We're going circles here, formerly they were enumerated in the MFD.
> Yes, they are devices which aren't likely be used outside a
> "sl28cpld", but there might there might be other versions of the
> sl28cpld with other components on different base addresses. I
> don't care if they are enumerated in DT or MFD, actually, I'd
> prefer the latter. _But_ I would like to have the device tree
> properties for its subdevices, e.g. the ones for the watchdog or
> whatever components there might be in the future.

[...]

> MFD core can
> match a device tree node today; but only one per unique compatible
> string. So what should I use to differentiate the different
> subdevices?

Right.  I have been aware of this issue.  The only suitable solution
to this would be to match on 'reg'.

FYI: I plan to fix this.

If your register map needs to change, then I suggest that this is
either a new device or at least a different version of the device and
would also have to be represented as different (sub-)mfd_cell.

> Rob suggested the internal offset, which I did here.

FWIW, I don't like this idea.  DTs should not have to be modified
(either in the first instance or subsequently) or specifically
designed to patch inadequacies in any given OS.

> But then, there is less use in duplicating the offsets in the MFD
> just to have the MFD enumerate the subdevices and then match
> the device tree nodes against it. I can just use
> of_platform_populate() to enumerate the children and I won't
> have to duplicate the base addresses.

Which is fine.  However this causes a different issue for you.  By
stripping out the MFD code you render the MFD portion seemingly
superfluous.  Another issue driver authors commonly contend with.

> So here we are, any ideas appreciated.

Working on it!

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
