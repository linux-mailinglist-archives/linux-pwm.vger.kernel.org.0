Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DD17913E
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbfG2QkV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 12:40:21 -0400
Received: from mailoutvs51.siol.net ([185.57.226.242]:38916 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726240AbfG2QkV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 12:40:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 56D3A5220E8;
        Mon, 29 Jul 2019 18:40:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta11.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta11.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id rCV9RUjdNIE8; Mon, 29 Jul 2019 18:40:16 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id CA35F5224B7;
        Mon, 29 Jul 2019 18:40:16 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id 508A35224B1;
        Mon, 29 Jul 2019 18:40:16 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, u.kleine-koenig@pengutronix.de
Cc:     Chen-Yu Tsai <wens@csie.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-pwm@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date:   Mon, 29 Jul 2019 18:40:15 +0200
Message-ID: <2346193.MplWYqIveT@jernej-laptop>
In-Reply-To: <20190729162428.bxuzgxg5sjqptlbp@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <CAGb2v66C=ghjck6rxTg6Vt4xN2DcXntzVOa=KJWh98KRjkhnHQ@mail.gmail.com> <20190729162428.bxuzgxg5sjqptlbp@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne ponedeljek, 29. julij 2019 ob 18:24:28 CEST je Uwe Kleine-König 
napisal(a):
> Hello,
> 
> On Tue, Jul 30, 2019 at 12:09:40AM +0800, Chen-Yu Tsai wrote:
> > On Tue, Jul 30, 2019 at 12:07 AM Uwe Kleine-König
> > 
> > <u.kleine-koenig@pengutronix.de> wrote:
> > > On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej Škrabec wrote:
> > > > Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-König
> > > > 
> > > > napisal(a):
> > > > > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > > > > > sun4i_pwm_single_bypass = {>
> > > > > > 
> > > > > >   .npwm = 1,
> > > > > >  
> > > > > >  };
> > > > > > 
> > > > > > +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst
> > > > > > = {
> > > > > > + .has_bus_clock = true,
> > > > > > + .has_prescaler_bypass = true,
> > > > > > + .has_reset = true,
> > > > > > + .npwm = 2,
> > > > > > +};
> > > > > > +
> > > > > > 
> > > > > >  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> > > > > >  
> > > > > >   {
> > > > > >   
> > > > > >           .compatible = "allwinner,sun4i-a10-pwm",
> > > > > > 
> > > > > > @@ -347,6 +354,9 @@ static const struct of_device_id
> > > > > > sun4i_pwm_dt_ids[] =
> > > > > > {
> > > > > > 
> > > > > >   }, {
> > > > > >   
> > > > > >           .compatible = "allwinner,sun8i-h3-pwm",
> > > > > >           .data = &sun4i_pwm_single_bypass,
> > > > > > 
> > > > > > + }, {
> > > > > > +         .compatible = "allwinner,sun50i-h6-pwm",
> > > > > > +         .data = &sun50i_pwm_dual_bypass_clk_rst,
> > > > > 
> > > > > If you follow my suggestion for the two previous patches, you can
> > > > > just
> > > > > 
> > > > > use:
> > > > >     compatible = "allwinner,sun50i-h6-pwm",
> > > > >     "allwinner,sun5i-a10s-pwm";
> > > > > 
> > > > > and drop this patch.
> > > > 
> > > > Maxime found out that it's not compatible with A10s due to difference
> > > > in bypass bit, but yes, I know what you mean.
> > > > 
> > > > Since H6 requires reset line and bus clock to be specified, it's not
> > > > compatible from DT binding side. New yaml based binding must somehow
> > > > know that in order to be able to validate DT node, so it needs
> > > > standalone compatible. However, depending on conclusions of other
> > > > discussions, this new compatible can be associated with already
> > > > available quirks structure or have it's own.> > 
> > > I cannot follow. You should be able to specify in the binding that the
> > > reset line and bus clock is optional. Then allwinner,sun50i-h6-pwm
> > > without a reset line and bus clock also verifies, but this doesn't
> > > really hurt (and who knows, maybe the next allwinner chip needs exactly
> > > this).
> > 
> > It is not optional. It will not work if either the clocks or reset
> > controls
> > are missing. How would these be optional anyway? Either it's connected and
> > thus required, or it's not and therefore should be omitted from the
> > description.
> 
> [Just arguing about the clock here, the argumentation is analogous for
> the reset control.]
> 
> From the driver's perspective it's optional: There are devices with and
> without a bus clock. This doesn't mean that you can just ignore this
> clock if it's specified. It's optional in the sense "If dt doesn't
> specify it, then assume this is a device that doesn't have it and so you
> don't need to handle it." but not in the sense "it doesn't matter if
> you handle it or not.".
> 
> Other than that I'm on your side. So for example I think it's not
> optimal that gpiod_get_optional returns NULL if GPIOLIB=n or that
> devm_reset_control_get_optional returns NULL if RESET_CONTROLLER=n
> because this hides exactly the kind of problem you point out here.
>

I think there's misunderstanding. I only argued that we can't use

compatible = "allwinner,sun50i-h6-pwm",
	 "allwinner,sun5i-a10s-pwm";

as you suggested and only 

compatible = "allwinner,sun50i-h6-pwm"; 

will work. Not because of driver itself (it can still use _optional() 
variants), but because of DT binding, which should be able to validate H6 PWM 
node - reset and bus clock references are required in this case.

Best regards,
Jernej
 
> Best regards
> Uwe




