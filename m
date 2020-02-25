Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41A4616BF90
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 12:27:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgBYL1D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 06:27:03 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34504 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbgBYL1D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 06:27:03 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01PBQsPq071859;
        Tue, 25 Feb 2020 05:26:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582630015;
        bh=YR8UHKTlWWxwot/NVci/5JdswMv6nWbcN4ohO7xw1d8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=YYzovR34NIFVJ1k4dWp+/eCPgAmMQqZvzaYGCctFCJD2qWoQdM1BVhoONFvQ7a7g6
         VYKmPjfaqa+4PLKvNPU59XrR2K6EznvSTSqiH+EAVSVKXCdPQreps3GxFWN74gWU1Z
         EUdDr3SXOnQVR1O+N3nucjhKgDpEOZwB1GNsB614=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01PBQsTc112032
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 05:26:54 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 05:26:54 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 05:26:54 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01PBQpGq099372;
        Tue, 25 Feb 2020 05:26:52 -0600
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before changing
 period/duty_cycle
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, <kernel@pengutronix.de>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
 <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
 <4aedb6d4-1823-ab46-b7e6-cc0b30f7747d@ti.com>
 <20200225064833.kmvaplfqqf53s3iy@pengutronix.de>
 <8e22912c-a65f-9efe-27e7-555cd144776f@ti.com>
 <20200225083846.4l4tnbjcpm6uggtl@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <4d830367-403a-5cf5-abf0-7daccbece1ae@ti.com>
Date:   Tue, 25 Feb 2020 16:56:02 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200225083846.4l4tnbjcpm6uggtl@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 25/02/20 2:08 PM, Uwe Kleine-König wrote:
> Hello Lokesh,
> 
> On Tue, Feb 25, 2020 at 01:29:57PM +0530, Lokesh Vutla wrote:
>> On 25/02/20 12:18 PM, Uwe Kleine-König wrote:
>>> On Tue, Feb 25, 2020 at 10:32:42AM +0530, Lokesh Vutla wrote:
>>>> On 24/02/20 2:25 PM, Uwe Kleine-König wrote:
>>>>> On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
>>>>>>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
>>>>>>  	omap->pdata->set_match(omap->dm_timer, true, match_value);
>>>>>
>>>>> (Without having looked into the depths of the driver I assume
>>>>> .set_load() sets the period of the PWM and .set_match() the duty cycle.)
>>>>
>>>> Right.
>>>>
>>>>>
>>>>> What happens on a running PWM if you change the period? Consider you
>>>>> change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
>>>>> period = 10000. As you set the period first, can it happen the hardware
>>>>> produces a cycle with duty_cycle = 1000, period = 10000?
>>>>
>>>> No. So, the current cycle is un affected with duty_cycle = 1000 and period =
>>>> 5000. Starting from next cycle new settings gets reflected with duty_cycle =
>>>> 4000 and period = 10000.
>>>
>>> Is the reference manual for this hardware publically available?
>>
>> AM335x TRM [0] Section 20.1.3.5 Pulse-Width Modulation (Page 4445).
>>
>> [0] http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf
> 
> Great. This is BTW an opportunity to increase your patch count: Create a
> patch that adds a reference to this document at the top of the driver.
> 
>>> So the .set_load callback just writes a shadow register and .set_match
>>> latches it into hardware atomically with its own register changes? A
>>> comment in the source code about this would be good. Also if .set_load
>>> doesn't work without .set_match I wonder if it is sane to put their
>>> logic in two different functions.
>>
>> Just to give a little bit of background:
> 
> Thanks, very appreciated.
> 
>> - The omap timer is an upward counter that can be started and stopped at any time.
>> - Once the timer counter overflows, it gets loaded with a predefined load
>> value.(Or can be configured to not re load at all).
>> - Timer has a configurable output pin which can be toggled in the following two
>> cases:
>> 	- When the counter overflows
>> 	- When the counter matches with a predefined register(match register).
>>
>> Using this o/p pin the driver tries to generate a PWM with period = (OVERFLOW -
>> LOAD_VALUE) and duty_cycle = (MATCH_VALUE - LOAD_VALUE).
>>
>> .set_load will configure the load value .set_match will configure the match
>> value. The configured values gets effected only in the next cycle of PWM.
> 
> Ah, so back to my original question: If you change from
> duty_cycle/period = 1000/5000 to duty_cycle/period = 4000/10000 and
> after you set the period but before you set the duty_cycle a period
> happens to end, you get indeed a cycle with mixed settings, right?

hmm..you are right but the mixed period happens in a bit different case. Let me
explain in bit more detail.

For omap dm timer, the load_value that gets set in the current period, will be
reflected only in next cycle, as timer counter has to overflow to load this
value. But in case of match register(which determines the duty cycle), the timer
counter is continuously matched to it. So below are the cases where a mixed
period can happen:
1) When signal is high and new match value is > current timer counter. Then the
duty cycle gets reflected in the current cycle.(Duty_cycle for current period=
new match value -  previous load  value).
2) When signal is high and new match value is < current timer counter. Then the
period and duty cycle for the current cycle gets effected as well. Because the
signal is pulled down only when counter matches with match register, and this
happens only in the next cycle(after timer counter overflows). Then:
	- new Period for current cycle = (current period + new period)
	- new duty cycle for current cycle =  (current period + new duty_cycle).

I am able to observe the above mentioned 2 behaviors on the scope using beagle
bone black. So the problem is with updating duty cycle when the signal is high.
but when signal is low, nothing gets effected to the current cycle.

How do you want to go about this? Should we describe this as limitation in the
driver as you asked?

Thanks and regards,
Lokesh
