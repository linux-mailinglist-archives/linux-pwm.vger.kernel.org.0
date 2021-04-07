Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65501356533
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Apr 2021 09:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbhDGH0h (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Apr 2021 03:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhDGH0f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Apr 2021 03:26:35 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D888C06174A;
        Wed,  7 Apr 2021 00:26:25 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 98073C6B24A;
        Wed,  7 Apr 2021 09:26:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617780383;
        bh=gSdkUT7mhlmJKM0rDKP57cj2J9eOROBbQRw/XQnVIXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g5S2Z+ikm5cVfl/yTm8yVx+T7Qd9T+tEp4XlW3g2N0D75cL26mfshQDdPHcZ4t+yd
         xLdYEdl++/4KWxO9fPrxv6UYc1v4XPbFm+0hYff4mk7IyLOilj7jj77BcYz+Y8CmEz
         GWCngB/PhDY3iKaGKTMU6vGB8u4p3j5DdGNm7ZSE=
Date:   Wed, 7 Apr 2021 09:26:21 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YG1enUUCCf11wjGB@workstation.tuxnet>
References: <20210406164140.81423-1-clemens.gruber@pqgruber.com>
 <20210407052428.4hkzzqtitpq7zzc5@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210407052428.4hkzzqtitpq7zzc5@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Wed, Apr 07, 2021 at 07:24:28AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Apr 06, 2021 at 06:41:33PM +0200, Clemens Gruber wrote:
> > The switch to the atomic API goes hand in hand with a few fixes to
> > previously experienced issues:
> > - The duty cycle is no longer lost after disable/enable (previously the
> >   OFF registers were cleared in disable and the user was required to
> >   call config to restore the duty cycle settings)
> > - If one sets a period resulting in the same prescale register value,
> >   the sleep and write to the register is now skipped
> > 
> > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > ---
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
> >  drivers/pwm/pwm-pca9685.c | 261 ++++++++++++++------------------------
> >  1 file changed, 92 insertions(+), 169 deletions(-)
> > 
> > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > index 4a55dc18656c..5a2ce97e71fd 100644
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
> > +
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
> 
> Why do you set val to 0 first? Do you get a compiler warning otherwise?

No, just to have it set to 0 in case regmap_read fails / val was not
set.

> 
> > +	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
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
> 
> Is this a relevant bug fix? If both OFF_H.FULL and ON_H.FULL are set,
> the output is low and this was diagnosed before as high.

Yes, I think so.
Previously, only the full ON bit was toggled (and full OFF cleared if
set to high), which could result in both full OFF and full ON not being
set and on=0, off=0, which is not allowed according to the datasheet.

I should probably mention it in the commit description.

> 
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
> 
> Orthogonal to your patch:
> I don't know the customs of GPIO drivers enough, but I wonder that
> .free() results in setting the value of the GPIO?!

Yeah. I am not sure about that either, but I kept that as it was before.

> 
> >  	pm_runtime_put(pca->chip.dev);
> >  	pca9685_pwm_clear_inuse(pca, offset);
> >  }
> > @@ -246,167 +283,56 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
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
> 
> Here the multiplication might overflow.  Also if period is small the
> result of the division might be 0 and prescale might end up being -1ULL.
> (But that's a problem that we had already before, so not a stopper for
> this patch.)

We would catch that with prescale > PCA9685_PRESCALE_MAX (below) though.

> 
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
> > +	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
> > +	duty = DIV_ROUND_CLOSEST_ULL(duty, state->period);
> 
> Here we're losing precision. In general calculating the duty should be
> done using time, not period counter values. (Again, that's an old
> problem.)
> 
> >  
> > +	if (duty < 1 || !state->enabled) {
> > +		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> > +		return 0;
> > +	} else if (duty == PCA9685_COUNTER_RANGE) {
> > +		pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
> >  		return 0;
> >  	}
> >  
> > -	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> > -	duty = DIV_ROUND_UP_ULL(duty, period_ns);
> 
> Oh, the new implementation uses DIV_ROUND_CLOSEST. IMHO either keep the
> calculations as is, or use the preferred round-down.

I can change that one to round-down if that's the preferred method.

> 
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
> 
> I assume it's a requirement to stop the oscillator when changing the
> prescaler?

Yes.

> 
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
> > +		regmap_write(pca->regmap, PCA9685_PRESCALE, (int)prescale);
> 
> The cast isn't necessary, is it?

You are right, I will remove it.

> 
> > -	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> > +		/* Wake the chip up */
> > +		pca9685_set_sleep_mode(pca, false);
> > +	}
> >  
> > +	pca9685_pwm_set_duty(pca, pwm->hwpwm, duty);
> >  	return 0;
> >  }
> >  
> > -static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> > -{
> > -	struct pca9685 *pca = to_pca(chip);
> > -	unsigned int reg;
> > -
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_OFF_H;
> > -	else
> > -		reg = LED_N_OFF_H(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, LED_FULL);
> > -
> > -	/* Clear the LED_OFF counter. */
> > -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> > -		reg = PCA9685_ALL_LED_OFF_L;
> > -	else
> > -		reg = LED_N_OFF_L(pwm->hwpwm);
> > -
> > -	regmap_write(pca->regmap, reg, 0x0);
> > -}
> > -
> >  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >  	struct pca9685 *pca = to_pca(chip);
> > @@ -422,15 +348,13 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> >  {
> >  	struct pca9685 *pca = to_pca(chip);
> >  
> > -	pca9685_pwm_disable(chip, pwm);
> > +	pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> >  	pm_runtime_put(chip->dev);
> >  	pca9685_pwm_clear_inuse(pca, pwm->hwpwm);
> >  }
> >  
> >  static const struct pwm_ops pca9685_pwm_ops = {
> > -	.enable = pca9685_pwm_enable,
> > -	.disable = pca9685_pwm_disable,
> > -	.config = pca9685_pwm_config,
> > +	.apply = pca9685_pwm_apply,
> >  	.request = pca9685_pwm_request,
> >  	.free = pca9685_pwm_free,
> >  	.owner = THIS_MODULE,
> > @@ -461,7 +385,6 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  			ret);
> >  		return ret;
> >  	}
> > -	pca->period_ns = PCA9685_DEFAULT_PERIOD;
> >  
> >  	i2c_set_clientdata(client, pca);
> >  
> > @@ -484,9 +407,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
> >  	reg &= ~(MODE1_ALLCALL | MODE1_SUB1 | MODE1_SUB2 | MODE1_SUB3);
> >  	regmap_write(pca->regmap, PCA9685_MODE1, reg);
> >  
> > -	/* Clear all "full off" bits */
> > -	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> > -	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> > +	/* Reset OFF registers to POR default */
> > +	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, LED_FULL);
> > +	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);
> 
> Is this hunk unrelated to the patch description?

It's a fix of the resets because the POR state is LED_FULL, not 0.
Do you want me to extract it into a separate patch?

Thanks,
Clemens
