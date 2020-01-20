Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6363E142EE3
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 16:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbgATPi1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 20 Jan 2020 10:38:27 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:46055 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbgATPi1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 10:38:27 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 3BD641C000F;
        Mon, 20 Jan 2020 15:38:23 +0000 (UTC)
Date:   Mon, 20 Jan 2020 16:38:22 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200120163822.232b1410@xps13>
In-Reply-To: <20200120144457.eznywc423ehw6kuc@pengutronix.de>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
        <20200120121329.GC206171@ulmo>
        <20200120134137.54dc307e@xps13>
        <20200120141944.GD206171@ulmo>
        <20200120144457.eznywc423ehw6kuc@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe, Thierry,

> > > > > +static void max7313_pwm_free(struct pwm_chip *chip,
> > > > > +			     struct pwm_device *pwm)
> > > > > +{
> > > > > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm);
> > > > > +
> > > > > +	gpiochip_free_own_desc(data->desc);
> > > > > +	kfree(data);
> > > > > +}
> > > > > +
> > > > > +static int max7313_pwm_apply(struct pwm_chip *chip,
> > > > > +			     struct pwm_device *pwm,
> > > > > +			     const struct pwm_state *state)
> > > > > +{
> > > > > +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > > > > +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > > > > +	unsigned int intensity, active;
> > > > > +	int ret = 0;
> > > > > +
> > > > > +	if (!state->enabled ||
> > > > > +	    state->period < PWM_PERIOD_NS ||    
> > > > 
> > > > I think you should actually make this a != so that you refuse any
> > > > attempt to change the period, since you can't do it anyway.  
> > > 
> > > Actually we discussed this with Uwe, see the below snippet:
> > > 
> > > ---8<---  
> > > > > > +	if (state->period != PWM_PERIOD_NS ||
> > > > > > +	    state->polarity != PWM_POLARITY_NORMAL)
> > > > > > +		return -EINVAL;      
> > > > > 
> > > > > The check for period is too strong. Anything bigger than PWM_PERIOD_NS
> > > > > is acceptable, too. (The policy I'd like to see is: Provide the biggest
> > > > > period possible not bigger than the requested policy.)    
> > > > 
> > > > I don't understand, what is this parameter supposed to mean? the period
> > > > cannot be changed, it is ruled by an internal oscillator. In this case
> > > > any period bigger than the actual period cannot be physically achieved.
> > > > If we derive ratios with a bigger period than possible, why not
> > > > allowing it for lower periods too?    
> > > 
> > > Yes, I understood that the period is fixed for your PWM. However
> > > consider a consumer who would prefer a different period. If you decline
> > > all requests unless state->period == PWM_PERIOD_NS the consumer has no
> > > guide to determine that unless all periods are tested. If however asking
> > > for period = 2s results in getting 31.25 ms this allows the consumer to
> > > assume that no period setting between 2s and 31.25 ms is possible. And
> > > so the usual policy to implement is as stated in my previous mail.  
> > > --->8---  
> > 
> > I think I understand what Uwe is getting at, but I don't think we should
> > lie to consumers. It's true that in some cases the drivers will silently
> > use a slightly different period if they can't match the one requested,
> > but I don't think that's a good thing. Most of the time in those drivers
> > the computed period that the controller can support is "close enough".
> > 
> > But in this case the controller doesn't support anything other than the
> > one period, so I don't think accepting anything other than that is good
> > for any consumer.
> > 
> > Also, typically this doesn't really matter because this will have been
> > defined in device tree and if the device tree has the wrong period, then
> > this should already be caught before the buggy DTS is upstreamed.
> > 
> > So, I agree that the current situation is not ideal and perhaps we
> > should enforce stronger requirements for accuracy. I suspect that a good
> > solution would be for the drivers to report back the state that would've
> > been applied without actually applying it (kind of like the semantics of
> > clk_round_rate() from the common clock framework). That would give users
> > a good way of checking whether the supported parameters are within the
> > desired range before applying them. For consumers that don't care all
> > that much about precision, they can feel free to ignore any differences
> > between what they asked and what they got, and most of the time that
> > will be fine.  
> 
> Yeah, it's something like clk_round_rate that I want in the end. And to
> make it actually workable the IMHO only sane approach is to allow
> rounding in one direction without limit. And as pwm_apply_state() should
> be consistent with pwm_round_state() the former must round without
> limit, too.
> 
> And if you want to require that a consumer of a PWM that only supports a
> single period setting passes that period, how do you want to handle the
> situation if this period happens to be 2000/3 ns. Is it ok to pass
> .period = 666? Is it ok to pass 667?
> 
> > In many cases it doesn't matter because the period is defined in DT and
> > is hand-picked to be among the ones supported by the controller, or the
> > small differences between the period in DT and the closest one supported
> > by the controller is not significant and things will just work.  
> 
> In my eyes to get a uniform behaviour of the PWM framework independant
> of the backend used, it must not be the driver who decides if a request
> is "close enough". We need a defined policy. And then it is obvious to
> me that this policy must be implemented in a way that it is in fact the
> consumer who has to decide which settings are ok and which are not. And
> then rounding without limit is the easiest to work with.
> 
> > However, ignoring period settings because the controller supports only a
> > fixed period seems a bit of an extreme.  
> 
> So the setting I want is:
> 
> 	if (request.period < HW_PERIOD)
> 		fail();
> 		
> and with the reasoning above, that's the only sensible thing (apart from
> the revered policy of rounding up and so failing for requested periods
> that are bigger than the implementable period).

One dumb question that I still have is: besides any backward
compatibility aspects, do we really care about the period/frequency of
the PWM? Why do we enforce a period and an active duration, while
we could limit ourselves to a ratio and let the driver use the most
suitable frequency if the hardware supports it?


This is purely a theoretical question, I am not requesting any API
changes.

Cheers,
Miquèl
