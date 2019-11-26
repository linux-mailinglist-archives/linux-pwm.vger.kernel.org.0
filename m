Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3740F109C86
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Nov 2019 11:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbfKZKtX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 26 Nov 2019 05:49:23 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59383 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbfKZKtX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Nov 2019 05:49:23 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iZYPJ-0003Bd-CC; Tue, 26 Nov 2019 11:49:21 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iZYPI-0002gz-8k; Tue, 26 Nov 2019 11:49:20 +0100
Date:   Tue, 26 Nov 2019 11:49:20 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191126104920.rjlgfwetz2ov3u44@pengutronix.de>
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
 <20191125203849.fxvg74xrzp6rxahy@pengutronix.de>
 <20191126095156.292c03af@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191126095156.292c03af@xps13>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hallo Miquel,

On Tue, Nov 26, 2019 at 09:51:56AM +0100, Miquel Raynal wrote:
> > Also when switching from 0% to 50% you could prevent a glitch by
> > sticking to an unset blink phase 0 bit.
> 
> You mean, when turning off the PWM, I should first change the intensity
> to 50%, then blink the phase, then change the intensity to 100%?
> (reversed logic when intensity > 0).

No, that's not what I meant. Your hardware seems to have two different
"modes". One where you can set the intensity between 0 and 15/16, and
another where the intensity is between 1/16 and 16/16, right? Switching
between these two results in a glitch and you use the first mode only
for intensity 0 and the second for the rest. If now you have to go from
0 to 8/16 your driver does a mode switch while this isn't necessary.

I also wonder if a glitch can at least be made less likely, even when
going from 0% to 100%. You claimed that changing intensity was glitch
free (i.e. the currently running period is completed before the changed
setting has an effect). Does this hold also for changing the blink
phase?

> > > +	/* Disable the internal oscillator if no channel is in use */
> > > +	if (!pwm->count) {
> > > +		mutex_lock(&chip->i2c_lock);
> > > +		regmap_write_bits(chip->regmap, MAX7313_MASTER,
> > > +				  PWM_INTENSITY_MASK << PWM_BITS_PER_REG, 0);
> > > +		mutex_unlock(&chip->i2c_lock);
> > > +	}  
> > 
> > What happens to the output pin when the oscillator gets disabled?
> 
> If .free does not modify the output, then disabling the oscillator
> will force a static state if that was not already the case. I suppose
> that's not what you want. Why one would free a pin if it stills need to
> blink?

It's the consumer who is supposed to stop the PWM before freeing it.
Then better do the oscillator stop when pwm_apply_state(pwm, {...
.enabled = false }) is called (and the other PWMs are off, too).

> If I am not allowed to disable the oscillator it means energy
> consumption will stay high for no reason as long as one PWM has been
> enabled, ever.
> 
> > 
> > > +	mutex_unlock(&pwm->count_lock);
> > > +
> > > +	gpiochip_free_own_desc(data->desc);
> > > +}
> > > +
> > > +static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
> > > +			     struct pwm_device *pwm_device,
> > > +			     const struct pwm_state *state)
> > > +{
> > > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > > +	unsigned int duty_cycle;
> > > +
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

(Of course for we'd need something like pwm_round_state() to effectively
find a good request without actually modifying the hardware state. That
is on my todo list.)

> > > +	data->enabled = state->enabled;
> > > +	data->duty_cycle = state->duty_cycle;  
> > 
> > Storing these is only to let .get_state yield the last set values,
> > right?
> 
> I can't guess the duty_cycle/enabled state just by reading the
> hardware. For instance, I cannot represent a "40% duty with PWM
> disabled". Reading the hardware will not be able to know if the PWM
> is enabled or not and the duty_cycle will be read as 0.

I interpret that as a "yes". IMHO it's a misconcept that a PWM driver
has to remember the duty cycle (and period) with enabled=false even
though this has no influence on the actual output in that state. I'd
like to get rid of .enabled in struct pwm_state completely, but Thierry
doesn't agree.

> > > +	if (!state->enabled || !state->duty_cycle)
> > > +		duty_cycle = 0;
> > > +	else
> > > +		/* Convert the duty-cycle to be in the [1;16] range */
> > > +		duty_cycle = DIV_ROUND_DOWN_ULL(state->duty_cycle,
> > > +						PWM_OFFSET_NS);
> > > +
> > > +	/* The hardware is supposedly glitch-free */
> > > +	return max7313_pwm_set_state(chip, pwm_device, duty_cycle);
> > > +}
> > > +
> > > +static void max7313_pwm_get_state(struct pwm_chip *pwm_chip,
> > > +				  struct pwm_device *pwm_device,
> > > +				  struct pwm_state *state)
> > > +{
> > > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > > +	u8 duty_cycle;
> > > +
> > > +	state->period = PWM_PERIOD_NS;
> > > +	state->polarity = PWM_POLARITY_NORMAL;
> > > +
> > > +	if (!data)
> > > +		return;
> > > +
> > > +	state->enabled = data->enabled;  
> > 
> > data->enabled is not initialized from hardware in .probe, so currently
> > .get doesn't provide anything useful for the initial call. :-|
> 
> 'enabled' only has a software meaning here, so it will return false at
> the first call as the structure is initially zeroed. Then it will
> provide the last state of the boolean. This IP has no "enable/disable"
> feature so I don't know how to handle this in a better way.

When we'd get rid of struct pwm_state::enabled this would be clearer,
right? As this driver will be another instance that will hopefully help
me convincing Thierry in the end, can you please add a comment somewhere
at the top like this?:

/*
 * Limitations:
 * - Period fixed to 31.25 ms
 * - Only supports normal polarity
 * - Doesn't support a disabled state
 * - Some glitches cannot be prevented
 */

(The idea is that a command like

	for f in drivers/pwm/pwm-*.c ; do echo $f; sed -rn '/^ \* Limitation/,/^ \*\/?$/p' $f ; done

gives some nice overview about common limitations.)

But also today you should check the hardware state and if duty_cycle is
greater than 0 don't report the PWM as disabled.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
