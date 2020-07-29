Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E43231AF1
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 10:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2IN4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 04:13:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:30332 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgG2IN4 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 04:13:56 -0400
IronPort-SDR: vHEm4cEsyGqVaya6QdjkITgQQMNMnancIwJqhnM1NRiX0QttSwtNqjJq3Op52SZr5zl4lR+GbE
 S/JANGnG2KoQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148834894"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="148834894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 01:13:55 -0700
IronPort-SDR: v4mYzCYYgFHIjPW6+3L/hGZvzMt5jd8xIIJ9N5cagq1hjgzlCSvrE0wPXty/f/epuvybq5XWY3
 PhGuv7sxBulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="322477465"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2020 01:13:51 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0hDj-004eLZ-Bu; Wed, 29 Jul 2020 11:13:51 +0300
Date:   Wed, 29 Jul 2020 11:13:51 +0300
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
Subject: Re: [PATCH v5 07/16] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
Message-ID: <20200729081351.GI3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717133753.127282-8-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:44PM +0200, Hans de Goede wrote:
> While looking into adding atomic-pwm support to the pwm-crc driver I
> noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
> there is a clock-divider which divides this with a value between 1-128,
> and there are 256 duty-cycle steps.
> 
> The pwm-crc code before this commit assumed that a clock-divider
> setting of 1 means that the PWM output is running at 6 MHZ, if that
> is true, where do these 256 duty-cycle steps come from?
> 
> This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
> seems unlikely for a PMIC which is using a silicon process optimized for
> power-switching transistors. It is way more likely that there is an 8
> bit counter for the duty cycle which acts as an extra fixed divider
> wrt the PWM output frequency.
> 
> The main user of the pwm-crc driver is the i915 GPU driver which uses it
> for backlight control. Lets compare the PWM register values set by the
> video-BIOS (the GOP), assuming the extra fixed divider is present versus
> the PWM frequency specified in the Video-BIOS-Tables:
> 
> Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
> Asus T100TA 	200			200
> Asus T100HA 	200			200
> Lenovo Miix 2 8	23437			20000
> Toshiba WT8-A	23437			20000
> 
> So as we can see if we assume the extra division by 256 then the register
> values set by the GOP are an exact match for the VBT values, where as
> otherwise the values would be of by a factor of 256.
> 
> This commit fixes the period / duty_cycle calculations to take the
> extra division by 256 into account.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Use NSEC_PER_USEC instead of adding a new (non-sensical) NSEC_PER_MHZ define
> ---
>  drivers/pwm/pwm-crc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 272eeb071147..c056eb9b858c 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -21,8 +21,8 @@
>  
>  #define PWM_MAX_LEVEL		0xFF
>  
> -#define PWM_BASE_CLK		6000000  /* 6 MHz */
> -#define PWM_MAX_PERIOD_NS	21333    /* 46.875KHz */
> +#define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
> +#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
>  
>  /**
>   * struct crystalcove_pwm - Crystal Cove PWM controller
> @@ -72,7 +72,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
>  
>  		/* changing the clk divisor, need to disable fisrt */
>  		crc_pwm_disable(c, pwm);
> -		clk_div = PWM_BASE_CLK * period_ns / NSEC_PER_SEC;
> +		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_USEC);
>  
>  		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
>  					clk_div | PWM_OUTPUT_ENABLE);
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


