Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5F21F39BF
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 13:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFILbR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 07:31:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:16519 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbgFILbO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jun 2020 07:31:14 -0400
IronPort-SDR: GGAMj9p+4vvyGoqlXRZey/lx9MB3RnVylu8ZED2V4jF0aVJLbEdR4/nmQVlyXPsmGvYC2MvCe2
 FHG7SMI6CyAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 04:31:13 -0700
IronPort-SDR: 90xVIqVw9Ze5b+8NRYAm/VSIQ0a/8K2zE0O5f31SzMgtC4sgrbDd6iluxqxcZDBhA8G3UNcQ+A
 QZyvC+8wwuuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="274573641"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006.jf.intel.com with ESMTP; 09 Jun 2020 04:31:10 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jicTI-00Bt5p-Mk; Tue, 09 Jun 2020 14:31:12 +0300
Date:   Tue, 9 Jun 2020 14:31:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 09/15] pwm: crc: Enable/disable PWM output on
 enable/disable
Message-ID: <20200609113112.GL2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-10-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-10-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:34PM +0200, Hans de Goede wrote:
> The pwm-crc code is using 2 different enable bits:
> 1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
> 2. bit 0 of the BACKLIGHT_EN register
> 
> So far we've kept the PWM_OUTPUT_ENABLE bit set when disabling the PWM,
> this commit makes crc_pwm_disable() clear it on disable and makes
> crc_pwm_enable() set it again on re-enable.
> 
> This should disable the internal (divided) PWM clock and tri-state the
> PWM output pin when disabled, saving some power.

...

> +static int crc_pwm_calc_clk_div(int period_ns)
> +{
> +	int clk_div;
> +
> +	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
> +	/* clk_div 1 - 128, maps to register values 0-127 */
> +	if (clk_div > 0)
> +		clk_div--;
> +
> +	return clk_div;
> +}

You can reduce ping-pong format of the series if you introduced this helper in
the patch that adds -1 to clock divisor.

-- 
With Best Regards,
Andy Shevchenko


