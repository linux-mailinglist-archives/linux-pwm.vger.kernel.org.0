Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A312D7423
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 11:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389339AbgLKKpv (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 05:45:51 -0500
Received: from foss.arm.com ([217.140.110.172]:49030 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728740AbgLKKpf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 11 Dec 2020 05:45:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A98FC31B;
        Fri, 11 Dec 2020 02:44:49 -0800 (PST)
Received: from [10.57.61.6] (unknown [10.57.61.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0CA63F68F;
        Fri, 11 Dec 2020 02:44:47 -0800 (PST)
Subject: Re: [PATCH] pwm: rockchip: Eliminate potential race condition when
 probing
To:     Trent Piepho <tpiepho@gmail.com>,
        Simon South <simon@simonsouth.net>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-rockchip@lists.infradead.org, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org
References: <875z5nof46.fsf@simonsouth.net>
 <20201130004419.1714-1-simon@simonsouth.net> <X9JfbpTnfqUVk6iN@ulmo>
 <2304095.iZASKD2KPV@zen.local>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <07807886-0abc-52a2-d3b5-d994b0d7c701@arm.com>
Date:   Fri, 11 Dec 2020 10:44:46 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <2304095.iZASKD2KPV@zen.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 2020-12-10 21:00, Trent Piepho wrote:
> On Thursday, December 10, 2020 9:48:30 AM PST Thierry Reding wrote:
>> On Sun, Nov 29, 2020 at 07:44:19PM -0500, Simon South wrote:
>>> @@ -326,21 +329,38 @@ static int rockchip_pwm_probe(struct
>>> platform_device *pdev)>
>>>   		return ret;
>>>   	
>>>   	}
>>>
>>> -	ret = clk_prepare_enable(pc->clk);
>>> +	ret = clk_prepare(pc->clk);
>>>
>>>   	if (ret) {
>>>
>>> -		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
>>> +		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
>>>
>>>   		return ret;
>>>   	
>>>   	}
>>>
>>> +	/*
>>> +	 * If it appears the PWM has already been enabled, perhaps by a
>>> +	 * bootloader, re-enable its clock to increment the clock's enable
>>> +	 * counter and ensure it is kept running (particularly in the case
>>> +	 * where there is no separate APB clock).
>>> +	 */
>>> +	enable_conf = pc->data->enable_conf;
>>> +	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
>>> +	enabled = (ctrl & enable_conf) == enable_conf;
>>
>> Given that we don't enable the bus clock before this, is it even safe to
>> access registers on the bus if the clock is disabled? I've seen a lot of
>> cases where accesses to an unclocked bus either lead to silent hangs or
>> very noisy crashes, and I would expect something like that (or something
>> in between) to happen on Rockchip SoCs.
> 
> I would also assume register access with the clock disabled would hang or
> otherwise fail.  There are possibly two clocks, one called "bus clock" and
> the other "APB clock".  APB being Advanced Peripheral Bus.  Not the greatest
> choice of names.  I assume the APB clock is needed for register access and
> the "bus clock" is used to generate the PWM signal and does not need to be
> enabled for register access.  Unfortunately the RK3399 docs do not have a
> clock diagram for the PWM or include details such as these.
> 
> There is a low power mode bit in the control register that disables the PWM
> signal's clock.  And which clock does that disabled, the "ABP clock" or the
> "bus clock"?  I quote §18.6.4, "the APB bus clock … is gated…"  It's like
> they're being intentional ambiguous.

FWIW I think it becomes clear enough if you read the DT binding in 
parallel with the code - if devm_clk_get(&pdev->dev, "pwm") fails, the 
driver falls back to assuming the RK3399-or-earlier case of a single 
unnamed clock, so "Can't get bus clk" is referring specifically to the 
devm_clk_get(&pdev->dev, NULL) call where that clock *is* also the APB 
clock.

Possibly the driver could do with a slightly clearer structure here, but 
compatibility fallbacks are inevitably messy to some degree.

Robin.

> Anyway, from the existing code, it seems clear that pc->pclk needs to be
> enabled for register access and pc->clk to generate a signal.  The call to
> clk_prepare(pc->pclk) should become clk_prepare_enable(pc->pclk) and moved
> to before the enabled_conf check.  Then clk_disable(pc->pclk) afterward.
> The existing code will disable pclk even if the PWM is enabled, so unless
> that is also a bug, it should be ok to disable pc->pclk after enabling
> pc->clk.
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
