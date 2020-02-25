Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2114016B8B0
	for <lists+linux-pwm@lfdr.de>; Tue, 25 Feb 2020 06:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbgBYFDj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 Feb 2020 00:03:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:56000 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgBYFDj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 Feb 2020 00:03:39 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P53Xb1006980;
        Mon, 24 Feb 2020 23:03:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582607013;
        bh=/f7DAwA/f56+FzLG8cQWhF1XqRY14tSIYmz3+7Jyu3E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=AkKo38l9/PaMnYNHCpTWmyVuCPfkprc2Wlws0tBPCRKhCwanvuZ0lO+RGFnQ5THPG
         tsOXAhpOia9gtOo/jKflLifan3IdYOrRz/zwDIpYhoPcZ56sSCOCexRymeAav41HTU
         0ehX0r6r+FQbvacq34fJRsO9vu1dp6H5jdNwggV0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P53XoZ076573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Feb 2020 23:03:33 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 24
 Feb 2020 23:03:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 24 Feb 2020 23:03:33 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P53UOr017362;
        Mon, 24 Feb 2020 23:03:31 -0600
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
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <4aedb6d4-1823-ab46-b7e6-cc0b30f7747d@ti.com>
Date:   Tue, 25 Feb 2020 10:32:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200224085531.zab5ewr2nfi2shem@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 24/02/20 2:25 PM, Uwe Kleine-König wrote:
> Hello,
> 
> On Mon, Feb 24, 2020 at 10:51:34AM +0530, Lokesh Vutla wrote:
>> Only the Timer control register(TCLR) can be updated only when the timer
>> is stopped. Registers like Counter register(TCRR), loader register(TLDR),
>> match register(TMAR) can be updated when the counter is running. Since
>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>> timer for period/duty_cycle update.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index f13be7216847..58c61559e72f 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -102,7 +102,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>  	u32 load_value, match_value;
>>  	struct clk *fclk;
>>  	unsigned long clk_rate;
>> -	bool timer_active;
>>  
>>  	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
>>  		duty_ns, period_ns);
>> @@ -178,25 +177,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
>>  	load_value = (DM_TIMER_MAX - period_cycles) + 1;
>>  	match_value = load_value + duty_cycles - 1;
>>  
>> -	/*
>> -	 * We MUST stop the associated dual-mode timer before attempting to
>> -	 * write its registers, but calls to omap_dm_timer_start/stop must
>> -	 * be balanced so check if timer is active before calling timer_stop.
>> -	 */
>> -	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
>> -	if (timer_active)
>> -		omap->pdata->stop(omap->dm_timer);
>> -
>>  	omap->pdata->set_load(omap->dm_timer, true, load_value);
>>  	omap->pdata->set_match(omap->dm_timer, true, match_value);
> 
> (Without having looked into the depths of the driver I assume
> .set_load() sets the period of the PWM and .set_match() the duty cycle.)

Right.

> 
> What happens on a running PWM if you change the period? Consider you
> change from duty_cycle = 1000, period = 5000 to duty_cycle = 4000,
> period = 10000. As you set the period first, can it happen the hardware
> produces a cycle with duty_cycle = 1000, period = 10000?

No. So, the current cycle is un affected with duty_cycle = 1000 and period =
5000. Starting from next cycle new settings gets reflected with duty_cycle =
4000 and period = 10000.

Thanks and regards,
Lokesh
