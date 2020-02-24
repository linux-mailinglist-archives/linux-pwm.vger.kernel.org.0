Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E39DD16A103
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 10:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727242AbgBXJHN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 04:07:13 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:48729 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgBXJHN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 04:07:13 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j69hj-0000fq-GO; Mon, 24 Feb 2020 10:07:07 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j69hi-00070c-HT; Mon, 24 Feb 2020 10:07:06 +0100
Date:   Mon, 24 Feb 2020 10:07:06 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Implement .apply callback
Message-ID: <20200224090706.xsujpc3yiqlmmrmm@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-5-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200224052135.17278-5-lokeshvutla@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Feb 24, 2020 at 10:51:35AM +0530, Lokesh Vutla wrote:
> Implement .apply callback and drop the legacy callbacks(enable, disable,
> config, set_polarity).
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 141 +++++++++++++++++++--------------
>  1 file changed, 80 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
> index 58c61559e72f..aeda4ab12385 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -31,8 +31,18 @@
>  #define DM_TIMER_LOAD_MIN 0xfffffffe
>  #define DM_TIMER_MAX      0xffffffff
>  
> +/**
> + * struct pwm_omap_dmtimer_chip - Structure representing a pwm chip
> + *				  corresponding to omap dmtimer.
> + * @chip:		PWM chip structure representing PWM controller
> + * @mutex:		Mutex to protect pwm apply state
> + * @dm_timer:		Pointer to omap dm timer.
> + * @pdata:		Pointer to omap dm timer ops.
> + * dm_timer_pdev:	Pointer to omap dm timer platform device
> + */
>  struct pwm_omap_dmtimer_chip {
>  	struct pwm_chip chip;
> +	/* Mutex to protect pwm apply state */
>  	struct mutex mutex;
>  	struct omap_dm_timer *dm_timer;
>  	const struct omap_dm_timer_ops *pdata;
> @@ -45,11 +55,22 @@ to_pwm_omap_dmtimer_chip(struct pwm_chip *chip)
>  	return container_of(chip, struct pwm_omap_dmtimer_chip, chip);
>  }
>  
> +/**
> + * pwm_omap_dmtimer_get_clock_cycles() - Get clock cycles in a time frame
> + * @clk_rate:	pwm timer clock rate
> + * @ns:		time frame in nano seconds.
> + *
> + * Return number of clock cycles in a given period(ins ns).
> + */
>  static u32 pwm_omap_dmtimer_get_clock_cycles(unsigned long clk_rate, int ns)
>  {
>  	return DIV_ROUND_CLOSEST_ULL((u64)clk_rate * ns, NSEC_PER_SEC);
>  }
>  
> +/**
> + * pwm_omap_dmtimer_start() - Start the pwm omap dm timer in pwm mode
> + * @omap:	Pointer to pwm omap dm timer chip
> + */
>  static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
>  {
>  	/*
> @@ -67,32 +88,16 @@ static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
>  	omap->pdata->start(omap->dm_timer);
>  }
>  
> -static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
> -				   struct pwm_device *pwm)
> -{
> -	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
> -
> -	mutex_lock(&omap->mutex);
> -	omap->pdata->set_pwm(omap->dm_timer,
> -			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
> -			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> -
> -	pwm_omap_dmtimer_start(omap);
> -	mutex_unlock(&omap->mutex);
> -
> -	return 0;
> -}
> -
> -static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
> -				     struct pwm_device *pwm)
> -{
> -	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
> -
> -	mutex_lock(&omap->mutex);
> -	omap->pdata->stop(omap->dm_timer);
> -	mutex_unlock(&omap->mutex);
> -}
> -
> +/**
> + * pwm_omap_dmtimer_config() - Update the configuration of pwm omap dm timer
> + * @chip:	Pointer to PWM controller
> + * @pwm:	Pointer to PWM channel
> + * @duty_ns:	New duty cycle in nano seconds
> + * @period_ns:	New period in nano seconds
> + *
> + * Return 0 if successfully changed the period/duty_cycle else appropriate
> + * error.
> + */
>  static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  				   struct pwm_device *pwm,
>  				   int duty_ns, int period_ns)
> @@ -100,30 +105,26 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
>  	u32 period_cycles, duty_cycles;
>  	u32 load_value, match_value;
> -	struct clk *fclk;
>  	unsigned long clk_rate;
> +	struct clk *fclk;
>  
>  	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
>  		duty_ns, period_ns);
>  
> -	mutex_lock(&omap->mutex);
>  	if (duty_ns == pwm_get_duty_cycle(pwm) &&
> -	    period_ns == pwm_get_period(pwm)) {
> -		/* No change - don't cause any transients. */
> -		mutex_unlock(&omap->mutex);
> +	    period_ns == pwm_get_period(pwm))
>  		return 0;
> -	}
>  
>  	fclk = omap->pdata->get_fclk(omap->dm_timer);
>  	if (!fclk) {
>  		dev_err(chip->dev, "invalid pmtimer fclk\n");
> -		goto err_einval;
> +		return -EINVAL;
>  	}
>  
>  	clk_rate = clk_get_rate(fclk);
>  	if (!clk_rate) {
>  		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
> -		goto err_einval;
> +		return -EINVAL;
>  	}
>  
>  	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
> @@ -151,7 +152,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  		dev_info(chip->dev,
>  			 "period %d ns too short for clock rate %lu Hz\n",
>  			 period_ns, clk_rate);
> -		goto err_einval;
> +		return -EINVAL;
>  	}
>  
>  	if (duty_cycles < 1) {
> @@ -183,54 +184,72 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>  	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
>  		load_value, load_value,	match_value, match_value);
>  
> -	mutex_unlock(&omap->mutex);
> -
>  	return 0;
> -
> -err_einval:
> -	mutex_unlock(&omap->mutex);
> -
> -	return -EINVAL;
>  }
>  
> -static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
> -					 struct pwm_device *pwm,
> -					 enum pwm_polarity polarity)
> +/**
> + * pwm_omap_dmtimer_apply() - Changes the state of the pwm omap dm timer.
> + * @chip:	Pointer to PWM controller
> + * @pwm:	Pointer to PWM channel
> + * @state:	New sate to apply
> + *
> + * Return 0 if successfully changed the state else appropriate error.
> + */
> +static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
> +				  struct pwm_device *pwm,
> +				  const struct pwm_state *state)
>  {
>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
> +	int ret = 0;
>  
> -	/*
> -	 * PWM core will not call set_polarity while PWM is enabled so it's
> -	 * safe to reconfigure the timer here without stopping it first.
> -	 */
>  	mutex_lock(&omap->mutex);
> -	omap->pdata->set_pwm(omap->dm_timer,
> -			     polarity == PWM_POLARITY_INVERSED,
> -			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
> +
> +	if (pwm_is_enabled(pwm) && !state->enabled) {

In my book calling PWM API functions (designed for PWM consumers) is not
so nice. I would prefer you checking the hardware registers or cache the
state locally instead of relying on the core here.

It would be great to have a general description at the top of the driver
(like for example drivers/pwm/pwm-sifive.c) that answers things like:

 - Does calling .stop completes the currently running period (it
   should)?
 - Does changing polarity, duty_cycle and period complete the running
   period?
 - How does the hardware behave on disable? (i.e. does it output the
   state the pin is at in that moment? Does it go High-Z?)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |
