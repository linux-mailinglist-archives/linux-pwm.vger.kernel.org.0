Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8407182A74
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 09:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgCLIG3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 04:06:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53744 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725268AbgCLIG3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 04:06:29 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C86KXG105763;
        Thu, 12 Mar 2020 03:06:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584000380;
        bh=J5M0FMAC5tNLJClXhjgw9z/u+wvqtVNBtEKQ1U48aok=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tqC4zg2twBtiPRZcL3GzBPAe1SxMSTj4g9Eei8p7WIXr76mpGiHued15tqXOf6EIS
         bXgzI7O2R7W/CAIS0bhiKN3Ff/Ac1OZLp4qJUYL1Fo3BtX+x6ckeRhtk+N9vzQYxD3
         gK+yGHtCfHuE88LeAP8GjrVdT5Xeyvr94AlMgcqc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C86Kb9104433
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Mar 2020 03:06:20 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 12
 Mar 2020 03:06:20 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 12 Mar 2020 03:06:20 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02C86Hlc020278;
        Thu, 12 Mar 2020 03:06:18 -0500
Subject: Re: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before
 changing period/duty_cycle
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
 <20200312042210.17344-5-lokeshvutla@ti.com>
 <20200312064042.p7himm3odxjyzroi@pengutronix.de>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <f250549f-1e7c-06d6-b2a4-7ae01c06725b@ti.com>
Date:   Thu, 12 Mar 2020 13:35:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200312064042.p7himm3odxjyzroi@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Uwe,

On 12/03/20 12:10 PM, Uwe Kleine-König wrote:
> On Thu, Mar 12, 2020 at 09:52:09AM +0530, Lokesh Vutla wrote:
>> Only the Timer control register(TCLR) cannot be updated when the timer
>> is running. Registers like Counter register(TCRR), loader register(TLDR),
>> match register(TMAR) can be updated when the counter is running. Since
>> TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
>> timer for period/duty_cycle update.
> 
> I'm not sure what is sensible here. Stopping the PWM for a short period
> is bad, but maybe emitting a wrong period isn't better. You can however
> optimise it if only one of period or duty_cycle changes.
> 
> @Thierry, what is your position here? I tend to say a short stop is
> preferable.

Short stop has side effects especially in the case where 1PPS is generated using
this PWM. In this case where PWM period is continuously synced with PTP clock,
cannot expect any breaks in PWM. This doesn't fall in the above limitations as
well. as duty_cycle is not a worry and only the rising edge is all that matters.

Also any specific reason why you wanted to stop rather than having the mentioned
limitation? it is just a corner anyway and doesn't happen all the time.

Thanks and regards,
Lokesh

> 
>> Tested-by: Tony Lindgren <tony@atomide.com>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  drivers/pwm/pwm-omap-dmtimer.c | 21 +++++++--------------
>>  1 file changed, 7 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
>> index 85b17b49980b..c56e7256e923 100644
>> --- a/drivers/pwm/pwm-omap-dmtimer.c
>> +++ b/drivers/pwm/pwm-omap-dmtimer.c
>> @@ -19,6 +19,13 @@
>>   * Limitations:
>>   * - When PWM is stopped, timer counter gets stopped immediately. This
>>   *   doesn't allow the current PWM period to complete and stops abruptly.
>> + * - When PWM is running and changing both duty cycle and period,
>> + *   we cannot prevent in software that the output might produce
>> + *   a period with mixed settings. Especially when period/duty_cyle
>> + *   is updated while the pwm pin is high, current pwm period/duty_cycle
>> + *   can get updated as below based on the current timer counter:
>> + *   	- period for current cycle =  current_period + new period
>> + *   	- duty_cycle for current period = current period + new duty_cycle.
> 
> In case we stay with a short stop, adding something like:
> 
>  - The PWM has to be stopped for updates of both period and duty_cycle.
> 
> Best regards
> Uwe
> 
