Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB44231CC1
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 12:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgG2Kc2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 06:32:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:45160 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2Kc1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 06:32:27 -0400
IronPort-SDR: mzgAxdauGmnJEq9nbN6ge2FSFOFrcfJafLzbfAC4sEbDn6LfMCsBtvVZRzTTaaOMJhNjZk/4MQ
 vobKmdbsPLjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="130949479"
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="130949479"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 03:32:26 -0700
IronPort-SDR: 7JXcY8QKMRfyvr2U+9DUu54QNPqnal9ObafaFtoBTfd8foBIGR2iFqcigrxjDB49g0IcU1f8vB
 5m0A0ocWMsDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,410,1589266800"; 
   d="scan'208";a="434645151"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 29 Jul 2020 03:32:22 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0jNl-004fiD-Sm; Wed, 29 Jul 2020 13:32:21 +0300
Date:   Wed, 29 Jul 2020 13:32:21 +0300
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
Subject: Re: [PATCH v5 10/16] pwm: crc: Enable/disable PWM output on
 enable/disable
Message-ID: <20200729103221.GR3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-11-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717133753.127282-11-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Jul 17, 2020 at 03:37:47PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
> 
> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
> this commit makes crc_pwm_disable() clear it on disable and makes
> crc_pwm_enable() set it again on re-enable.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v3:
> - Remove paragraph about tri-stating the output from the commit message,
>   we don't have a datasheet so this was just an unfounded guess
> ---
>  drivers/pwm/pwm-crc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
> index 81232da0c767..b72008c9b072 100644
> --- a/drivers/pwm/pwm-crc.c
> +++ b/drivers/pwm/pwm-crc.c
> @@ -54,7 +54,9 @@ static int crc_pwm_calc_clk_div(int period_ns)
>  static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
>  {
>  	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
> +	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
>  
> +	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div | PWM_OUTPUT_ENABLE);
>  	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 1);
>  
>  	return 0;
> @@ -63,8 +65,10 @@ static int crc_pwm_enable(struct pwm_chip *c, struct pwm_device *pwm)
>  static void crc_pwm_disable(struct pwm_chip *c, struct pwm_device *pwm)
>  {
>  	struct crystalcove_pwm *crc_pwm = to_crc_pwm(c);
> +	int div = crc_pwm_calc_clk_div(pwm_get_period(pwm));
>  
>  	regmap_write(crc_pwm->regmap, BACKLIGHT_EN, 0);
> +	regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, div);
>  }
>  
>  static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
> -- 
> 2.26.2
> 

-- 
With Best Regards,
Andy Shevchenko


