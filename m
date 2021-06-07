Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFDC339DEE5
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Jun 2021 16:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGOiD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Jun 2021 10:38:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:6488 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230213AbhFGOiD (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 7 Jun 2021 10:38:03 -0400
IronPort-SDR: ShV0/11HTYcLLl524PdDMZ4s5r2i9PtKLTiMkkomfp410kK9XOlHBq4ll5mdonphBsvvpI4IWM
 rcFauRd6Obxg==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="184315546"
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="184315546"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:36:08 -0700
IronPort-SDR: Y37UMWScXJDZ303soo6I9Yqr9mSsORiTUXT9IqjmD+0FVepK7Jy9XZkXULa3tOZNWgoCVRrEsz
 1RYnHBCHWJTA==
X-IronPort-AV: E=Sophos;i="5.83,255,1616482800"; 
   d="scan'208";a="484794854"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 07:36:05 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1lqGME-000HEt-Dk; Mon, 07 Jun 2021 17:36:02 +0300
Date:   Mon, 7 Jun 2021 17:36:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v3 1/6] docs: firmware-guide: ACPI: Add a PWM example
Message-ID: <YL4u0iPs3WbWulV8@smile.fi.intel.com>
References: <20210607122458.40073-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0jNWTzy37rX_V6LF7y7LOdy=KUokkVZ+25zj4+AZ244OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jNWTzy37rX_V6LF7y7LOdy=KUokkVZ+25zj4+AZ244OQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Jun 07, 2021 at 02:38:26PM +0200, Rafael J. Wysocki wrote:
> On Mon, Jun 7, 2021 at 2:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > When PWM support for ACPI has been added into the kernel, it missed
> > the documentation update. Hence update documentation here.
> >
> > Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> and I'm assuming this to go in via PWM.

Yes, thanks for your tags!

-- 
With Best Regards,
Andy Shevchenko


