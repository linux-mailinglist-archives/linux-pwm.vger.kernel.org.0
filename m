Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903CB180EDE
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2020 05:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725813AbgCKENu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 11 Mar 2020 00:13:50 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:41052 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgCKENu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 11 Mar 2020 00:13:50 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02B4Dblu125647;
        Tue, 10 Mar 2020 23:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583900017;
        bh=5ofOG+gfPhoCmIZuODzbDvCrnXBGO1iU4BMFVihuZv0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=HHqxNgTAkdPmlgBcyBRt8vw4//wXk7a+cDh/MitEhOTQUXnWyREtXboOtlrv8B46H
         H26TH35w5hXSwBZzdV0/ivFV1v6FhXBO1KDVuXPEdre4UZSFSbAiF77QZHZvsKgwuJ
         cFdOGixee9bWYIwry8zbwCXt7izizSgNEczcD2EU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02B4DbpB127963
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Mar 2020 23:13:37 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 10
 Mar 2020 23:13:37 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 10 Mar 2020 23:13:37 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02B4DY32014325;
        Tue, 10 Mar 2020 23:13:35 -0500
Subject: Re: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
To:     Tony Lindgren <tony@atomide.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Sebastian Reichel <sre@kernel.org>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
 <20200228095651.32464-5-lokeshvutla@ti.com>
 <20200306181443.GJ37466@atomide.com>
 <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
 <20200309180123.GP37466@atomide.com>
 <666dbb7a-db98-d16a-ee73-27d353d2a317@ti.com>
 <20200310155242.GT37466@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <296e28b7-7925-5dfa-ce5a-c0b2a2f1c2e0@ti.com>
Date:   Wed, 11 Mar 2020 09:42:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200310155242.GT37466@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org



On 10/03/20 9:22 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [200310 07:06]:
>> Hi Tony,
>>
>> [...snip...]
>>
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * Disable auto reload so that the current cycle gets completed and
>>>>>> +	 * then the counter stops.
>>>>>> +	 */
>>>>>>  	mutex_lock(&omap->mutex);
>>>>>> -	omap->pdata->stop(omap->dm_timer);
>>>>>> +	omap->pdata->set_pwm(omap->dm_timer,
>>>>>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>>>>>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
>>>>>> +			     false);
>>>>>> +
>>>>>>  	mutex_unlock(&omap->mutex);
>>>>>>  }
>>>>>
>>>>> I'm seeing an issue with this patch where after use something is
>>>>> left on and power consumption stays higher by about 30 mW after
>>>>> use.
>>>>
>>>> Interesting...What is the PWM period and duty cycle in the test case?
>>>> Can you dump the following registers before and after disabling:
>>>> - TLDR
>>>> - TMAR
>>>> - TCLR
>>>
>>> Here's the state dumped before and after in omap_dm_timer_set_pwm():
>>>
>>> omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
>>> omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
>>> omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00000040
>>> omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001842
>>> omap_timer 4013e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
>>> omap_timer 4013e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
>>> omap_timer 4803e000.timer: XXX set_pwm before: tldr: fffffeb8 tmar: fffffffe tclr: 00001843
>>> omap_timer 4803e000.timer: XXX set_pwm after: tldr: fffffeb8 tmar: fffffffe tclr: 00001841
>>>
>>
>> Looking at the registers:
>> period = 327 *(1000/clk_freq in MHz) ns
>> duty_cycle =  perioid.
>>
>> I did simulate this behavior on BeagleBoneBlack on timer7. PWM is going down
>> after disabling.
>>
>>> So looks like the start bit is still enabled after use?
>>
>> Right, that is expected. The start bit gets disabled automatically once the pwm
>> period completes. This is because auto reload bit is off. That's the main idea
>> of this patch so that PWM period is completed after disabling, else PWM is
>> stopped abruptly.
> 
> OK
> 
>> Not sure why it is not happening in your case. If you think it is not needed, I
>> can drop this patch and add a limitation saying that PWM gets disabled
>> immediately without completing the current cycle.
> 
> Could it be that we now have the cpu_pm notifier restore something
> invalid after exiting idle that restarts the counter?

If that's the case, mis behavior should have happened without this patch as well.

Is it possible for you to dump the registers when you are observing higher power
consumption after the use?

However, I see an issue with the patch itself as pm_runtime is not disabled
after the pwm is stopped. Not sure how that could be nullified with this approach.


Thanks and regards,
Lokesh
