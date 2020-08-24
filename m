Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B00CA24FB1E
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgHXKPC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 06:15:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:18743 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgHXKPB (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 06:15:01 -0400
IronPort-SDR: qBbXJuqGL2q7Plg2GnUr+UxzniZWmEDEdwMX8mE8DDdCzwF2En7mZ/4RTwhAyXXo3j49LUMbi7
 TFMTTsxHtSiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135416480"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="135416480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 03:15:00 -0700
IronPort-SDR: +1K6+IOcnplflhLmEToWJpcdL/LSAqLYEAscJLX0cLn3OT3K7Ns4k7HWcjTDAUPpuxkru8/RBc
 jUzt+G+CNW5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="328440827"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2020 03:14:56 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kA9V8-00B1PV-Oz; Mon, 24 Aug 2020 13:14:54 +0300
Date:   Mon, 24 Aug 2020 13:14:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v10 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200824101454.GK1891694@smile.fi.intel.com>
References: <cover.1598240097.git.rahul.tanwar@linux.intel.com>
 <05b664b961e37c1c35fa7d5d1cfc9ae244bc86bc.1598240097.git.rahul.tanwar@linux.intel.com>
 <20200824081715.GA1891694@smile.fi.intel.com>
 <ed7affbb-b95d-cf42-b9bc-71addf908ffc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed7affbb-b95d-cf42-b9bc-71addf908ffc@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 05:36:47PM +0800, Tanwar, Rahul wrote:
> On 24/8/2020 4:17 pm, Andy Shevchenko wrote:
> > On Mon, Aug 24, 2020 at 11:36:37AM +0800, Rahul Tanwar wrote:

...

> >> +	ret = reset_control_deassert(pc->rst);
> >> +	if (ret) {
> >> +		if (ret != -EPROBE_DEFER)
> >> +			dev_err_probe(dev, ret, "cannot deassert reset control\n");
> >> +		return ret;
> >> +	}
> > Please, spend a bit of time to understand the changes you are doing. There are
> > already few examples how to use dev_err_probe() properly.
> 
> I guess your point is that the check of (ret !- -EPROBE_DEFER) is not needed
> when using dev_err_probe() as it encapsulates it.

It does even more. Look at the existing examples.

> Sorry, i missed it. Will
> fix it. I am not able to find any other missing point after referring to
> two driver examples which uses dev_err_probe() ?

There are three drivers that are using it in Linux Next. All of them utilizing
it correctly, look at them.

> >> +	ret = clk_prepare_enable(pc->clk);
> >> +	if (ret) {
> >> +		dev_err(dev, "failed to enable clock\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret = devm_add_action_or_reset(dev, lgm_pwm_action, pc);
> >> +	if (ret)
> >> +		return ret;
> > You have also ordering issues here.
> >
> > So, what I can see about implementation is that
> >
> >
> > 	static void ..._clk_disable(void *data)
> > 	{
> > 		clk_disable_unprepare(data);
> > 	}
> >
> > 	static int ..._clk_enable(...)
> > 	{
> > 		int ret;
> >
> > 		ret = clk_preare_enable(...);
> > 		if (ret)
> > 			return ret;
> > 		return devm_add_action_or_reset(..., ..._clk_disable);
> > 	}
> >
> >
> > Similar for reset control.
> >
> > Then in the ->probe() something like this:
> >
> > 	ret = devm_reset_control_get...;
> > 	if (ret)
> > 		return ret;
> >
> > 	ret = ..._reset_deassert(...);
> > 	if (ret)
> > 		return ret;
> >
> > followed by similar section for the clock.
> >
> 
> Regarding ordering: In early rounds of review, feedback about ordering was that
> it is recommended to be reverse of the sequence in probe i.e.
> if in probe:
> 1. reset_control_deassert()
> 2. clk_prepare_enable()
> then in remove:
> 1. clk_disable_uprepare()
> 2. reset_control_assert()
> 
> That's the reason i added a generic action() which reverses order.

Yes, and my suggestion follows this.

> I understand your suggested way as explained above but not sure if that would
> ensure reverse ordering during unwind.

You have:
 devm r1
 devm r2
 enable r1
 enable r2 (and here you have broken error path)

My suggestion has it like this (and no broken error path):
 devm r1
 enable r1
 devm r2
 enable r2

-- 
With Best Regards,
Andy Shevchenko


