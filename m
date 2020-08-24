Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC2C24F8BF
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 11:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgHXJhJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 05:37:09 -0400
Received: from mga12.intel.com ([192.55.52.136]:16464 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgHXJgy (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 24 Aug 2020 05:36:54 -0400
IronPort-SDR: rFHxpNYUpeyJ5Q+HoqLM0A6ZwifP0W4U+6P8oOML0fvpp1qJG5rT0sDYylIS/Uezs40dBoaEEf
 rrAeUHiWIyTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135412726"
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="135412726"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 02:36:52 -0700
IronPort-SDR: 67MvChZQtMHeJGcLdFvFwsT6bbMTvuekf5QhyOcXeEmCSDtpZWY29mFmWCA+/rewHoWu7cSXQ4
 2loCMKTHXHMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,348,1592895600"; 
   d="scan'208";a="279608953"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 24 Aug 2020 02:36:52 -0700
Received: from [10.249.74.159] (rtanwar-MOBL.gar.corp.intel.com [10.249.74.159])
        by linux.intel.com (Postfix) with ESMTP id 403425805B5;
        Mon, 24 Aug 2020 02:36:48 -0700 (PDT)
Subject: Re: [PATCH v10 2/2] Add PWM fan controller driver for LGM SoC
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
        lee.jones@linaro.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        songjun.Wu@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, rahul.tanwar.linux@gmail.com,
        rtanwar@maxlinear.com
References: <cover.1598240097.git.rahul.tanwar@linux.intel.com>
 <05b664b961e37c1c35fa7d5d1cfc9ae244bc86bc.1598240097.git.rahul.tanwar@linux.intel.com>
 <20200824081715.GA1891694@smile.fi.intel.com>
From:   "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>
Message-ID: <ed7affbb-b95d-cf42-b9bc-71addf908ffc@linux.intel.com>
Date:   Mon, 24 Aug 2020 17:36:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200824081715.GA1891694@smile.fi.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


Hi Andy,

On 24/8/2020 4:17 pm, Andy Shevchenko wrote:
> On Mon, Aug 24, 2020 at 11:36:37AM +0800, Rahul Tanwar wrote:
>> Intel Lightning Mountain(LGM) SoC contains a PWM fan controller.
>> This PWM controller does not have any other consumer, it is a
>> dedicated PWM controller for fan attached to the system. Add
>> driver for this PWM fan controller.
> ...
>
>> +	pc->regmap = devm_regmap_init_mmio(dev, io_base, &lgm_pwm_regmap_config);
>> +	if (IS_ERR(pc->regmap)) {
>> +		ret = PTR_ERR(pc->regmap);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err_probe(dev, ret, "failed to init register map\n");
>> +		return ret;
>> +	}
>> +
>> +	pc->clk = devm_clk_get(dev, NULL);
>> +	if (IS_ERR(pc->clk)) {
>> +		ret = PTR_ERR(pc->clk);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err_probe(dev, ret, "failed to get clock\n");
>> +		return ret;
>> +	}
>> +
>> +	pc->rst = devm_reset_control_get_exclusive(dev, NULL);
>> +	if (IS_ERR(pc->rst)) {
>> +		ret = PTR_ERR(pc->rst);
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err_probe(dev, ret, "failed to get reset control\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = reset_control_deassert(pc->rst);
>> +	if (ret) {
>> +		if (ret != -EPROBE_DEFER)
>> +			dev_err_probe(dev, ret, "cannot deassert reset control\n");
>> +		return ret;
>> +	}
> Please, spend a bit of time to understand the changes you are doing. There are
> already few examples how to use dev_err_probe() properly.

I guess your point is that the check of (ret !- -EPROBE_DEFER) is not needed
when using dev_err_probe() as it encapsulates it. Sorry, i missed it. Will
fix it. I am not able to find any other missing point after referring to
two driver examples which uses dev_err_probe() ?

>> +	ret = clk_prepare_enable(pc->clk);
>> +	if (ret) {
>> +		dev_err(dev, "failed to enable clock\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = devm_add_action_or_reset(dev, lgm_pwm_action, pc);
>> +	if (ret)
>> +		return ret;
> You have also ordering issues here.
>
> So, what I can see about implementation is that
>
>
> 	static void ..._clk_disable(void *data)
> 	{
> 		clk_disable_unprepare(data);
> 	}
>
> 	static int ..._clk_enable(...)
> 	{
> 		int ret;
>
> 		ret = clk_preare_enable(...);
> 		if (ret)
> 			return ret;
> 		return devm_add_action_or_reset(..., ..._clk_disable);
> 	}
>
>
> Similar for reset control.
>
> Then in the ->probe() something like this:
>
> 	ret = devm_reset_control_get...;
> 	if (ret)
> 		return ret;
>
> 	ret = ..._reset_deassert(...);
> 	if (ret)
> 		return ret;
>
> followed by similar section for the clock.
>

Regarding ordering: In early rounds of review, feedback about ordering was that
it is recommended to be reverse of the sequence in probe i.e.
if in probe:
1. reset_control_deassert()
2. clk_prepare_enable()
then in remove:
1. clk_disable_uprepare()
2. reset_control_assert()

That's the reason i added a generic action() which reverses order.

I understand your suggested way as explained above but not sure if that would
ensure reverse ordering during unwind.

Thanks.

Regards,
Rahul
