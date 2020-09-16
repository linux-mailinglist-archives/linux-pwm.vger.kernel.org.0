Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC126C661
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Sep 2020 19:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbgIPRrT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 16 Sep 2020 13:47:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:45080 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727452AbgIPRrJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 16 Sep 2020 13:47:09 -0400
IronPort-SDR: rpgjmYjSEd8bSz1OawL01HbCHgBXxhvRytZJd9d98tCFL2whUshfkHFwlYTcZqdvABI/JsPmur
 bnB8ewlCfEng==
X-IronPort-AV: E=McAfee;i="6000,8403,9746"; a="223695281"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="223695281"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 09:36:30 -0700
IronPort-SDR: aQEGKxyCZrJBJjnBjmCV7zsjIxrHWy5WQH2RWWO1p7+JHWPD8I6zKnQs1cWkLxwbYviOFDRr5I
 9jPfBKKxWp5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="336082131"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 16 Sep 2020 09:36:29 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kIaPy-00H7my-A5; Wed, 16 Sep 2020 19:36:26 +0300
Date:   Wed, 16 Sep 2020 19:36:26 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH v1] pwm: lpss: Use positive condition in
 pwm_lpss_prepare()
Message-ID: <20200916163626.GA3956970@smile.fi.intel.com>
References: <20200115150849.74036-1-andriy.shevchenko@linux.intel.com>
 <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200115155425.n6nt7srrh4kxuczg@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Wed, Jan 15, 2020 at 04:54:25PM +0100, Uwe Kleine-König wrote:
> On Wed, Jan 15, 2020 at 05:08:49PM +0200, Andy Shevchenko wrote:
> > For better readability and maintenance use positive condition
> > in pwm_lpss_prepare(). No functional change intended.

...

> > @@ -109,10 +109,11 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
> >  	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
> >  	ctrl |= on_time_div;
> >  
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

Fun fact that d6d54bacb1dd could be slightly better with this applied, but we
have what we have :-)

-- 
With Best Regards,
Andy Shevchenko


