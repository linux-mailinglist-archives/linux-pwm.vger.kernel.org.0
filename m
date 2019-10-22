Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFCDFDE2
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Oct 2019 08:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387623AbfJVGyj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 02:54:39 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43059 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387614AbfJVGyj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 02:54:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMo3e-0006b9-7z; Tue, 22 Oct 2019 08:54:18 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iMo3b-0000Jn-91; Tue, 22 Oct 2019 08:54:15 +0200
Date:   Tue, 22 Oct 2019 08:54:15 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
 <20191022043649.GB2091@labundy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022043649.GB2091@labundy.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello Jeff,

On Mon, Oct 21, 2019 at 11:36:49PM -0500, Jeff LaBundy wrote:
> On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-König wrote:
> > > +struct iqs620_pwm_private {
> > > +	struct iqs62x_core *iqs62x;
> > > +	struct pwm_chip chip;
> > > +	struct notifier_block notifier;
> > > +	bool ready;
> > 
> > This is always true, so you can drop it.
> > 
> 
> This is here because iqs620_pwm_notifier references chip.pwms, which is
> not allocated until after the notifier is registered and pwmchip_add is
> called. So it protects against this (albeit unlikely) race condition:
> 
> 1. iqs620_pwm_notifier is registered
> 2. Device immediately suffers an asynchronous reset and notifier chain
>    is called (more on that in a bit)
> 3. iqs620_pwm_notifier evaluates chips.pwms (NULL)
> 
> I felt this was simpler than calling pwmchip_add before registering the
> notifier and adding an error/tear-down path in iqs620_pwm_probe in case
> of failure. I would be happy to add a comment or two to explain the not-
> so-obvious purpose of this flag.

Ah, understood. A comment is definitively necessary here.

> > > +};
> > > +
> > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > +			    struct pwm_state *state)
> > 
> > Since
> > 
> > 	71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
> > 
> > this isn't the right prototype.
> > 
> 
> Sure thing; I will add the 'const' qualifier and remove the two changes
> to the state argument.
> 
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	struct iqs62x_core *iqs62x;
> > > +	int error;
> > > +	int duty_calc = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
> > > +	u8 duty_clamp = clamp(duty_calc, 0, 0xFF);

Another problem that we have here is that the period is fixed to 1 ms
and if a consumer requests for example:

	.period = 5000000,
	.duty_cycle = 1000000,

the hardware is actually configured for

	.period = 1000000,
	.duty_cycle = 1000000,

. I don't have a good suggestion how to fix this. We'd need to
draw a line somewhere and decline a request that is too far from the
result. But where this line should be is not obvious, it should
definitively not be implemented in the driver itself IMHO.

(The only halfway sane approach would be to let lowlevel drivers
implement a .round_state callback and then let the framework judge. But
we're a long way from having that, so that's not a solution for today.)

> > > +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> > > +	iqs62x = iqs620_pwm->iqs62x;
> > > +
> > > +	error = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_clamp);
> > > +	if (error)
> > > +		return error;
> > > +
> > > +	state->period = IQS620_PWM_PERIOD_NS;
> > > +	state->duty_cycle = (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 256;
> > 
> > This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 the
> > duty cycle is 1/256 ms with a period of 1 ms and the output cannot be
> > constant inactive. If this is right please add a paragraph in the
> > driver's comment at the top:
> > 
> > 	* Limitations:
> > 	* - The hardware cannot generate a 0% duty cycle
> > 
> > (Please stick to this format, other drivers use it, too.)
> 
> That's correct; the lowest duty cycle that can be achieved using only the
> IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% duty
> cycle by disabling the output altogether using a separate register. Would
> that be better than flat-out saying it's impossible?

There is (maybe) a small difference between disabled and 0% duty cycle,
at least from the framework's POV: If you do:

	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });
	pwm_apply_state(pwm, { .enabled = false, .period = $DC, .duty_cycle = $DC, });
	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });

and compare it to the expected result of

	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });
	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 0, });
	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });

the difference is that the duration of the inactive phase in the latter
case is a multiple of 1 ms.

There is no policy for lowlevel drivers what to do, but disabling when
0% is requested is at least not unseen and probably more what consumers
expect.

> > How does the hardware behave on changes? For example you're first
> > committing the duty cycle and then on/off. Can it happen that between
> > 
> > 	pwm_apply_state(pwm, { .duty_cycle = 3900, .period = 1000000, .enabled = true)
> > 	...
> > 	pwm_apply_state(pwm, { .duty_cycle = 1000000, .period = 1000000, .enabled = false)
> > 
> > the output is active for longer than 4 µs because the iqs620_pwm_apply
> > function is preempted between the two register writes and so we already
> > have .duty_cycle = 1000000 but still .enabled = true in the hardware?
> > 
> 
> My results show that it is possible to generate up to two irregular periods
> by changing the duty cycle while the output is active.
> 
> Depending on the ratio of old-to-new duty cycle and the position of the I2C
> write relative to the asynchronous output, the device may produce one pulse
> for which the width represents neither the old nor the new duty cycle.
> 
> > Does a change complete the currently running period? Does disabling
> > complete the currently running period? If so, does regmap_update_bits
> > block until the new setting is active?
> > 
> 
> A quick test reveals the following:
> 
> * Duty cycle changes may interrupt a running period, i.e., the output may
>   transition in the middle of the period to accommodate the new duty cycle.
> * Disabling the output drives it to zero immediately, i.e., the period does
>   does not run to completion.
> 
> I will add a 'Limitations' section at the top as other drivers do, and call
> these points out specifically.

Great. Thanks.

> > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > +			       unsigned long event_flags, void *context)
> > > +{
> > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > +	struct pwm_state state;
> > > +	int error;
> > > +
> > > +	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
> > > +				  notifier);
> > > +
> > > +	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > +		return NOTIFY_DONE;
> > > +
> > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > > +
> > > +	error = iqs620_pwm_apply(&iqs620_pwm->chip,
> > > +				 &iqs620_pwm->chip.pwms[0], &state);
> > > +	if (error) {
> > > +		dev_err(iqs620_pwm->chip.dev,
> > > +			"Failed to re-initialize device: %d\n", error);
> > > +		return NOTIFY_BAD;
> > > +	}
> > > +
> > > +	return NOTIFY_OK;
> > 
> > So the PWM can loose it's state sometimes? When does that happen?
> 
> That's correct. The device performs an internal soft reset in the presence
> of what it considers to be an I2C timeout error; in this case all registers
> are restored to their default values.

Is this a theoretic problem or does that happen from time to time?
 
> The data sheet goes so far as to recommend monitoring for this interrupt and
> restoring the device on-the-fly. I have added some comments in iqs62x_irq in
> patch [2/8] which provides some further detail.

Monitoring that interrupt seems reasonable.
 
> > > +	error = devm_add_action_or_reset(&pdev->dev,
> > > +					 iqs620_pwm_notifier_unregister,
> > > +					 iqs620_pwm);
> > 
> > I wonder if this is safe. If in iqs620_pwm_notifier_unregister()
> > unregistering of the notifier goes wrong (not sure when this can happen)
> > the memory behind iqs620_pwm goes away. Then later iqs620_pwm_notifier
> > might be called trying to use *iqs620_pwm ...
> 
> I think this is purely theoretical, as blocking_notifier_chain_unregister
> only fails if the notifier is not found in the chain. If for some reason
> blocking_notifier_chain_register fails (which currently cannot happen, as
> it always returns zero), the driver will fail to probe before the action
> could be added.
> 
> This of course means the error message in iqs620_pwm_notifier_unregister
> is unnecessary; it is simply provided for debug/visibility.

I'd suggest to do the unregister call in the remove callback which you
have for pwm unregistration anyhow. Or alternatively implement a devm_
variant of the notifier registration that explains in the comments that
it is safe.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
