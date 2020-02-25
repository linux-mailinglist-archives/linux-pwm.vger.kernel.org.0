Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E9216BB6B
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 09:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729124AbgBYIA7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 03:00:59 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46786 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729001AbgBYIA7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 03:00:59 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P80o69051240;
        Tue, 25 Feb 2020 02:00:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582617650;
        bh=4O0ikGYh4/tavxMZ/AO6uLr8sOwU8CxwwTO2EYFCJtI=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bqhRVH0Hb82uxMkVAxykwDpPwqiTZHpHOK2ljBWur/HAxwhlKoHjkP8Z6+6uy5csU
         XjpLP4iLnMyM8ylLn6pE2aIbhios4Wh+btQA7LgcUEHAirRxQA2jTizJGXSItGCFd2
         uWypX4Z7CmVGbCIq6Srx8zAivwDJ+kaZPVRKJcrk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P80ojB064802
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 02:00:50 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 02:00:49 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 02:00:49 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01P80kX3095890;
        Tue, 25 Feb 2020 02:00:47 -0600
Subject: Re: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before changing
 period/duty_cycle
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
 <20200224052135.17278-4-lokeshvutla@ti.com>
 <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
 <4aedb6d4-1823-ab46-b7e6-cc0b30f7747d@ti.com>
 <20200225064833.kmvaplfqqf53s3iy@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <8e22912c-a65f-9efe-27e7-555cd144776f@ti.com>
Date:   Tue, 25 Feb 2020 13:29:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200225064833.kmvaplfqqf53s3iy@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 25/02/20 12:18 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Feb 25, 2020 at 10:32:42AM +0530, Lokesh Vutla wrote:
>> On 24/02/20 2:25 PM, Uwe Kleine-König wrote:
>>> Hello,
>>>
>>> On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
>>>> Only the Timer control register(TCLR) can be updated only when the timer
>>>> is stopped. Registers like Counter register(TCRR), loader register(TLDR),
>>>> match register(TMAR) can be updated when the counter is running. Since
>>>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>>>> timer for period/duty_cycle update.
>>>>
>>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>>> ---
>>>>  drivers/pwm/pwm-omap-dmtimer.c | 14 --------------
>>>>  1 file changed, 14 deletions(-)
>>>>
>>>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>>>> index f13be7216847..58c61559e72f 100644
>>>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>>>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>>>> @@ -102,7 +102,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>>>  	u32 load_value, match_value;
>>>>  	struct clk *fclk;
>>>>  	unsigned long clk_rate;
>>>> -	bool timer_active;
>>>>  
>>>>  	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
>>>>  		duty_ns, period_ns);
>>>> @@ -178,25 +177,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>>>  	load_value = (DM_TIMER_MAX - period_cycles) + 1;
>>>>  	match_value = load_value + duty_cycles - 1;
>>>>  
>>>> -	/*
>>>> -	 * We MUST stop the associated dual-mode timer before attempting to
>>>> -	 * write its registers, but calls to omap_dm_timer_start/stop must
>>>> -	 * be balanced so check if timer is active before calling timer_stop.
>>>> -	 */
>>>> -	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
>>>> -	if (timer_active)
>>>> -		omap->pdata->stop(omap->dm_timer);
>>>> -
>>>>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
>>>>  	omap->pdata->set_match(omap->dm_timer, true, match_value);
>>>
>>> (Without having looked into the depths of the driver I assume
>>> .set_load() sets the period of the PWM and .set_match() the duty cycle.)
>>
>> Right.
>>
>>>
>>> What happens on a running PWM if you change the period? Consider you
>>> change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
>>> period = 10000. As you set the period first, can it happen the hardware
>>> produces a cycle with duty_cycle = 1000, period = 10000?
>>
>> No. So, the current cycle is un affected with duty_cycle = 1000 and period =
>> 5000. Starting from next cycle new settings gets reflected with duty_cycle =
>> 4000 and period = 10000.
> 
> Is the reference manual for this hardware publically available?

AM335x TRM [0] Section 20.1.3.5 Pulse-Width Modulation (Page 4445).

[0] http://www.ti.com/lit/ug/spruh73q/spruh73q.pdf

> 
> So the .set_load callback just writes a shadow register and .set_match
> latches it into hardware atomically with its own register changes? A
> comment in the source code about this would be good. Also if .set_load
> doesn't work without .set_match I wonder if it is sane to put their
> logic in two different functions.

Just to give a little bit of background:
- The omap timer is an upward counter that can be started and stopped at any time.
- Once the timer counter overflows, it gets loaded with a predefined load
value.(Or can be configured to not re load at all).
- Timer has a configurable output pin which can be toggled in the following two
cases:
	- When the counter overflows
	- When the counter matches with a predefined register(match register).

Using this o/p pin the driver tries to generate a PWM with period = (OVERFLOW -
LOAD_VALUE) and duty_cycle = (MATCH_VALUE - LOAD_VALUE).

.set_load will configure the load value .set_match will configure the match
value. The configured values gets effected only in the next cycle of PWM.

I hope this is clear. Let me know if you need more details.

Thanks and regards,
Lokesh
