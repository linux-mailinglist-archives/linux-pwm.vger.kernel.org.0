Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD1A3B78E2
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jun 2021 21:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbhF2TzX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 29 Jun 2021 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhF2TzX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 29 Jun 2021 15:55:23 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8351C061766
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jun 2021 12:52:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:7d95:f75f:5ece:4663])
        by albert.telenet-ops.be with bizsmtp
        id P7st2500X4F6zkK067st1T; Tue, 29 Jun 2021 21:52:54 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lyJmv-00511w-F7; Tue, 29 Jun 2021 21:52:53 +0200
Date:   Tue, 29 Jun 2021 21:52:53 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To:     =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2] pwm: Ensure for legacy drivers that pwm->state stays
 consistent
In-Reply-To: <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.DEB.2.22.394.2106292151170.1195556@ramsan.of.borg>
References: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de> <20210501160943.108821-1-u.kleine-koenig@pengutronix.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-140647764-1624996373=:1195556"
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-140647764-1624996373=:1195556
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

 	Hi Uwe,

On Sat, 1 May 2021, Uwe Kleine-König wrote:
> Without this change it can happen that if changing the polarity succeeded
> but changing duty_cycle and period failed pwm->state contains a mixture
> between the old and the requested state.
>
> So remember the initial state before starting to modify the configuration
> and restore it when one of the required callback fails.
>
> Compared to the previous implementation .disable() (if necessary) is called
> earlier to prevent a glitch.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your patch, which is now commit d7bff84fe7ed8c3b ("pwm:
Ensure for legacy drivers that pwm->state stays consistent") in
pwm/for-next.

This commit broke the backlight on the Atmark Techno Armadillo 800 EVA
board (arch/arm/boot/dts/r8a7740-armadillo800eva.dts), which now shows a
black screen.  Reverting the commit fixes the problem.

Do you have an idea what is wrong, and how to fix it?
Anything I can do to investigate?

Thanks!

> ---
> Hello,
>
> just a small optimisation: At the end of pwm_apply_legacy()
> state->enabled is known to be true, so simplify
>
> 	if (state->enabled && !pwm->state.enabled) {
>
> to
> 	if (!pwm->state.enabled) {
>
> Best regards
> Uwe
>
> drivers/pwm/core.c | 139 +++++++++++++++++++++++++--------------------
> 1 file changed, 78 insertions(+), 61 deletions(-)
>
> diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> index c4d5c0667137..57105deafb55 100644
> --- a/drivers/pwm/core.c
> +++ b/drivers/pwm/core.c
> @@ -535,6 +535,71 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
> 	}
> }
>
> +static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state)
> +{
> +	int err;
> +	struct pwm_state initial_state = pwm->state;
> +
> +	if (state->polarity != pwm->state.polarity) {
> +		if (!chip->ops->set_polarity) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +
> +		/*
> +		 * Changing the polarity of a running PWM is only allowed when
> +		 * the PWM driver implements ->apply().
> +		 */
> +		if (pwm->state.enabled) {
> +			chip->ops->disable(chip, pwm);
> +
> +			/*
> +			 * Update pwm->state already here in case
> +			 * .set_polarity() or another callback depend on that.
> +			 */
> +			pwm->state.enabled = false;
> +		}
> +
> +		err = chip->ops->set_polarity(chip, pwm,
> +					      state->polarity);
> +		if (err)
> +			goto out_err;
> +
> +		pwm->state.polarity = state->polarity;
> +	}
> +
> +	if (!state->enabled) {
> +		if (pwm->state.enabled)
> +			chip->ops->disable(chip, pwm);
> +		return 0;
> +	}
> +
> +	if (state->period != pwm->state.period ||
> +	    state->duty_cycle != pwm->state.duty_cycle) {
> +		err = chip->ops->config(pwm->chip, pwm,
> +					state->duty_cycle,
> +					state->period);
> +		if (err)
> +			goto out_err;
> +
> +		pwm->state.period = state->period;
> +		pwm->state.duty_cycle = state->duty_cycle;
> +	}
> +
> +	if (!pwm->state.enabled) {
> +		err = chip->ops->enable(chip, pwm);
> +		if (err)
> +			goto out_err;
> +	}
> +
> +	return 0;
> +
> +out_err:
> +	pwm->state = initial_state;
> +	return err;
> +}
> +
> /**
>  * pwm_apply_state() - atomically apply a new state to a PWM device
>  * @pwm: PWM device
> @@ -544,6 +609,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
> {
> 	struct pwm_chip *chip;
> 	int err;
> +	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
> +		     const struct pwm_state *state);
>
> 	if (!pwm || !state || !state->period ||
> 	    state->duty_cycle > state->period)
> @@ -557,70 +624,20 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
> 	    state->enabled == pwm->state.enabled)
> 		return 0;
>
> -	if (chip->ops->apply) {
> -		err = chip->ops->apply(chip, pwm, state);
> -		if (err)
> -			return err;
> -
> -		trace_pwm_apply(pwm, state);
> -
> -		pwm->state = *state;
> -
> -		/*
> -		 * only do this after pwm->state was applied as some
> -		 * implementations of .get_state depend on this
> -		 */
> -		pwm_apply_state_debug(pwm, state);
> -	} else {
> -		/*
> -		 * FIXME: restore the initial state in case of error.
> -		 */
> -		if (state->polarity != pwm->state.polarity) {
> -			if (!chip->ops->set_polarity)
> -				return -EINVAL;
> -
> -			/*
> -			 * Changing the polarity of a running PWM is
> -			 * only allowed when the PWM driver implements
> -			 * ->apply().
> -			 */
> -			if (pwm->state.enabled) {
> -				chip->ops->disable(chip, pwm);
> -				pwm->state.enabled = false;
> -			}
> +	apply = chip->ops->apply ?: pwm_apply_legacy;
> +	err = apply(chip, pwm, state);
> +	if (err)
> +		return err;
>
> -			err = chip->ops->set_polarity(chip, pwm,
> -						      state->polarity);
> -			if (err)
> -				return err;
> +	trace_pwm_apply(pwm, state);
>
> -			pwm->state.polarity = state->polarity;
> -		}
> -
> -		if (state->period != pwm->state.period ||
> -		    state->duty_cycle != pwm->state.duty_cycle) {
> -			err = chip->ops->config(pwm->chip, pwm,
> -						state->duty_cycle,
> -						state->period);
> -			if (err)
> -				return err;
> +	pwm->state = *state;
>
> -			pwm->state.duty_cycle = state->duty_cycle;
> -			pwm->state.period = state->period;
> -		}
> -
> -		if (state->enabled != pwm->state.enabled) {
> -			if (state->enabled) {
> -				err = chip->ops->enable(chip, pwm);
> -				if (err)
> -					return err;
> -			} else {
> -				chip->ops->disable(chip, pwm);
> -			}
> -
> -			pwm->state.enabled = state->enabled;
> -		}
> -	}
> +	/*
> +	 * only do this after pwm->state was applied as some
> +	 * implementations of .get_state depend on this
> +	 */
> +	pwm_apply_state_debug(pwm, state);
>
> 	return 0;
> }
> -- 
> 2.30.2

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
--8323329-140647764-1624996373=:1195556--
