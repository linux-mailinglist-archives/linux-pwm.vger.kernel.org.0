Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0F0623A12F
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Aug 2020 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725884AbgHCImC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 3 Aug 2020 04:42:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:53282 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgHCImC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 3 Aug 2020 04:42:02 -0400
IronPort-SDR: SqqE/9ag8b0VXH7vn6/P+h6iC4zM1Zzwr1cpeDvSjaGmIRU9Wf4eJm/LOm7EShGQCcitQUvlPB
 I858XQI5M2og==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="153268212"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="153268212"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 01:42:01 -0700
IronPort-SDR: jdqq4oNfED4wgeLRjHMaHuNP8RyD9MdyK9lfemnRpVQM6L/Ft6bG1h6r8EWEU5WDugyaVOv/MK
 0sYucpi5FI1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="scan'208";a="273862936"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2020 01:41:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k2W2f-005tVV-LR; Mon, 03 Aug 2020 11:41:57 +0300
Date:   Mon, 3 Aug 2020 11:41:57 +0300
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
Subject: Re: [PATCH v5 06/16] pwm: lpss: Use pwm_lpss_apply() when restoring
 state on resume
Message-ID: <20200803084157.GW3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-7-hdegoede@redhat.com>
 <20200728185703.GA3703480@smile.fi.intel.com>
 <1e19e31f-cf68-5607-3027-3b963ce53c39@redhat.com>
 <20200729081218.GH3703480@smile.fi.intel.com>
 <0e8595ff-2ebb-76a6-a43d-d670154c0352@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e8595ff-2ebb-76a6-a43d-d670154c0352@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sun, Aug 02, 2020 at 10:51:34PM +0200, Hans de Goede wrote:
> On 7/29/20 10:12 AM, Andy Shevchenko wrote:

...

> Ok, I've added the suggested/discussed helper in my personal tree. Is it ok
> if I add your Reviewed-by with that change in place.

Yes, go ahead!

> This is the last unreviewed
> bit, so I would rather not respin the series just for this (there will be one
> more respin when I rebase it on 5.9-rc1).
> 
> If you want to check out what the patch looks like now, the new version from
> my personal tree is here:
> 
> https://github.com/jwrdegoede/linux-sunxi/commit/e4869830d88bb8cb8251718e0086ac189abc0f56

Thanks, looks good to me.

-- 
With Best Regards,
Andy Shevchenko


