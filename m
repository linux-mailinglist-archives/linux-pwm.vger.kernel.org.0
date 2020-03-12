Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1F44182E16
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 11:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgCLKpc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 06:45:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:46766 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLKpc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 06:45:32 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02CAjNee065463;
        Thu, 12 Mar 2020 05:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584009923;
        bh=KD36+jDsPV+sll5Mg8prcB177U8BNxBxUQWZLYSafHM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=cRhj9sRnb/wglP9uwXWbBQ/rcA1CeNDcHfyICtFboyzkWasnZlNE1ON46uDl9r7t0
         MoMGDwzPiJc4zaeYld0hnAvuSc4r0b9MBKdYKsyt23pIpB29PiUrcT/f7BF/hhkwex
         CzuuOp99gej9niGzqHuXfBmiJ4ez4SVVJJnw2r7Q=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02CAjNUi076794
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Mar 2020 05:45:23 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 05:45:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 05:45:23 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02CAjKuZ044598;
        Thu, 12 Mar 2020 05:45:20 -0500
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        <kernel@pengutronix.de>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
 <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
 <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <2a5a06cd-7aca-c450-b048-33329d058eca@ti.com>
Date:   Thu, 12 Mar 2020 16:14:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200312084739.isixgdo3txr6rjzg@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 12/03/20 2:17 PM, Uwe Kleine-König wrote:
> On Thu, Mar 12, 2020 at 01:35:32PM +0530, Lokesh Vutla wrote:
>> On 12/03/20 12:10 PM, Uwe Kleine-König wrote:
>>> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
>>>> Only the Timer control register(TCLR) cannot be updated when the timer
>>>> is running. Registers like Counter register(TCRR), loader register(TLDR),
>>>> match register(TMAR) can be updated when the counter is running. Since
>>>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>>>> timer for period/duty_cycle update.
>>>
>>> I'm not sure what is sensible here. Stopping the PWM for a short period
>>> is bad, but maybe emitting a wrong period isn't better. You can however
>>> optimise it if only one of period or duty_cycle changes.
>>>
>>> @Thierry, what is your position here? I tend to say a short stop is
>>> preferable.
>>
>> Short stop has side effects especially in the case where 1PPS is generated using
>> this PWM. In this case where PWM period is continuously synced with PTP clock,
>> cannot expect any breaks in PWM. This doesn't fall in the above limitations as
>> well. as duty_cycle is not a worry and only the rising edge is all that matters.
>>
>> Also any specific reason why you wanted to stop rather than having the mentioned
>> limitation? it is just a corner anyway and doesn't happen all the time.
> 
> I'm a bit torn here. Which of the two steps out of line is worse depends
> on what is driven by the PWM in question. And also I think ignoring
> "just corner cases" is a reliable way into trouble.

I do agree that corner cases should not be ignored. But in this particular
driver, just trying to explain the effect of this corner case. On dynamic pwm
period update, the current pwm cycle might generate a period with mixed
settings. IMHO, it is okay to live with it and mark it as a limitation as you
pointed out in case of sifive driver[0].


> 
> The usual PWM contributer (understandably) cares mostly about their own
> problem they have to solve. If however you take a step back and care
> about the PWM framework as a whole to be capable to solve problems in
> general, such that any consumer just has to know that there is a PWM and
> start requesting specific settings for their work to get done, it gets
> obvious that you want some kind of uniform behaviour of each hardware
> driver. And then a short inactive break between two periods is more
> common and better understandable than a mixed period.

But the problem here is that inactive breaks between two periods is not desired.
Because the pwm is used to generate a 1PPS signal and is continuously
synchronized with PTP clock.

I am up if this can be solved generically. But updating period is very specific
to hardware implementation. Not sure what generic solution can be brought out of
this. Please correct me if I am wrong.

[0]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pwm/pwm-sifive.c#n7

Thanks and regards,
Lokesh
