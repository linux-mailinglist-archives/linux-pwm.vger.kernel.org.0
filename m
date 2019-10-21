Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A083DDEE52
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Oct 2019 15:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbfJUNtE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Oct 2019 09:49:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35928 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728083AbfJUNtE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Oct 2019 09:49:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 8B22128AC19
Subject: Re: [PATCH 2/4] pwm: cros-ec: Cache duty cycle value
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-pwm@vger.kernel.org
References: <20191021105739.1357629-1-thierry.reding@gmail.com>
 <20191021105739.1357629-2-thierry.reding@gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <041c05b7-f558-0249-0450-305dfa2697a9@collabora.com>
Date:   Mon, 21 Oct 2019 15:48:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191021105739.1357629-2-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On 21/10/19 12:57, Thierry Reding wrote:
> The ChromeOS embedded controller doesn't differentiate between disabled
> and duty cycle being 0. In order not to potentially confuse consumers,
> cache the duty cycle and return the cached value instead of the real
> value when the PWM is disabled.
> 
> Signed-off-by: Thierry Reding <thierry.reding@gmail.com>

One nit and tested on top of 5.4.0-rc4. The backlight is alive again. So,

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

> ---
>  drivers/pwm/pwm-cros-ec.c | 58 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
> index 89497448d217..09c08dee099e 100644
> --- a/drivers/pwm/pwm-cros-ec.c
> +++ b/drivers/pwm/pwm-cros-ec.c
> @@ -25,11 +25,39 @@ struct cros_ec_pwm_device {
>  	struct pwm_chip chip;
>  };
>  
> +/**
> + * struct cros_ec_pwm - per-PWM driver data
> + * @duty_cycle: cached duty cycle
> + */
> +struct cros_ec_pwm {
> +	u16 duty_cycle;
> +};
> +
>  static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
>  {
>  	return container_of(c, struct cros_ec_pwm_device, chip);
>  }
>  
> +static int cros_ec_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct cros_ec_pwm *channel;
> +
> +	channel = kzalloc(sizeof(*channel), GFP_KERNEL);
> +	if (!channel)
> +		return -ENOMEM;
> +
> +	pwm_set_chip_data(pwm, channel);
> +
> +	return 0;
> +}
> +
> +static void cros_ec_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
> +{
> +	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
> +
> +	kfree(channel);
> +}
> +
>  static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
>  {
>  	struct {
> @@ -96,7 +124,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  			     const struct pwm_state *state)
>  {
>  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
> -	int duty_cycle;
> +	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
> +	u16 duty_cycle;
> +	int ret;
>  
>  	/* The EC won't let us change the period */
>  	if (state->period != EC_PWM_MAX_DUTY)
> @@ -108,13 +138,20 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>  	 */
>  	duty_cycle = state->enabled ? state->duty_cycle : 0;
>  
> -	return cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> +	ret = cros_ec_pwm_set_duty(ec_pwm->ec, pwm->hwpwm, duty_cycle);
> +	if (ret < 0)
> +		return ret;
> +
> +	channel->duty_cycle = state->duty_cycle;
> +
> +	return 0;
>  }
>  
>  static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  				  struct pwm_state *state)
>  {
>  	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
> +	struct cros_ec_pwm *channel = pwm_get_chip_data(pwm);
>  	int ret;
>  
>  	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
> @@ -126,8 +163,19 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>  	state->enabled = (ret > 0);
>  	state->period = EC_PWM_MAX_DUTY;
>  
> -	/* Note that "disabled" and "duty cycle == 0" are treated the same */
> -	state->duty_cycle = ret;
> +	/*
> +	 * Note that "disabled" and "duty cycle == 0" are treated the same. If
> +	 * the cached duty cycle is not zero, used the cached duty cycle. This
> +	 * ensures that the configured duty cycle is kept across a disable and
> +	 * enable operation and avoids potentially confusing consumers.
> +	 *
> +	 * For the case of the initial hardware readout, channel->duty_cycle
> +	 * will be 0 and the actual duty cycle read from the EC is used.
> +	 */
> +	if (ret == 0 && channel->duty_cycle > 0)
> +		state->duty_cycle = channel->duty_cycle;
> +	else
> +		state->duty_cycle = ret;
>  }
>  
>  static struct pwm_device *
> @@ -149,6 +197,8 @@ cros_ec_pwm_xlate(struct pwm_chip *pc, const struct of_phandle_args *args)
>  }
>  
>  static const struct pwm_ops cros_ec_pwm_ops = {
> +	.request = cros_ec_pwm_request,
> +	.free = cros_ec_pwm_free,

nit: Align using tabs for readability.

>  	.get_state	= cros_ec_pwm_get_state,
>  	.apply		= cros_ec_pwm_apply,
>  	.owner		= THIS_MODULE,
> 
