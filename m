Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5047B24D098
	for <lists+linux-pwm@lfdr.de>; Fri, 21 Aug 2020 10:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgHUIeU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 21 Aug 2020 04:34:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:56150 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgHUIeU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 21 Aug 2020 04:34:20 -0400
IronPort-SDR: oz4lFG840vQdO0iZnRNzsJd0ltH8DfBihxPBQ89GmQUDn+TVCfZuRlPT/3613hdfpqwQu14qoD
 20Qj3qwkNqLQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="156541988"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="156541988"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 01:34:19 -0700
IronPort-SDR: yKfxbOr24TelhNRiVvpNppbz77Gv4KCoV1rc0ZILM/dgLDab8B02F0f6uNPu/Nc8mgdTWrLSnl
 Quk7m2+uwKFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="327705469"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 01:34:16 -0700
Received: from andy by smile with local (Exim 4.94)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1k92KV-00AIAJ-Pa; Fri, 21 Aug 2020 11:23:19 +0300
Date:   Fri, 21 Aug 2020 11:23:19 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
Subject: Re: [PATCH v8 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200821082319.GI1891694@smile.fi.intel.com>
References: <cover.1597898872.git.rahul.tanwar@linux.intel.com>
 <b6d0a65625a2bc231c649c970c0a1af1ff3a5dd5.1597898872.git.rahul.tanwar@linux.intel.com>
 <20200820105255.GB1891694@smile.fi.intel.com>
 <ae472e72-8727-b62b-4fc7-f62aa41cafbc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae472e72-8727-b62b-4fc7-f62aa41cafbc@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On Fri, Aug 21, 2020 at 02:07:49PM +0800, Tanwar, Rahul wrote:
> On 20/8/2020 6:52 pm, Andy Shevchenko wrote:
> > On Thu, Aug 20, 2020 at 12:50:46PM +0800, Rahul Tanwar wrote:

...

> >> +	ret = clk_prepare_enable(pc->clk);
> > Wrap it with devm_add_action_or_reset(). Same for reset_control_deassert().
> > You probably can even put them under one function.
> 
> I did some study and research for using devm_add_action_or_reset(). But
> still i have some doubts. Below steps is what i intend to do in order to
> switch to using this API. Please do review and let me know it is ok and
> i am not missing anything else. Thanks.
> 
> 1. Call reset_control_assert()
> 2. Call clk_prepare_enable()

> 3. Call pwmchip_add()

First of all, I haven't told anything about this.

> 4. Call devm_add_action_or_reset(dev, my_action, pc)
> 5. Remove explicit calls to unprepare/reset_control_assert from probe in
> failure cases.
> 6. static void my_action(void *pc)
>    {
>       pwmchip_remove(&pc->chip);
>       clk_disable_upprepare(pc->clk);
>       reset_control_assert(pc->rst);
>    }
> 7. Remove platform_driver.remove() entirely.

Nope, pwmchip_add() and pwmchip_remove() stay as is now.

Only wrap clock and reset resources.

> >> +	if (ret) {
> >> +		dev_err(dev, "failed to enable clock\n");
> >> +		reset_control_assert(pc->rst);
> >> +		return ret;
> >> +	}

-- 
With Best Regards,
Andy Shevchenko


