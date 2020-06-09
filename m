Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCC301F39C5
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 13:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbgFILcW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 07:32:22 -0400
Received: from mga03.intel.com ([134.134.136.65]:14623 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgFILcV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jun 2020 07:32:21 -0400
IronPort-SDR: byFtijlj3feCYnrD57gGmwMovKU1IY90LMG8T56/71MD3Rn0m1x4aEGdf+X/9XXxNESCRfC46t
 JFov96dLPZAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 04:32:21 -0700
IronPort-SDR: L0LgvNBi2k6f5iiXQc4Wblsaksrz/TWDy7KllAeR1Qs6vh54ijqNBYzq2t02RDsc6eudKjrxJX
 PcqDhIfvqRCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="349492878"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga001.jf.intel.com with ESMTP; 09 Jun 2020 04:32:18 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jicUO-00Bt6r-ID; Tue, 09 Jun 2020 14:32:20 +0300
Date:   Tue, 9 Jun 2020 14:32:20 +0300
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
Subject: Re: [PATCH v2 10/15] pwm: crc: Implement apply() method to support
 the new atomic PWM API
Message-ID: <20200609113220.GM2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-11-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-11-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:35PM +0200, Hans de Goede wrote:
> Replace the enable, disable and config pwm_ops with an apply op,
> to support the new atomic PWM API.

...

> -static int crc_pwm_calc_clk_div(int period_ns)
> +static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
> +			 const struct pwm_state *state)
>  {
> -	int clk_div;
> -
> -	clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
> -	/* clk_div 1 - 128, maps to register values 0-127 */
> -	if (clk_div > 0)
> -		clk_div--;
> -
> -	return clk_div;
> -}

...

> +		clk_div = PWM_BASE_CLK_MHZ * state->period /
> +			  (256 * NSEC_PER_MHZ);
> +		/* clk_div 1 - 128, maps to register values 0-127 */
> +		if (clk_div > 0)
> +			clk_div--;

And again... :-(

-- 
With Best Regards,
Andy Shevchenko


