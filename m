Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3648A78986
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 12:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbfG2KTG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 06:19:06 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47331 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfG2KTG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 06:19:06 -0400
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1hs2k8-0005Yb-DO; Mon, 29 Jul 2019 12:19:00 +0200
Message-ID: <1564395538.7633.7.camel@pengutronix.de>
Subject: Re: [PATCH 2/6] pwm: sun4i: Add a quirk for reset line
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Date:   Mon, 29 Jul 2019 12:18:58 +0200
In-Reply-To: <20190729071218.bukw7vxilqy523k3@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
         <20190726184045.14669-3-jernej.skrabec@siol.net>
         <20190729063630.rn325whatfnc3m7n@pengutronix.de>
         <CAGb2v65KOpivHQNkg+R2=D=ejCJYnPdVcyHJZW-GJCR8j0Yk0g@mail.gmail.com>
         <20190729071218.bukw7vxilqy523k3@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Mon, 2019-07-29 at 09:12 +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Jul 29, 2019 at 02:43:23PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Jul 29, 2019 at 2:36 PM Uwe Kleine-König
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Fri, Jul 26, 2019 at 08:40:41PM +0200, Jernej Skrabec wrote:
> > > > @@ -371,6 +374,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> > > >       if (IS_ERR(pwm->clk))
> > > >               return PTR_ERR(pwm->clk);
> > > > 
> > > > +     if (pwm->data->has_reset) {
> > > > +             pwm->rst = devm_reset_control_get(&pdev->dev, NULL);
> > > > +             if (IS_ERR(pwm->rst))
> > > > +                     return PTR_ERR(pwm->rst);
> > > > +
> > > > +             reset_control_deassert(pwm->rst);
> > > > +     }
> > > > +
> > > 
> > > I wonder why there is a need to track if a given chip needs a reset
> > > line. I'd just use devm_reset_control_get_optional() and drop the
> > > .has_reset member in struct sun4i_pwm_data.
> > 
> > Because it's not optional for this platform, i.e. it won't work if
> > the reset control (or clk, in the next patch) is somehow missing from
> > the device tree.
> 
> If the device tree is wrong it is considered ok that the driver doesn't
> behave correctly. So this is not a problem you need (or should) care
> about.

I agree with this. Catching missing DT properties and other device tree
validation is not the job of device drivers. The _optional request
variants were introduced to simplify drivers that require the reset line
on some platforms and not on others.

I would ask to explicitly state whether the driver needs full control
over the moment of (de)assertion of the reset signal, or whether the
only requirement is that the reset signal stays deasserted while the PWM
driver is active, by using devm_reset_control_get_optional_exclusive or
devm_reset_control_get_optional_shared to request the reset control.

regards
Philipp
