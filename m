Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CED7B9F4
	for <lists+linux-pwm@lfdr.de>; Wed, 31 Jul 2019 08:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbfGaGwj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 31 Jul 2019 02:52:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57717 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfGaGwj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 31 Jul 2019 02:52:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsiTP-0005UT-U7; Wed, 31 Jul 2019 08:52:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsiTO-0005LC-5S; Wed, 31 Jul 2019 08:52:30 +0200
Date:   Wed, 31 Jul 2019 08:52:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Message-ID: <20190731065230.mqbtn5sfoxrkevw5@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <173825848.1FZsmuHfpq@jernej-laptop>
 <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
 <2452836.v7ux4bnEjb@jernej-laptop>
 <20190730080900.hhxrqun7vk4nsj2h@pengutronix.de>
 <20190730170601.a7ei43wku6jsjanu@flea>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730170601.a7ei43wku6jsjanu@flea>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 30, 2019 at 07:06:01PM +0200, Maxime Ripard wrote:
> On Tue, Jul 30, 2019 at 10:09:00AM +0200, Uwe Kleine-König wrote:
> > Hello Rob and Frank,
> >
> > Maxime and Jernej on one side and me on the other cannot agree about a
> > detail in the change to the bindings here. I'm trying to objectively
> > summarize the situation for you to help deciding what is the right thing
> > to do here.
> >
> > TLDR: The sun4i pwm driver is extended to support a new variant of that
> > device on the H6 SoC. Compared to the earlier supported variants
> > allwinner,sun50i-h6-pwm on H6 needs to handle a reset controller and an
> > additional clock.
> >
> > The two positions are:
> >
> >  - We need a new compatible because only then the driver and/or the dt
> >    schema checker can check that each "allwinner,sun50i-h6-pwm" device
> >    has a reset property and a "bus" clock; and the earlier variants
> >    don't.
> 
> There is two topics here, really. The binding itself really must have
> those properties as required.
> 
> You had an analogy before that we shouldn't really do that, since it
> would be verification and that it would be similar to checking whether
> the register range was right. This analogy isn't correct, a better one
> would be checking that the register range exists in the first place.

The relevant difference is that *all* devices supported by the driver
have to have a register range. Compared to that only a subset of the
devices have to have a bus clock.

> Indeed, if you don't have a register range, you have no register to
> write to, and that's a showstopper for any driver. I'm pretty sure we
> all agree on that. But on those SoCs, like Chen-Yu said, having no
> resets or clocks properties result in an equally bad result: either
> any write to that device is completely ignored (missing reset), or the
> system completely (and silently) locks up (missing bus clock).
> 
> We *have* to catch that somehow and not let anything like that happen.

IIUC both the clock and the reset stuff is SoC specific, so it's the
same for all machines with the H6, right? So assuming this is correctly
contained in the h6.dtsi, in which cases can this go wrong? I only see
the cases that the dts author includes the wrong dtsi or overrides
stuff. In the first case a non-working PWM is probably one of the
smaller problems and the second is something we're not really able to
catch.

But even if each machine's dts author has to get this right, I don't
think the dts schema is the right place to assert this.

> That being said, we can't really validate that the clock pointed is
> the right one, just like we can't really check that the register range
> is the proper one. Or rather, we could, but it's completely
> impractical and we do agree on that as well.
> 
> Having the bus clock and reset line being required however is only a
> few lines in the binding though, and is very practical.
> 
> >  - The driver can be simpler and the device specific knowledge is only
> >    in a single place (the dt) if the device tree is considered valid and
> >    a reset property and "bus" clock is used iff it's provided in the
> >    device tree without additional comparison for the compatible.
> 
> And now we have the discussion on how it's implemented in a
> driver. Since it's pretty cheap to implement (only a couple of lines:
> two for the if block, one for the additional field in the structure,
> one for each SoC using that) and have huge benefits (not silently
> locking up the system at boot), then I'd say we should go for it.

Right, it's only a few lines. Still it (IMHO needlessly) complicates the
driver. From the driver's POV the device tree defines the
characteristics of the device and if the dts defines an h6-pwm without a
bus clock then maybe this is the PWM on the next generation SoC that
doesn't need it. And maybe you're happy in a few year's time when you
don't have to touch the driver again for this next generation SoC
because the driver is not only simpler but also flexible enough to
handle the new PWM without adaptions.

All in all I don't care much about the dt schema stuff, I want to keep
the driver simple. So if we agree that the schema ensures that the h6
pwms have a reset and a bus clock and we just use reset_get_optional and
clk_get_optional that's a compromise I can agree to.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
