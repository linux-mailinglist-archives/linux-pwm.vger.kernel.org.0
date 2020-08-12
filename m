Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5C2426E8
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 10:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgHLIrd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 04:47:33 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:54847 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgHLIrc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 04:47:32 -0400
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 30E1C10000B;
        Wed, 12 Aug 2020 08:47:29 +0000 (UTC)
Date:   Wed, 12 Aug 2020 10:47:28 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pwm: atmel: Make use of dev_err_probe()
Message-ID: <20200812084728.GI3448@piout.net>
References: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
 <20200812082002.GD4354@dell>
 <20200812083204.kktnid63j6vefsky@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812083204.kktnid63j6vefsky@pengutronix.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 12/08/2020 10:32:04+0200, Uwe Kleine-König wrote:
> On Wed, Aug 12, 2020 at 09:20:02AM +0100, Lee Jones wrote:
> > On Wed, 12 Aug 2020, Uwe Kleine-König wrote:
> > 
> > > Add an error message for failure points that currently lack a message
> > > and convert dev_err to dev_err_probe() which does the right thing for
> > > -EPROBE_DEFER. Also slightly simplify the error handling.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/pwm/pwm-atmel.c | 24 +++++++++++-------------
> > >  1 file changed, 11 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
> > > index 6161e7e3e9ac..aa0b36695dc7 100644
> > > --- a/drivers/pwm/pwm-atmel.c
> > > +++ b/drivers/pwm/pwm-atmel.c
> > > @@ -415,17 +415,18 @@ static int atmel_pwm_probe(struct platform_device *pdev)
> > >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > >  	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
> > >  	if (IS_ERR(atmel_pwm->base))
> > > -		return PTR_ERR(atmel_pwm->base);
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->base),
> > > +				     "Failed to remap register space\n");
> > 
> > This is a regression.
> > 
> > devm_ioremap_resource() already emits and error message for !-ENOMEM.
> > 
> > -ENOMEM cases should fail silently.
> 
> ah right. Maybe dev_err_probe() should do this right, too?
> 
> > >  	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > >  	if (IS_ERR(atmel_pwm->clk))
> > > -		return PTR_ERR(atmel_pwm->clk);
> > > +		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
> > > +				     "Failed to get clock\n");
> > 
> > Isn't dev_err_probe() only useful for drivers handling -EPROBE_DEFER?
> 
> devm_clk_get() might return -EPROBE_DEFER.
> 

If it did, you wouldn't be able to print this message. I' not sure it is
worth adding so many checks for errors that will never happen.

> > >  	ret = clk_prepare(atmel_pwm->clk);
> > > -	if (ret) {
> > > -		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
> > > -		return ret;
> > > -	}
> > > +	if (ret)
> > > +		return dev_err_probe(&pdev->dev, ret,
> > > +				     "Failed to prepare PWM clock\n");
> > 
> > As above.
> 
> I only checked quickly and didn't find an instance where clk_prepare can
> return -EPROBE_DEFER, but even if it doesn't it works fine.

Same here, clk_prepare will never fail but there is a check and a string
that will never be used. In my opinion, this is simply a waste of
space...


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
