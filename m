Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D17D3142B0E
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 13:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbgATMll convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Mon, 20 Jan 2020 07:41:41 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:57615 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbgATMll (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 07:41:41 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 80D38FF802;
        Mon, 20 Jan 2020 12:41:38 +0000 (UTC)
Date:   Mon, 20 Jan 2020 13:41:37 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200120134137.54dc307e@xps13>
In-Reply-To: <20200120121329.GC206171@ulmo>
References: <20200107133130.1338-1-miquel.raynal@bootlin.com>
        <20200120121329.GC206171@ulmo>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

Thanks for reviewing,

> > +static bool max7313_pwm_reg_is_accessible(struct device *dev, unsigned int reg)
> > +{
> > +	struct pca953x_chip *chip = dev_get_drvdata(dev);
> > +	unsigned int bank_sz = chip->driver_data & PCA_GPIO_MASK;
> > +
> > +	if (reg >= MAX7313_MASTER && reg < (MAX7313_INTENSITY + bank_sz))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> >  static bool pca953x_readable_register(struct device *dev, unsigned int reg)
> >  {
> >  	struct pca953x_chip *chip = dev_get_drvdata(dev);
> >  	u32 bank;
> >  
> > +	if ((chip->driver_data & MAX_PWM) &&
> > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > +		return true;  
> 
> This doesn't look correct. The MAX_PWM flag doesn't signify that all
> GPIOs are used in PWM mode, right? So the above check would return true
> even if you're trying to access GPIO registers on a chip that has PWM
> support.

Not exactly: this part returns true only if we are using a chip with
PWM and we are accessing PWM registers.

Otherwise, for instance if we are accessing GPIO registers, this will
not return anything.

> 
> I think you still want to proceed with the checks below if reg doesn't
> match any of the PWM related registers.

This is precisely what we do here. See the
max7313_pwm_reg_is_accessible helper above: only the PWM registers are
checked, I suppose this is the part you missed.

> So it'd be something more along
> these lines:
> 
> 	if ((chip->driver_data & MAX_PWM) &&
> 	    !max7313_pwm_reg_is_accessible(dev, reg))
> 		return false;
> 
> > +
> >  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> >  		bank = PCA953x_BANK_INPUT | PCA953x_BANK_OUTPUT |
> >  		       PCA953x_BANK_POLARITY | PCA953x_BANK_CONFIG;
> > @@ -267,6 +318,10 @@ static bool pca953x_writeable_register(struct device *dev, unsigned int reg)
> >  	struct pca953x_chip *chip = dev_get_drvdata(dev);
> >  	u32 bank;
> >  
> > +	if ((chip->driver_data & MAX_PWM) &&
> > +	    max7313_pwm_reg_is_accessible(dev, reg))
> > +		return true;  
> 
> Same here.
> 
> > +
> >  	if (PCA_CHIP_TYPE(chip->driver_data) == PCA953X_TYPE) {
> >  		bank = PCA953x_BANK_OUTPUT | PCA953x_BANK_POLARITY |
> >  			PCA953x_BANK_CONFIG;
> > @@ -855,6 +910,335 @@ static int device_pca957x_init(struct pca953x_chip *chip, u32 invert)
> >  	return ret;
> >  }
> >  

[...]

> > +static void max7313_pwm_free(struct pwm_chip *chip,
> > +			     struct pwm_device *pwm)
> > +{
> > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm);
> > +
> > +	gpiochip_free_own_desc(data->desc);
> > +	kfree(data);
> > +}
> > +
> > +static int max7313_pwm_apply(struct pwm_chip *chip,
> > +			     struct pwm_device *pwm,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > +	unsigned int intensity, active;
> > +	int ret = 0;
> > +
> > +	if (!state->enabled ||
> > +	    state->period < PWM_PERIOD_NS ||  
> 
> I think you should actually make this a != so that you refuse any
> attempt to change the period, since you can't do it anyway.

Actually we discussed this with Uwe, see the below snippet:

---8<---
> > > +	if (state->period != PWM_PERIOD_NS ||
> > > +	    state->polarity != PWM_POLARITY_NORMAL)
> > > +		return -EINVAL;    
> > 
> > The check for period is too strong. Anything bigger than PWM_PERIOD_NS
> > is acceptable, too. (The policy I'd like to see is: Provide the biggest
> > period possible not bigger than the requested policy.)  
> 
> I don't understand, what is this parameter supposed to mean? the period
> cannot be changed, it is ruled by an internal oscillator. In this case
> any period bigger than the actual period cannot be physically achieved.
> If we derive ratios with a bigger period than possible, why not
> allowing it for lower periods too?  

Yes, I understood that the period is fixed for your PWM. However
consider a consumer who would prefer a different period. If you decline
all requests unless state->period == PWM_PERIOD_NS the consumer has no
guide to determine that unless all periods are tested. If however asking
for period = 2s results in getting 31.25 ms this allows the consumer to
assume that no period setting between 2s and 31.25 ms is possible. And
so the usual policy to implement is as stated in my previous mail.
--->8---

> 
> > +	    state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> > +
> > +	/* Convert the duty-cycle to be in the [0;16] range */
> > +	intensity = max7313_pwm_duty_to_intensity(state->duty_cycle);
> > +

[...]

> > @@ -1130,7 +1522,7 @@ static const struct of_device_id pca953x_dt_ids[] = {
> >  
> >  	{ .compatible = "maxim,max7310", .data = OF_953X( 8, 0), },
> >  	{ .compatible = "maxim,max7312", .data = OF_953X(16, PCA_INT), },
> > -	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT), },
> > +	{ .compatible = "maxim,max7313", .data = OF_953X(16, PCA_INT | MAX_PWM), },
> >  	{ .compatible = "maxim,max7315", .data = OF_953X( 8, PCA_INT), },
> >  	{ .compatible = "maxim,max7318", .data = OF_953X(16, PCA_INT), },  
> 
> Aren't you missing a call to pwmchip_remove() somewhere? Otherwise once
> you unload the driver, the PWM chip will become dangling and any attempt
> to access its PWMs will crash.

That's true, I'll correct.


Thanks,
Miquèl
