Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD41F19A93F
	for <lists+linux-pwm@lfdr.de>; Wed,  1 Apr 2020 12:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgDAKPT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 1 Apr 2020 06:15:19 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57998 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgDAKPS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 1 Apr 2020 06:15:18 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 031AFB50074640;
        Wed, 1 Apr 2020 05:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585736111;
        bh=VHWDppBeZMnct+fmlb85sd/m6PVJpfigJspsPqyup8Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QSpSRc4hvstCrq8bCBJgAGMf+nwXD9BVZFiWhDPTG8iTSasO43GTpmRL5uCpgNDOv
         JQAdqyVILFKk97QretLTYP9rYwnhjv9EH6SxaZszW8Whs6D5mD6zA96DAOTe7hzxY6
         k3G1CDcHs+GXkYZoiJuUFvlXlAgyt/cOISrEdmAc=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 031AFAVn071292
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 1 Apr 2020 05:15:11 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 1 Apr
 2020 05:15:10 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 1 Apr 2020 05:15:10 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 031AF7q6122698;
        Wed, 1 Apr 2020 05:15:08 -0500
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <20200330141436.GG2431644@ulmo> <638d7136-6a74-8069-5331-b2248c948ed4@ti.com>
 <20200331201014.GA2954599@ulmo>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <57ce30f0-00e1-cbe6-8412-5461b412b361@ti.com>
Date:   Wed, 1 Apr 2020 15:45:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200331201014.GA2954599@ulmo>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Thierry,

On 01/04/20 1:40 AM, Thierry Reding wrote:
> On Tue, Mar 31, 2020 at 08:59:47PM +0530, Lokesh Vutla wrote:
>> Hi Thierry,
>>
>> On 30/03/20 7:44 PM, Thierry Reding wrote:
>>> On Thu, Mar 12, 2020 at 07:40:42AM +0100, Uwe Kleine-König wrote:
>>>> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
>>>>> Only the Timer control register(TCLR) cannot be updated when the timer
>>>>> is running. Registers like Counter register(TCRR), loader register(TLDR),
>>>>> match register(TMAR) can be updated when the counter is running. Since
>>>>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>>>>> timer for period/duty_cycle update.
>>>>
>>>> I'm not sure what is sensible here. Stopping the PWM for a short period
>>>> is bad, but maybe emitting a wrong period isn't better. You can however
>>>> optimise it if only one of period or duty_cycle changes.
>>>>
>>>> @Thierry, what is your position here? I tend to say a short stop is
>>>> preferable.
>>>
>>> It's not clear to me from the above description how exactly the device
>>> behaves, but I suspect that it may latch the values in those registers
>>> and only update the actual signal output once a period has finished. I
>>> know of a couple of other devices that do that, so it wouldn't be
>>> surprising.
>>>
>>> Even if that was not the case, I think this is just the kind of thing
>>> that we have to live with. Sometimes it just isn't possible to have all
>>> supported devices adhere strictly to an API. So I think the best we can
>>> do is have an API that loosely defines what's supposed to happen and
>>> make a best effort to implement those semantics. If a device deviates
>>> slightly from those expectations, we can always cross fingers and hope
>>> that things still work. And it looks like they are.
>>>
>>> So I think if Lokesh and Tony agree that this is the right thing to do
>>> and have verified that things still work after this, that's about as
>>> good as it's going to get.
>>
>> Yes this is needed especially in the use-case[0] that I am trying to enable
>> using PWM. In this case PWM cannot be stopped in between and needs to be updated
>> dynamically. Also hardware doesn't provide any restrictions on updating the
>> period. So IMHO, this might be the right thing to do.
>>
>> Tony did provide tested-by and I measured PWM signals on scope with these
>> changes. Let me know if any thing else is required?
>>
>> [0] https://sourceforge.net/p/linuxptp/mailman/message/36943248/
> 
> From you measurements, can you tell whether or not the signal actually
> gets updated in the middle of a period, or does it only get updated at
> the end of a full period?

There is a corner case where period/duty-cycle gets updated in the middle of the
cycle. So let me give more details on how it works:

OMAP dual-mode timers with a upward  timer counter, can be configured in PWM
mode. When the timer counter overflows it gets reloaded with the load value(Load
register) and the pwm output goes up. When counter matches with match register,
the output goes down. So the load register is used to calculate the period and
similarly match register for duty cycle.

When PWM is running and changing both duty cycle and period, we cannot prevent
in software that the output might produce a period with mixed settings.
Especially when the PWM signal is high the following cases can happen:
1) When signal is high and new match value is > current timer counter. Then the
duty cycle gets reflected in the current cycle.(Duty_cycle for current period=
new match value -  previous load  value).
2) When signal is high and new match value is < current timer counter. Then the
period and duty cycle for the current cycle gets effected as well. Because the
signal is pulled down only when counter matches with match register, and this
happens only in the next cycle(after timer counter overflows). Then:
	- new Period for current cycle = (current period + new period)
	- new duty cycle for current cycle =  (current period + new duty_cycle).

Rest all the cases the values gets reflected in the next cycle.

As advised by Uwe, I have updated all these details in driver.

Thanks and regards,
Lokesh


