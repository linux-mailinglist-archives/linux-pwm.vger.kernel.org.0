Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3C177927
	for <lists+linux-pwm@lfdr.de>; Sat, 27 Jul 2019 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387691AbfG0OPy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 27 Jul 2019 10:15:54 -0400
Received: from mailoutvs42.siol.net ([185.57.226.233]:44109 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387665AbfG0OPy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 27 Jul 2019 10:15:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id CA74F521268;
        Sat, 27 Jul 2019 16:15:50 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hbLuWxG2e3C6; Sat, 27 Jul 2019 16:15:50 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 647CA5212C6;
        Sat, 27 Jul 2019 16:15:50 +0200 (CEST)
Received: from jernej-laptop.localnet (89-212-178-211.dynamic.t-2.net [89.212.178.211])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Zimbra) with ESMTPA id 9D7F3521268;
        Sat, 27 Jul 2019 16:15:49 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Maxime Ripard <mripard@kernel.org>
Cc:     thierry.reding@gmail.com, wens@csie.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date:   Sat, 27 Jul 2019 16:15:49 +0200
Message-ID: <2870898.N5hf0jI4cO@jernej-laptop>
In-Reply-To: <20190727104628.jsdvpxvcpzru75v5@flea.home>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-4-jernej.skrabec@siol.net> <20190727104628.jsdvpxvcpzru75v5@flea.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dne sobota, 27. julij 2019 ob 12:46:28 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Fri, Jul 26, 2019 at 08:40:42PM +0200, Jernej Skrabec wrote:
> > H6 PWM core needs bus clock to be enabled in order to work.
> > 
> > Add a quirk for it.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/pwm/pwm-sun4i.c | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > index 1b7be8fbde86..7d3ac3f2dc3f 100644
> > --- a/drivers/pwm/pwm-sun4i.c
> > +++ b/drivers/pwm/pwm-sun4i.c
> > @@ -72,6 +72,7 @@ static const u32 prescaler_table[] = {
> > 
> >  };
> >  
> >  struct sun4i_pwm_data {
> > 
> > +	bool has_bus_clock;
> > 
> >  	bool has_prescaler_bypass;
> >  	bool has_reset;
> >  	unsigned int npwm;
> > 
> > @@ -79,6 +80,7 @@ struct sun4i_pwm_data {
> > 
> >  struct sun4i_pwm_chip {
> >  
> >  	struct pwm_chip chip;
> > 
> > +	struct clk *bus_clk;
> > 
> >  	struct clk *clk;
> >  	struct reset_control *rst;
> >  	void __iomem *base;
> > 
> > @@ -382,6 +384,16 @@ static int sun4i_pwm_probe(struct platform_device
> > *pdev)> 
> >  		reset_control_deassert(pwm->rst);
> >  	
> >  	}
> > 
> > +	if (pwm->data->has_bus_clock) {
> > +		pwm->bus_clk = devm_clk_get(&pdev->dev, "bus");
> > +		if (IS_ERR(pwm->bus_clk)) {
> > +			ret = PTR_ERR(pwm->bus_clk);
> > +			goto err_bus;
> > +		}
> > +
> > +		clk_prepare_enable(pwm->bus_clk);
> > +	}
> > +
> 
> The patch itself looks fine, but you should clarify which clock is
> being used by the old driver.
> 
> My guess is that the "new" clock is actually the mod one, while the
> old one was both the clock of the register interface (bus) and the
> clock of the PWM generation logic (mod).

Well, I checked few datasheets and nowhere is explicitly stated what is the 
bus clock, but I would make same guess as you.

Anyway, since you requested that order of the clocks has to be changed, I have 
to separately obtain clocks if there is bus clock present too or not. If it 
is, both clocks have to be obtained by name, and if not, old code without name 
can be used.

Best regards,
Jernej

> 
> Maxime
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com




