Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21611F39AF
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jun 2020 13:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728960AbgFIL3J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jun 2020 07:29:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:64407 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728730AbgFIL3G (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 9 Jun 2020 07:29:06 -0400
IronPort-SDR: qGV0XtEB9p2oSn6Pnj1zcNSJ69SiFlk5lZwW9NhA+2fT2yg9fit1cn5+k3uqYkkFxCZL0Vgop/
 abIb3kcZQi5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 04:29:05 -0700
IronPort-SDR: I9ZI5hVQJ8gIbUCnBOMI/UzhZ+Gbu7ciNfFaR4ypZ3pNkt8/JldgZKH6f5wcN4DYB5hfT0N6q7
 Q1OEIaoCb5DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,491,1583222400"; 
   d="scan'208";a="270862142"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003.jf.intel.com with ESMTP; 09 Jun 2020 04:29:02 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jicRF-00Bt4F-B4; Tue, 09 Jun 2020 14:29:05 +0300
Date:   Tue, 9 Jun 2020 14:29:05 +0300
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
Subject: Re: [PATCH v2 06/15] pwm: crc: Fix period / duty_cycle times being
 off by a factor of 256
Message-ID: <20200609112905.GK2428291@smile.fi.intel.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
 <20200607181840.13536-7-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200607181840.13536-7-hdegoede@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Jun 07, 2020 at 08:18:31PM +0200, Hans de Goede wrote:
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

...

> +#define NSEC_PER_MHZ		1000

This is against physics. What this cryptic name means actually?
Existing NSEC_PER_USEC ?

-- 
With Best Regards,
Andy Shevchenko


