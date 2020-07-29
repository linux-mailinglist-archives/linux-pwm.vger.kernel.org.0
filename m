Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38734231CE9
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 12:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgG2Kvf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 06:51:35 -0400
Received: from mga05.intel.com ([192.55.52.43]:11145 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgG2Kve (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 06:51:34 -0400
IronPort-SDR: Ps9pl11suxZES4sz5qDp19wrfRzjZZC5DxWyI5xKqRRmwO6tZ/mI1q8cOMuE03WBZnP5J9UiEm
 H3bGpKHrkj4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="236257939"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="236257939"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 03:51:34 -0700
IronPort-SDR: a0olRvFj5gweD2gY6DUgp59jJpnFbKMuCCczKdaM4lu2UOaB9HiKESagTA4LXCSVUT1rylkgg7
 QKGQTJZzzHxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="434649021"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 03:51:30 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0jgH-004ftr-Qv; Wed, 29 Jul 2020 13:51:29 +0300
Date:   Wed, 29 Jul 2020 13:51:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v5 11/16] pwm: crc: Implement apply() method to support
 the new atomic PWM API
Message-ID: <20200729105129.GS3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-12-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-12-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:48PM +0200, Hans de Goede wrote:
> Replace the enable, disable and config pwm_ops with an apply op,
> to support the new atomic PWM API.

I didn't notice any visible issue, so
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Perhaps you may consider reusing existing _enable() / _disable(), but I don't
see if there will be nice improvement (maybe if in on of the previous patches
you also add an error handling to them first).

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Keep crc_pwm_calc_clk_div() helper to avoid needless churn
> ---
>  drivers/pwm/pwm-crc.c | 89 ++++++++++++++++++++++++++-----------------
>  1 file changed, 53 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index b72008c9b072..8a7f4707279c 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -51,59 +51,76 @@ static int crc_pwm_calc_clk_div(int period_ns)
>  	return clk_div;
>  }
>  
> -static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
> +static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
>  {
> -	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
> -	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
> -
> -	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
> -	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
> -
> -	return 0;
> -}
> -
> -static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
> -{
> -	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
> -	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
> -
> -	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
> -	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
> -}
> -
> -static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
> -			  int duty_ns, int period_ns)
> -{
> -	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
> +	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
>  	struct device *dev = crc_pwm->chip.dev;
> -	int level;
> +	int err;
>  
> -	if (period_ns > PWM_MAX_PERIOD_NS) {
> +	if (state->period > PWM_MAX_PERIOD_NS) {
>  		dev_err(dev, "un-supported period_ns\n");
>  		return -EINVAL;
>  	}
>  
> -	if (pwm_get_period(pwm) != period_ns) {
> -		int clk_div = crc_pwm_calc_clk_div(period_ns);
> +	if (state->polarity != PWM_POLARITY_NORMAL)
> +		return -EOPNOTSUPP;
> +
> +	if (pwm_is_enabled(pwm) && !state->enabled) {
> +		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
> +		if (err) {
> +			dev_err(dev, "Error writing BACKLIGHT_EN %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	if (pwm_get_duty_cycle(pwm) != state->duty_cycle ||
> +	    pwm_get_period(pwm) != state->period) {
> +		int level = state->duty_cycle * PWM_MAX_LEVEL / state->period;
>  
> +		err = regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
> +		if (err) {
> +			dev_err(dev, "Error writing PWM0_DUTY_CYCLE %d\n", err);
> +			return err;
> +		}
> +	}
> +
> +	if (pwm_is_enabled(pwm) && state->enabled &&
> +	    pwm_get_period(pwm) != state->period) {
>  		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
> -		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
> +		err = regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
> +		if (err) {
> +			dev_err(dev, "Error writing PWM0_CLK_DIV %d\n", err);
> +			return err;
> +		}
> +	}
>  
> -		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
> -					clk_div | PWM_OUTPUT_ENABLE);
> +	if (pwm_get_period(pwm) != state->period ||
> +	    pwm_is_enabled(pwm) != state->enabled) {
> +		int clk_div = crc_pwm_calc_clk_div(state->period);
> +		int pwm_output_enable = state->enabled ? PWM_OUTPUT_ENABLE : 0;
> +
> +		err = regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
> +				   clk_div | pwm_output_enable);
> +		if (err) {
> +			dev_err(dev, "Error writing PWM0_CLK_DIV %d\n", err);
> +			return err;
> +		}
>  	}
>  
> -	/* change the pwm duty cycle */
> -	level = duty_ns * PWM_MAX_LEVEL / period_ns;
> -	regmap_write(crc_pwm->regmap, PWM0_DUTY_CYCLE, level);
> +	if (!pwm_is_enabled(pwm) && state->enabled) {
> +		err = regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
> +		if (err) {
> +			dev_err(dev, "Error writing BACKLIGHT_EN %d\n", err);
> +			return err;
> +		}
> +	}
>  
>  	return 0;
>  }
>  
>  static const struct pwm_ops crc_pwm_ops = {
> -	.config = crc_pwm_config,
> -	.enable = crc_pwm_enable,
> -	.disable = crc_pwm_disable,
> +	.apply = crc_pwm_apply,
>  };
>  
>  static int crystalcove_pwm_probe(struct platform_device *pdev)
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


