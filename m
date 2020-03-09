Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3590417D8A9
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 05:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCIExG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 00:53:06 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:48268 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgCIExG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 00:53:06 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0294qvxj077105;
        Sun, 8 Mar 2020 23:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583729577;
        bh=19GEtNMqbK7WwV7Ny6Ssf+Ax9DfoQ90Ggv3gqxaS+eE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=GRlmZKSZUc1pqJDE/KxnuKjd4pauy6qi9sKNfWMMlnbkezgXoNDPgtgIBRW8VK8aP
         cac3T7/UrjaFl14g3A8+cOl/ok9R2UP7N/0hT1306T+47bCkV1wlmFufj0uqcXCZtX
         aRBk9wYjFV2HtTYyrsHiaUcov5As9RT5SsBDnW1E=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0294qvNG108367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 8 Mar 2020 23:52:57 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 8 Mar
 2020 23:52:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 8 Mar 2020 23:52:57 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0294qsnq052533;
        Sun, 8 Mar 2020 23:52:54 -0500
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
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <9129d4fe-a17e-2fa6-764c-6a746fa5096d@ti.com>
Date:   Mon, 9 Mar 2020 10:21:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200306181443.GJ37466@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Tony,

On 06/03/20 11:44 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [200228 09:58]:
>> pwm_omap_dmtimer_disable() calls .stop callback which abruptly stops the
>> timer counter. This doesn't complete the current pwm cycle and
>> immediately disables the pwm. Instead disable the auto reload
>> functionality which allows to complete the current pwm cycle and then
>> disables the timer.
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index bc338619232d..89b3c25d02b8 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -93,8 +93,16 @@ static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
>>  {
>>  	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
>>  
>> +	/*
>> +	 * Disable auto reload so that the current cycle gets completed and
>> +	 * then the counter stops.
>> +	 */
>>  	mutex_lock(&omap->mutex);
>> -	omap->pdata->stop(omap->dm_timer);
>> +	omap->pdata->set_pwm(omap->dm_timer,
>> +			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
>> +			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
>> +			     false);
>> +
>>  	mutex_unlock(&omap->mutex);
>>  }
> 
> I'm seeing an issue with this patch where after use something is
> left on and power consumption stays higher by about 30 mW after
> use.

Interesting...What is the PWM period and duty cycle in the test case?
Can you dump the following registers before and after disabling:
- TLDR
- TMAR
- TCLR

> 
> I can reproduce this easily on droid4 with Sebastian's rumble-test
> app[0]. After use, I sometimes also hear the vibrator keep chirping
> quietly, so there seems to be some pwm still happening after disable :)

hmm..The line clearly goes down on the scope after the current pwm duty cycle is
done and never comes back.

> 
> Reloading modules for pwm-vibra and pwm-omap-dmtimer make the power
> consumption go back down again.
> 
> If you have a scope set up, maybe check the lines are quiet after
> disable after this patch?
> 
> Regards,
> 
> Tony
> 
> 
> [0] https://git.collabora.com/cgit/user/sre/rumble-test.git/plain/rumble-test.c

This is redirecting to collabora.com. Is this code available in github or some
public repo?

Thanks and regards,
Lokesh
