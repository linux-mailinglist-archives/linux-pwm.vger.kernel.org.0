Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE624B768
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Aug 2020 12:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731538AbgHTKxU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Aug 2020 06:53:20 -0400
Received: from mga06.intel.com ([134.134.136.31]:52351 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731514AbgHTKxC (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 20 Aug 2020 06:53:02 -0400
IronPort-SDR: mTFY2IsmrTjA6seb/afrZwNU1L7tes2q0eqeR3QSAyZloyQIdIKO/+12EJNW19vwwFNoiriWL6
 iFtHE447+Vlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="216814278"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="216814278"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 03:53:01 -0700
IronPort-SDR: F/MSpuvDJb0c+Fl311bQpLMxkIGXF5XvQ6IQk4EsJbAiffqOx9xUzw79vymMv2eshLsNtJO8RA
 U7BalIxgzuLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="327392777"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2020 03:52:58 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k8iBj-00A5k8-Ra; Thu, 20 Aug 2020 13:52:55 +0300
Date:   Thu, 20 Aug 2020 13:52:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v8 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200820105255.GB1891694@smile.fi.intel.com>
References: <cover.1597898872.git.rahul.tanwar@linux.intel.com>
 <b6d0a65625a2bc231c649c970c0a1af1ff3a5dd5.1597898872.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d0a65625a2bc231c649c970c0a1af1ff3a5dd5.1597898872.git.rahul.tanwar@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Thu, Aug 20, 2020 at 12:50:46PM +0800, Rahul Tanwar wrote:
> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
> This PWM controller does not have any other consumer, it is a
> dedicated PWM controller for fan attached to the system. Add
> driver for this PWM fan controller.

...

> +config PWM_INTEL_LGM
> +	tristate "Intel LGM PWM support"

> +	depends on OF && HAS_IOMEM
> +	depends on X86 || COMPILE_TEST

For better test coverage you may rewrite this

	depends on HAS_IOMEM
	depends on (OF && X86) || COMPILE_TEST

> +	select REGMAP_MMIO
> +	help
> +	  Generic PWM fan controller driver for LGM SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-intel-lgm.

...

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>

> +#include <linux/of_device.h>

This should be mod_devicetable.h.

> +#include <linux/pwm.h>
> +#include <linux/regmap.h>
> +#include <linux/reset.h>

...

> +#define LGM_PWM_PERIOD_2WIRE_NSECS	40000000

NSECS -> NS
40000000 -> (40 * NSEC_PER_MSEC)

...

> +	if (state->polarity != PWM_POLARITY_NORMAL ||
> +	    state->period < pc->period)

It can be one line.

> +		return -EINVAL;

...

> +	if (!state->enabled) {

> +		ret = lgm_pwm_enable(chip, 0);
> +		return ret;

What is the point?

> +	}

...

> +	ret = lgm_pwm_enable(chip, 1);
> +
> +	return ret;

Ditto.

...

> +	state->duty_cycle = DIV_ROUND_UP(duty * pc->period,
> +					 LGM_PWM_MAX_DUTY_CYCLE);

One line?

...

> +	struct lgm_pwm_chip *pc;
> +	struct device *dev = &pdev->dev;

Use reversed xmas tree order.

> +	void __iomem *io_base;
> +	int ret;

...

> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
> +	if (IS_ERR(pc->regmap)) {

> +		ret = PTR_ERR(pc->regmap);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to init register map: %pe\n",
> +				pc->regmap);
> +		return ret;

dev_err_probe()

> +	}

...

> +	pc->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(pc->clk)) {
> +		ret = PTR_ERR(pc->clk);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get clock: %pe\n", pc->clk);
> +		return ret;

Ditto.

> +	}
> +
> +	pc->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(pc->rst)) {
> +		ret = PTR_ERR(pc->rst);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "failed to get reset control: %pe\n",
> +				pc->rst);
> +		return ret;

Ditto.

> +	}
> +
> +	ret = reset_control_deassert(pc->rst);
> +	if (ret) {
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(dev, "cannot deassert reset control: %pe\n",
> +				ERR_PTR(ret));
> +		return ret;

Ditto.

> +	}

...

> +	ret = clk_prepare_enable(pc->clk);

Wrap it with devm_add_action_or_reset(). Same for reset_control_deassert().
You probably can even put them under one function.

> +	if (ret) {
> +		dev_err(dev, "failed to enable clock\n");
> +		reset_control_assert(pc->rst);
> +		return ret;
> +	}

...

> +	ret = pwmchip_add(&pc->chip);

> +	if (ret < 0) {

Does ' < 0' have any meaning?

> +		dev_err(dev, "failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		clk_disable_unprepare(pc->clk);
> +		reset_control_assert(pc->rst);
> +		return ret;
> +	}

...

> +	ret = pwmchip_remove(&pc->chip);
> +	if (ret < 0)

Ditto.

> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


