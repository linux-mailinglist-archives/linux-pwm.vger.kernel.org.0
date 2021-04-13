Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8275935DE60
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Apr 2021 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhDMMMD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Apr 2021 08:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239489AbhDMMMB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Apr 2021 08:12:01 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B8C061574;
        Tue, 13 Apr 2021 05:11:41 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 6F570C725C8;
        Tue, 13 Apr 2021 14:11:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618315900;
        bh=eaU+Hd7DMj/xK1WJCEW68pc7WwkmuDgRSDfczue0GGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jwdCypOAV4rz+dgNKzsUqs6F+yelRcGsLHiQ6WqMwSByLxQUaV2TgKDzfYAGRh+Tr
         yt9ZB9ZJ0wwxHzhFuUwt9hvYkej6bpD98IbEBLDF7AupQb8FtggOsaoghYkzPBCabE
         RRgJLHsx9iSzZzD5n44QsVznvqH2cTq2Uilb9pA8=
Date:   Tue, 13 Apr 2021 14:11:38 +0200
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/8] pwm: pca9685: Switch to atomic API
Message-ID: <YHWKehtYFSaHt1hC@workstation.tuxnet>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
 <20210412161808.lp2amdfopw74lvz7@pengutronix.de>
 <YHR3wP4Fk3jidnri@workstation.tuxnet>
 <20210412201019.vouxx4daumusrcvr@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210412201019.vouxx4daumusrcvr@pengutronix.de>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Mon, Apr 12, 2021 at 10:10:19PM +0200, Uwe Kleine-König wrote:
> Hello Clemens,
> 
> On Mon, Apr 12, 2021 at 06:39:28PM +0200, Clemens Gruber wrote:
> > On Mon, Apr 12, 2021 at 06:18:08PM +0200, Uwe Kleine-König wrote:
> > > On Mon, Apr 12, 2021 at 03:27:38PM +0200, Clemens Gruber wrote:
> > > > The switch to the atomic API goes hand in hand with a few fixes to
> > > > previously experienced issues:
> > > > - The duty cycle is no longer lost after disable/enable (previously the
> > > >   OFF registers were cleared in disable and the user was required to
> > > >   call config to restore the duty cycle settings)
> > > > - If one sets a period resulting in the same prescale register value,
> > > >   the sleep and write to the register is now skipped
> > > > - Previously, only the full ON bit was toggled in GPIO mode (and full
> > > >   OFF cleared if set to high), which could result in both full OFF and
> > > >   full ON not being set and on=0, off=0, which is not allowed according
> > > >   to the datasheet
> > > > - The OFF registers were reset to 0 in probe, which could lead to the
> > > >   forbidden on=0, off=0. Fixed by resetting to POR default (full OFF)
> > > > 
> > > > Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> > > > ---
> > > > Changes since v7:
> > > > - Moved check for !state->enabled before prescaler configuration
> > > > - Removed unnecessary cast
> > > > - Use DIV_ROUND_DOWN in .apply
> > > > 
> > > > Changes since v6:
> > > > - Order of a comparison switched for improved readability
> > > > 
> > > > Changes since v5:
> > > > - Function documentation for set_duty
> > > > - Variable initializations
> > > > - Print warning if all LEDs channel
> > > > - Changed EOPNOTSUPP to EINVAL
> > > > - Improved error messages
> > > > - Register reset corrections moved to this patch
> > > > 
> > > > Changes since v4:
> > > > - Patches split up
> > > > - Use a single set_duty function
> > > > - Improve readability / new macros
> > > > - Added a patch to restrict prescale changes to the first user
> > > > 
> > > > Changes since v3:
> > > > - Refactoring: Extracted common functions
> > > > - Read prescale register value instead of caching it
> > > > - Return all zeros and disabled for "all LEDs" channel state
> > > > - Improved duty calculation / mapping to 0..4096
> > > > 
> > > > Changes since v2:
> > > > - Always set default prescale value in probe
> > > > - Simplified probe code
> > > > - Inlined functions with one callsite
> > > > 
> > > > Changes since v1:
> > > > - Fixed a logic error
> > > > - Impoved PM runtime handling and fixed !CONFIG_PM
> > > > - Write default prescale reg value if invalid in probe
> > > > - Reuse full_off/_on functions throughout driver
> > > > - Use cached prescale value whenever possible
> > > > 
> > > >  drivers/pwm/pwm-pca9685.c | 259 +++++++++++++-------------------------
> > > >  1 file changed, 89 insertions(+), 170 deletions(-)
> > > > 
> > > > diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> > > > index 4a55dc18656c..827b57ced3c2 100644
> > > > --- a/drivers/pwm/pwm-pca9685.c
> > > > +++ b/drivers/pwm/pwm-pca9685.c
> > > > @@ -51,7 +51,6 @@
> > > >  #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
> > > >  
> > > >  #define PCA9685_COUNTER_RANGE	4096
> > > > -#define PCA9685_DEFAULT_PERIOD	5000000	/* Default period_ns = 1/200 Hz */
> > > >  #define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
> > > >  
> > > >  #define PCA9685_NUMREGS		0xFF
> > > > @@ -71,10 +70,14 @@
> > > >  #define LED_N_OFF_H(N)	(PCA9685_LEDX_OFF_H + (4 * (N)))
> > > >  #define LED_N_OFF_L(N)	(PCA9685_LEDX_OFF_L + (4 * (N)))
> > > >  
> > > > +#define REG_ON_H(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_H : LED_N_ON_H((C)))
> > > > +#define REG_ON_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_ON_L : LED_N_ON_L((C)))
> > > > +#define REG_OFF_H(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_H : LED_N_OFF_H((C)))
> > > > +#define REG_OFF_L(C)	((C) >= PCA9685_MAXCHAN ? PCA9685_ALL_LED_OFF_L : LED_N_OFF_L((C)))
> > > 
> > > I'd like to see these named PCA9685_REG_ON_H etc.
> > 
> > I did not use the prefix because the existing LED_N_ON/OFF_H/L also do
> > not have a prefix. If the prefix is mandatory, I think LED_N_.. should
> > also be prefixed, right?
> 
> I'd like to seem the prefixed (and assume that Thierry doesn't agree).
> IMHO it's good style and even though it yields longer name usually it
> yields easier understandable code. (But this seems to be subjective.)

I am not sure I want to also rename the existing LED_N_OFF stuff in this
patch. Maybe we can discuss unifying the macros (either with or without
prefix) in a later patch and I keep the REG_ON_ stuff for now without to
match the LED_N_ stuff?

> 
> > > > +	val = 0;
> > > > +	regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > > 
> > > I asked in the last round why you initialize val. You answered "just to
> > > have it set to 0 in case regmap_read fails / val was not set." I wonder
> > > if
> > > 
> > > 	ret = regmap_read(pca->regmap, LED_N_OFF_L(channel), &val);
> > > 	if (!ret)
> > > 		/* 
> 
> I intended to write something like
> 
> 		/* initialize val in case reading LED_N_OFF failed */
> 
> > > 		val = 0
> > > 
> > > would be better then and also make the intention obvious.

Maybe a little bit better.. I can change it.

> > 
> > I am not sure if that's more clear, but if others find it more obvious
> > like this, I can change it.
> > 
> > > 
> > > > +	return ((off_h & 0xf) << 8) | (val & 0xff);
> > > > +}
> > > > +
> > > >  #if IS_ENABLED(CONFIG_GPIOLIB)
> > > >  static bool pca9685_pwm_test_and_set_inuse(struct pca9685 *pca, int pwm_idx)
> > > >  {
> > > > @@ -138,34 +186,23 @@ static int pca9685_pwm_gpio_request(struct gpio_chip *gpio, unsigned int offset)
> > > >  static int pca9685_pwm_gpio_get(struct gpio_chip *gpio, unsigned int offset)
> > > >  {
> > > >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> > > > -	struct pwm_device *pwm = &pca->chip.pwms[offset];
> > > > -	unsigned int value;
> > > >  
> > > > -	regmap_read(pca->regmap, LED_N_ON_H(pwm->hwpwm), &value);
> > > > -
> > > > -	return value & LED_FULL;
> > > > +	return pca9685_pwm_get_duty(pca, offset) != 0;
> > > >  }
> > > >  
> > > >  static void pca9685_pwm_gpio_set(struct gpio_chip *gpio, unsigned int offset,
> > > >  				 int value)
> > > >  {
> > > >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> > > > -	struct pwm_device *pwm = &pca->chip.pwms[offset];
> > > > -	unsigned int on = value ? LED_FULL : 0;
> > > > -
> > > > -	/* Clear both OFF registers */
> > > > -	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0);
> > > > -	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0);
> > > >  
> > > > -	/* Set the full ON bit */
> > > > -	regmap_write(pca->regmap, LED_N_ON_H(pwm->hwpwm), on);
> > > > +	pca9685_pwm_set_duty(pca, offset, value ? PCA9685_COUNTER_RANGE : 0);
> > > >  }
> > > >  
> > > >  static void pca9685_pwm_gpio_free(struct gpio_chip *gpio, unsigned int offset)
> > > >  {
> > > >  	struct pca9685 *pca = gpiochip_get_data(gpio);
> > > >  
> > > > -	pca9685_pwm_gpio_set(gpio, offset, 0);
> > > > +	pca9685_pwm_set_duty(pca, offset, 0);
> > > >  	pm_runtime_put(pca->chip.dev);
> > > >  	pca9685_pwm_clear_inuse(pca, offset);
> > > >  }
> > > > @@ -246,167 +283,52 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
> > > >  	}
> > > >  }
> > > >  
> > > > -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > -			      int duty_ns, int period_ns)
> > > > +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +			     const struct pwm_state *state)
> > > >  {
> > > > [...]
> > > > +	prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
> > > > +					 PCA9685_COUNTER_RANGE * 1000) - 1;
> > > > +	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
> > > > +		dev_err(chip->dev, "pwm not changed: period out of bounds!\n");
> > > > +		return -EINVAL;
> > > >  	}
> > > >  
> > > > [...]
> > > > +	if (!state->enabled) {
> > > > +		pca9685_pwm_set_duty(pca, pwm->hwpwm, 0);
> > > >  		return 0;
> > > >  	}
> > > >  
> > > > [...]
> > > > +	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
> > > > +	if (prescale != val) {
> > > > +		/*
> > > > +		 * Putting the chip briefly into SLEEP mode
> > > > +		 * at this point won't interfere with the
> > > > +		 * pm_runtime framework, because the pm_runtime
> > > > +		 * state is guaranteed active here.
> > > > +		 */
> > > > +		/* Put chip into sleep mode */
> > > > +		pca9685_set_sleep_mode(pca, true);
> > > >  
> > > > [...]
> > > > +		/* Change the chip-wide output frequency */
> > > > +		regmap_write(pca->regmap, PCA9685_PRESCALE, prescale);
> > > >  
> > > > -	regmap_update_bits(pca->regmap, reg, LED_FULL, 0x0);
> > > > +		/* Wake the chip up */
> > > > +		pca9685_set_sleep_mode(pca, false);
> > > > +	}
> > > >  
> > > > +	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
> > > > +	duty = DIV_ROUND_DOWN_ULL(duty, state->period);
> > > 
> > > If you round down here you should probably also round down in the
> > > calculation of prescale. Also note that you're losing precision by using
> > > state->period.
> > > 
> > > Consider the following request: state->period = 4177921 [ns] +
> > > state->duty_cycle = 100000 [ns], then we get
> > > PRESCALE = round(25 * state->period / 4096000) - 1 = 25 and so an actual
> > > period of 4096000 / 25 * (25 + 1) = 4259840 [ns]. If you now calculate
> > > the duty using 4096 * 100000 / 4177920 = 98, this corresponds to an
> > > actual duty cycle of 98 * 4259840 / 4096 = 101920 ns while you should
> > > actually configure 96 to get 99840 ns.
> > > 
> > > So in the end I'd like to have the following:
> > > 
> > > 	PRESCALE = round-down(25 * state->period / 4096000) - 1
> > > 
> > > (to get the biggest period not bigger than state->period) and
> > > 
> > > 	duty = round-down(state->duty_cycle * 25 / ((PRESCALE + 1) * 1000))
> > > 
> > > (to get the biggest duty cycle not bigger than state->duty_cycle). With
> > > the example above this yields
> > > 
> > > 	PRESCALE = 24
> > > 	duty = 100
> > > 
> > > which results in
> > > 
> > > 	.period = 4096000 / 25 * 25 = 4096000 [ns]
> > > 	.duty_cycle = 100000 [ns]
> > > 	
> > > Now you have a mixture of old and new with no consistent behaviour. So
> > > please either stick to the old behaviour or do it right immediately.
> > 
> > I avoided rounding down the prescale value because the datasheet has an
> > example where a round-closest is used, see page 25.
> 
> The hardware guy who wrote this data sheet wasn't aware of the rounding
> rules for Linux PWM drivers :-)
> 
> > With your suggested round-down, the example with frequency of 200 Hz
> > would no longer result in 30 but 29 and that contradicts the datasheet.
> 
> Well, with PRESCALE = 30 we get a frequency of 196.88 Hz and with
> PRESCALE = 29 we get a frequency of 203.45 Hz. So no matter if you pick
> 29 or 30, you don't get 200 Hz. And which of the two possible values is
> the better one depends on the consumer, no matter what rounding
> algorithm the data sheet suggests. Also note that the math here contains
> surprises you don't expect at first. For example, what PRESCALE value
> would you pick to get 284 Hz? [If my mail was a video, I'd suggest to
> press Space now to pause and let you think first :-)] The data sheet's
> formula suggests:
> 
> 	round(25 MHz / (4096 * 284)) - 1 = 20
> 
> The resulting frequency when picking PRESCALE = 20 is 290.644 Hz (so an
> error of 6.644 Hz). If instead you pick PRESCALE = 21 you get 277.433 Hz
> (error = 6.567 Hz), so 21 is the better choice.
> 
> Exercise for the reader:
>  What is the correct formula to really determine the PRESCALE value that
>  yields the best approximation (i.e. minimizing
>  abs(real_freq - target_freq)) for a given target_freq?
> 
> These things don't happen when you round down only.

Sure, but it might also be counterintuitive that the Linux driver does
not use the same formula as the datasheet. And when using 200 Hz, 29 is
a little closer than 30.
I once measured the actual frequency and the internal oscillator is not
very accurate, so even if you think you should get 196.88 Hz, the actual
frequency measured with a decent scope is about 206 Hz and varies from
chip to chip (~ 205-207 Hz).

> 
> > So would you rather have me keep the old duty rounding behaviour?
> > 
> > Meaning: Keep rounding up the duty calculation in apply and use
> > round-down in the new .get_state function?
> 
> There are two things I want:
> 
>  a) To improve consistency among the PWM drivers (and to keep the math
>     simple and unsurprising), the pca9685 driver should use round-down
>     instead of round-nearest (or whatever mix it is currently using).
> 
>  b) .get_state should be the inverse to .apply in the sense that
>     applying the result of .get_state is idempotent.
> 
> I don't care much how you get there, so it's up to you if you do that in
> this patch that converts to .apply, or if you keep the math as is and
> then adapt the rounding behaviour in a separate change. But changing the
> algorithm in this patch and not getting to the "good" one is ugly, so
> please don't do that.

OK, then I think the best option is to keep the math as it was before
and if we want to change the rounding behaviour we do this in a separate
patch in the future. Then we can continue the discussion wether changing
the prescaler formula to round-down even though the datasheet does it
otherwise is the way to go.

Thanks,
Clemens
