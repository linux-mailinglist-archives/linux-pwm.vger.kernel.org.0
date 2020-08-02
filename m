Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6760A2356AE
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Aug 2020 13:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgHBLZ3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Aug 2020 07:25:29 -0400
Received: from mga09.intel.com ([134.134.136.24]:62423 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726578AbgHBLZ3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 2 Aug 2020 07:25:29 -0400
IronPort-SDR: WLBEzmGVIdbCvgfxqMsVqFsU5RLKV/HUWmsrWO6im9Iwo0u6LdVkdl3Z8UqhkDK5peErRePqA6
 ORf54cfbr15w==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="153201450"
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="153201450"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 04:25:28 -0700
IronPort-SDR: UTOmpJ4fZQD2Rw5VNiUh+1mVo9aD5GDEpqPm95/RPFxD7Iwv7woQUiF1/Rm20KQhIGKuCd79wP
 imQWstfJClOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,426,1589266800"; 
   d="scan'208";a="305523573"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2020 04:25:25 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k2C7I-005iAE-LN; Sun, 02 Aug 2020 14:25:24 +0300
Date:   Sun, 2 Aug 2020 14:25:24 +0300
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
Subject: Re: [PATCH v5 00/16] acpi/pwm/i915: Convert pwm-crc and i915
 driver's PWM code to use the atomic PWM API
Message-ID: <20200802112524.GS3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200729105436.GT3703480@smile.fi.intel.com>
 <e8f93474-1775-b20c-f9f2-e33592a02028@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8f93474-1775-b20c-f9f2-e33592a02028@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 01, 2020 at 04:38:16PM +0200, Hans de Goede wrote:
> On 7/29/20 12:54 PM, Andy Shevchenko wrote:
> > On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:

...

> > One comment to consider, though. There are three channels in that PWM AFAIU.
> > One of them is backlight control, another one can be attached to haptics. The
> > concern is how this series may (or may not?) affect haptics behaviour.
> 
> When you say "in that PWM" do you mean the LPSS one or the CRC one ?

CRC one. I have read it from PMIC spec, that's why the question.

> The CRC PWM driver patches do make it honor the requested output frequency,
> where before, because of a bug, it would stick with the out frequency
> setup by the firmware (or the power-on-reset value if no value is set
> by the firmware). This fix causing this is very clearly correct, but
> it could have unexpected side-effects.

-- 
With Best Regards,
Andy Shevchenko


