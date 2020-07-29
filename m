Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77062231B25
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 10:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgG2IXP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 04:23:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:12855 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2IXO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 04:23:14 -0400
IronPort-SDR: UnH1EuRFBqFhH+RP/MBPEUlE8ih3XeKwSHXD5972M967ywkOQUaSp8LzdPzuKpgkz9EgsNsv4j
 ENhXsWWEXLQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="149220918"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="149220918"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 01:23:10 -0700
IronPort-SDR: YgJufAO+VvF9JKj6/+berwFwFFx7I/v9sC+BOqWhjeM/8QDTXBVydKe5VTSCIvoI3d37MtIoD+
 Ak99Hp7bBZNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="322479903"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2020 01:23:06 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0hMf-004eRE-VX; Wed, 29 Jul 2020 11:23:05 +0300
Date:   Wed, 29 Jul 2020 11:23:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
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
Message-ID: <20200729082305.GK3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200727074120.GB2781612@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727074120.GB2781612@ulmo>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jul 27, 2020 at 09:41:20AM +0200, Thierry Reding wrote:
> On Fri, Jul 17, 2020 at 03:37:37PM +0200, Hans de Goede wrote:

> I've applied patches 3 through 12 to the PWM tree. I thought it was a
> bit odd that only a handful of these patches had been reviewed and there
> were no Tested-bys, but I'm going to trust that you know what you're
> doing. =) If this breaks things for anyone I'm sure they'll complain.

Can we postpone a bit?

> That said I see that Rafael has acked patches 1-2 and Jani did so for
> patches 13-16. I'm not sure if you expect me to pick those patches up as
> well. As far as I can tell the ACPI, PWM and DRM parts are all
> independent, so these patches could be applied to the corresponding
> subsystem trees.
> 
> Anyway, if you want me to pick those all up into the PWM tree, I suppose
> that's something I can do as well.



-- 
With Best Regards,
Andy Shevchenko


