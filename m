Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A8E109A8E
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Nov 2019 09:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfKZIwB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pwm@lfdr.de>); Tue, 26 Nov 2019 03:52:01 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35833 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfKZIwB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 26 Nov 2019 03:52:01 -0500
X-Originating-IP: 90.76.211.102
Received: from xps13 (lfbn-1-2154-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 52AA11C0011;
        Tue, 26 Nov 2019 08:51:57 +0000 (UTC)
Date:   Tue, 26 Nov 2019 09:51:56 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v3] gpio: pca953x: Add Maxim MAX7313 PWM support
Message-ID: <20191126095156.292c03af@xps13>
In-Reply-To: <20191125203849.fxvg74xrzp6rxahy@pengutronix.de>
References: <20191122113230.16486-1-miquel.raynal@bootlin.com>
        <20191125203849.fxvg74xrzp6rxahy@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,


> > +/*
> > + * For a given PWM channel, when the blink phase 0 bit is set, the intensity
> > + * range is only [1/16;16/16]. With this range, a static low output is
> > + * physically not possible. When the blink phase 0 bit is cleared, the intensity
> > + * range is [15/16;0/16] which then allows a static low output but not a static
> > + * high output.
> > + *
> > + * In this driver we choose to set the blink phase 0 bit by default, hence we
> > + * can slide from a low output to a fully high output without glitch. However,
> > + * the only way to get a static low output is by clearing the blink phase 0 bit,
> > + * and by changing the intensity value to its maximum (as, at this moment,
> > + * intensity is reversed). There is no way to atomically flip the register *and*
> > + * change the PWM value at the same time so this will produce a small glitch.
> > + */
> > +static int max7313_pwm_set_state(struct pca953x_chip *chip,
> > +				 struct pwm_device *pwm_device,
> > +				 unsigned int duty_cycle)  
> 
> I'd like to see a better name than "duty_cycle" here. In the comment
> above you call it "intensity" which is more clear IMHO.
> 
> > +{
> > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > +	struct gpio_desc *desc = data->desc;
> > +	int ret;
> > +
> > +	/* A null duty_cycle will invert the phase */
> > +	ret = gpiod_direction_output(desc, duty_cycle);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Maximize the low time in case of static low state */
> > +	if (!duty_cycle)
> > +		duty_cycle = PWM_DC_STATES;
> > +
> > +	return max7313_pwm_set_intensity(chip, pwm_device->hwpwm, duty_cycle);  
> 
> Thierry already commented that the call to gpiod_direction_output is a
> bit strange. What about:
> 
> 	if (intensity) {
> 		gpiod_direction_output(desc, 1);
> 		max7313_pwm_set_intensity(chip, pwm_device->hwpwm, intensity - 1)
> 	} else {
> 		gpiod_direction_output(desc, 0);
> 		max7313_pwm_set_intensity(chip, pwm_device->hwpwm, 15);
> 	}

I'm fine with that.

> 
> Also when switching from 0% to 50% you could prevent a glitch by
> sticking to an unset blink phase 0 bit.

You mean, when turning off the PWM, I should first change the intensity
to 50%, then blink the phase, then change the intensity to 100%?
(reversed logic when intensity > 0).

If the intensity was already low, this will produce a glitch in any
case, right? Same if the user changes the intensity from 0 to 15%, that
will bright at 50%.

Do you think it is worth adding such logic?

> 
> > +}
> > +
> > +static int max7313_pwm_request(struct pwm_chip *pwm_chip,
> > +			       struct pwm_device *pwm_device)
> > +{
> > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > +	struct max7313_pwm_data *data;
> > +	struct gpio_desc *desc;
> > +	int ret;
> > +
> > +	desc = gpiochip_request_own_desc(&chip->gpio_chip, pwm_device->hwpwm,
> > +					 "max7313-pwm", GPIO_ACTIVE_HIGH,
> > +					 GPIOD_OUT_LOW);
> > +	if (IS_ERR(desc)) {
> > +		dev_err(&chip->client->dev,
> > +			"pin already in use (probably as GPIO)\n");
> > +		return PTR_ERR(desc);
> > +	}
> > +
> > +	data = devm_kzalloc(&chip->client->dev, sizeof(*data), GFP_KERNEL);
> > +	if (!data)
> > +		return -ENOMEM;
> > +
> > +	data->desc = desc;
> > +	pwm_set_chip_data(pwm_device, data);
> > +
> > +	ret = max7313_pwm_set_state(chip, pwm_device, 0);
> > +	if (ret) {
> > +		dev_err(&chip->client->dev, "cannot set PWM default state\n");  
> 
> Would be good to include the error code here. I suggest to use
> 
> 	dev_err(&chip->client->dev, "cannot set PWM default state: %pe\n",
> 		ERR_PTR(ret));
> 
> Ditto for the error message above when gpiochip_request_own_desc fails.
> 
> If I'm not mistaken this already initializes the PWM, however .request
> isn't supposed to do that. The output state should be unmodified to
> allow to take over an already initialized PWM from the boot loader.

Ok, I'll get rid of that call.

> 
> > +		goto free_gpiod;
> > +	}
> > +
> > +	/*
> > +	 * Set master intensity to the maximum level to let individual outputs
> > +	 * the greatest flexibility range. Also enables the internal oscillator.
> > +	 */
> > +	mutex_lock(&pwm->count_lock);
> > +	if (!pwm->count) {
> > +		mutex_lock(&chip->i2c_lock);
> > +		ret = regmap_write_bits(chip->regmap, MAX7313_MASTER,
> > +					PWM_INTENSITY_MASK << PWM_BITS_PER_REG,
> > +					PWM_INTENSITY_MASK << PWM_BITS_PER_REG);
> > +		mutex_unlock(&chip->i2c_lock);
> > +	}
> > +
> > +	if (!ret)
> > +		pwm->count++;
> > +
> > +	mutex_unlock(&pwm->count_lock);
> > +
> > +	if (ret)
> > +		goto free_gpiod;
> > +
> > +	return 0;
> > +
> > +free_gpiod:
> > +	gpiochip_free_own_desc(data->desc);
> > +
> > +	return ret;
> > +}
> > +
> > +static void max7313_pwm_free(struct pwm_chip *pwm_chip,
> > +			     struct pwm_device *pwm_device)
> > +{
> > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > +
> > +	max7313_pwm_set_state(chip, pwm_device, 0);  
> 
> As .request above also .free is not supposed to modify the output.
> 
> > +	mutex_lock(&pwm->count_lock);
> > +
> > +	pwm->count--;
> > +
> > +	/* Disable the internal oscillator if no channel is in use */
> > +	if (!pwm->count) {
> > +		mutex_lock(&chip->i2c_lock);
> > +		regmap_write_bits(chip->regmap, MAX7313_MASTER,
> > +				  PWM_INTENSITY_MASK << PWM_BITS_PER_REG, 0);
> > +		mutex_unlock(&chip->i2c_lock);
> > +	}  
> 
> What happens to the output pin when the oscillator gets disabled?

If .free does not modify the output, then disabling the oscillator
will force a static state if that was not already the case. I suppose
that's not what you want. Why one would free a pin if it stills need to
blink?

If I am not allowed to disable the oscillator it means energy
consumption will stay high for no reason as long as one PWM has been
enabled, ever.

> 
> > +	mutex_unlock(&pwm->count_lock);
> > +
> > +	gpiochip_free_own_desc(data->desc);
> > +}
> > +
> > +static int max7313_pwm_apply(struct pwm_chip *pwm_chip,
> > +			     struct pwm_device *pwm_device,
> > +			     const struct pwm_state *state)
> > +{
> > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > +	unsigned int duty_cycle;
> > +
> > +	if (state->period != PWM_PERIOD_NS ||
> > +	    state->polarity != PWM_POLARITY_NORMAL)
> > +		return -EINVAL;  
> 
> The check for period is too strong. Anything bigger than PWM_PERIOD_NS
> is acceptable, too. (The policy I'd like to see is: Provide the biggest
> period possible not bigger than the requested policy.)

I don't understand, what is this parameter supposed to mean? the period
cannot be changed, it is ruled by an internal oscillator. In this case
any period bigger than the actual period cannot be physically achieved.
If we derive ratios with a bigger period than possible, why not
allowing it for lower periods too?

> 
> > +	data->enabled = state->enabled;
> > +	data->duty_cycle = state->duty_cycle;  
> 
> Storing these is only to let .get_state yield the last set values,
> right?

I can't guess the duty_cycle/enabled state just by reading the
hardware. For instance, I cannot represent a "40% duty with PWM
disabled". Reading the hardware will not be able to know if the PWM
is enabled or not and the duty_cycle will be read as 0.

> 
> > +	if (!state->enabled || !state->duty_cycle)
> > +		duty_cycle = 0;
> > +	else
> > +		/* Convert the duty-cycle to be in the [1;16] range */
> > +		duty_cycle = DIV_ROUND_DOWN_ULL(state->duty_cycle,
> > +						PWM_OFFSET_NS);
> > +
> > +	/* The hardware is supposedly glitch-free */
> > +	return max7313_pwm_set_state(chip, pwm_device, duty_cycle);
> > +}
> > +
> > +static void max7313_pwm_get_state(struct pwm_chip *pwm_chip,
> > +				  struct pwm_device *pwm_device,
> > +				  struct pwm_state *state)
> > +{
> > +	struct max7313_pwm_data *data = pwm_get_chip_data(pwm_device);
> > +	struct max7313_pwm *pwm = to_max7313_pwm(pwm_chip);
> > +	struct pca953x_chip *chip = to_pca953x(pwm);
> > +	u8 duty_cycle;
> > +
> > +	state->period = PWM_PERIOD_NS;
> > +	state->polarity = PWM_POLARITY_NORMAL;
> > +
> > +	if (!data)
> > +		return;
> > +
> > +	state->enabled = data->enabled;  
> 
> data->enabled is not initialized from hardware in .probe, so currently
> .get doesn't provide anything useful for the initial call. :-|

'enabled' only has a software meaning here, so it will return false at
the first call as the structure is initially zeroed. Then it will
provide the last state of the boolean. This IP has no "enable/disable"
feature so I don't know how to handle this in a better way.

> > +	if (!state->enabled) {
> > +		state->duty_cycle = data->duty_cycle;
> > +	} else {
> > +		duty_cycle = max7313_pwm_get_intensity(chip, pwm_device->hwpwm);
> > +		state->duty_cycle = duty_cycle * PWM_OFFSET_NS;  
> 
> if the hardware is configured with blink phase 0 bit unset the returned
> value is wrong, isn't it?

True, I'll correct.

> 
> > +	}
> > +};  
> 
> Best regards
> Uwe
> 

Thanks,
Miquèl
