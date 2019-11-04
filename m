Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8C5EE93F
	for <lists+linux-pwm@lfdr.de>; Mon,  4 Nov 2019 21:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfKDULC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 Nov 2019 15:11:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51393 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfKDULB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 Nov 2019 15:11:01 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRigg-0002wy-8Q; Mon, 04 Nov 2019 21:10:54 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iRige-0006VB-Jc; Mon, 04 Nov 2019 21:10:52 +0100
Date:   Mon, 4 Nov 2019 21:10:52 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
Message-ID: <20191104201052.bxzdues2y4aqkukd@pengutronix.de>
References: <20191103203334.10539-1-peron.clem@gmail.com>
 <20191103203334.10539-4-peron.clem@gmail.com>
 <20191104082410.qdgcnphkamlzaipf@pengutronix.de>
 <CAJiuCcdxHDwoQYBsrjK5dcOtMDie62DzJ84NH+bZzYHHv49fEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJiuCcdxHDwoQYBsrjK5dcOtMDie62DzJ84NH+bZzYHHv49fEQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Clément,

On Mon, Nov 04, 2019 at 07:07:00PM +0100, Clément Péron wrote:
> On Mon, 4 Nov 2019 at 09:24, Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> > On Sun, Nov 03, 2019 at 09:33:30PM +0100, Clément Péron wrote:
> > > From: Jernej Skrabec <jernej.skrabec@siol.net>
> > >
> > > H6 PWM core needs bus clock to be enabled in order to work.
> > >
> > > Add an optional probe for it and a fallback for previous
> > > bindings without name on module clock.
> > >
> > > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > Signed-off-by: Clément Péron <peron.clem@gmail.com>
> > > ---
> > >  drivers/pwm/pwm-sun4i.c | 36 ++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 36 insertions(+)
> > >
> > > diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> > > index d194b8ebdb00..b5e7ac364f59 100644
> > > --- a/drivers/pwm/pwm-sun4i.c
> > > +++ b/drivers/pwm/pwm-sun4i.c
> > > @@ -78,6 +78,7 @@ struct sun4i_pwm_data {
> > >
> > >  struct sun4i_pwm_chip {
> > >       struct pwm_chip chip;
> > > +     struct clk *bus_clk;
> > >       struct clk *clk;
> > >       struct reset_control *rst;
> > >       void __iomem *base;
> > > @@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
> >
> > Adding more context here:
> >
> > |       pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > >       if (IS_ERR(pwm->clk))
> > >               return PTR_ERR(pwm->clk);
> > >
> > > +     /* Get all clocks and reset line */
> > > +     pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
> > > +     if (IS_ERR(pwm->clk)) {
> > > +             dev_err(&pdev->dev, "get clock failed %ld\n",
> > > +                     PTR_ERR(pwm->clk));
> > > +             return PTR_ERR(pwm->clk);
> > > +     }
> >
> > I guess you want to drop the first assignment to pwm->clk.
> 
> devm_clk_get_optional will return NULL if there is no entry, I don't
> get where I need to drop it assignment.

With your patch the code looks as follows:

	pwm->clk = devm_clk_get(&pdev->dev, NULL);
	if (IS_ERR(pwm->clk))
		return PTR_ERR(pwm->clk);

	/* Get all clocks and reset line */
	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
	...

The assignment to pwm->clk above the comment is the one I suggested to
drop.

> > > +     /* Fallback for old dtbs with a single clock and no name */
> > > +     if (!pwm->clk) {
> > > +             pwm->clk = devm_clk_get(&pdev->dev, NULL);
> > > +             if (IS_ERR(pwm->clk)) {
> > > +                     dev_err(&pdev->dev, "get clock failed %ld\n",
> > > +                             PTR_ERR(pwm->clk));
> > > +                     return PTR_ERR(pwm->clk);
> > > +             }
> > > +     }
> >
> > There is a slight change of behaviour if I'm not mistaken. If you have
> > this:
> >
> >         clocks = <&clk1>;
> >         clock-names = "mod";
> >
> >         pwm {
> >                 compatible = "allwinner,sun4i-a10-pwm"
> >                 clocks = <&clk2>;
> >         }
> >
> > you now use clk1 instead of clk2 before.
> >
> > Assuming this is only a theoretical problem, at least pointing this out
> > in the commit log would be good I think.
> 
> Yes it's correct and as you said the driver don't check for a correct
> device tree, that why it's now optional probe.
> Let's assume that's the device-tree is correct, I will add a comment
> in the commit log.

If the mod clock was shared by all peripherals on the bus this would be
IMHO quite elegant. Probably it depends on what you mean by saying
"incorrect" if this snippet is incorrect. (It can be part of a valid dtb
that even complies to the binding documentation. However that's not how
any existing allwinner hardware looks like.) But let's stop arguing as
we agree it's a corner case and if you mention it in the commit log
we're both happy.

> > What is that clock used for? Is it required to access the hardware
> > registers? Or is it only required while the PWM is enabled? If so you
> > could enable the clock more finegrainded.
> 
> Regarding the datasheet it's required to access the hardware.
> page 261 : https://linux-sunxi.org/File:Allwinner_H6_V200_User_Manual_V1.1.pdf

So enabling the bus clock is called "open APB1 Bus gating" in that
manual? If I understand that correctly the bus clock then only need to
be on while accessing the registers and could be disabled once the
hardware is programmed and running.

Can you please describe that in a comment. Something like:

	/*
	 * We're keeping the bus clock on for the sake of simplicity.
	 * Actually it only needs to be on for hardware register
	 * accesses.
	 */
	 
should be fine. This way it's at least obvious that the handling could
be improved.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
