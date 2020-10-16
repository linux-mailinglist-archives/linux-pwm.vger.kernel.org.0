Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C42901C5
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395237AbgJPJXV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 05:23:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:13146 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394942AbgJPJXV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 05:23:21 -0400
IronPort-SDR: jB6zzjE4ExvZtu3mnOUzcxVSyi6GN4OjE6rvAOtButGYylxWPBBridWAXY36vgTOkLlqTyzHbC
 8sb7PZzZV5wQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="251261488"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="251261488"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:23:20 -0700
IronPort-SDR: vuQvgOp2DIwx95vtL10g/8QcpP9geARi9TedgnjFEcCjzNp2T/Aj8fYT7eV6F9gxW39+sOJmyC
 GilywQYdXxLA==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="314836742"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:23:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kTLyG-0088AB-Db; Fri, 16 Oct 2020 12:24:20 +0300
Date:   Fri, 16 Oct 2020 12:24:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     vijayakannan.ayyathurai@intel.com, thierry.reding@gmail.com,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        mgross@linux.intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201016092420.GG4077@smile.fi.intel.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <20201016062439.lvpzbtxd4azku2fq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201016062439.lvpzbtxd4azku2fq@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 08:24:39AM +0200, Uwe Kleine-König wrote:
> On Thu, Oct 15, 2020 at 01:42:17PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel.com wrote:
> > > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

...

> > > +	ret = pwmchip_add(&priv->chip);
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> > 
> > > +		clk_disable_unprepare(priv->clk);
> > 
> > This messes up with ordering of things.
> > 
> > That's why devm golden rule is either all or none. You may fix this by
> > switching to devm_add_action_or_reset().
> > 
> > One of possible way is like in below drivers:
> > 
> > 	% git grep -n devm_add_action_or_reset.*disable_unprepare -- drivers/
> > 
> > But it may be fixed in follow up change. Depends on maintainers' wishes.
> 
> I recently sent a patch to address this in a still more comfortable way:
>
> 	https://lore.kernel.org/r/20201013082132.661993-1-u.kleine-koenig@pengutronix.de

Good to know, thanks!

> Other than that I don't think there is a real issue to fix here, yes,
> the unroll order doesn't match the init order, but here this is about
> ioremap vs clk_prepare_enable, so I'm fine with the status quo.
> 
> (I assume I didn't miss a real issue here. Please tell if so.)

No, as you said and as I answered in previous reply that the more serious issue
(which you pointed out) has been replaced with less serious which can even be
addressed separately, but it's up to you and Thierry.

-- 
With Best Regards,
Andy Shevchenko


