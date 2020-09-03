Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67E825C16A
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 14:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgICM46 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 08:56:58 -0400
Received: from mga14.intel.com ([192.55.52.115]:32386 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728409AbgICM4b (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 3 Sep 2020 08:56:31 -0400
IronPort-SDR: 1z1MFP6C/hYgkBEkBTiIVyJPQxuGyy51v+qlIhq2dWKVH1zuh2EAVMjqhxb6Hp9R9l4g9akuFa
 8+PnH2NhPkuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9732"; a="156835077"
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="156835077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 05:56:31 -0700
IronPort-SDR: ttfkhcEQ4M7plm0rWrzzUPBGVfW6Uok9NxDdMC0S+ahWiwZIRhDDv8NnrXXoPTkfMpoZavNT78
 BuD0ToeLnQmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,386,1592895600"; 
   d="scan'208";a="331778180"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2020 05:56:23 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kDomq-00E1xi-F2; Thu, 03 Sep 2020 15:56:20 +0300
Date:   Thu, 3 Sep 2020 15:56:20 +0300
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
Subject: Re: [PATCH v10 07/17] pwm: lpss: Remove suspend/resume handlers
Message-ID: <20200903125620.GB1891694@smile.fi.intel.com>
References: <20200903112337.4113-1-hdegoede@redhat.com>
 <20200903112337.4113-8-hdegoede@redhat.com>
 <20200903124816.GA1891694@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903124816.GA1891694@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Sep 03, 2020 at 03:48:16PM +0300, Andy Shevchenko wrote:
> On Thu, Sep 03, 2020 at 01:23:27PM +0200, Hans de Goede wrote:

> the question is do we need to have similar in acpi_lpss.c?
> For example,
> 	static const struct lpss_device_desc byt_pwm_dev_desc = {
> 		.flags = LPSS_SAVE_CTX,
> 		^^^^^^^^^^^^^^
> 		.prv_offset = 0x800,
> 		.setup = byt_pwm_setup,
> 	};
> 
> 	static const struct lpss_device_desc bsw_pwm_dev_desc = {
> 		.flags = LPSS_SAVE_CTX | LPSS_NO_D3_DELAY,
> 		^^^^^^^^^^^^^^
> 		.prv_offset = 0x800,
> 		.setup = bsw_pwm_setup,
> 	};

Okay, it's a private space which has clock and reset gating, so means we still
need to handle it.

-- 
With Best Regards,
Andy Shevchenko


