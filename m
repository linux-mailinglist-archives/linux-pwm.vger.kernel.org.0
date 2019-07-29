Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D754379052
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727172AbfG2QH1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Jul 2019 12:07:27 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35151 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfG2QH1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 12:07:27 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hs8BI-0006L9-N0; Mon, 29 Jul 2019 18:07:24 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hs8BH-0005er-CP; Mon, 29 Jul 2019 18:07:23 +0200
Date:   Mon, 29 Jul 2019 18:07:23 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@siol.net>
Cc:     mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
        linux-kernel@vger.kernel.org, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, thierry.reding@gmail.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Message-ID: <20190729160723.am3cs5pasi22pibi@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net>
 <20190726184045.14669-5-jernej.skrabec@siol.net>
 <20190729064030.7uenld2kbof45zti@pengutronix.de>
 <223488703.0I5IR7NXoI@jernej-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <223488703.0I5IR7NXoI@jernej-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 29, 2019 at 05:55:52PM +0200, Jernej Škrabec wrote:
> Hi Uwe,
> 
> Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-König 
> napisal(a):
> > On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > > Now that sun4i PWM driver supports deasserting reset line and enabling
> > > bus clock, support for H6 PWM can be added.
> > > 
> > > Note that while H6 PWM has two channels, only first one is wired to
> > > output pin. Second channel is used as a clock source to companion AC200
> > > chip which is bundled into same package.
> > > 
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > ---
> > > 
> > >  drivers/pwm/pwm-sun4i.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index 7d3ac3f2dc3f..9e0eca79ff88 100644
> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > > sun4i_pwm_single_bypass = {> 
> > >  	.npwm = 1,
> > >  
> > >  };
> > > 
> > > +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst = {
> > > +	.has_bus_clock = true,
> > > +	.has_prescaler_bypass = true,
> > > +	.has_reset = true,
> > > +	.npwm = 2,
> > > +};
> > > +
> > > 
> > >  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> > >  
> > >  	{
> > >  	
> > >  		.compatible = "allwinner,sun4i-a10-pwm",
> > > 
> > > @@ -347,6 +354,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =
> > > {
> > > 
> > >  	}, {
> > >  	
> > >  		.compatible = "allwinner,sun8i-h3-pwm",
> > >  		.data = &sun4i_pwm_single_bypass,
> > > 
> > > +	}, {
> > > +		.compatible = "allwinner,sun50i-h6-pwm",
> > > +		.data = &sun50i_pwm_dual_bypass_clk_rst,
> > 
> > If you follow my suggestion for the two previous patches, you can just
> > use:
> > 
> > 	compatible = "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";
> > 
> > and drop this patch.
> 
> Maxime found out that it's not compatible with A10s due to difference in bypass 
> bit, but yes, I know what you mean.
> 
> Since H6 requires reset line and bus clock to be specified, it's not compatible 
> from DT binding side. New yaml based binding must somehow know that in order 
> to be able to validate DT node, so it needs standalone compatible. However, 
> depending on conclusions of other discussions, this new compatible can be 
> associated with already available quirks structure or have it's own.

I cannot follow. You should be able to specify in the binding that the
reset line and bus clock is optional. Then allwinner,sun50i-h6-pwm
without a reset line and bus clock also verifies, but this doesn't
really hurt (and who knows, maybe the next allwinner chip needs exactly
this).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
