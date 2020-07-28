Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453B323120E
	for <lists+linux-pwm@lfdr.de>; Tue, 28 Jul 2020 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732550AbgG1S5J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 28 Jul 2020 14:57:09 -0400
Received: from mga09.intel.com ([134.134.136.24]:51118 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728782AbgG1S5J (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 28 Jul 2020 14:57:09 -0400
IronPort-SDR: /ZZs1w6oH5xECtkCBWVOXBVv+boZ+pt1fwUPONo9Z41X1VFOs4ZQPRlPq4Cf4UjH92eByXMw3o
 7cLlX6rpK6TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="152537800"
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="152537800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2020 11:57:07 -0700
IronPort-SDR: UmduEKAs43os32xUjafr9i+QhylJuv1Ke5h4kc5YbuMpJDI/CH0Q6CjoAW8Gt55YsmGeo6NmF6
 aH/dwdSgnEGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,407,1589266800"; 
   d="scan'208";a="286260467"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2020 11:57:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0Umd-004WCX-TA; Tue, 28 Jul 2020 21:57:03 +0300
Date:   Tue, 28 Jul 2020 21:57:03 +0300
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
Subject: Re: [PATCH v5 06/16] pwm: lpss: Use pwm_lpss_apply() when restoring
 state on resume
Message-ID: <20200728185703.GA3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-7-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:43PM +0200, Hans de Goede wrote:
> Before this commit a suspend + resume of the LPSS PWM controller
> would result in the controller being reset to its defaults of
> output-freq = clock/256, duty-cycle=100%, until someone changes
> to the output-freq and/or duty-cycle are made.
> 
> This problem has been masked so far because the main consumer
> (the i915 driver) was always making duty-cycle changes on resume.
> With the conversion of the i915 driver to the atomic PWM API the
> driver now only disables/enables the PWM on suspend/resume leaving
> the output-freq and duty as is, triggering this problem.
> 
> The LPSS PWM controller has a mechanism where the ctrl register value
> and the actual base-unit and on-time-div values used are latched. When
> software sets the SW_UPDATE bit then at the end of the current PWM cycle,
> the new values from the ctrl-register will be latched into the actual
> registers, and the SW_UPDATE bit will be cleared.
> 
> The problem is that before this commit our suspend/resume handling
> consisted of simply saving the PWM ctrl register on suspend and
> restoring it on resume, without setting the PWM_SW_UPDATE bit.
> When the controller has lost its state over a suspend/resume and thus
> has been reset to the defaults, just restoring the register is not
> enough. We must also set the SW_UPDATE bit to tell the controller to
> latch the restored values into the actual registers.
> 
> Fixing this problem is not as simple as just or-ing in the value which
> is being restored with SW_UPDATE. If the PWM was enabled before we must
> write the new settings + PWM_SW_UPDATE before setting PWM_ENABLE.
> We must also wait for PWM_SW_UPDATE to become 0 again and depending on the
> model we must do this either before or after the setting of PWM_ENABLE.
> 
> All the necessary logic for doing this is already present inside
> pwm_lpss_apply(), so instead of duplicating this inside the resume
> handler, this commit makes the resume handler use pwm_lpss_apply() to
> restore the settings when necessary. This fixes the output-freq and
> duty-cycle being reset to their defaults on resume.

...

> -static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> -			  const struct pwm_state *state)
> +static int __pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state, bool from_resume)
>  {
>  	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>  	int ret = 0;
>  
>  	if (state->enabled) {
>  		if (!pwm_is_enabled(pwm)) {
> -			pm_runtime_get_sync(chip->dev);
> +			if (!from_resume)
> +				pm_runtime_get_sync(chip->dev);
> +
>  			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
> -			if (ret)
> +			if (ret && !from_resume)
>  				pm_runtime_put(chip->dev);
>  		} else {
>  			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
>  		}
>  	} else if (pwm_is_enabled(pwm)) {
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> -		pm_runtime_put(chip->dev);
> +
> +		if (!from_resume)
> +			pm_runtime_put(chip->dev);
>  	}
>  
>  	return ret;
>  }

Maybe I'm too picky, but I would go even further and split apply to two versions

static int pwm_lpss_apply_on_resume(struct pwm_chip *chip, struct pwm_device *pwm,
			  const struct pwm_state *state)
>  {
>  	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>  
>  	if (state->enabled)
>  		return pwm_lpss_prepare_enable(lpwm, pwm, state, !pwm_is_enabled(pwm));
>  	if (pwm_is_enabled(pwm)) {
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
>  	return 0;
>  }

and another one for !from_resume.

> +static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			  const struct pwm_state *state)
> +{
> +	return __pwm_lpss_apply(chip, pwm, state, false);
> +}

...

> +		ret = __pwm_lpss_apply(&lpwm->chip, pwm, &saved_state, true);
> +		if (ret)
> +			dev_err(dev, "Error restoring state on resume\n");

I'm wondering if it's a real error why we do not bail out?
Otherwise dev_warn() ?

-- 
With Best Regards,
Andy Shevchenko


