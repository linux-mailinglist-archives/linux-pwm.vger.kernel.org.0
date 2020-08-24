Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E020924F3C7
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgHXIRV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 04:17:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:58092 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbgHXIRV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 04:17:21 -0400
IronPort-SDR: tQuQeOpGEgBXujuvoschzFoz2SmIvIrKZ/QqHY3c1NL1VzFD5PAw9z8qWkR9wD1QafHxIUxs5B
 QbE397OcEeqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="156912824"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="156912824"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 01:17:20 -0700
IronPort-SDR: YgZeuobHHY4IZVNhEvjbXlNIhlhPDgpCafSQZqUr0+WRkJPs8YeJx6krWF7wjLBy2aS5sIGnqD
 7ByXCkPB6/uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="328413608"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2020 01:17:17 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1kA7fH-00AzkR-9V; Mon, 24 Aug 2020 11:17:15 +0300
Date:   Mon, 24 Aug 2020 11:17:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v10 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200824081715.GA1891694@smile.fi.intel.com>
References: <cover.1598240097.git.rahul.tanwar@linux.intel.com>
 <05b664b961e37c1c35fa7d5d1cfc9ae244bc86bc.1598240097.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05b664b961e37c1c35fa7d5d1cfc9ae244bc86bc.1598240097.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Mon, Aug 24, 2020 at 11:36:37AM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.

...

> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
> +	if (IS_ERR(pc->regmap)) {
> +		ret = PTR_ERR(pc->regmap);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret, "failed to init register map\n");
> +		return ret;
> +	}
> +
> +	pc->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pc->clk)) {
> +		ret = PTR_ERR(pc->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret, "failed to get clock\n");
> +		return ret;
> +	}
> +
> +	pc->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pc->rst)) {
> +		ret = PTR_ERR(pc->rst);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret, "failed to get reset control\n");
> +		return ret;
> +	}
> +
> +	ret = reset_control_deassert(pc->rst);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err_probe(dev, ret, "cannot deassert reset control\n");
> +		return ret;
> +	}

Please, spend a bit of time to understand the changes you are doing. There are
already few examples how to use dev_err_probe() properly.

> +	ret = clk_prepare_enable(pc->clk);
> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, lgm_pwm_action, pc);
> +	if (ret)
> +		return ret;

You have also ordering issues here.

So, what I can see about implementation is that


	static void ..._clk_disable(void *data)
	{
		clk_disable_unprepare(data);
	}

	static int ..._clk_enable(...)
	{
		int ret;

		ret = clk_preare_enable(...);
		if (ret)
			return ret;
		return devm_add_action_or_reset(..., ..._clk_disable);
	}


Similar for reset control.

Then in the ->probe() something like this:

	ret = devm_reset_control_get...;
	if (ret)
		return ret;

	ret = ..._reset_deassert(...);
	if (ret)
		return ret;

followed by similar section for the clock.

-- 
With Best Regards,
Andy Shevchenko


