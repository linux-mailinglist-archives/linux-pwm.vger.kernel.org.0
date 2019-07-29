Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C379364
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbfG2SvN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 14:51:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39441 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfG2SvN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 14:51:13 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsAjl-000690-SO; Mon, 29 Jul 2019 20:51:09 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hsAjk-0002Ay-OI; Mon, 29 Jul 2019 20:51:08 +0200
Date:   Mon, 29 Jul 2019 20:51:08 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [linux-sunxi] Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Message-ID: <20190729185108.tpilwoooxvi2z72e@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <2346193.MplWYqIveT@jernej-laptop>
 <20190729184041.vlvfz3vz3ykhufdk@pengutronix.de>
 <173825848.1FZsmuHfpq@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173825848.1FZsmuHfpq@jernej-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 29, 2019 at 08:46:25PM +0200, Jernej Škrabec wrote:
> Dne ponedeljek, 29. julij 2019 ob 20:40:41 CEST je Uwe Kleine-König 
> napisal(a):
> > On Mon, Jul 29, 2019 at 06:40:15PM +0200, Jernej Škrabec wrote:
> > > Dne ponedeljek, 29. julij 2019 ob 18:24:28 CEST je Uwe Kleine-König
> > > 
> > > napisal(a):
> > > > Hello,
> > > > 
> > > > On Tue, Jul 30, 2019 at 12:09:40AM +0800, Chen-Yu Tsai wrote:
> > > > > On Tue, Jul 30, 2019 at 12:07 AM Uwe Kleine-König
> > > > > 
> > > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > > > On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej Škrabec wrote:
> > > > > > > Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe
> > > > > > > Kleine-König
> > > > > > > 
> > > > > > > napisal(a):
> > > > > > > > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > > > > > > > > --- a/drivers/pwm/pwm-sun4i.c
> > > > > > > > > +++ b/drivers/pwm/pwm-sun4i.c
> > > > > > > > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > > > > > > > > sun4i_pwm_single_bypass = {>
> > > > > > > > > 
> > > > > > > > >   .npwm = 1,
> > > > > > > > >  
> > > > > > > > >  };
> > > > > > > > > 
> > > > > > > > > +static const struct sun4i_pwm_data
> > > > > > > > > sun50i_pwm_dual_bypass_clk_rst
> > > > > > > > > = {
> > > > > > > > > + .has_bus_clock = true,
> > > > > > > > > + .has_prescaler_bypass = true,
> > > > > > > > > + .has_reset = true,
> > > > > > > > > + .npwm = 2,
> > > > > > > > > +};
> > > > > > > > > +
> > > > > > > > > 
> > > > > > > > >  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> > > > > > > > >  
> > > > > > > > >   {
> > > > > > > > >   
> > > > > > > > >           .compatible = "allwinner,sun4i-a10-pwm",
> > > > > > > > > 
> > > > > > > > > @@ -347,6 +354,9 @@ static const struct of_device_id
> > > > > > > > > sun4i_pwm_dt_ids[] =
> > > > > > > > > {
> > > > > > > > > 
> > > > > > > > >   }, {
> > > > > > > > >   
> > > > > > > > >           .compatible = "allwinner,sun8i-h3-pwm",
> > > > > > > > >           .data = &sun4i_pwm_single_bypass,
> > > > > > > > > 
> > > > > > > > > + }, {
> > > > > > > > > +         .compatible = "allwinner,sun50i-h6-pwm",
> > > > > > > > > +         .data = &sun50i_pwm_dual_bypass_clk_rst,
> > > > > > > > 
> > > > > > > > If you follow my suggestion for the two previous patches, you
> > > > > > > > can
> > > > > > > > just
> > > > > > > > 
> > > > > > > > use:
> > > > > > > >     compatible = "allwinner,sun50i-h6-pwm",
> > > > > > > >     "allwinner,sun5i-a10s-pwm";
> > > > > > > > 
> > > > > > > > and drop this patch.
> > > > > > > 
> > > > > > > Maxime found out that it's not compatible with A10s due to
> > > > > > > difference
> > > > > > > in bypass bit, but yes, I know what you mean.
> > > > > > > 
> > > > > > > Since H6 requires reset line and bus clock to be specified, it's
> > > > > > > not
> > > > > > > compatible from DT binding side. New yaml based binding must
> > > > > > > somehow
> > > > > > > know that in order to be able to validate DT node, so it needs
> > > > > > > standalone compatible. However, depending on conclusions of other
> > > > > > > discussions, this new compatible can be associated with already
> > > > > > > available quirks structure or have it's own.> >
> > > > > > 
> > > > > > I cannot follow. You should be able to specify in the binding that
> > > > > > the
> > > > > > reset line and bus clock is optional. Then allwinner,sun50i-h6-pwm
> > > > > > without a reset line and bus clock also verifies, but this doesn't
> > > > > > really hurt (and who knows, maybe the next allwinner chip needs
> > > > > > exactly
> > > > > > this).
> > > > > 
> > > > > It is not optional. It will not work if either the clocks or reset
> > > > > controls
> > > > > are missing. How would these be optional anyway? Either it's connected
> > > > > and
> > > > > thus required, or it's not and therefore should be omitted from the
> > > > > description.
> > > > 
> > > > [Just arguing about the clock here, the argumentation is analogous for
> > > > the reset control.]
> > > > 
> > > > From the driver's perspective it's optional: There are devices with and
> > > > without a bus clock. This doesn't mean that you can just ignore this
> > > > clock if it's specified. It's optional in the sense "If dt doesn't
> > > > specify it, then assume this is a device that doesn't have it and so you
> > > > don't need to handle it." but not in the sense "it doesn't matter if
> > > > you handle it or not.".
> > > > 
> > > > Other than that I'm on your side. So for example I think it's not
> > > > optimal that gpiod_get_optional returns NULL if GPIOLIB=n or that
> > > > devm_reset_control_get_optional returns NULL if RESET_CONTROLLER=n
> > > > because this hides exactly the kind of problem you point out here.
> > > 
> > > I think there's misunderstanding. I only argued that we can't use
> > > 
> > > compatible = "allwinner,sun50i-h6-pwm",
> > > 
> > > 	 "allwinner,sun5i-a10s-pwm";
> > > 
> > > as you suggested and only
> > > 
> > > compatible = "allwinner,sun50i-h6-pwm";
> > > 
> > > will work. Not because of driver itself (it can still use _optional()
> > > variants), but because of DT binding, which should be able to validate H6
> > > PWM node - reset and bus clock references are required in this case.
> > 
> > I think I understood. In my eyes there is no need to let validation of
> > the DT bindings catch a missing "optional" property that is needed on
> > H6.
> > 
> > You have to draw the line somewhere which information the driver has
> > hard-coded and what is only provided by the device tree and just assumed
> > to be correct by the driver. You argue the driver should know that 
> 
> No, in this thread I argue that DT validation tool, executed by
> 
> make ARCH=arm64 dtbs_check
> 
> should catch that. This is not a driver, but DT binding described in YAML.

The argumentation is the same. dtbs_check doesn't notice if the base
address of your "allwinner,sun50i-h6-pwm" device is wrong. So why should
it catch a missing reset controller phandle?

Best regards
Uwe


-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
