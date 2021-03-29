Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2534434D5CA
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhC2RMU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 13:12:20 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:57278 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229711AbhC2RL4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 29 Mar 2021 13:11:56 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id CB191C729F1;
        Mon, 29 Mar 2021 19:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617037915;
        bh=Szu94hAh+X9JbhCN33k24NYs+V2mdbKnJBSTA0PXUpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SREAclvrF+bcBWaiWV2uGeGXWr2FkHmLLpdtfJkg2MvBq6s/eq8r1UqR0IS+h5D1M
         D9i2PYWnLcbdh9HY1cb1GwXl+Nz3efae4wRebqO6qpGColSSz/sRWSAJ7nbX0afnRF
         Ehtt2OEcdGb210kPozWAM1pP1htOxBz3NYXNhNM4=
Date:   Mon, 29 Mar 2021 19:11:53 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/7] pwm: pca9685: Support hardware readout
Message-ID: <YGIKWRfT7354nkPX@workstation.tuxnet>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
 <20210329125707.182732-2-clemens.gruber@pqgruber.com>
 <20210329165429.ookfliw4eq6zz2sg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210329165429.ookfliw4eq6zz2sg@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Mar 29, 2021 at 06:54:29PM +0200, Uwe Kleine-König wrote:
> On Mon, Mar 29, 2021 at 02:57:02PM +0200, Clemens Gruber wrote:
> > Implements .get_state to read-out the current hardware state.
> > 
> > The hardware readout may return slightly different values than those
> > that were set in apply due to the limited range of possible prescale and
> > counter register values.
> > 
> > Also note that although the datasheet mentions 200 Hz as default
> > frequency when using the internal 25 MHz oscillator, the calculated
> > period from the default prescaler register setting of 30 is 5079040ns.
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> >  drivers/pwm/pwm-pca9685.c | 41 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 0ed1013737e3..fb026a25fb61 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -333,6 +333,46 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> >  	return 0;
> >  }
> >  
> > +static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
> > +				  struct pwm_state *state)
> > +{
> > +	struct pca9685 *pca = to_pca(chip);
> > +	unsigned long long duty;
> > +	unsigned int val = 0;
> > +
> > +	/* Calculate (chip-wide) period from prescale value */
> > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > +	state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
> > +			(val + 1);
> 
> As we have PCA9685_OSC_CLOCK_MHZ = 25 this is an integer calculation
> without loss of precision. It might be worth to point that out in a
> comment. (Otherwise doing the division at the end might be more
> sensible.)

What comment do you have in mind?
/* 1 integer multiplication (without loss of precision) at runtime */ ?

> 
> > +	/* The (per-channel) polarity is fixed */
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
> > +		/*
> > +		 * The "all LEDs" channel does not support HW readout
> > +		 * Return 0 and disabled for backwards compatibility
> > +		 */
> > +		state->duty_cycle = 0;
> > +		state->enabled = false;
> > +		return;
> > +	}
> > +
> > +	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
> > +
> > +	state->enabled = !!duty;
> > +	if (!state->enabled) {
> > +		state->duty_cycle = 0;
> > +		return;
> > +	} else if (duty == PCA9685_COUNTER_RANGE) {
> > +		state->duty_cycle = state->period;
> > +		return;
> > +	}
> > +
> > +	duty *= state->period;
> > +	state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
> 
> .apply uses ROUND_CLOSEST to calculate duty from state->duty_cycle,
> still using / here (instead of ROUND_CLOSEST), but again as
> PCA9685_OSC_CLOCK_MHZ is 25 this calculation doesn't suffer from
> rounding errors. So if you feed the state returned here into .apply
> again, there is (as I want it) no change.
> 
> The only annoyance is that if PCA9685_PRESCALE holds a value smaller
> than 3, .apply() will fail. Not sure there is any saner way to handle
> this.

According to the datasheet, "The hardware forces a minimum value that
can be loaded into the PRE_SCALE register at '3'", so there should never
be anything below 3 in that register.

Thanks for your review!

Clemens
