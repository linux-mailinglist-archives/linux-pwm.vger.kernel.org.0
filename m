Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E583D24D34C
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 12:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHUKx1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 06:53:27 -0400
Received: from mga01.intel.com ([192.55.52.88]:2596 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgHUKwy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Aug 2020 06:52:54 -0400
IronPort-SDR: 8aNO/msoBSpTqqCklOoI2JacQjPjJQO7YCLjMr1I3OOZV3lZ1AUJ5pD9elmREgbCIopPhUm8HQ
 sEH1QZIVz28w==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="173557967"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="173557967"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 03:52:53 -0700
IronPort-SDR: O7Lz0ZnWt71v2rhcFMeN/ax6FCKFYVTkccb1vrG1j5ztBa9wkip6kUaRQ1nMEuIOPKHxS+3k0z
 lLexMjyeq4Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327731116"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 03:52:50 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k94fA-00AK5B-Ke; Fri, 21 Aug 2020 13:52:48 +0300
Date:   Fri, 21 Aug 2020 13:52:48 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v8 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200821105248.GM1891694@smile.fi.intel.com>
References: <cover.1597898872.git.rahul.tanwar@linux.intel.com>
 <b6d0a65625a2bc231c649c970c0a1af1ff3a5dd5.1597898872.git.rahul.tanwar@linux.intel.com>
 <20200820105255.GB1891694@smile.fi.intel.com>
 <56c2a40d-6872-8ae7-7214-420b8bb9f027@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56c2a40d-6872-8ae7-7214-420b8bb9f027@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 21, 2020 at 05:14:29PM +0800, Tanwar, Rahul wrote:
> On 20/8/2020 6:52 pm, Andy Shevchenko wrote:
> > On Thu, Aug 20, 2020 at 12:50:46PM +0800, Rahul Tanwar wrote:
> >> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> >> This PWM controller does not have any other consumer, it is a
> >> dedicated PWM controller for fan attached to the system. Add
> >> driver for this PWM fan controller.
> > ...
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/module.h>
> >> +#include <linux/of_device.h>
> > This should be mod_devicetable.h.
> 
> Inlcuding mod_devicetable.h instead of of_device.h results in
> build failure related to all platform calls. Build is ok if
> i remove it. Just FYI..

I didn't get what the change you performed, by there is no users of of_device.h
in your code. If build fails it means you need to figure out proper list of
what has to be included.

-- 
With Best Regards,
Andy Shevchenko


