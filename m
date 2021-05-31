Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05465396510
	for <lists+linux-pwm@lfdr.de>; Mon, 31 May 2021 18:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbhEaQV7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 31 May 2021 12:21:59 -0400
Received: from mga07.intel.com ([134.134.136.100]:39760 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234751AbhEaQTv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 31 May 2021 12:19:51 -0400
IronPort-SDR: vR13DPA9US+xhesTuVmJyhtE5SaZenwQVQ4VqpbmgKrt4z9rcCRht9mxqrbq6I+0keJXDnDiQM
 erYcoJ6hL5mg==
X-IronPort-AV: E=McAfee;i="6200,9189,10001"; a="267261518"
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="267261518"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 09:09:19 -0700
IronPort-SDR: 5adWyKVx44g8zdVr1QDZCDvNSJCXMyeMXe+JApXi3aIVVcfhFUiHuXW1DyxrZfcpLbBioauMRV
 tJJTiW8+sGKQ==
X-IronPort-AV: E=Sophos;i="5.83,237,1616482800"; 
   d="scan'208";a="446645810"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2021 09:09:15 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lnkTZ-00G8y7-NV; Mon, 31 May 2021 19:09:13 +0300
Date:   Mon, 31 May 2021 19:09:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v1 1/5] docs: firmware-guide: ACPI: Add a PWM example
Message-ID: <YLUKKeltfJe+4X2k@smile.fi.intel.com>
References: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210531154351.53614-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, May 31, 2021 at 06:43:47PM +0300, Andy Shevchenko wrote:
> When PWM support for ACPI has been added into the kernel, it missed
> the documentation update. Hence update documentation here.

I am actually in doubt that original commit message provides that short period
intentionally. Possibly it was misinterpretation of nanoseconds (which is
expected by PWM framework) with microseconds than might sound logical for LED.

Perhaps we may add 000 to the value (1) and replace us by ms in the text (2).

...

> +                    Package () {
> +                        "\\_SB.PCI0.PWM",  // <PWM device reference>
> +                        0,                 // <PWM index>

> +                        600000,            // <PWM period>

(1)

> +                        0,                 // <PWM flags>
> +                    }

> +In the above example the PWM-based LED driver references to the PWM channel 0
> +of \_SB.PCI0.PWM device with initial period setting equal to 600 us (note that

(2)

> +value is given in nanoseconds).

-- 
With Best Regards,
Andy Shevchenko


