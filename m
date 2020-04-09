Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF271A33CE
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDIMKu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 08:10:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:48884 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgDIMKu (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 9 Apr 2020 08:10:50 -0400
IronPort-SDR: JD1UOVtRZvOKA8BbPhqStdX9SMToIggQGLNDqOp+hdca7xWSCC3SB/dliPHAMLRM3xX36AMB0d
 Dr/ljNvel/9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2020 05:10:50 -0700
IronPort-SDR: Vyos/EH52Ork9vMP5IPTuGcpmfS2aKm/4Db6XhB24UAYziYNxEOPWJVpYplAeKoI4zBefXxbc4
 Yv3PMono507Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,362,1580803200"; 
   d="scan'208";a="270058516"
Received: from mylly.fi.intel.com (HELO [10.237.72.51]) ([10.237.72.51])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2020 05:10:47 -0700
Subject: Re: [PATCH] pwm: Add DesignWare PWM Controller Driver
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Raymond Tan <raymond.tan@intel.com>,
        Felipe Balbi <balbi@kernel.org>
References: <20200408125404.527090-1-jarkko.nikula@linux.intel.com>
 <20200409084828.uzqjb65zh3vklqs2@pengutronix.de>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <1216506a-de51-1f37-7d7a-de7d9bbd9433@linux.intel.com>
Date:   Thu, 9 Apr 2020 15:10:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200409084828.uzqjb65zh3vklqs2@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi

On 4/9/20 11:48 AM, Uwe Kleine-König wrote:
>> diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
>> new file mode 100644
>> index 000000000000..962d504c1281
>> --- /dev/null
>> +++ b/drivers/pwm/pwm-dwc.c
>> @@ -0,0 +1,328 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/**
>> + * DesignWare PWM Controller driver
>> + *
>> + * Copyright (C) 2018-2020 Intel Corporation
>> + *
>> + * Author: Felipe Balbi
> 
> Is there a publicly available reference manual available? If so, adding
> a link here would be great.
> 
Point taken as well as for other trivial ones. Replies to more complex 
ones below.

>> +static void __dwc_pwm_configure(struct dwc_pwm *dwc, int pwm,
>> +				unsigned int duty_ns,
>> +				unsigned int period_ns)
>> +{
>> +	u32 ctrl;
>> +	u32 high;
>> +	u32 low;
>> +
>> +	high = DIV_ROUND_CLOSEST(duty_ns, dwc->clk_period_ns) - 1;
>> +	low = DIV_ROUND_CLOSEST(period_ns - duty_ns, dwc->clk_period_ns) - 1;
> 
> Have you tested your driver with CONFIG_PWM_DEBUG? I would expect that
> using ROUND_CLOSEST triggers
> 
> 	.apply is supposed to round down period
> 
> in some situations.
> 
Hmm.. in fact not tested, nor near the and over the boundaries. Will check.

> Maybe soon duty_ns and period_ns will become 64 bit integers. I suggest
> to already cope for this today and introduce proper range checking.
> 
Ah, good to know.

>> +static void __dwc_pwm_set_enable(struct dwc_pwm *dwc, int pwm, int enabled)
>> +{
>> +	u32 reg;
>> +
>> +	reg = dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(pwm));
>> +
>> +	if (enabled)
>> +		reg |= DWC_TIM_CTRL_EN;
>> +	else
>> +		reg &= ~DWC_TIM_CTRL_EN;
>> +
>> +	dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(pwm), reg);
> 
> What happens to the output if the EN bit is cleared? Does the hardware
> complete the currently running period? If not, does the output "freeze"
> or get inactive?
...
> 
> Is it necessary to stop the hardware before writing the counter
> registers? Or is this only done to prevent race conditions that yield
> unexpected cycles?
> 
Good questions. I need to spend time in the lab next week and debug :-)

>> +static int dwc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			 const struct pwm_state *state)
>> +{
>> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
>> +
>> +	mutex_lock(&dwc->lock);
>> +
>> +	if (state->enabled) {
>> +		if (!pwm_is_enabled(pwm))
> 
> If pwm_is_enabled() would be changed to call .get_state() you'd run in a
> dead lock. Please don't call PWM API functions in driver callbacks.
> 
Oh. I guess we copied this from pwm-lpss.c and pwm-mxs.c.

>> +			pm_runtime_get_sync(dwc->dev);
>> +		__dwc_pwm_configure_timer(dwc, pwm, state);
>> +	} else {
>> +		if (pwm_is_enabled(pwm)) {
>> +			__dwc_pwm_set_enable(dwc, pwm->hwpwm, false);
>> +			pm_runtime_put_sync(dwc->dev);
>> +		}
>> +	}
> 
> You don't check state->polarity here.
> 
If I recall correctly I didn't see the polarity bit in HW but will 
check. Should the driver emulate it by recalculating duty etc since I 
didn't see quickly from PWM core can a driver with apply() callback 
report support for polarity?

>> +static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
>> +			      struct pwm_state *state)
>> +{
>> +	struct dwc_pwm *dwc = to_dwc_pwm(chip);
>> +
>> +	pm_runtime_get_sync(dwc->dev);
>> +
>> +	mutex_lock(&dwc->lock);
>> +	state->enabled = __dwc_pwm_is_enabled(dwc, pwm->hwpwm);
>> +	state->duty_cycle = __dwc_pwm_duty_ns(dwc, pwm->hwpwm);
>> +	state->period = __dwc_pwm_period_ns(dwc, pwm->hwpwm,
>> +					    state->duty_cycle);
> 
> I wonder if doing the math in .get_state() directly
> instead of introducing a function with IMHO strange semantics that is
> only used once would be easier to understand.
> 
Maybe. Will check how does it look that way.

>> +	dwc->version = dwc_pwm_readl(dwc->base, DWC_TIMERS_COMP_VERSION);
>> +
>> +	/* mask all interrupts and disable all timers */
>> +	for (i = 0; i < data->npwm; i++) {
>> +		dwc_pwm_writel(dwc->base, DWC_TIM_CTRL(i), 0);
>> +		dwc_pwm_writel(dwc->base, DWC_TIM_LD_CNT(i), 0);
>> +		dwc_pwm_writel(dwc->base, DWC_TIM_CUR_VAL(i), 0);
>> +	}
> 
> Does "disable all timers" result in stopping all outputs? If so, please
> don't to allow taking over running hardware from the boot loader.
> 
Very good point. We probably didn't think about that.

>> +	mutex_init(&dwc->lock);
> 
> What does this mutex protect? I think it's save to assume that calls to
> .get_state() and .apply_state() for a single channel are serialized by the
> core, so locking might not be necessary at the driver level.
> 
That would be good. Will check.

>> +#ifdef CONFIG_PM_SLEEP
>> +static int dwc_pwm_suspend(struct device *dev)
>> +{
>> +	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
>> +	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
>> +	int i, index_base;
>> +
>> +	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
>> +		index_base = i * 3;
>> +		dwc->saved_registers[index_base] =
>> +			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT(i));
>> +		dwc->saved_registers[index_base+1] =
>> +			dwc_pwm_readl(dwc->base, DWC_TIM_LD_CNT2(i));
>> +		dwc->saved_registers[index_base+2] =
>> +			dwc_pwm_readl(dwc->base, DWC_TIM_CTRL(i));
>> +	}
> 
> Does sleeping stop the output? If so (I think) you should prevent going
> to sleep if the consumers didn't stop the output.
> 
I believe stopping the activity is an expectation during suspend but 
don't have the knowledge here. So in general PWM consumers should stop 
the PWM in their suspend handlers, e.g. in display panel drivers etc, 
rather than blindly stop it here? How about when PWM is enabled from sysfs?

-- 
Jarkko
