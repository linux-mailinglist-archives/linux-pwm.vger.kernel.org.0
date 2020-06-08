Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88E931F196C
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 14:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgFHMzy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Jun 2020 08:55:54 -0400
Received: from mga14.intel.com ([192.55.52.115]:6911 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729543AbgFHMzq (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 8 Jun 2020 08:55:46 -0400
IronPort-SDR: /on35IMGohc1AJZ4zG6wg5UM0dTCsBBys7CGTbgBm6i/W2uskdZfXuMUAPWq8TKriZFDD8pwrI
 MSFzQtOgBZ9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 05:55:43 -0700
IronPort-SDR: YMTtf9LtzCA+Fx3BKfkswyKevs/R7Wz3cr4ojWM5YYlDjeaaQoGG8r6F+hMyE9psqP81iWftVT
 fB06DdDIq6dA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="295440241"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 08 Jun 2020 05:55:40 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiHJW-00BgLB-PO; Mon, 08 Jun 2020 15:55:42 +0300
Date:   Mon, 8 Jun 2020 15:55:42 +0300
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
Subject: Re: [PATCH v2 04/15] pwm: lpss: Fix off by one error in base_unit
 math in pwm_lpss_prepare()
Message-ID: <20200608125542.GM2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-5-hdegoede@redhat.com>
 <20200608035512.GA2428291@smile.fi.intel.com>
 <c8a8d466-9b4a-9021-ca74-01d315e99117@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a8d466-9b4a-9021-ca74-01d315e99117@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 08, 2020 at 01:13:01PM +0200, Hans de Goede wrote:
> On 6/8/20 5:55 AM, Andy Shevchenko wrote:
> > On Sun, Jun 07, 2020 at 08:18:29PM +0200, Hans de Goede wrote:
> > > According to the data-sheet the way the PWM controller works is that
> > > each input clock-cycle the base_unit gets added to a N bit counter and
> > > that counter overflowing determines the PWM output frequency.
> > > 
> > > So assuming e.g. a 16 bit counter this means that if base_unit is set to 1,
> > > after 65535 input clock-cycles the counter has been increased from 0 to
> > > 65535 and it will overflow on the next cycle, so it will overflow after
> > > every 65536 clock cycles and thus the calculations done in
> > > pwm_lpss_prepare() should use 65536 and not 65535.
> > > 
> > > This commit fixes this. Note this also aligns the calculations in
> > > pwm_lpss_prepare() with those in pwm_lpss_get_state().
> > 
> > This one sounds like a bug which I have noticed on Broxton (but thought as a
> > hardware issue). In any case it has to be tested on various platforms to see
> > how it affects on them.
> 
> If you like at the datasheet / read my commit description then it
> becomes obvious that because of the way the PWM controller works that
> it takes the full 2^(base-unit-bits) for the counter to overflow,
> not 2^(base-unit-bits) - 1. This will make a difference of a factor
> 65535/65536 in the output frequency which will be tricky to measure.
> 
> IOW I'm not sure we can really test if this helps, but it is
> obviously the right thing to do and it aligns the pwm_apply code
> with the pwm_get_state code which already does not have the - 1.

Yes. It seems I did a mistake in the commit
684309e5043e ("pwm: lpss: Avoid potential overflow of base_unit")
when missed multiplication.

For this one

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


