Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23FD8231CB0
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 12:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgG2K3A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 06:29:00 -0400
Received: from mga03.intel.com ([134.134.136.65]:18201 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2K3A (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 06:29:00 -0400
IronPort-SDR: mHhQHEdVd4KLR8DQ/JjfXst1N7oF2XFdty9Z5A/MF4Z+T65pbOH/9wOY3t3hYB/8GhLTa2Votx
 xPUR0rfgEnxw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="151372097"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="151372097"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 03:28:59 -0700
IronPort-SDR: pFmGOE9DMDUahmu6PJQM3J5A2wCVQQ5sHKOG7eFdxyD/ywAhnoazswxstxySaUcNNceehnJwEc
 BArPWz+zBtng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="273851313"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 29 Jul 2020 03:28:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0jKR-004ffH-Rm; Wed, 29 Jul 2020 13:28:55 +0300
Date:   Wed, 29 Jul 2020 13:28:55 +0300
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
Subject: Re: [PATCH v5 08/16] pwm: crc: Fix off-by-one error in the
 clock-divider calculations
Message-ID: <20200729102855.GP3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-9-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:45PM +0200, Hans de Goede wrote:
> The CRC PWM controller has a clock-divider which divides the clock with
> a value between 1-128. But as can seen from the PWM_DIV_CLK_xxx
> defines, this range maps to a register value of 0-127.
> 
> So after calculating the clock-divider we must subtract 1 to get the
> register value, unless the requested frequency was so high that the
> calculation has already resulted in a (rounded) divider value of 0.
> 
> Note that before this fix, setting a period of PWM_MAX_PERIOD_NS which
> corresponds to the max. divider value of 128 could have resulted in a
> bug where the code would use 128 as divider-register value which would
> have resulted in an actual divider value of 0 (and the enable bit being
> set). A rounding error stopped this bug from actually happen. This
> same rounding error means that after the subtraction of 1 it is impossible
> to set the divider to 128. Also bump PWM_MAX_PERIOD_NS by 1 ns to allow
> setting a divider of 128 (register-value 127).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Introduce crc_pwm_calc_clk_div() here instead of later in the patch-set
>   to reduce the amount of churn in the patch-set a bit
> ---
>  drivers/pwm/pwm-crc.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index c056eb9b858c..44ec7d5b63e1 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -22,7 +22,7 @@
>  #define PWM_MAX_LEVEL		0xFF
>  
>  #define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
> -#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
> +#define PWM_MAX_PERIOD_NS	5461334	/* 183 Hz */
>  
>  /**
>   * struct crystalcove_pwm - Crystal Cove PWM controller
> @@ -39,6 +39,18 @@ static inline struct crystalcove_pwm *to_crc_pwm(struct pwm_chip *pc)
>  	return container_of(pc, struct crystalcove_pwm, chip);
>  }
>  
> +static int crc_pwm_calc_clk_div(int period_ns)
> +{
> +	int clk_div;
> +
> +	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
> +	/* clk_div 1 - 128, maps to register values 0-127 */
> +	if (clk_div > 0)
> +		clk_div--;
> +
> +	return clk_div;
> +}
> +
>  static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
>  {
>  	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
> @@ -68,11 +80,10 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
>  	}
>  
>  	if (pwm_get_period(pwm) != period_ns) {
> -		int clk_div;
> +		int clk_div = crc_pwm_calc_clk_div(period_ns);
>  
>  		/* changing the clk divisor, need to disable fisrt */
>  		crc_pwm_disable(c, pwm);
> -		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
>  
>  		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
>  					clk_div | PWM_OUTPUT_ENABLE);
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


