Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402D4231CBA
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 12:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgG2Kau (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 06:30:50 -0400
Received: from mga12.intel.com ([192.55.52.136]:44973 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Kau (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 06:30:50 -0400
IronPort-SDR: IZ/0nN5+nQ6OiFmL8cU4ySnk1cRqDaNNt8wxWbPhwUQ1ZP9I4p6qvTUtWSr7Xf4TjyyPbASe36
 THNU3sJORKBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="130949310"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="130949310"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 03:30:49 -0700
IronPort-SDR: +HXs94QtFgBD1L6KmvEO2GzWNqNS8uhtP7T8Ettqw519VfO8AxD1T5zU54CnFW0TE6eiXelQC+
 nEhIOF1CmZWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="286473564"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2020 03:30:46 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0jMD-004fgQ-Li; Wed, 29 Jul 2020 13:30:45 +0300
Date:   Wed, 29 Jul 2020 13:30:45 +0300
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
Subject: Re: [PATCH v5 09/16] pwm: crc: Fix period changes not having any
 effect
Message-ID: <20200729103045.GQ3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-10-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:46PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
> 
> I strongly suspect that the BACKLIGHT_EN register at address 0x51 really
> controls a separate output-only GPIO which is connected to the LCD panels
> backlight-enable input. Like how the PANEL_EN register at address 0x52
> controls an output-only GPIO which is earmarked for the LCD panel's
> enable pin. If this is correct then this GPIO should really be added to
> the gpio-crystalcove.c driver and the PWM driver should stop poking it.
> But I've been unable to come up with a definitive answer here, so I'm
> keeping this as is for now.
> 
> As the comment in the old code already indicates we must disable the PWM
> before we can change the clock divider. But the crc_pwm_disable() and
> crc_pwm_enable() calls the old code make for this only change the
> BACKLIGHT_EN register; and the value of that register does not matter for
> changing the period / the divider. What does matter is that the
> PWM_OUTPUT_ENABLE bit must be cleared before a new value can be written.
> 
> This commit modifies crc_pwm_config() to clear PWM_OUTPUT_ENABLE instead
> when changing the period, so that period changes actually work.
> 
> Note this fix will cause a significant behavior change on some devices
> using the CRC PWM output to drive their backlight. Before the PWM would
> always run with the output frequency configured by the BIOS at boot, now
> the period time specified by the i915 driver will actually be honored.

We have a confirmation now that those two bits are real GPOs.

So, with corrected commit message

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/pwm/pwm-crc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 44ec7d5b63e1..81232da0c767 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -82,14 +82,11 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
>  	if (pwm_get_period(pwm) != period_ns) {
>  		int clk_div = crc_pwm_calc_clk_div(period_ns);
>  
> -		/* changing the clk divisor, need to disable fisrt */
> -		crc_pwm_disable(c, pwm);
> +		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
> +		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
>  
>  		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
>  					clk_div | PWM_OUTPUT_ENABLE);
> -
> -		/* enable back */
> -		crc_pwm_enable(c, pwm);
>  	}
>  
>  	/* change the pwm duty cycle */
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


