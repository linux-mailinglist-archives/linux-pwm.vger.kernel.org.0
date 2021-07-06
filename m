Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72A3BDB55
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jul 2021 18:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGFQan (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 6 Jul 2021 12:30:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:47991 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhGFQam (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 6 Jul 2021 12:30:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="272994965"
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="272994965"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:28:02 -0700
X-IronPort-AV: E=Sophos;i="5.83,328,1616482800"; 
   d="scan'208";a="563369725"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2021 09:27:59 -0700
Received: from andy by smile with local (Exim 4.94.2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1m0nvO-009Uen-1g; Tue, 06 Jul 2021 19:27:54 +0300
Date:   Tue, 6 Jul 2021 19:27:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Colin King <colin.king@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH][next] pwm: core: remove redundant assignment to pointer
 pwm
Message-ID: <YOSEivHTfvhnCgkY@smile.fi.intel.com>
References: <20210706151133.33175-1-colin.king@canonical.com>
 <20210706155820.aiv3q6rxuer7kdco@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210706155820.aiv3q6rxuer7kdco@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Tue, Jul 06, 2021 at 05:58:20PM +0200, Uwe Kleine-König wrote:

> [adding Andy and Rafael to Cc:]

Thanks.

> On Tue, Jul 06, 2021 at 04:11:32PM +0100, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > The pointer pwm is being initialized with a value that is never read and
> > it is being updated later with a new value. The initialization is
> > redundant and can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/pwm/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index a28c8639af5b..35e894f4a379 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -846,7 +846,7 @@ EXPORT_SYMBOL_GPL(of_pwm_get);
> >   */
> >  static struct pwm_device *acpi_pwm_get(const struct fwnode_handle *fwnode)
> >  {
> > -	struct pwm_device *pwm = ERR_PTR(-ENODEV);
> > +	struct pwm_device *pwm;

I would move it after the next line...

> >  	struct fwnode_reference_args args;

...i.e. here

	struct pwm_device *pwm;

> >  	struct pwm_chip *chip;
> >  	int ret;
> 
> LGTM:
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> and if you want:
> 
> Fixes: e5c38ba9f281 ("pwm: core: Reuse fwnode_to_pwmchip() in ACPI case")

With or without above comment addressed,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for spotting and fixing this!

-- 
With Best Regards,
Andy Shevchenko


