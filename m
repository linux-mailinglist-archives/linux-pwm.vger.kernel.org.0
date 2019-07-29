Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 177EB78FC1
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2019 17:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388229AbfG2Pso convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 29 Jul 2019 11:48:44 -0400
Received: from mailoutvs12.siol.net ([185.57.226.203]:56714 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387495AbfG2Pso (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Jul 2019 11:48:44 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id 4F143520794;
        Mon, 29 Jul 2019 17:48:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta09.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta09.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id UWI1rWW0TD-m; Mon, 29 Jul 2019 17:48:39 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id E201C5205D8;
        Mon, 29 Jul 2019 17:48:38 +0200 (CEST)
Received: from jernej-laptop.localnet (cpe-194-152-11-237.cable.triera.net [194.152.11.237])
        (Authenticated sender: jernej.skrabec@siol.net)
        by mail.siol.net (Postfix) with ESMTPA id AA376522650;
        Mon, 29 Jul 2019 17:48:36 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Uwe =?ISO-8859-1?Q?Kleine=2DK=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     thierry.reding@gmail.com, mripard@kernel.org, wens@csie.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, kernel@pengutronix.de
Subject: Re: [PATCH 3/6] pwm: sun4i: Add a quirk for bus clock
Date:   Mon, 29 Jul 2019 17:48:36 +0200
Message-ID: <4022372.WfP88Fa4Lu@jernej-laptop>
In-Reply-To: <20190729063825.wxfky6nswcru26g7@pengutronix.de>
References: <20190726184045.14669-1-jernej.skrabec@siol.net> <20190726184045.14669-4-jernej.skrabec@siol.net> <20190729063825.wxfky6nswcru26g7@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

Dne ponedeljek, 29. julij 2019 ob 08:38:25 CEST je Uwe Kleine-König 
napisal(a):
> Hello,
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
> 
> Similar to my suggestion in patch 2: I'd use devm_clk_get_optional() and
> drop struct sun4i_pwm_data::has_bus_clock.

This one is not so simple. This patch has incorrect logic. Correct logic would 
be to use "devm_clk_get(&pdev->dev, NULL)" for variants without bus clock as 
it is done already and "devm_clk_get(&pdev->dev, "bus")" and 
"devm_clk_get(&pdev->dev, "mod")" for variants with bus clock.

You see, DT nodes for other variants don't have clock-names property at all. 
If it would be specified, it would be "mod". So, DT nodes for other variants 
have "mod" clock specified on first place (the only one), while H6 DT node will 
have "mod" clock specified on second place (see one of e-mails from Maxime), so 
"NULL" can't be used instead of "mod" in both cases.

So I would say quirk is beneficial to know if you have to look up clocks by 
name or you just take first clock specified.

Best regards,
Jernej

> 
> Best regards
> Uwe




