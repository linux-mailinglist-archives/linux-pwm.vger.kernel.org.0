Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACF121A276
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 16:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgGIOuR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 10:50:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:5994 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOuR (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Jul 2020 10:50:17 -0400
IronPort-SDR: NtF7VqloOu4BEECHyCeT9rQGJGIiIpyOtcKX/qevTa2/O3I0RkjmbM6UPbBq4RcX6iKq2agPGO
 2f2kWBO38tfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="147081022"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="147081022"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 07:50:16 -0700
IronPort-SDR: D/XUYMSp7pV3RqXOFUNrDLm8myVFN+vUXCjDbk4u4enIZwh5VeaP3rkTuAjMvg45USqZ04zgtD
 IrKqRKUSO7lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="389163251"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 07:50:13 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtXsL-000sMF-Dd; Thu, 09 Jul 2020 17:50:13 +0300
Date:   Thu, 9 Jul 2020 17:50:13 +0300
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
Subject: Re: [PATCH v4 06/16] pwm: lpss: Correct get_state result for
 base_unit == 0
Message-ID: <20200709145013.GA3703480@smile.fi.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708211432.28612-7-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jul 08, 2020 at 11:14:22PM +0200, Hans de Goede wrote:
> The datasheet specifies that programming the base_unit part of the
> ctrl register to 0 results in a contineous low signal.
> 
> Adjust the get_state method to reflect this by setting pwm_state.period
> to 1 and duty_cycle to 0.

...

> +	if (freq == 0) {
> +		/* In this case the PWM outputs a continous low signal */

> +		state->period = 1;

I guess this should be something like half of the range (so base unit calc
will give 128). Because with period = 1 (too small) it will give too small
base unit (if apply) and as a result we get high frequency pulses.

> +		state->duty_cycle = 0;
> +	} else {
>  		state->period = NSEC_PER_SEC / (unsigned long)freq;
> +		on_time_div *= state->period;
> +		do_div(on_time_div, 255);
> +		state->duty_cycle = on_time_div;
> +	}

-- 
With Best Regards,
Andy Shevchenko


