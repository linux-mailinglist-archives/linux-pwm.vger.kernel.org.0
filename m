Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3DFA2901BB
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Oct 2020 11:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405570AbgJPJU1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Oct 2020 05:20:27 -0400
Received: from mga14.intel.com ([192.55.52.115]:61105 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394987AbgJPJU1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 16 Oct 2020 05:20:27 -0400
IronPort-SDR: ABmvZ7KK/26x7I6y/25sUh40oasJMbORsIkE+LvIaOa0iUGdfPqaaD2+Q36hFJtYkvmWL1OF6s
 aYdwx8eun2qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9775"; a="165799562"
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="165799562"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:20:26 -0700
IronPort-SDR: e76N9CeG4MdDtrqHMptxm9uAhbobrboaLyyt1l2jgUC1hb6BMHX4CzMdWz+1Kpo72odoecD/EY
 7V2DwDjCyGbQ==
X-IronPort-AV: E=Sophos;i="5.77,382,1596524400"; 
   d="scan'208";a="319388347"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2020 02:20:24 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kTLvT-00884J-1o; Fri, 16 Oct 2020 12:21:27 +0300
Date:   Fri, 16 Oct 2020 12:21:27 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Ayyathurai, Vijayakannan" <vijayakannan.ayyathurai@intel.com>
Cc:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Wan Mohamad, Wan Ahmad Zainie" 
        <wan.ahmad.zainie.wan.mohamad@intel.com>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Raja Subramanian, Lakshmi Bai" 
        <lakshmi.bai.raja.subramanian@intel.com>
Subject: Re: [PATCH v12 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20201016092127.GF4077@smile.fi.intel.com>
References: <cover.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <5fc6189f9c4cf382d54ae00e663f296baeb2c06e.1602703463.git.vijayakannan.ayyathurai@intel.com>
 <20201015104217.GR4077@smile.fi.intel.com>
 <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB425089996A0CC9A43CBC50C5FB030@DM6PR11MB4250.namprd11.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Oct 16, 2020 at 03:18:08AM +0000, Ayyathurai, Vijayakannan wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com> 
> Sent: Thursday, 15 October, 2020 4:12 PM
> On Thu, Oct 15, 2020 at 03:36:09AM +0800, vijayakannan.ayyathurai@intel.com wrote:
> > From: Vijayakannan Ayyathurai <vijayakannan.ayyathurai@intel.com>

...

> > +	priv->clk = devm_clk_get(dev, NULL);
> > +	if (IS_ERR(priv->clk))
> > +		return dev_err_probe(dev, PTR_ERR(priv->clk), "Failed to get 
> > +clock\n");
> > +
> > +	ret = clk_prepare_enable(priv->clk);
> > +	if (ret)
> > +		return ret;
> > +
> > +	priv->base = devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(priv->base)) {
> 
> > +		clk_disable_unprepare(priv->clk);
> 
> See below.
> 
> > +		return PTR_ERR(priv->base);
> > +	}
> > +
> > +	priv->chip.base = -1;
> > +	priv->chip.dev = dev;
> > +	priv->chip.ops = &keembay_pwm_ops;
> > +	priv->chip.npwm = KMB_TOTAL_PWM_CHANNELS;
> > +
> > +	ret = pwmchip_add(&priv->chip);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> 
> > +		clk_disable_unprepare(priv->clk);
> 
> This messes up with ordering of things.
> 
> That's why devm golden rule is either all or none. You may fix this by switching to devm_add_action_or_reset().
> 
> One of possible way is like in below drivers:
> 
> 	% git grep -n devm_add_action_or_reset.*disable_unprepare -- drivers/
> 
> But it may be fixed in follow up change. Depends on maintainers' wishes.
> 
> Sure. I shall incorporate and check based on maintainers wish in the next version.
> 
> > +		return ret;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, priv);
> > +
> > +	return 0;
> > +}
> > +
> > +static int keembay_pwm_remove(struct platform_device *pdev) {
> > +	struct keembay_pwm *priv = platform_get_drvdata(pdev);
> > +	int ret;
> > +
> > +	ret = pwmchip_remove(&priv->chip);
> > +	clk_disable_unprepare(priv->clk);
> > +
> > +	return ret;
> 
> ...and this will be simplified to
> 
> 	return pwmchip_remove(&priv->chip);
> 
> Until v10, It is as per your suggestion. But I have changed it in v11 to overcome the issue mentioned by Uwe. I have kept the snip of v10 FYR below.
> 
> //Start snip from v10 review mailing list
> //> +static int keembay_pwm_remove(struct platform_device *pdev) {
> //> +	struct keembay_pwm *priv = platform_get_drvdata(pdev);
> //> +
> //> +	clk_disable_unprepare(priv->clk);
> //> +
> //> +	return pwmchip_remove(&priv->chip);
> //
> //You have to call pwmchip_remove first. Otherwise you're stopping the PWM while the framework still believes everything to be fine.
> //
> //> +}
> //End snip from v10 review mailing review
> 
> > +}

What I said does not contradict with what Uwe said. So, please, fix ordering
either by dropping devm_ in the middle or adding devm_ action.

Now you moved serious ordering issue in ->remove() (which Uwe noted) to less
serious in ->probe(). But issue is still present.

-- 
With Best Regards,
Andy Shevchenko


