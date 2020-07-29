Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A2F231AED
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Jul 2020 10:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2IMZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Jul 2020 04:12:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:30081 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728023AbgG2IMY (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 29 Jul 2020 04:12:24 -0400
IronPort-SDR: sRZC3h5cPcvCVdhI5hsQtq3oq0KIGeAeiPpMShP83u0FKEi+pLZauWMzFkugcn4+Z52mBUHidG
 TouFIs+tjiMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="148834709"
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="148834709"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 01:12:22 -0700
IronPort-SDR: s2JNo0zhIjiaCpq1u81jmQCbPSEu3ALLV3y99My7JkY6HkvzEaDoGe40MzeL9eJW6L0vQy+RZd
 6tyjyOke+mag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,409,1589266800"; 
   d="scan'208";a="272561398"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga007.fm.intel.com with ESMTP; 29 Jul 2020 01:12:19 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1k0hCE-004eKo-T4; Wed, 29 Jul 2020 11:12:18 +0300
Date:   Wed, 29 Jul 2020 11:12:18 +0300
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
Message-ID: <20200729081218.GH3703480@smile.fi.intel.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
 <20200717133753.127282-7-hdegoede@redhat.com>
 <20200728185703.GA3703480@smile.fi.intel.com>
 <1e19e31f-cf68-5607-3027-3b963ce53c39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e19e31f-cf68-5607-3027-3b963ce53c39@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 28, 2020 at 09:55:22PM +0200, Hans de Goede wrote:
> On 7/28/20 8:57 PM, Andy Shevchenko wrote:
> > On Fri, Jul 17, 2020 at 03:37:43PM +0200, Hans de Goede wrote:

...

> > Maybe I'm too picky, but I would go even further and split apply to two versions
> > 
> > static int pwm_lpss_apply_on_resume(struct pwm_chip *chip, struct pwm_device *pwm,
> > 			  const struct pwm_state *state)
> > >   {
> > >   	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> > >   	if (state->enabled)
> > >   		return pwm_lpss_prepare_enable(lpwm, pwm, state, !pwm_is_enabled(pwm));
> > >   	if (pwm_is_enabled(pwm)) {
> > >   		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> > >   	return 0;
> > >   }
> > 
> > and another one for !from_resume.
> 
> It is a bit picky :) But that is actually not a bad idea, although I would write
> it like this for more symmetry with the normal (not on_resume) apply version,
> while at it I also renamed the function:
> 
> /*
>  * This is a mirror of pwm_lpss_apply() without pm_runtime reference handling
>  * for restoring the PWM state on resume.
>  */
> static int pwm_lpss_restore_state(struct pwm_chip *chip, struct pwm_device *pwm,
>                                   const struct pwm_state *state)
> {
>    	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
> 	int ret = 0;
> 
>    	if (state->enabled)
>    		ret = pwm_lpss_prepare_enable(lpwm, pwm, state, !pwm_is_enabled(pwm));
>    	else if (pwm_is_enabled(pwm))
>    		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
> 
>    	return ret;
> }
> 
> Would that work for you?

Yes.

...

> > > +		ret = __pwm_lpss_apply(&lpwm->chip, pwm, &saved_state, true);
> > > +		if (ret)
> > > +			dev_err(dev, "Error restoring state on resume\n");
> > 
> > I'm wondering if it's a real error why we do not bail out?
> > Otherwise dev_warn() ?
> 
> It is a real error, but a single PWM chip might have multiple controllers
> and bailing out early would mean not even trying to restore the state on
> the other controllers.  As for propagating the error, AFAIK the pm framework
> does not do anything with resume errors other then log an extra error.

OK.

-- 
With Best Regards,
Andy Shevchenko


