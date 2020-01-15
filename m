Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDB8713C95C
	for <lists+linux-pwm@lfdr.de>; Wed, 15 Jan 2020 17:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbgAOQbh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 15 Jan 2020 11:31:37 -0500
Received: from mga17.intel.com ([192.55.52.151]:46420 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgAOQbh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 15 Jan 2020 11:31:37 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Jan 2020 08:31:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,323,1574150400"; 
   d="scan'208";a="213760996"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 15 Jan 2020 08:31:35 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1irlZw-0007i7-RO; Wed, 15 Jan 2020 18:31:36 +0200
Date:   Wed, 15 Jan 2020 18:31:36 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: Use positive condition in
 pwm_lpss_prepare()
Message-ID: <20200115163136.GE32742@smile.fi.intel.com>
References: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
 <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 04:54:25PM +0100, Uwe Kleine-König wrote:
> On Wed, Jan 15, 2020 at 05:08:49PM +0200, Andy Shevchenko wrote:

...

> > -	if (orig_ctrl != ctrl) {
> > -		pwm_lpss_write(pwm, ctrl);
> > -		pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> > -	}
> > +	if (orig_ctrl == ctrl)
> > +		return;
> > +
> > +	pwm_lpss_write(pwm, ctrl);
> > +	pwm_lpss_write(pwm, ctrl | PWM_SW_UPDATE);
> 
> I personally don't think that readability improved much and think that
> the old code is more intuitive. ("If the wanted register value doesn't
> match the actual value, write the value out.")
> 
> But I agree that the patch doesn't introduce a semantic difference.
> 
> What made you create that patch? Is it really that you read through the
> driver and thought "Huh, this is more complicated than necessary."?

My personal preferable style. So, I can survive with the current code.
Thanks for review!

-- 
With Best Regards,
Andy Shevchenko


