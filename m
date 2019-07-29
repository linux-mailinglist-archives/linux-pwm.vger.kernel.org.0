Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 687C1792F2
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 20:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387422AbfG2SU6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 14:20:58 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:33101 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfG2SU6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 14:20:58 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsAGS-0003Im-Gu; Mon, 29 Jul 2019 20:20:52 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsAGM-0001Qa-Ko; Mon, 29 Jul 2019 20:20:46 +0200
Date:   Mon, 29 Jul 2019 20:20:46 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
Message-ID: <20190729182046.6bwrterbxoceulrx@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-3-jernej.skrabec@siol.net>
 <20190729063630.rn325whatfnc3m7n@pengutronix.de>
 <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
 <20190729071218.bukw7vxilqy523k3@pengutronix.de>
 <20190729163715.vtv7lkrywewomxga@flea.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190729163715.vtv7lkrywewomxga@flea.home>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 29, 2019 at 06:37:15PM +0200, Maxime Ripard wrote:
> On Mon, Jul 29, 2019 at 09:12:18AM +0200, Uwe Kleine-König wrote:
> > Hello,
> >
> > On Mon, Jul 29, 2019 at 02:43:23PM +0800, Chen-Yu Tsai wrote:
> > > On Mon, Jul 29, 2019 at 2:36 PM Uwe Kleine-König
> > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> > > > > @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> > > > >       if (IS_ERR(pwm->clk))
> > > > >               return PTR_ERR(pwm->clk);
> > > > >
> > > > > +     if (pwm->data->has_reset) {
> > > > > +             pwm->rst = devm_reset_control_get(&pdev->dev, NULL);
> > > > > +             if (IS_ERR(pwm->rst))
> > > > > +                     return PTR_ERR(pwm->rst);
> > > > > +
> > > > > +             reset_control_deassert(pwm->rst);
> > > > > +     }
> > > > > +
> > > >
> > > > I wonder why there is a need to track if a given chip needs a reset
> > > > line. I'd just use devm_reset_control_get_optional() and drop the
> > > > .has_reset member in struct sun4i_pwm_data.
> > >
> > > Because it's not optional for this platform, i.e. it won't work if
> > > the reset control (or clk, in the next patch) is somehow missing from
> > > the device tree.
> >
> > If the device tree is wrong it is considered ok that the driver doesn't
> > behave correctly. So this is not a problem you need (or should) care
> > about.
> 
> To some extent that's true, but if we can make the life easier for
> everyone by reporting an error and bailing out instead of silently
> ignoring that, continuing to probe and just ending up with a
> completely broken system for no apparent reason, then why not just do
> that?
> 
> I mean, all it takes is three lines of code.

<pedantic>Actually it's more because you need to track for each variant
if it needs the clock (or reset stuff) or not.</pedantic>

It's a weighing between "simpler driver" and "catch unlikely errors".
(If the SoC's .dtsi includes the needed stuff, an error here is really
unlikely, isn't it?)

So to some degree it's subjective which one is better. I tend to prefer
"simpler driver". Also when catching this type of error you have to do
it right twice (in the .dtsi and the driver) while with my approach
there is only a single place that defines what is right, which is a good
design according to what I learned during my studies.

> It's no different than just calling clk_get, and testing the return
> code to see if it's there or not. I wouldn't call that check when you
> depend on a clock "validating the DT". It's just making sure that all
> the resources needed for you to operate properly are there, which is a
> pretty common thing to do.

This is different. As a driver author you are allowed (or even supposed)
to assume that the device tree (or ACPI or platform data ...) is right
and completely defines the stuff for the driven hardware to work
correctly. You must not assume that clk_get() succeeds unconditionally.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
