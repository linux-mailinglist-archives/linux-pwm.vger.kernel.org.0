Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 007C4242E11
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 19:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgHLRg7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Wed, 12 Aug 2020 13:36:59 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57837 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgHLRg6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 13:36:58 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 7DD121C0004;
        Wed, 12 Aug 2020 17:36:55 +0000 (UTC)
Date:   Wed, 12 Aug 2020 19:36:53 +0200
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
Subject: Re: [PATCH v6] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20200812193653.27953c51@xps13>
In-Reply-To: <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
References: <20200503105453.23658-1-miquel.raynal@bootlin.com>
        <20200703145313.vwjsh5crdqx2u76a@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Uwe,

Thanks for the review!

Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote on Fri, 3 Jul
2020 16:53:13 +0200:

> Hello Miquel,
> 
> On Sun, May 03, 2020 at 12:54:53PM +0200, Miquel Raynal wrote:
> > +static u8 max7313_pwm_get_intensity(struct pca953x_chip *pca_chip,
> > +				    unsigned int idx)
> > +{
> > +	struct device *dev = &pca_chip->client->dev;
> > +	unsigned int reg, shift, val, output;
> > +	u8 intensity;
> > +	bool phase;
> > +	int ret;
> > +
> > +	/* Retrieve the intensity */
> > +	reg = MAX7313_INTENSITY + (idx / PWM_PER_REG);
> > +	shift = (idx % PWM_PER_REG) ? PWM_BITS_PER_REG : 0;  
> 
> I would find
> 
> 	shift = (idx % PWM_PER_REG) * PWM_BITS_PER_REG
> 
> more natural here as your formula only works for PWM_PER_REG = 2.

Understood.

> 
> > +	mutex_lock(&pca_chip->i2c_lock);
> > +	ret = regmap_read(pca_chip->regmap, reg, &val);
> > +	mutex_unlock(&pca_chip->i2c_lock);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Cannot retrieve PWM intensity (%d)\n", ret);  
> 
> Please use %pe for error codes.

Fine, fixed at three relevant locations.

> 
> > +		return 0;
> > +	}
> > +
> > +	val >>= shift;
> > +	val &= PWM_INTENSITY_MASK;
> > +
> > +	/* Retrieve the phase */
> > +	reg = pca953x_recalc_addr(pca_chip, pca_chip->regs->output, idx, 0, 0);
> > +
> > +	mutex_lock(&pca_chip->i2c_lock);
> > +	ret = regmap_read(pca_chip->regmap, reg, &output);
> > +	mutex_unlock(&pca_chip->i2c_lock);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Cannot retrieve PWM phase (%d)\n", ret);
> > +		return 0;
> > +	}
> > +
> > +	phase = output & BIT(idx % BANK_SZ);  
> 
> Would it make sense to cache the phase value to reduce register access
> and locking here?

I suppose it could be done and would certainly reduce register access a
little bit but it means refactoring quite some code and as I'm not near
the board to actually test these changes right now I fear to do
something wrong. Instead, I'd prefer not to touch that part, and let
users that would need this enhancement do it themselves if you don't
mind.

> 
> > [...]
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
> > +	    state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EINVAL;  
> 
> You could simulate state->enabled = false using duty_cycle = 0.

Absolutely!

> 
> > +	/* Convert the duty-cycle to be in the [0;16] range */
> > +	intensity = max7313_pwm_duty_to_intensity(state->duty_cycle);  
> 
> This might return a value > 16 if state->duty_cycle > PWM_PERIOD_NS.
> I suggest to do
> 
> 	duty_cycle = min(state->duty_cycle, PWM_PERIOD_NS);
> 
> and use that value instead of state->duty_cycle.

Done.

> 
> > +	/*
> > +	 * The hardware is supposedly glitch-free when changing the intensity,
> > +	 * unless we need to flip the blink phase to reach an extremity or the
> > +	 * other of the spectrum (0/16 from phase 1, 16/16 from phase 0).  
> 
> s/other of/other end of/. I don't understand the difference between
> extremity and "other end of the spectrum".

Fixed.

> 
> > +	 */
> > +	return max7313_pwm_set_state(pca_chip, pwm, intensity);
> > +}
> > +
> > +static void max7313_pwm_get_state(struct pwm_chip *chip,
> > +				  struct pwm_device *pwm,
> > +				  struct pwm_state *state)
> > +{
> > +	struct max7313_pwm *max_pwm = to_max7313_pwm(chip);
> > +	struct pca953x_chip *pca_chip = to_pca953x(max_pwm);
> > +	u8 intensity;
> > +
> > +	state->enabled = true;
> > +	state->period = PWM_PERIOD_NS;
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	intensity = max7313_pwm_get_intensity(pca_chip, pwm->hwpwm);
> > +	state->duty_cycle = max7313_pwm_intensity_to_duty(intensity);  
> 
> Please round up the division in max7313_pwm_intensity_to_duty().

I understand the use case, done as well.

I will respin a compile tested version rebased on top of current master
(which includes Linus-W GPIO-5.9-1 merge request).

Thanks,
Miquèl
