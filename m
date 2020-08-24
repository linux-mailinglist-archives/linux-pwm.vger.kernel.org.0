Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2B324F38C
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 10:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbgHXIDx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 04:03:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:9876 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbgHXIDp (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 04:03:45 -0400
IronPort-SDR: P/TR/vsPzETOh+Idt4yNcCRe1t/94fUDzlzQNDP7MP6gOSPBSnGChU0MTQAxeRkIIwSi0DDjRg
 k1KxLufosl7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135399630"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="135399630"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 01:03:45 -0700
IronPort-SDR: nsuW3aUHJ28vqbV5G1i/JloVAVpwBrPSIpnluXRnHUS9A9AnCrkF/0gXwmUrvxpCkC/+vG8buR
 HEGF2M3fcbIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="328410026"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 24 Aug 2020 01:03:42 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1kA7Ha-00AzUx-S4; Mon, 24 Aug 2020 10:52:46 +0300
Date:   Mon, 24 Aug 2020 10:52:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     vineetha.g.jaya.kumaran@intel.com
Cc:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        robh+dt@kernel.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, wan.ahmad.zainie.wan.mohamad@intel.com,
        lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v4 1/2] pwm: Add PWM driver for Intel Keem Bay
Message-ID: <20200824075246.GZ1891694@smile.fi.intel.com>
References: <1598106646-16595-1-git-send-email-vineetha.g.jaya.kumaran@intel.com>
 <1598106646-16595-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598106646-16595-2-git-send-email-vineetha.g.jaya.kumaran@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Sat, Aug 22, 2020 at 10:30:45PM +0800, vineetha.g.jaya.kumaran@intel.com wrote:
> From: "Lai, Poey Seng" <poey.seng.lai@intel.com>
> 

Side note, please use my @linux.intel.com address in the Cc list.

> Enable PWM support for the Intel Keem Bay SoC.

...

> + * Authors: Lai Poey Seng <poey.seng.lai@intel.com>
> + *          Vineetha G. Jaya Kumaran <vineetha.g.jaya.kumaran@intel.com>

Seems you missed Co-developed-by in the tag block of commit message.

...

> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

There is no user of this header. But mod_devicetable.h is missing.

> +#include <linux/platform_device.h>
> +#include <linux/pwm.h>
> +#include <linux/regmap.h>

...

> +	/*
> +	 * The upper 16 bits of the KMB_PWM_HIGHLOW_OFFSET register contain
> +	 * the high time of the waveform, while the last 16 bits contain
> +	 * the low time of the waveform, in terms of clock cycles.
> +	 *
> +	 * high time = clock rate * duty cycle / NSEC_PER_SEC
> +	 * low time =  clock rate * (period - duty cycle) / NSEC_PER_SEC
> +	 *
> +	 * e.g. For period 50us, duty cycle 30us, and clock rate 500MHz:

> +	 * high time = (500MHz * 30us) / 1000000000 = 0x3A98

10^9 divisor now is redundant. It's school physics about units.

> +	 * low time = (500MHz * 20us) / 1000000000 = 0x2710

Ditto.

> +	 * Value written to KMB_PWM_HIGHLOW_OFFSET = 0x3A982710
> +	 */

Note, in the code you are operating different units.

...

> +	div = clk_rate * state->duty_cycle;
> +	div = DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);

For example, here you have clock rate in Hz, duty cycle in ns, that's why you
need to use NSEC_PER_SEC divisor here.

...

> +	div = clk_rate * (state->period - state->duty_cycle);
> +	div = DIV_ROUND_CLOSEST_ULL(div, NSEC_PER_SEC);

Same here.

(Just to be clear, code is okay!)

...

> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->clk))
> +		dev_err_probe(dev, PTR_ERR(priv->clk),
> +			     "Failed to get clock\n");

First of all, it can be one line, second, it misses something...

-- 
With Best Regards,
Andy Shevchenko


