Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E662B3762
	for <lists+linux-pwm@lfdr.de>; Sun, 15 Nov 2020 18:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgKORqH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 15 Nov 2020 12:46:07 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:33940 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgKORqG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 15 Nov 2020 12:46:06 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 5FA99C6866D;
        Sun, 15 Nov 2020 18:46:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1605462364;
        bh=h/kcm0FO/W0fKCze/8YCez+uBq+/uq+gZJnSPzZRTF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ouWlu2zLdO1v2qo+fNCXl31OK7pXSCwWZS9u9XDnG3P7kVDs6eeUCbBNsnx+2iI03
         dqAmBzgtKgCg/Cf1BmKM3tx8xi+HrfwAprfjIlbubFTuVas+edx019ID2Z0buJfTLk
         LuR/qzkIwF98q6AkKM5ualQiH0bunuP5uiFTbUo8=
Date:   Sun, 15 Nov 2020 18:46:03 +0100
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] pwm: pca9685: fix duty cycle loss on disable/enable
Message-ID: <20201115174603.GA87405@workstation.tuxnet>
References: <20201112163751.204187-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112163751.204187-1-clemens.gruber@pqgruber.com>
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Nov 12, 2020 at 05:37:50PM +0100, Clemens Gruber wrote:
> Currently, disabling a pwm channel clears the OFF registers, which
> resets the configured duty cycle. Therefore, after a disable/enable
> sequence, the pwm state is not in the same state as it was before.
> As a workaround, the user had to do a config call after disable/enable.
> 
> Fix it by only toggling the "full-off" bit in disable/enable and no
> longer use the "full-on" / "full-off" bits in config.
> 
> From now on, the "full-on" bit is only used in GPIO mode and the
> "full-off" bit is only used in disable/enable, which also reduces
> complexity in the driver.
> 
> Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 83 +++++----------------------------------
>  1 file changed, 9 insertions(+), 74 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 4a55dc18656c..df214758256e 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -283,45 +283,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		}
>  	}
>  
> -	if (duty_ns < 1) {
> -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -			reg = PCA9685_ALL_LED_OFF_H;
> -		else
> -			reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, LED_FULL);
> -
> -		return 0;
> -	}
> -
> -	if (duty_ns == period_ns) {
> -		/* Clear both OFF registers */
> -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -			reg = PCA9685_ALL_LED_OFF_L;
> -		else
> -			reg = LED_N_OFF_L(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, 0x0);
> -
> -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -			reg = PCA9685_ALL_LED_OFF_H;
> -		else
> -			reg = LED_N_OFF_H(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, 0x0);
> -
> -		/* Set the full ON bit */
> -		if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -			reg = PCA9685_ALL_LED_ON_H;
> -		else
> -			reg = LED_N_ON_H(pwm->hwpwm);
> -
> -		regmap_write(pca->regmap, reg, LED_FULL);
> -
> -		return 0;
> -	}
> -
> -	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> +	duty = (PCA9685_COUNTER_RANGE - 1) * (unsigned long long)duty_ns;
>  	duty = DIV_ROUND_UP_ULL(duty, period_ns);
>  
>  	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> @@ -338,14 +300,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  
>  	regmap_write(pca->regmap, reg, ((int)duty >> 8) & 0xf);
>  
> -	/* Clear the full ON bit, otherwise the set OFF time has no effect */
> -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -		reg = PCA9685_ALL_LED_ON_H;
> -	else
> -		reg = LED_N_ON_H(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0);
> -
>  	return 0;
>  }
>  
> @@ -354,24 +308,6 @@ static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct pca9685 *pca = to_pca(chip);
>  	unsigned int reg;
>  
> -	/*
> -	 * The PWM subsystem does not support a pre-delay.
> -	 * So, set the ON-timeout to 0
> -	 */
> -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -		reg = PCA9685_ALL_LED_ON_L;
> -	else
> -		reg = LED_N_ON_L(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0);
> -
> -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -		reg = PCA9685_ALL_LED_ON_H;
> -	else
> -		reg = LED_N_ON_H(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0);
> -
>  	/*
>  	 * Clear the full-off bit.
>  	 * It has precedence over the others and must be off.
> @@ -391,20 +327,16 @@ static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
>  	struct pca9685 *pca = to_pca(chip);
>  	unsigned int reg;
>  
> +	/*
> +	 * Set the full-off bit.
> +	 * It has precedence over the others.
> +	 */
>  	if (pwm->hwpwm >= PCA9685_MAXCHAN)
>  		reg = PCA9685_ALL_LED_OFF_H;
>  	else
>  		reg = LED_N_OFF_H(pwm->hwpwm);
>  
> -	regmap_write(pca->regmap, reg, LED_FULL);
> -
> -	/* Clear the LED_OFF counter. */
> -	if (pwm->hwpwm >= PCA9685_MAXCHAN)
> -		reg = PCA9685_ALL_LED_OFF_L;
> -	else
> -		reg = LED_N_OFF_L(pwm->hwpwm);
> -
> -	regmap_write(pca->regmap, reg, 0x0);
> +	regmap_update_bits(pca->regmap, reg, LED_FULL, LED_FULL);
>  }
>  
>  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
> @@ -487,6 +419,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  	/* Clear all "full off" bits */
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> +	/* Clear all "on" regs */
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_L, 0);
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_ON_H, 0);
>  
>  	pca->chip.ops = &pca9685_pwm_ops;
>  	/* Add an extra channel for ALL_LED */
> -- 
> 2.29.2
> 

Please ignore the whole series (we found a flaw!).

Will send a v2 in the upcoming week.

Best regards,
Clemens
