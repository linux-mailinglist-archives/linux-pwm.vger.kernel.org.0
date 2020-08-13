Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9370E243F4A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Aug 2020 21:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726253AbgHMTYG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Aug 2020 15:24:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:20347 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726249AbgHMTYG (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 13 Aug 2020 15:24:06 -0400
IronPort-SDR: Vh+1QL47bfs3S+rUGk+Pi3Nl67JKZcuCLd3l+mOTLa+1gopswg/KW8do0dPtyUYjIOiqOf2E39
 cBQufKb/ICvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="215837426"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="215837426"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 12:24:06 -0700
IronPort-SDR: Fehaz2vLakIic6YHnUUPe8Kft9srLmKl1amhJaYg1WGwqaEvsIFm8ySGgypQyUWFGWUrdxXTf3
 +aaVM8vqpCgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="325514344"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2020 12:24:04 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k6IpW-008VE7-V6; Thu, 13 Aug 2020 22:24:02 +0300
Date:   Thu, 13 Aug 2020 22:24:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v3 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200813192402.GI1891694@smile.fi.intel.com>
References: <1597334646-21087-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1597334646-21087-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597334646-21087-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 14, 2020 at 12:04:05AM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 
> Enable PWM support for the Intel Keem Bay SoC.

...

> +static inline void keembay_pwm_update_bits(struct keembay_pwm *priv, u32 mask,
> +					   u32 val, u32 offset)
> +{
> +	u32 buff, tmp;

> +	void __iomem *address;

No need to have this. Just use calc in place.

> +	address = priv->base + offset;

> +	buff = readl(address);

> +	tmp = buff & ~mask;
> +	tmp |= FIELD_PREP(mask, val);

One line and one variable less:

	buff = (buff & ~mask) | FIELD_PREP(...);

But shouldn't be u32_replace_bits() instead?

> +	writel(tmp, address);
> +}

...

> +	 * high time = clock rate * duty cycle / NSEC_PER_SEC
> +	 * low time =  clock rate * (period - duty cycle) / NSEC_PER_SEC

> +	 * e.g. For period 50000ns, duty cycle 30000ns, and clock rate 500MHz:
> +	 * high time = (500000000 * 30000) / 1000000000 = 0x3A98
> +	 * low time = (500000000 * 20000) / 1000000000 = 0x2710

Please, replace all multipliers to physical units
	... 50us ... 30us ...
	... 500MHz * 30us = 0x3a98
	...and so on.

> +	 * Value written to KMB_PWM_HIGHLOW_OFFSET = 0x3A982710

...

> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk)) {

> +		if (PTR_ERR(priv->clk) != -EPROBE_DEFER)
> +			dev_err(dev, "Failed to get clock: %pe", priv->clk);
> +
> +		return PTR_ERR(priv->clk);

return dev_err_probe(...);

> +	}

...

> +	ret = pwmchip_add(&priv->chip);
> +	if (ret < 0) {

' < 0' makes any sense?

> +		dev_err(dev, "Failed to add PWM chip: %pe\n", ERR_PTR(ret));
> +		return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


