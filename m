Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F8E1701D3
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Feb 2020 16:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgBZPFe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Feb 2020 10:05:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44335 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgBZPFe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 26 Feb 2020 10:05:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6yFg-0003zb-DY; Wed, 26 Feb 2020 16:05:32 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j6yFg-00072S-4V; Wed, 26 Feb 2020 16:05:32 +0100
Date:   Wed, 26 Feb 2020 16:05:32 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] pwm: pca9685: migrate config/enable/disable to apply
Message-ID: <20200226150532.n45yl6hx6vjolde2@pengutronix.de>
References: <20200226135229.24929-1-matthias.schiffer@ew.tq-group.com>
 <20200226135229.24929-4-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226135229.24929-4-matthias.schiffer@ew.tq-group.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hello,

On Wed, Feb 26, 2020 at 02:52:29PM +0100, Matthias Schiffer wrote:
> For consistency with disabled state, initialize all LEDs in FULL_OFF
> state during probe.
> 
> This also fixes a broken interaction between config with 100% duty cycle
> (which would set the LED to FULL_ON) and enable (which would unset
> FULL_ON), effectively disabling the LED again when enable was called
> after config. This behaviour was observed with the leds-pwm driver when
> directly switching from 0 to maximum brightness.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  drivers/pwm/pwm-pca9685.c | 53 +++++++++++----------------------------
>  1 file changed, 14 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
> index 370691b21107..e266cbbd39bf 100644
> --- a/drivers/pwm/pwm-pca9685.c
> +++ b/drivers/pwm/pwm-pca9685.c
> @@ -219,15 +219,16 @@ static void pca9685_set_sleep_mode(struct pca9685 *pca, bool enable)
>  	}
>  }
>  
> -static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
> -			      int duty_ns, int period_ns)
> +static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			     const struct pwm_state *state)
>  {
>  	struct pca9685 *pca = to_pca(chip);
>  	unsigned long long duty;
>  	int prescale;
>  
> -	if (period_ns != pca->period_ns) {
> -		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ * period_ns,
> +	if (state->period != pca->period_ns) {
> +		prescale = DIV_ROUND_CLOSEST(PCA9685_OSC_CLOCK_MHZ *
> +					     state->period,
>  					     PCA9685_COUNTER_RANGE * 1000) - 1;
>  
>  		if (prescale >= PCA9685_PRESCALE_MIN &&
> @@ -247,7 +248,7 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  			/* Wake the chip up */
>  			pca9685_set_sleep_mode(pca, false);
>  
> -			pca->period_ns = period_ns;
> +			pca->period_ns = state->period;
>  		} else {
>  			dev_err(chip->dev,
>  				"prescaler not set: period out of bounds!\n");
> @@ -255,13 +256,13 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		}
>  	}
>  
> -	if (duty_ns < 1) {
> +	if (!state->enabled || state->duty_cycle < 1) {
> +		/* Set the full OFF bit */
>  		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
> -
>  		return 0;
>  	}
>  
> -	if (duty_ns == period_ns) {
> +	if (state->duty_cycle == state->period) {
>  		/* Clear both OFF registers */
>  		regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
>  		regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), 0x0);
> @@ -272,8 +273,8 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  		return 0;
>  	}
>  
> -	duty = PCA9685_COUNTER_RANGE * (unsigned long long)duty_ns;
> -	duty = DIV_ROUND_UP_ULL(duty, period_ns);
> +	duty = PCA9685_COUNTER_RANGE * (unsigned long long)state->duty_cycle;
> +	duty = DIV_ROUND_UP_ULL(duty, state->period);
>  
>  	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), (int)duty & 0xff);
>  	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm),
> @@ -285,29 +286,6 @@ static int pca9685_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
>  	return 0;

You seem to ignore state->polarity which is wrong.

>  }
>  
> -static int pca9685_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct pca9685 *pca = to_pca(chip);
> -
> -	/*
> -	 * Clear the full-off bit.
> -	 * It has precedence over the others and must be off.
> -	 */
> -	regmap_update_bits(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL, 0x0);
> -
> -	return 0;
> -}
> -
> -static void pca9685_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
> -{
> -	struct pca9685 *pca = to_pca(chip);
> -
> -	regmap_write(pca->regmap, LED_N_OFF_H(pwm->hwpwm), LED_FULL);
> -
> -	/* Clear the LED_OFF counter. */
> -	regmap_write(pca->regmap, LED_N_OFF_L(pwm->hwpwm), 0x0);
> -}
> -
>  static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
>  	struct pca9685 *pca = to_pca(chip);
> @@ -321,14 +299,11 @@ static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
>  
>  static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
>  {
> -	pca9685_pwm_disable(chip, pwm);
>  	pm_runtime_put(chip->dev);
>  }
>  
>  static const struct pwm_ops pca9685_pwm_ops = {
> -	.enable = pca9685_pwm_enable,
> -	.disable = pca9685_pwm_disable,
> -	.config = pca9685_pwm_config,
> +	.apply = pca9685_pwm_apply,
>  	.request = pca9685_pwm_request,
>  	.free = pca9685_pwm_free,
>  	.owner = THIS_MODULE,
> @@ -377,9 +352,9 @@ static int pca9685_pwm_probe(struct i2c_client *client,
>  
>  	regmap_write(pca->regmap, PCA9685_MODE2, mode2);
>  
> -	/* clear all "full off" bits */
> +	/* Set all LEDs full off */
>  	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_L, 0);
> -	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, 0);
> +	regmap_write(pca->regmap, PCA9685_ALL_LED_OFF_H, LED_FULL);

This looks wrong or at least unrelated?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
