Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F8721A1FE
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jul 2020 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGIOWN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Jul 2020 10:22:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:27900 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbgGIOWN (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Jul 2020 10:22:13 -0400
IronPort-SDR: FGZkNEhvR9IPJNJLkfm3dnifipB0RU/1yOZ5dpppnqA/XczDAmNA/qOachNIMhu7NQ8f2O45TX
 TEen4vF1x0YA==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="232875370"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="232875370"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 07:21:38 -0700
IronPort-SDR: c2WIKw4jfQ8WTE9lh+uAwWd89MuxcMUjbFQPViJoLVlrvVbVeTLWDRAbZidHF3hgSXNXxDFfqc
 i96O0/v0+G8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="scan'208";a="268763781"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2020 07:21:35 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jtXQe-000s8i-5u; Thu, 09 Jul 2020 17:21:36 +0300
Date:   Thu, 9 Jul 2020 17:21:36 +0300
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
Subject: Re: [PATCH v4 04/16] pwm: lpss: Add range limit check for the
 base_unit register value
Message-ID: <20200709142136.GZ3703480@smile.fi.intel.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
 <20200708211432.28612-5-hdegoede@redhat.com>
 <20200709125342.GX3703480@smile.fi.intel.com>
 <4ff9dc18-fa59-d9a3-c7bf-9f95c62fc356@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ff9dc18-fa59-d9a3-c7bf-9f95c62fc356@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Jul 09, 2020 at 03:23:13PM +0200, Hans de Goede wrote:
> On 7/9/20 2:53 PM, Andy Shevchenko wrote:
> > On Wed, Jul 08, 2020 at 11:14:20PM +0200, Hans de Goede wrote:
> > > When the user requests a high enough period ns value, then the
> > > calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
> > > 
> > > But according to the data-sheet the way the PWM controller works is that
> > > each input clock-cycle the base_unit gets added to a N bit counter and
> > > that counter overflowing determines the PWM output frequency. Adding 0
> > > to the counter is a no-op. The data-sheet even explicitly states that
> > > writing 0 to the base_unit bits will result in the PWM outputting a
> > > continuous 0 signal.
> > 
> > And I don't see how you can get duty 100% / 0% (I don't remember which one is
> > equivalent to 0 in base unit) after this change. IIRC the problem here that
> > base unit when non-zero is always being added to the counter and it will
> > trigger the change of output at some point which is not what we want for 100% /
> > 0% cases.
> 
> The base_unit controls the output frequency, not the duty-cycle. So clamping
> the base_unit, as calculated from the period here, which also only configures
> output-frequency does not impact the duty-cycle at all.
> 
> note that AFAICT currently no (in kernel) users actually try to set a period value
> which would hit the clamp, so for existing users the clamp is a no-op. I just
> added it to this patch-set for correctness sake and because userspace
> (sysfs interface) users could in theory set out of range values.
> 
> As for the duty-cycle thing, first of all let me say that that is a
> question / issue which is completely orthogonal to this patch, this
> patch only impacts the period/output frequency NOT the duty-cycle,

Unfortunately the base unit settings affects duty cycle.

Documentation says about integer part and fractional, where integer is
8 bit and this what's being compared to on time divisor. Thus, if on time
divisor is 255 and base unit is 1 (in integer part) or 0.25, we can't get 0%.
(It looks like if 'on time divisor MOD base unit == 0' we won't get 0%)

> With that said, the documentation is not really helpful here,
> we need to set the on_time_div to 255 to get a duty-cycle close to 0
> (and to 0 to get a duty cycle of 100%) but if setting this to 255 gives
> us a duty-cycle of really really 0%, or just close to 0% is uncleaer.

It depends on base unit value.

> We could do a separate patch add ing a hack where if the user asks for
> 0% duty-cycle we program the base_unit to 0, but that seems like a bad
> idea for 2 reasons:

> 1. If the user really wants the output to be constantly 0 the user should
> just disable the pwm

I can't take this as an argument. Disabling PWM is orthogonal to what duty cycle is.

> 2. New base_unit values are latched and not applied until the counter
> overflows, with a base_unit of 0 the counter never overflows. I have
> not tested this but I would not be surprised if after programming a
> base_unit value of 0, we are unable to ever change the value again
> through any other means then power-cycling the PWM controller.
> Even if I could test this on some revisions, we already know that
> not all revisions work the same wrt the latching. So it is best to
> just never set base_unit to 0, that is just a recipe asking for trouble.

This what doc says about zeros:
• Programming either the PWM_base_unit value or the PWM_on_time_divisor to ‘0’
will generate an always zero output.

So, what I'm talking seems about correlation between base unit and on time
divisor rather than zeros.

I agree with this patch.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> > > When the user requestes a low enough period ns value, then the
> > > calculations in pwm_lpss_prepare() might result in a base_unit value
> > > which is bigger then base_unit_range - 1. Currently the codes for this
> > > deals with this by applying a mask:
> > > 
> > > 	base_unit &= (base_unit_range - 1);
> > > 
> > > But this means that we let the value overflow the range, we throw away the
> > > higher bits and store whatever value is left in the lower bits into the
> > > register leading to a random output frequency, rather then clamping the
> > > output frequency to the highest frequency which the hardware can do.
> > 
> > It would be nice to have an example of calculus here.
> > 
> > > This commit fixes both issues by clamping the base_unit value to be
> > > between 1 and (base_unit_range - 1).
> > 
> > Eventually I sat and wrote all this on paper. I see now that the problem
> > is in out of range of the period. And strongly we should clamp rather period
> > to the supported range, but your solution is an equivalent.
> 
> Right, the advantage of doing the clamping on the register value is that we
> avoid some tricky math with possible rounding errors and which is different
> per controller revision because the number of bits in the base unit being
> different per controller revision.

...

> > > +	base_unit = clamp_t(unsigned long long, base_unit, 1,
> > > +			    base_unit_range - 1);
> > 
> > A nit: one line.
> 
> Doesn't fit in 80 chars, I guess we could make this one line now with the new 100 chars
> limit, but that does make it harder to read for people using standard terminal widths
> and a terminal based editors. So I would prefer to keep this as is.

You can use clamp_val().

-- 
With Best Regards,
Andy Shevchenko


