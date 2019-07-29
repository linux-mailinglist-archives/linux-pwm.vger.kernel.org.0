Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42A3978FEA
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 17:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387594AbfG2Pz4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 11:55:56 -0400
Received: from mailoutvs54.siol.net ([185.57.226.245]:56000 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387593AbfG2Pz4 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 11:55:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 8DCAD522BB3;
        Mon, 29 Jul 2019 17:55:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u-_fD2Ny9KTo; Mon, 29 Jul 2019 17:55:53 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 266D5522D23;
        Mon, 29 Jul 2019 17:55:53 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id A1875522BB3;
        Mon, 29 Jul 2019 17:55:52 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, kernel@pengutronix.de
Subject: Re: [PATCH 4/6] pwm: sun4i: Add support for H6 PWM
Date:   Mon, 29 Jul 2019 17:55:52 +0200
Message-ID: <223488703.0I5IR7NXoI@jernej-laptop>
In-Reply-To: <20190729064030.7uenld2kbof45zti@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-5-jernej.skrabec@siol.net> <20190729064030.7uenld2kbof45zti@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Dne ponedeljek, 29. julij 2019 ob 08:40:30 CEST je Uwe Kleine-König 
napisal(a):
> On Fri, Jul 26, 2019 at 08:40:43PM +0200, Jernej Skrabec wrote:
> > Now that sun4i PWM driver supports deasserting reset line and enabling
> > bus clock, support for H6 PWM can be added.
> > 
> > Note that while H6 PWM has two channels, only first one is wired to
> > output pin. Second channel is used as a clock source to companion AC200
> > chip which is bundled into same package.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/pwm/pwm-sun4i.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 7d3ac3f2dc3f..9e0eca79ff88 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -331,6 +331,13 @@ static const struct sun4i_pwm_data
> > sun4i_pwm_single_bypass = {> 
> >  	.npwm = 1,
> >  
> >  };
> > 
> > +static const struct sun4i_pwm_data sun50i_pwm_dual_bypass_clk_rst = {
> > +	.has_bus_clock = true,
> > +	.has_prescaler_bypass = true,
> > +	.has_reset = true,
> > +	.npwm = 2,
> > +};
> > +
> > 
> >  static const struct of_device_id sun4i_pwm_dt_ids[] = {
> >  
> >  	{
> >  	
> >  		.compatible = "allwinner,sun4i-a10-pwm",
> > 
> > @@ -347,6 +354,9 @@ static const struct of_device_id sun4i_pwm_dt_ids[] =
> > {
> > 
> >  	}, {
> >  	
> >  		.compatible = "allwinner,sun8i-h3-pwm",
> >  		.data = &sun4i_pwm_single_bypass,
> > 
> > +	}, {
> > +		.compatible = "allwinner,sun50i-h6-pwm",
> > +		.data = &sun50i_pwm_dual_bypass_clk_rst,
> 
> If you follow my suggestion for the two previous patches, you can just
> use:
> 
> 	compatible = "allwinner,sun50i-h6-pwm", "allwinner,sun5i-a10s-pwm";
> 
> and drop this patch.

Maxime found out that it's not compatible with A10s due to difference in bypass 
bit, but yes, I know what you mean.

Since H6 requires reset line and bus clock to be specified, it's not compatible 
from DT binding side. New yaml based binding must somehow know that in order 
to be able to validate DT node, so it needs standalone compatible. However, 
depending on conclusions of other discussions, this new compatible can be 
associated with already available quirks structure or have it's own.

Best regards,
Jernej

> 
> Best regards
> Uwe
> 
> >  	}, {
> >  	
> >  		/* sentinel */
> >  	
> >  	},




