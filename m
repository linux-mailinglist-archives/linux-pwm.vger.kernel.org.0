Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E31BA5D0D
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Sep 2019 22:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfIBUU3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 2 Sep 2019 16:20:29 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52389 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfIBUU3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 2 Sep 2019 16:20:29 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4soO-0006ad-B7; Mon, 02 Sep 2019 22:20:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1i4soO-0002kg-0V; Mon, 02 Sep 2019 22:20:28 +0200
Date:   Mon, 2 Sep 2019 22:20:27 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pwm@vger.kernel.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Patrick Havelange <patrick.havelange@essensium.com>,
        linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 2/6] pwm: let pwm_get_state() return the last
 implemented state
Message-ID: <20190902202027.es2vmearjdgzzdpz@pengutronix.de>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
 <20190824153707.13746-3-uwe@kleine-koenig.org>
 <5802279.ETANMDGNFP@phil>
 <20190902143231.k2ugpv2oemceaequ@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190902143231.k2ugpv2oemceaequ@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Sep 02, 2019 at 04:32:31PM +0200, Uwe Kleine-König wrote:
> On Fri, Aug 30, 2019 at 07:48:35PM +0200, Heiko Stuebner wrote:
> > Am Samstag, 24. August 2019, 17:37:03 CEST schrieb Uwe Kleine-König:
> > > ---
> > >  drivers/pwm/core.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > > index 72347ca4a647..92333b89bf02 100644
> > > --- a/drivers/pwm/core.c
> > > +++ b/drivers/pwm/core.c
> > > @@ -473,7 +473,14 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
> > >  		if (err)
> > >  			return err;
> > >  
> > > -		pwm->state = *state;
> > > +		/*
> > > +		 * .apply might have to round some values in *state, if possible
> > > +		 * read the actually implemented value back.
> > > +		 */
> > > +		if (chip->ops->get_state)
> > > +			chip->ops->get_state(chip, pwm, &pwm->state);
> > > +		else
> > > +			pwm->state = *state;
> > 
> > This should probably become
> > >-		pwm->state = *state;
> > > +
> > > +		/*
> > > +		 * .apply might have to round some values in *state, if possible
> > > +		 * read the actually implemented value back.
> > > +		 */
> > > +		if (chip->ops->get_state)
> > > +			chip->ops->get_state(chip, pwm, &pwm->state);
> > 
> > so always initialize the state to the provided one and then let the driver
> > override values?
> 
> This feels wrong. There is another thread that adds a developer knob
> that emits some warnings. Catching this kind of error with it would be a
> good idea IMHO.
> 
> > The inversion case stems from the Rockchip pwm driver (wrongly?) only
> > setting the polarity field when actually inverted, so here the polarity field
> > probably never actually got set at all.
> > 
> > But while we should probably fix the rockchip driver to set polarity all the
> > time, this is still being true for possible future state-fields, which also
> > wouldn't get initialzed from all drivers, which might need an adaption
> > first?
> 
> Actually I would prefer that all drivers do it right and rely on this.

FTR: I sent a patch for the rockchip driver to do the right thing here.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
