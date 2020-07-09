Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E435121A0FD
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 15:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGINgN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 09:36:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:65395 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgGINgM (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Jul 2020 09:36:12 -0400
IronPort-SDR: gxP3V5AVSYi82NCwg0FtJ59wvAEKoQP6sZjs3kiwT4MVgR1Kdecp2CGss6ALqhwUJh61bWuUtg
 uk/tpskFnjCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="146078911"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="146078911"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 06:36:12 -0700
IronPort-SDR: UboHJqh1nndBjOld5+xN9RqqWuNwLZizV1X/1HZBDQgavEA+WWzfEFH2R70Yko5iGln5KPA3ON
 A3TGACA3fk/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="358442727"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 09 Jul 2020 06:36:08 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtWif-000rnE-BI; Thu, 09 Jul 2020 16:36:09 +0300
Date:   Thu, 9 Jul 2020 16:36:09 +0300
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
Subject: Re: [PATCH v4 05/16] pwm: lpss: Use pwm_lpss_apply() when restoring
 state on resume
Message-ID: <20200709133609.GY3703480@smile.fi.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-6-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708211432.28612-6-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 08, 2020 at 11:14:21PM +0200, Hans de Goede wrote:
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

> +static int __pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			    const struct pwm_state *state, bool from_resume)
>  {
>  	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
>  	int ret;
>  
>  	if (state->enabled) {
>  		if (!pwm_is_enabled(pwm)) {
> -			pm_runtime_get_sync(chip->dev);
> +			if (!from_resume)
> +				pm_runtime_get_sync(chip->dev);
> +
>  			ret = pwm_lpss_is_updating(pwm);
>  			if (ret) {
> -				pm_runtime_put(chip->dev);
> +				if (!from_resume)
> +					pm_runtime_put(chip->dev);
> +
>  				return ret;
>  			}
>  			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
>  			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
>  			ret = pwm_lpss_wait_for_update(pwm);
>  			if (ret) {
> -				pm_runtime_put(chip->dev);
> +				if (!from_resume)
> +					pm_runtime_put(chip->dev);
> +
>  				return ret;
>  			}
>  			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);

>  		}
>  	} else if (pwm_is_enabled(pwm)) {
>  		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> -		pm_runtime_put(chip->dev);
> +
> +		if (!from_resume)
> +			pm_runtime_put(chip->dev);
>  	}

I'm wondering if splitting more will make this look better, like:

	...
	if (from_resume) {
		ret = pwm_lpss_prepare_enable(...); // whatever name you think suits better
	} else {
		pm_runtime_get_sync(...);
		ret = pwm_lpss_prepare_enable(...);
		if (ret)
			pm_runtime_put(...);
	}
	...

-- 
With Best Regards,
Andy Shevchenko


