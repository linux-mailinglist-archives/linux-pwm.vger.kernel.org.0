Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353552575E5
	for <lists+linux-pwm@lfdr.de>; Mon, 31 Aug 2020 10:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHaI47 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 Aug 2020 04:56:59 -0400
Received: from mga05.intel.com ([192.55.52.43]:5987 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725978AbgHaI44 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 Aug 2020 04:56:56 -0400
IronPort-SDR: 28Z6gUHx1DkRsYuybJS/tGT3eZgvj9GpbVwHcE5kWmoCQm9UHzKHNySOkSqjbVe4WLRcAGVnQo
 3VdMSSF7+Xjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="241745504"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="241745504"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 01:56:55 -0700
IronPort-SDR: 9yN/1yUHqKELgGxgDMn4zYS+tfQ0H1S1gvVgEktTHAZNke7hmJJp9nZHec9rRoqP0OkxoPRziL
 nwHRUbc8FLAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="330626277"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 31 Aug 2020 01:56:52 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kCfcP-00CvS5-HF; Mon, 31 Aug 2020 11:56:49 +0300
Date:   Mon, 31 Aug 2020 11:56:49 +0300
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
Subject: Re: [PATCH v8 07/17] pwm: lpss: Always update state and set update
 bit
Message-ID: <20200831085649.GB1891694@smile.fi.intel.com>
References: <20200830125753.230420-1-hdegoede@redhat.com>
 <20200830125753.230420-8-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830125753.230420-8-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Aug 30, 2020 at 02:57:43PM +0200, Hans de Goede wrote:
> This commit removes a check where we would skip writing the ctrl register
> and then setting the update bit in case the ctrl register already contains
> the correct values.
> 
> In a perfect world skipping the update should be fine in these cases, but
> on Cherry Trail devices the AML code in the GFX0 devices' PS0 and PS3
> methods messes with the PWM controller.
> 
> The "ACPI / LPSS: Resume Cherry Trail PWM controller in no-irq phase" patch
> earlier in this series stops the GFX0._PS0 method from messing with the PWM
> controller and on the DSDT-s inspected sofar the _PS3 method only reads
> from the PWM controller (and turns it off before we get a change to do so):
> 
>     {
>         PWMB = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>         PSAT |= 0x03
>         Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>     }
> 
> The PWM controller getting turning off before we do this ourselves is
> a bit annoying but not really an issue.
> 
> The problem this patch fixes comes from a new variant of the GFX0._PS3 code
> messing with the PWM controller found on the Acer One 10 S1003 (1):
> 
>     {
>         PWMB = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>         PWMT = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>         PWMT &= 0xFF0000FF
>         PWMT |= 0xC0000000
>         PWMC = PWMT /* \_SB_.PCI0.GFX0.PWMT */
>         PWMT = PWMC /* \_SB_.PCI0.GFX0.PWMC */
>         Sleep (0x64)
>         PWMB &= 0x3FFFFFFF
>         PWMC = PWMB /* \_SB_.PCI0.GFX0.PWMB */
>         PSAT |= 0x03
>         Local0 = PSAT /* \_SB_.PCI0.GFX0.PSAT */
>     }
> 
> This "beautiful" piece of code clears the base-unit part of the ctrl-reg,
> which effectively disables the controller, and it sets the update flag
> to apply this change. Then after this it restores the original ctrl-reg
> value, so we do not see it has mucked with the controller.
> 
> *But* it does not set the update flag when restoring the original value.
> So the check to see if we can skip writing the ctrl register succeeds
> but since the update flag was not set, the old base-unit value of 0 is
> still in use and the PWM controller is effectively disabled.
> 
> IOW this PWM controller poking means that we cannot trust the base-unit /
> on-time-div value we read back from the PWM controller since it may not
> have been applied/committed. Thus we must always update the ctrl-register
> and set the update bit.
> 
> 1) And once I knew what to look for also in a bunch of other devices
> including the popular Lenovo Ideapad Miix 310 and 320 models and
> various Medion models.

Despite the above mentioned issue I'm always in favour of not micro-optimizing I/O.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v8:
> - New patch in v8 of this patch-set
> ---
>  drivers/pwm/pwm-lpss.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 9a7400c6fb6e..20f6b6d6f874 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -85,7 +85,7 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>  	unsigned long long on_time_div;
>  	unsigned long c = lpwm->info->clk_rate, base_unit_range;
>  	unsigned long long base_unit, freq = NSEC_PER_SEC;
> -	u32 orig_ctrl, ctrl;
> +	u32 ctrl;
>  
>  	do_div(freq, period_ns);
>  
> @@ -104,16 +104,14 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
>  	do_div(on_time_div, period_ns);
>  	on_time_div = 255ULL - on_time_div;
>  
> -	orig_ctrl = ctrl = pwm_lpss_read(pwm);
> +	ctrl = pwm_lpss_read(pwm);
>  	ctrl &= ~PWM_ON_TIME_DIV_MASK;
>  	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
>  	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
>  	ctrl |= on_time_div;
>  
> -	if (orig_ctrl != ctrl) {
> -		pwm_lpss_write(pwm, ctrl);
> -		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> -	}
> +	pwm_lpss_write(pwm, ctrl);
> +	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
>  }
>  
>  static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
> -- 
> 2.28.0
> 

-- 
With Best Regards,
Andy Shevchenko


