Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 235D1E103A
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Oct 2019 04:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389378AbfJWCwr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 22 Oct 2019 22:52:47 -0400
Received: from p3plsmtpa11-10.prod.phx3.secureserver.net ([68.178.252.111]:49013
        "EHLO p3plsmtpa11-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389384AbfJWCwr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 22 Oct 2019 22:52:47 -0400
Received: from labundy.com ([136.49.227.119])
        by :SMTPAUTH: with ESMTPSA
        id N6eLiOopsnCKMN6eNiDE02; Tue, 22 Oct 2019 19:45:28 -0700
Date:   Tue, 22 Oct 2019 21:45:25 -0500
From:   Jeff LaBundy <jeff@labundy.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     lee.jones@linaro.org, dmitry.torokhov@gmail.com, jdelvare@suse.com,
        linux@roeck-us.net, thierry.reding@gmail.com, jic23@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH 5/8] pwm: Add support for Azoteq IQS620A PWM generator
Message-ID: <20191023024525.GC3233@labundy.com>
References: <1571631083-4962-1-git-send-email-jeff@labundy.com>
 <1571631083-4962-6-git-send-email-jeff@labundy.com>
 <20191021073419.27r4xjqpz2wswerj@pengutronix.de>
 <20191022043649.GB2091@labundy.com>
 <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191022065415.2zxmpbsmogvgul7x@pengutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-CMAE-Envelope: MS4wfMcclth9O7PC0fd6iqJbU4Y02w8NFCaUz1cNkRK2OB+itn9EN/4bxpqbpXuZ8OnitWkK8p20kLALxyzVmbaBlFxx1Jq2OEBM2hpKsmFJpmH66QRtdhfS
 78XSMtUUat1QHo5MfJel2AF5Nu1R0UWJqAGCqaSNrIRavWnMLW7z6IPWxsf3UHfCm/HqK+rHG1fmo/25olWzCzOQVlXhC38oquyDqxU/sUwoZ59pkhnkFxYk
 95H24ZiuL1otrgQFQVLo3OF1QFXmPOPsn298qTB8VExeuahZFaSHmRTMJhLxLEJ0ZeMUVCdVimF7+pR7Ha8tsgeWFuGJzGr06rpP9YOgDBl5Lgj4W3rzZ+2W
 bgggMYlcBjW5K3z52FOmSLRXh4tmdC99iCUY3TNeoJaANMbdjTKKzby26UlGikKfTX59z4JgZ95sQKEYhBeiCfvJfSkIX974IO/BjLnW9FsPnH111yzbecI5
 r9kwxB09xbC9gbrqR1/2BuFX22YDuTpK0zRRJKuYCBSsCpv19slx7b+daaEeNtDpXSEX+obs/t6xc/Tlnt/V6FsO4mxnOIghDbSVhWQtJF+SeGFnrhtvxOct
 YkJT7VlS9fr9nbKvIFe1FqOeKZGMPpN9lKDJhB3fxXcyqjFm30Ijbp1TuHP+VYiHh8V7uSA7lZK+II3bboMb1pQndYghj8Nrv6Ebd+nZ1XWAiYr792gOt68X
 +7P5QMPEspA=
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On Tue, Oct 22, 2019 at 08:54:15AM +0200, Uwe Kleine-König wrote:
> Hello Jeff,
> 
> On Mon, Oct 21, 2019 at 11:36:49PM -0500, Jeff LaBundy wrote:
> > On Mon, Oct 21, 2019 at 09:34:19AM +0200, Uwe Kleine-König wrote:
> > > > +struct iqs620_pwm_private {
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	struct pwm_chip chip;
> > > > +	struct notifier_block notifier;
> > > > +	bool ready;
> > > 
> > > This is always true, so you can drop it.
> > > 
> > 
> > This is here because iqs620_pwm_notifier references chip.pwms, which is
> > not allocated until after the notifier is registered and pwmchip_add is
> > called. So it protects against this (albeit unlikely) race condition:
> > 
> > 1. iqs620_pwm_notifier is registered
> > 2. Device immediately suffers an asynchronous reset and notifier chain
> >    is called (more on that in a bit)
> > 3. iqs620_pwm_notifier evaluates chips.pwms (NULL)
> > 
> > I felt this was simpler than calling pwmchip_add before registering the
> > notifier and adding an error/tear-down path in iqs620_pwm_probe in case
> > of failure. I would be happy to add a comment or two to explain the not-
> > so-obvious purpose of this flag.
> 
> Ah, understood. A comment is definitively necessary here.
> 

Sure thing; will do.

> > > > +};
> > > > +
> > > > +static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> > > > +			    struct pwm_state *state)
> > > 
> > > Since
> > > 
> > > 	71523d1812ac ("pwm: Ensure pwm_apply_state() doesn't modify the state argument")
> > > 
> > > this isn't the right prototype.
> > > 
> > 
> > Sure thing; I will add the 'const' qualifier and remove the two changes
> > to the state argument.
> > 
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	struct iqs62x_core *iqs62x;
> > > > +	int error;
> > > > +	int duty_calc = state->duty_cycle * 256 / IQS620_PWM_PERIOD_NS - 1;
> > > > +	u8 duty_clamp = clamp(duty_calc, 0, 0xFF);
> 
> Another problem that we have here is that the period is fixed to 1 ms
> and if a consumer requests for example:
> 
> 	.period = 5000000,
> 	.duty_cycle = 1000000,
> 
> the hardware is actually configured for
> 
> 	.period = 1000000,
> 	.duty_cycle = 1000000,
> 
> . I don't have a good suggestion how to fix this. We'd need to
> draw a line somewhere and decline a request that is too far from the
> result. But where this line should be is not obvious, it should
> definitively not be implemented in the driver itself IMHO.
> 
> (The only halfway sane approach would be to let lowlevel drivers
> implement a .round_state callback and then let the framework judge. But
> we're a long way from having that, so that's not a solution for today.)
> 

Agreed on all counts. For now, I will mention in the 'Limitations' heading that
the period cannot be adjusted.

> > > > +	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
> > > > +	iqs62x = iqs620_pwm->iqs62x;
> > > > +
> > > > +	error = regmap_write(iqs62x->map, IQS620_PWM_DUTY_CYCLE, duty_clamp);
> > > > +	if (error)
> > > > +		return error;
> > > > +
> > > > +	state->period = IQS620_PWM_PERIOD_NS;
> > > > +	state->duty_cycle = (duty_clamp + 1) * IQS620_PWM_PERIOD_NS / 256;
> > > 
> > > This suggests that if the value in the IQS620_PWM_DUTY_CYCLE is 0 the
> > > duty cycle is 1/256 ms with a period of 1 ms and the output cannot be
> > > constant inactive. If this is right please add a paragraph in the
> > > driver's comment at the top:
> > > 
> > > 	* Limitations:
> > > 	* - The hardware cannot generate a 0% duty cycle
> > > 
> > > (Please stick to this format, other drivers use it, too.)
> > 
> > That's correct; the lowest duty cycle that can be achieved using only the
> > IQS620_PWM_DUTY_CYCLE register is 0.4%. We can, however, generate 0% duty
> > cycle by disabling the output altogether using a separate register. Would
> > that be better than flat-out saying it's impossible?
> 
> There is (maybe) a small difference between disabled and 0% duty cycle,
> at least from the framework's POV: If you do:
> 
> 	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });
> 	pwm_apply_state(pwm, { .enabled = false, .period = $DC, .duty_cycle = $DC, });
> 	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });
> 
> and compare it to the expected result of
> 
> 	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });
> 	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 0, });
> 	pwm_apply_state(pwm, { .enabled = true, .period = 1000000, .duty_cycle = 1000000, });
> 
> the difference is that the duration of the inactive phase in the latter
> case is a multiple of 1 ms.
> 
> There is no policy for lowlevel drivers what to do, but disabling when
> 0% is requested is at least not unseen and probably more what consumers
> expect.
> 

With the change I am proposing, the output will be driven to zero if enabled = false
OR duty_cycle < 4000 ns. Stated another way:

enable duty_cycle IQS620_PWR_SETTINGS[7] IQS620_PWM_DUTY_CYCLE
------ ---------- ---------------------- ---------------------
  0    don't care           0                  don't care
  1    0 ... 3999           0                  don't care
  1    4000 ... x           1                      0
  1    x+1  ... y           1                      1

...and so on. For context, if IQS620_PWR_SETTINGS[7] = 0 then the output is held to
zero. If IQS620_PWR_SETTINGS[7] = 1 then the output toggles at a duty cycle between
0.4% and 100% as a function of IQS620_PWM_DUTY_CYCLE.

Based on how the device behaves in response to its two available registers, I think
your two examples will appear equal, but please let me know if I have understood.

> > > How does the hardware behave on changes? For example you're first
> > > committing the duty cycle and then on/off. Can it happen that between
> > > 
> > > 	pwm_apply_state(pwm, { .duty_cycle = 3900, .period = 1000000, .enabled = true)
> > > 	...
> > > 	pwm_apply_state(pwm, { .duty_cycle = 1000000, .period = 1000000, .enabled = false)
> > > 
> > > the output is active for longer than 4 µs because the iqs620_pwm_apply
> > > function is preempted between the two register writes and so we already
> > > have .duty_cycle = 1000000 but still .enabled = true in the hardware?
> > > 
> > 
> > My results show that it is possible to generate up to two irregular periods
> > by changing the duty cycle while the output is active.
> > 
> > Depending on the ratio of old-to-new duty cycle and the position of the I2C
> > write relative to the asynchronous output, the device may produce one pulse
> > for which the width represents neither the old nor the new duty cycle.
> > 
> > > Does a change complete the currently running period? Does disabling
> > > complete the currently running period? If so, does regmap_update_bits
> > > block until the new setting is active?
> > > 
> > 
> > A quick test reveals the following:
> > 
> > * Duty cycle changes may interrupt a running period, i.e., the output may
> >   transition in the middle of the period to accommodate the new duty cycle.
> > * Disabling the output drives it to zero immediately, i.e., the period does
> >   does not run to completion.
> > 
> > I will add a 'Limitations' section at the top as other drivers do, and call
> > these points out specifically.
> 
> Great. Thanks.
> 
> > > > +static int iqs620_pwm_notifier(struct notifier_block *notifier,
> > > > +			       unsigned long event_flags, void *context)
> > > > +{
> > > > +	struct iqs620_pwm_private *iqs620_pwm;
> > > > +	struct pwm_state state;
> > > > +	int error;
> > > > +
> > > > +	iqs620_pwm = container_of(notifier, struct iqs620_pwm_private,
> > > > +				  notifier);
> > > > +
> > > > +	if (!iqs620_pwm->ready || !(event_flags & BIT(IQS62X_EVENT_SYS_RESET)))
> > > > +		return NOTIFY_DONE;
> > > > +
> > > > +	pwm_get_state(&iqs620_pwm->chip.pwms[0], &state);
> > > > +
> > > > +	error = iqs620_pwm_apply(&iqs620_pwm->chip,
> > > > +				 &iqs620_pwm->chip.pwms[0], &state);
> > > > +	if (error) {
> > > > +		dev_err(iqs620_pwm->chip.dev,
> > > > +			"Failed to re-initialize device: %d\n", error);
> > > > +		return NOTIFY_BAD;
> > > > +	}
> > > > +
> > > > +	return NOTIFY_OK;
> > > 
> > > So the PWM can loose it's state sometimes? When does that happen?
> > 
> > That's correct. The device performs an internal soft reset in the presence
> > of what it considers to be an I2C timeout error; in this case all registers
> > are restored to their default values.
> 
> Is this a theoretic problem or does that happen from time to time?
>  

This event can occur if the I2C master stalls a transaction for 10's of ms. It's
not a theoretical problem, but it should not happen during normal circumstances.

> > The data sheet goes so far as to recommend monitoring for this interrupt and
> > restoring the device on-the-fly. I have added some comments in iqs62x_irq in
> > patch [2/8] which provides some further detail.
> 
> Monitoring that interrupt seems reasonable.
>  
> > > > +	error = devm_add_action_or_reset(&pdev->dev,
> > > > +					 iqs620_pwm_notifier_unregister,
> > > > +					 iqs620_pwm);
> > > 
> > > I wonder if this is safe. If in iqs620_pwm_notifier_unregister()
> > > unregistering of the notifier goes wrong (not sure when this can happen)
> > > the memory behind iqs620_pwm goes away. Then later iqs620_pwm_notifier
> > > might be called trying to use *iqs620_pwm ...
> > 
> > I think this is purely theoretical, as blocking_notifier_chain_unregister
> > only fails if the notifier is not found in the chain. If for some reason
> > blocking_notifier_chain_register fails (which currently cannot happen, as
> > it always returns zero), the driver will fail to probe before the action
> > could be added.
> > 
> > This of course means the error message in iqs620_pwm_notifier_unregister
> > is unnecessary; it is simply provided for debug/visibility.
> 
> I'd suggest to do the unregister call in the remove callback which you
> have for pwm unregistration anyhow. Or alternatively implement a devm_
> variant of the notifier registration that explains in the comments that
> it is safe.

Sure thing; I'll unregister the notifier in iqs620_pwm_remove.

> 
> Best regards
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 

Kind regards,
Jeff LaBundy
