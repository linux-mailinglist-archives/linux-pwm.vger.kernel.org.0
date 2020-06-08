Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31EC1F11E2
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jun 2020 05:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFHDuZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Jun 2020 23:50:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:26678 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbgFHDuY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 7 Jun 2020 23:50:24 -0400
IronPort-SDR: 7TlQWMk6JyuNyJJ32t/eiOAOn2gBLDhdrdy0qCLhA+UiotKU+NK+FEqD1F4GVXXRw+4AIACxYR
 LcX8BpFC7sGg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2020 20:50:24 -0700
IronPort-SDR: aBms9IEQNhijJBDDXaj4Ih289dsactoAreSJwOIoFVQlNORC8n8IEK99gECcaTtaEP8q7YgwB+
 d2CD1mMArAWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,486,1583222400"; 
   d="scan'208";a="446588491"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga005.jf.intel.com with ESMTP; 07 Jun 2020 20:50:21 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ji8nn-00Ba6K-HD; Mon, 08 Jun 2020 06:50:23 +0300
Date:   Mon, 8 Jun 2020 06:50:23 +0300
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
Subject: Re: [PATCH v2 03/15] pwm: lpss: Add range limit check for the
 base_unit register value
Message-ID: <20200608035023.GZ2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-4-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:28PM +0200, Hans de Goede wrote:
> When the user requests a high enough period ns value, then the
> calculations in pwm_lpss_prepare() might result in a base_unit value of 0.
> 
> But according to the data-sheet the way the PWM controller works is that
> each input clock-cycle the base_unit gets added to a N bit counter and
> that counter overflowing determines the PWM output frequency. Adding 0
> to the counter is a no-op. The data-sheet even explicitly states that
> writing 0 to the base_unit bits will result in the PWM outputting a
> continuous 0 signal.

So, and why it's a problem?

> base_unit values > (base_unit_range / 256), or iow base_unit values using
> the 8 most significant bits, cause loss of resolution of the duty-cycle.
> E.g. assuming a base_unit_range of 65536 steps, then a base_unit value of
> 768 (256 * 3), limits the duty-cycle resolution to 65536 / 768 = 85 steps.
> Clamp the max base_unit value to base_unit_range / 32 to ensure a
> duty-cycle resolution of at least 32 steps. This limits the maximum
> output frequency to 600 KHz / 780 KHz depending on the base clock.

This part I don't understand. Why we limiting base unit? I seems like a
deliberate regression.

-- 
With Best Regards,
Andy Shevchenko


