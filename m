Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5AD2142DEF
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATOpC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 09:45:02 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36333 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgATOpC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 09:45:02 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1itYIV-00017T-5f; Mon, 20 Jan 2020 15:44:59 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1itYIT-00027X-UE; Mon, 20 Jan 2020 15:44:57 +0100
Date:   Mon, 20 Jan 2020 15:44:57 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200120144457.eznywc423ehw6kuc@pengutronix.de>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
 <20200120121329.GC206171@ulmo>
 <20200120134137.54dc307e@xps13>
 <20200120141944.GD206171@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200120141944.GD206171@ulmo>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Thierry,

On Mon, Jan 20, 2020 at 03:19:44PM +0100, Thierry Reding wrote:
> On Mon, Jan 20, 2020 at 01:41:37PM +0100, Miquel Raynal wrote:
> > Hi Thierry,
> > 
> > Thanks for reviewing,
> > 
> > > > +static bool max7313_pwm_reg_is_accessible(struct device *dev, unsigned int reg)
> > > > +{
> > > > +	struct pca953x_chip *chip = dev_get_drvdata(dev);
> > > > +	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
> > > > +
> > > > +	if (reg >= MAX7313_MASTER && reg < (MAX7313_INTENSITY + bank_sz))
> > > > +		return true;
> > > > +
> > > > +	return false;
> > > > +}
> > > > +
> > > >  static bool pca953x_readable_register(struct device *dev, unsigned int reg)
> > > >  {
> > > >  	struct pca953x_chip *chip = dev_get_drvdata(dev);
> > > >  	u32 bank;
> > > >  
> > > > +	if ((chip->driver_data & MAX_PWM) &&
> > > > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > > > +		return true;  
> > > 
> > > This doesn't look correct. The MAX_PWM flag doesn't signify that all
> > > GPIOs are used in PWM mode, right? So the above check would return true
> > > even if you're trying to access GPIO registers on a chip that has PWM
> > > support.
> > 
> > Not exactly: this part returns true only if we are using a chip with
> > PWM and we are accessing PWM registers.
> > 
> > Otherwise, for instance if we are accessing GPIO registers, this will
> > not return anything.
> > 
> > > 
> > > I think you still want to proceed with the checks below if reg doesn't
> > > match any of the PWM related registers.
> > 
> > This is precisely what we do here. See the
> > max7313_pwm_reg_is_accessible helper above: only the PWM registers are
> > checked, I suppose this is the part you missed.
> 
> No idea what I missed, but on a second look, yes, you're absolutely
> right.
> 
> > > So it'd be something more along
> > > these lines:
> > > 
> > > 	if ((chip->driver_data & MAX_PWM) &&
> > > 	    !max7313_pwm_reg_is_accessible(dev, reg))
> > > 		return false;
> > > 
> > > > +
> > > >  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> > > >  		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
> > > >  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> > > > @@ -267,6 +318,10 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
> > > >  	struct pca953x_chip *chip = dev_get_drvdata(dev);
> > > >  	u32 bank;
> > > >  
> > > > +	if ((chip->driver_data & MAX_PWM) &&
> > > > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > > > +		return true;  
> > > 
> > > Same here.
> > > 
> > > > +
> > > >  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> > > >  		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
> > > >  			PCA953x_BANK_CONFIG;
> > > > @@ -855,6 +910,335 @@ static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
> > > >  	return ret;
> > > >  }
> > > >  
> > 
> > [...]
> > 
> > > > +static void max7313_pwm_free(struct pwm_chip *chip,
> > > > +			     struct pwm_device *pwm)
> > > > +{
> > > > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm);
> > > > +
> > > > +	gpiochip_free_own_desc(data->desc);
> > > > +	kfree(data);
> > > > +}
> > > > +
> > > > +static int max7313_pwm_apply(struct pwm_chip *chip,
> > > > +			     struct pwm_device *pwm,
> > > > +			     const struct pwm_state *state)
> > > > +{
> > > > +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > > > +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > > > +	unsigned int intensity, active;
> > > > +	int ret = 0;
> > > > +
> > > > +	if (!state->enabled ||
> > > > +	    state->period < PWM_PERIOD_NS ||  
> > > 
> > > I think you should actually make this a != so that you refuse any
> > > attempt to change the period, since you can't do it anyway.
> > 
> > Actually we discussed this with Uwe, see the below snippet:
> > 
> > ---8<---
> > > > > +	if (state->period != PWM_PERIOD_NS ||
> > > > > +	    state->polarity != PWM_POLARITY_NORMAL)
> > > > > +		return -EINVAL;    
> > > > 
> > > > The check for period is too strong. Anything bigger than PWM_PERIOD_NS
> > > > is acceptable, too. (The policy I'd like to see is: Provide the biggest
> > > > period possible not bigger than the requested policy.)  
> > > 
> > > I don't understand, what is this parameter supposed to mean? the period
> > > cannot be changed, it is ruled by an internal oscillator. In this case
> > > any period bigger than the actual period cannot be physically achieved.
> > > If we derive ratios with a bigger period than possible, why not
> > > allowing it for lower periods too?  
> > 
> > Yes, I understood that the period is fixed for your PWM. However
> > consider a consumer who would prefer a different period. If you decline
> > all requests unless state->period == PWM_PERIOD_NS the consumer has no
> > guide to determine that unless all periods are tested. If however asking
> > for period = 2s results in getting 31.25 ms this allows the consumer to
> > assume that no period setting between 2s and 31.25 ms is possible. And
> > so the usual policy to implement is as stated in my previous mail.
> > --->8---
> 
> I think I understand what Uwe is getting at, but I don't think we should
> lie to consumers. It's true that in some cases the drivers will silently
> use a slightly different period if they can't match the one requested,
> but I don't think that's a good thing. Most of the time in those drivers
> the computed period that the controller can support is "close enough".
> 
> But in this case the controller doesn't support anything other than the
> one period, so I don't think accepting anything other than that is good
> for any consumer.
> 
> Also, typically this doesn't really matter because this will have been
> defined in device tree and if the device tree has the wrong period, then
> this should already be caught before the buggy DTS is upstreamed.
> 
> So, I agree that the current situation is not ideal and perhaps we
> should enforce stronger requirements for accuracy. I suspect that a good
> solution would be for the drivers to report back the state that would've
> been applied without actually applying it (kind of like the semantics of
> clk_round_rate() from the common clock framework). That would give users
> a good way of checking whether the supported parameters are within the
> desired range before applying them. For consumers that don't care all
> that much about precision, they can feel free to ignore any differences
> between what they asked and what they got, and most of the time that
> will be fine.

Yeah, it's something like clk_round_rate that I want in the end. And to
make it actually workable the IMHO only sane approach is to allow
rounding in one direction without limit. And as pwm_apply_state() should
be consistent with pwm_round_state() the former must round without
limit, too.

And if you want to require that a consumer of a PWM that only supports a
single period setting passes that period, how do you want to handle the
situation if this period happens to be 2000/3 ns. Is it ok to pass
.period = 666? Is it ok to pass 667?

> In many cases it doesn't matter because the period is defined in DT and
> is hand-picked to be among the ones supported by the controller, or the
> small differences between the period in DT and the closest one supported
> by the controller is not significant and things will just work.

In my eyes to get a uniform behaviour of the PWM framework independant
of the backend used, it must not be the driver who decides if a request
is "close enough". We need a defined policy. And then it is obvious to
me that this policy must be implemented in a way that it is in fact the
consumer who has to decide which settings are ok and which are not. And
then rounding without limit is the easiest to work with.

> However, ignoring period settings because the controller supports only a
> fixed period seems a bit of an extreme.

So the setting I want is:

	if (request.period < HW_PERIOD)
		fail();
		
and with the reasoning above, that's the only sensible thing (apart from
the revered policy of rounding up and so failing for requested periods
that are bigger than the implementable period).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
