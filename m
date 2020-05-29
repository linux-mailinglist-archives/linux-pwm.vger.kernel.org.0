Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4201E7E96
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2020 15:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgE2NZd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 May 2020 09:25:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:33994 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726579AbgE2NZd (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 29 May 2020 09:25:33 -0400
IronPort-SDR: PqJt2LbLXT2IUy1eo0r9JThXlehUJNcmJoYG5Jc7qMtCszBe2p4/aoZatea+jfSPDgd1QHkjC3
 l/OpRNpT0BSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2020 06:25:32 -0700
IronPort-SDR: 7qtcJ9mwY6bMLRbS6kl3AG4lgqYymwYIrXEQTEIXgmU0x9tO64SH03BU8FzFl1mVHlAXe0I5Vo
 JwXuwj4zZB1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,448,1583222400"; 
   d="scan'208";a="271215128"
Received: from mylly.fi.intel.com (HELO [10.237.72.182]) ([10.237.72.182])
  by orsmga006.jf.intel.com with ESMTP; 29 May 2020 06:25:31 -0700
Subject: Re: [PATCH v2] pwm: Add DesignWare PWM Controller Driver
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>
References: <20200508123233.712610-1-jarkko.nikula@linux.intel.com>
 <20200524201116.pc7jmffr6jxlwren@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <4d2b00a9-7970-03b0-c842-4338ac160c43@linux.intel.com>
Date:   Fri, 29 May 2020 16:25:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200524201116.pc7jmffr6jxlwren@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi

Thanks for review.

On 5/24/20 11:11 PM, Uwe Kleine-König wrote:
>> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
>> new file mode 100644
>> index 000000000000..21740273e7a3
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc.c
>> @@ -0,0 +1,300 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
> 
> This isn't kernel-doc, is it? So this should use only a single *
> 
Yes, I'm blind, will fix :-)

>> + * DesignWare PWM Controller driver
>> + *
>> + * Copyright (C) 2018-2020 Intel Corporation
>> + *
>> + * Author: Felipe Balbi (Intel)
>> + * Author: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>> + * Author: Raymond Tan <raymond.tan@intel.com>
>> + */
> 
> Is there publically available documentation available? If yes, please
> add a link here.
> 
Ah, forgot to mention that on my change log. I was too hurry for weekend 
I guess... So no, I didn't find public spec but will check again.

> I would have chosen the following prototype:
> 
> 	static inline void dwc_pwm_writel(struct dwc_pwm *dwc, u32 value, u32 offset)
> 
> Passing a struct dwc_pwm * instead of a void __iomem * saves some
> horizontal space and putting the base in the middle looks bad (but that
> might be subjective?)
> 
I'll check and see.

>> +static void __dwc_pwm_configure(struct dwc_pwm *dwc, int pwm,
>> +				unsigned int duty_ns,
>> +				unsigned int period_ns)
>> +{
>> +	u32 ctrl;
>> +	u32 high;
>> +	u32 low;
>> +
>> +	high = DIV_ROUND_CLOSEST(duty_ns, dwc->clk_period_ns) - 1;
> 
> If duty_ns is zero, high ends up being 0xffffffff which looks wrong?!
> 
> DIV_ROUND_CLOSEST is wrong. Did you test your driver with PWM_DEBUG
> enabled?
> 
Yes it's now on in my .config files. I don't remember did I try with 
zero duty. Which is actually not possible in this HW, nor 100 %. Minimum 
for both high and low periods is one clock cycle.

>> +	low = DIV_ROUND_CLOSEST(period_ns - duty_ns, dwc->clk_period_ns) - 1;
> 
> Would be great to have a comment explaining the resulting waveform for
> these two register values. If I interpret this correctly DWC_TIM_LD_CNT
> defines the time the output is low (A value of x results in (x + 1) * 10
> ns low). And DWC_TIM_LD_CNT2 defines the high time (with the same
> formula). Right?
> 
Yes.

>> +	dwc_pwm_writel(low, dwc->base, DWC_TIM_LD_CNT(pwm));
>> +	dwc_pwm_writel(high, dwc->base, DWC_TIM_LD_CNT2(pwm));
> 
> Maybe add a comment that __dwc_pwm_configure is only called with the PWM
> disabled. This way it gets obvious that there is no race here.
> 
...
>> +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
>> +	__dwc_pwm_configure(dwc, pwm->hwpwm, state->duty_cycle,
>> +			    state->period);
>> +	__dwc_pwm_set_enable(dwc, pwm->hwpwm, state->enabled);
> 
> Is it necessary to disable the hardware for reconfiguration? Please
> document if disabling the hardware completes the currently running
> period.
> 
I forgot also this from the changelog. I was testing this with a script 
toggling minor 1 step duty cycle changes back and forth in a 1 s loop 
using relatively long period (a few seconds IIRC) and didn't see 
differences with or without disabling. Not sure was that methodology 
correct.

However, usage flow in the spec says that timer must be disabled before 
writing load counter registers "in order to avoid potential 
synchronization problems" so best to document it here.

>> +static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      struct pwm_state *state)
>> +{
>> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
>> +	u64 duty, period;
>> +
>> +	pm_runtime_get_sync(dwc->dev);
>> +
>> +	state->enabled = !!(dwc_pwm_readl(dwc->base,
>> +				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
>> +
>> +	duty = dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(pwm->hwpwm));
>> +	duty += 1;
>> +	duty *= dwc->clk_period_ns;
> 
> So the hardware doesn't support a zero duty_cycle? Please document this
> in a Limitations paragraph as do some other drivers. (In the same format
> please to make this easily greppable.)
> 
...
> And the hardware also doesn't support a 100% duty cycle? -> document
> please.
> 
Yes to both. Will add.

>> +	/* Cap the value to 2^32-1 ns */
>> +	state->period = min(period, (u64)(u32)-1);
> 
> Instead of describing in the comment what you do, please tell why.
> 
Or, would it make sense to convert period and duty_cycle in PWM core to 
64-bit? I'm fine to both commenting capping here or changing the period 
and duty to 64-bit.

>> +	dwc->clk_period_ns = DWC_CLK_PERIOD_NS;
> 
> Given this is constant you could drop the member and use
> DWC_CLK_PERIOD_NS instead of dwc->clk_period_ns.
> 
Ok.

>> +	ret = pcim_enable_device(pci);
>> +	if (ret) {
>> +		dev_err(&pci->dev, "Failed to enable device (%d)\n", ret);
> 
> Please use %pE for error codes.
> 
That (%pe I guess?) looks awesome! Will certainly add.

>> +		return ret;
>> +	}
>> +
>> +	pci_set_master(pci);
>> +
>> +	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
>> +	if (ret) {
>> +		dev_err(&pci->dev, "Failed to iomap PCI BAR (%d)\n", ret);
> 
> Don't you need to undo pcim_enable_device?
> 
Yes for pci_enable_device(), pcim_enable_device() is the managed one.

Jarkko
