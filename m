Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0341035CEC9
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244911AbhDLQtK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 12:49:10 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:33030 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344474AbhDLQkD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Apr 2021 12:40:03 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 28D09C725C8;
        Mon, 12 Apr 2021 18:39:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618245582;
        bh=hWy1bUUT9xmtwmAaV3Xfr3hGg5KOcgwBSzPee7KdCQ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TOcxj+nNG6tdQF/+Ibg3t/ekaqPfydIJTt+KWRKqqfMHLa+Btr29UVhUcPuGH0SJd
         ixfQqNWpSm2rTb6qLzC8nGdAKq2/y8qxdp7H+DImHL/SE6Exihc+gV9j3Cpu4TNMXb
         S/j1cpRXp8c7dODxK272UNT2ljsIBVwTMCMGWxOs=
Date:   Mon, 12 Apr 2021 18:39:28 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YHR3wP4Fk3jidnri@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Apr 12, 2021 at 06:18:08PM +0200, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> > The switch to the atomic API goes hand in hand with a few fixes to
> > previously experienced issues:
> > - The duty cycle is no longer lost after disable/enable (previously the
> >   OFF registers were cleared in disable and the user was required to
> >   call config to restore the duty cycle settings)
> > - If one sets a period resulting in the same prescale register value,
> >   the sleep and write to the register is now skipped
> > - Previously, only the full ON bit was toggled in GPIO mode (and full
> >   OFF cleared if set to high), which could result in both full OFF and
> >   full ON not being set and on=0, off=0, which is not allowed according
> >   to the datasheet
> > - The OFF registers were reset to 0 in probe, which could lead to the
> >   forbidden on=0, off=0. Fixed by resetting to POR default (full OFF)
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
> > Changes since v7:
> > - Moved check for !state->enabled before prescaler configuration
> > - Removed unnecessary cast
> > - Use DIV_ROUND_DOWN in .apply
> > 
> > Changes since v6:
> > - Order of a comparison switched for improved readability
> > 
> > Changes since v5:
> > - Function documentation for set_duty
> > - Variable initializations
> > - Print warning if all LEDs channel
> > - Changed EOPNOTSUPP to EINVAL
> > - Improved error messages
> > - Register reset corrections moved to this patch
> > 
> > Changes since v4:
> > - Patches split up
> > - Use a single set_duty function
> > - Improve readability / new macros
> > - Added a patch to restrict prescale changes to the first user
> > 
> > Changes since v3:
> > - Refactoring: Extracted common functions
> > - Read prescale register value instead of caching it
> > - Return all zeros and disabled for "all LEDs" channel state
> > - Improved duty calculation / mapping to 0..4096
> > 
> > Changes since v2:
> > - Always set default prescale value in probe
> > - Simplified probe code
> > - Inlined functions with one callsite
> > 
> > Changes since v1:
> > - Fixed a logic error
> > - Impoved PM runtime handling and fixed !CONFIG_PM
> > - Write default prescale reg value if invalid in probe
> > - Reuse full_off/_on functions throughout driver
> > - Use cached prescale value whenever possible
> > 
> >  drivers/pwm/pwm-pca9685.c | 259 +++++++++++++-------------------------
> >  1 file changed, 89 insertions(+), 170 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 4a55dc18656c..827b57ced3c2 100644
> > --- a/drivers/pwm/pwm-pca9685.c
> > +++ b/drivers/pwm/pwm-pca9685.c
> > @@ -51,7 +51,6 @@
> >  #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
> >  
> >  #define PCA9685_COUNTER_RANGE	4096
> > -#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns = 1/200 Hz */
> >  #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
> >  
> >  #define PCA9685_NUMREGS		0xFF
> > @@ -71,10 +70,14 @@
> >  #define LED_N_OFF_H(N)	(PCA9685_LEDX_OFF_H + (4 * (N)))
> >  #define LED_N_OFF_L(N)	(PCA9685_LEDX_OFF_L + (4 * (N)))
> >  
> > +#define REG_ON_H(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_H : LED_N_ON_H((C)))
> > +#define REG_ON_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_L : LED_N_ON_L((C)))
> > +#define REG_OFF_H(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H : LED_N_OFF_H((C)))
> > +#define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
> 
> I'd like to see these named PCA9685_REG_ON_H etc.

I did not use the prefix because the existing LED_N_ON/OFF_H/L also do
not have a prefix. If the prefix is mandatory, I think LED_N_.. should
also be prefixed, right?

> 
> >  struct pca9685 {
> >  	struct pwm_chip chip;
> >  	struct regmap *regmap;
> > -	int period_ns;
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> >  	struct mutex lock;
> >  	struct gpio_chip gpio;
> > @@ -87,6 +90,51 @@ static inline struct pca9685 *to_pca(struct pwm_chip *chip)
> >  	return container_of(chip, struct pca9685, chip);
> >  }
> >  
> > +/* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
> > +static void pca9685_pwm_set_duty(struct pca9685 *pca, int channel, unsigned int duty)
> > +{
> > +	if (duty == 0) {
> > +		/* Set the full OFF bit, which has the highest precedence */
> > +		regmap_write(pca->regmap, REG_OFF_H(channel), LED_FULL);
> > +	} else if (duty >= PCA9685_COUNTER_RANGE) {
> > +		/* Set the full ON bit and clear the full OFF bit */
> > +		regmap_write(pca->regmap, REG_ON_H(channel), LED_FULL);
> > +		regmap_write(pca->regmap, REG_OFF_H(channel), 0);
> > +	} else {
> > +		/* Set OFF time (clears the full OFF bit) */
> > +		regmap_write(pca->regmap, REG_OFF_L(channel), duty & 0xff);
> > +		regmap_write(pca->regmap, REG_OFF_H(channel), (duty >> 8) & 0xf);
> > +		/* Clear the full ON bit */
> > +		regmap_write(pca->regmap, REG_ON_H(channel), 0);
> > +	}
> > +}
> > +
> > +static unsigned int pca9685_pwm_get_duty(struct pca9685 *pca, int channel)
> > +{
> > +	unsigned int off_h = 0, val = 0;
> > +
> > +	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
> > +		/* HW does not support reading state of "all LEDs" channel */
> > +		return 0;
> > +	}
> > +
> > +	regmap_read(pca->regmap, LED_N_OFF_H(channel), &off_h);
> > +	if (off_h & LED_FULL) {
> > +		/* Full OFF bit is set */
> > +		return 0;
> > +	}
> > +
> > +	regmap_read(pca->regmap, LED_N_ON_H(channel), &val);
> > +	if (val & LED_FULL) {
> > +		/* Full ON bit is set */
> > +		return PCA9685_COUNTER_RANGE;
> > +	}
> > +
> > +	val = 0;
> > +	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> 
> I asked in the last round why you initialize val. You answered "just to
> have it set to 0 in case regmap_read fails / val was not set." I wonder
> if
> 
> 	ret = regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> 	if (!ret)
> 		/* 
> 		val = 0
> 
> would be better then and also make the intention obvious.

I am not sure if that's more clear, but if others find it more obvious
like this, I can change it.

> 
> > +	return ((off_h & 0xf) << 8) | (val & 0xff);
> > +}
> > +
> >  #if IS_ENABLED(CONFIG_GPIOLIB)
> >  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
> >  {
> > @@ -138,34 +186,23 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
> >  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
> >  {
> >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> > -	struct pwm_device *pwm = &pca->chip.pwms[offset];
> > -	unsigned int value;
> >  
> > -	regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
> > -
> > -	return value & LED_FULL;
> > +	return pca9685_pwm_get_duty(pca, offset) != 0;
> >  }
> >  
> >  static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
> >  				 int value)
> >  {
> >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> > -	struct pwm_device *pwm = &pca->chip.pwms[offset];
> > -	unsigned int on = value ? LED_FULL : 0;
> > -
> > -	/* Clear both OFF registers */
> > -	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
> > -	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
> >  
> > -	/* Set the full ON bit */
> > -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
> > +	pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
> >  }
> >  
> >  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
> >  {
> >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> >  
> > -	pca9685_pwm_gpio_set(gpio, offset, 0);
> > +	pca9685_pwm_set_duty(pca, offset, 0);
> >  	pm_runtime_put(pca->chip.dev);
> >  	pca9685_pwm_clear_inuse(pca, offset);
> >  }
> > @@ -246,167 +283,52 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
> >  	}
> >  }
> >  
> > -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > -			      int duty_ns, int period_ns)
> > +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > +			     const struct pwm_state *state)
> >  {
> >  	struct pca9685 *pca = to_pca(chip);
> > -	unsigned long long duty;
> > -	unsigned int reg;
> > -	int prescale;
> > -
> > -	if (period_ns != pca->period_ns) {
> > -		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
> > -					     PCA9685_COUNTER_RANGE * 1000) - 1;
> > -
> > -		if (prescale >= PCA9685_PRESCALE_MIN &&
> > -			prescale <= PCA9685_PRESCALE_MAX) {
> > -			/*
> > -			 * Putting the chip briefly into SLEEP mode
> > -			 * at this point won't interfere with the
> > -			 * pm_runtime framework, because the pm_runtime
> > -			 * state is guaranteed active here.
> > -			 */
> > -			/* Put chip into sleep mode */
> > -			pca9685_set_sleep_mode(pca, true);
> > -
> > -			/* Change the chip-wide output frequency */
> > -			regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> > -
> > -			/* Wake the chip up */
> > -			pca9685_set_sleep_mode(pca, false);
> > -
> > -			pca->period_ns = period_ns;
> > -		} else {
> > -			dev_err(chip->dev,
> > -				"prescaler not set: period out of bounds!\n");
> > -			return -EINVAL;
> > -		}
> > -	}
> > +	unsigned long long duty, prescale;
> > +	unsigned int val = 0;
> >  
> > -	if (duty_ns < 1) {
> > -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -			reg = PCA9685_ALL_LED_OFF_H;
> > -		else
> > -			reg = LED_N_OFF_H(pwm->hwpwm);
> > +	if (state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EINVAL;
> >  
> > -		regmap_write(pca->regmap, reg, LED_FULL);
> > -
> > -		return 0;
> > +	prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
> > +					 PCA9685_COUNTER_RANGE * 1000) - 1;
> > +	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
> > +		dev_err(chip->dev, "pwm not changed: period out of bounds!\n");
> > +		return -EINVAL;
> >  	}
> >  
> > -	if (duty_ns == period_ns) {
> > -		/* Clear both OFF registers */
> > -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -			reg = PCA9685_ALL_LED_OFF_L;
> > -		else
> > -			reg = LED_N_OFF_L(pwm->hwpwm);
> > -
> > -		regmap_write(pca->regmap, reg, 0x0);
> > -
> > -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -			reg = PCA9685_ALL_LED_OFF_H;
> > -		else
> > -			reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -		regmap_write(pca->regmap, reg, 0x0);
> > -
> > -		/* Set the full ON bit */
> > -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -			reg = PCA9685_ALL_LED_ON_H;
> > -		else
> > -			reg = LED_N_ON_H(pwm->hwpwm);
> > -
> > -		regmap_write(pca->regmap, reg, LED_FULL);
> > -
> > +	if (!state->enabled) {
> > +		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> >  		return 0;
> >  	}
> >  
> > -	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> > -	duty = DIV_ROUND_UP_ULL(duty, period_ns);
> > -
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_OFF_L;
> > -	else
> > -		reg = LED_N_OFF_L(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, (int)duty & 0xff);
> > -
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_OFF_H;
> > -	else
> > -		reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
> > -
> > -	/* Clear the full ON bit, otherwise the set OFF time has no effect */
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_ON_H;
> > -	else
> > -		reg = LED_N_ON_H(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, 0);
> > -
> > -	return 0;
> > -}
> > -
> > -static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> > -{
> > -	struct pca9685 *pca = to_pca(chip);
> > -	unsigned int reg;
> > -
> > -	/*
> > -	 * The PWM subsystem does not support a pre-delay.
> > -	 * So, set the ON-timeout to 0
> > -	 */
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_ON_L;
> > -	else
> > -		reg = LED_N_ON_L(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, 0);
> > -
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_ON_H;
> > -	else
> > -		reg = LED_N_ON_H(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, 0);
> > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > +	if (prescale != val) {
> > +		/*
> > +		 * Putting the chip briefly into SLEEP mode
> > +		 * at this point won't interfere with the
> > +		 * pm_runtime framework, because the pm_runtime
> > +		 * state is guaranteed active here.
> > +		 */
> > +		/* Put chip into sleep mode */
> > +		pca9685_set_sleep_mode(pca, true);
> >  
> > -	/*
> > -	 * Clear the full-off bit.
> > -	 * It has precedence over the others and must be off.
> > -	 */
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_OFF_H;
> > -	else
> > -		reg = LED_N_OFF_H(pwm->hwpwm);
> > +		/* Change the chip-wide output frequency */
> > +		regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> >  
> > -	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> > +		/* Wake the chip up */
> > +		pca9685_set_sleep_mode(pca, false);
> > +	}
> >  
> > +	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
> > +	duty = DIV_ROUND_DOWN_ULL(duty, state->period);
> 
> If you round down here you should probably also round down in the
> calculation of prescale. Also note that you're losing precision by using
> state->period.
> 
> Consider the following request: state->period = 4177921 [ns] +
> state->duty_cycle = 100000 [ns], then we get
> PRESCALE = round(25 * state->period / 4096000) - 1 = 25 and so an actual
> period of 4096000 / 25 * (25 + 1) = 4259840 [ns]. If you now calculate
> the duty using 4096 * 100000 / 4177920 = 98, this corresponds to an
> actual duty cycle of 98 * 4259840 / 4096 = 101920 ns while you should
> actually configure 96 to get 99840 ns.
> 
> So in the end I'd like to have the following:
> 
> 	PRESCALE = round-down(25 * state->period / 4096000) - 1
> 
> (to get the biggest period not bigger than state->period) and
> 
> 	duty = round-down(state->duty_cycle * 25 / ((PRESCALE + 1) * 1000))
> 
> (to get the biggest duty cycle not bigger than state->duty_cycle). With
> the example above this yields
> 
> 	PRESCALE = 24
> 	duty = 100
> 
> which results in
> 
> 	.period = 4096000 / 25 * 25 = 4096000 [ns]
> 	.duty_cycle = 100000 [ns]
> 	
> Now you have a mixture of old and new with no consistent behaviour. So
> please either stick to the old behaviour or do it right immediately.

I avoided rounding down the prescale value because the datasheet has an
example where a round-closest is used, see page 25.

With your suggested round-down, the example with frequency of 200 Hz
would no longer result in 30 but 29 and that contradicts the datasheet.

So would you rather have me keep the old duty rounding behaviour?
Meaning: Keep rounding up the duty calculation in apply and use
round-down in the new .get_state function?

Thanks,
Clemens
