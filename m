Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3DF21789B8
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Mar 2020 05:45:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgCDEpW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Mar 2020 23:45:22 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42862 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgCDEpV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Mar 2020 23:45:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0244ivrG024092;
        Tue, 3 Mar 2020 22:44:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583297097;
        bh=SGsbks8+4AvLnHdN2mgK11maD+F3vSBL3viu3KdMGVc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TbF3sFLvoS24d/BcSM3VztS5d/ph+Fk8hBXT3+e9C8seVl387vO23cI1eWEC9ntUM
         qesc8tJYLnZqY6UhaNGR+ANPIxlSEbh9swa/Ik8jJKu3dNPZx8Gd2ucMBngewORRl4
         zUhgoh1o5CJy2gsG5q+ydJsOpcN/cYK98rYbWyXA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0244ivcq118799;
        Tue, 3 Mar 2020 22:44:57 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 22:44:56 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 22:44:56 -0600
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 0244iq4A053386;
        Tue, 3 Mar 2020 22:44:53 -0600
Subject: Re: [PATCH v2 2/5] clocksource: timer-ti-dm: Implement cpu_pm
 notifier for context save and restore
To:     Tony Lindgren <tony@atomide.com>
CC:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        <linux-pwm@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Keerthy <j-keerthy@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
 <20200228095346.32177-3-lokeshvutla@ti.com>
 <20200303163259.GU37466@atomide.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <dfe74d0a-a092-474c-5c66-402ab0724a8f@ti.com>
Date:   Wed, 4 Mar 2020 10:14:00 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200303163259.GU37466@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Tony,

On 03/03/20 10:02 PM, Tony Lindgren wrote:
> Hi,
> 
> * Lokesh Vutla <lokeshvutla@ti.com> [200228 09:55]:
>> omap_dm_timer_enable() restores the entire context(including counter)
>> based on 2 conditions:
>> - If get_context_loss_count is populated and context is lost.
>> - If get_context_loss_count is not populated update unconditionally.
>>
>> Case2 has a side effect of updating the counter register even though
>> context is not lost. When timer is configured in pwm mode, this is
>> causing undesired behaviour in the pwm period.
>>
>> Instead of using get_context_loss_count call back, implement cpu_pm
>> notifier with context save and restore support. And delete the
>> get_context_loss_count callback all together.
> 
> Thanks for getting this going.
> 
> I noticed system timers are not working properly now though. Not

Can you provide me details on how you are testing and on which SoC?

> sure what might cause that, but I spotted few issues below.
> 
>> --- a/drivers/clocksource/timer-ti-dm.c
>> +++ b/drivers/clocksource/timer-ti-dm.c
> ...
>> +static void omap_timer_save_context(struct omap_dm_timer *timer)
>> +{
>> +	pm_runtime_get_sync(&timer->pdev->dev);
>> +	timer->context.tclr =
>> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
>> +	timer->context.twer =
>> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
>> +	timer->context.tldr =
>> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
>> +	timer->context.tmar =
>> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
>> +	timer->context.tier = readl_relaxed(timer->irq_ena);
>> +	timer->context.tsicr =
>> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
>> +	pm_runtime_put_sync(&timer->pdev->dev);
>> +}
> 
> We must not use pm_runtime functions here, these notifiers run
> at a point when runtime PM is out of the picture already. And
> we really don't want to tag any modules with pm_runtime_irq_safe()
> as it takes a permanent use count on the parent device.
> 
> Instead, just add atomic_t awake that runtime_resume sets at the end,
> and runtime_suspend clears first thing. Then you can check for awake
> here, and there's nothing to do here if !awake.

But context should be saved when awake is enabled. In this case how to make sure
the registers are accessible? Driver heavily uses pm_runtime calls for most
register access. When timer is running the register are made accessible but I am
worried about the case when timer is not running and trying to save context.

Also in CLUSTER_PM_EXIT case,  how to guarantee that registers are accessible?

> 
> And then runtime_suspend should save the context too and
> runtime_resume restore it :)
> 
>> @@ -827,6 +830,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
>>  	list_for_each_entry(timer, &omap_timer_list, node)
>>  		if (!strcmp(dev_name(&timer->pdev->dev),
>>  			    dev_name(&pdev->dev))) {
>> +			if (!(timer->capability & OMAP_TIMER_ALWON))
>> +				cpu_pm_unregister_notifier(&timer->nb);
>>  			list_del(&timer->node);
>>  			ret = 0;
>>  			break;
> 
> For the OMAP_TIMER_ALWON checks, I believe am335x and am437x have
> OMAP_TIMER_ALWON set for timers but will still have context lost
> in deeper idle states as only the PMIC is enabled.
> 
> For those cases, at least runtime_suspend and resume functions
> need to save and restore context based on setting some flag
> maybe based on of_machine_is_compatible() or soc_device_match().

hmm..then it is better to not mark as alwon in case of am335x and am43xx no? I
don't see the flag being used for anything else other that context save and restore.

Thanks and regards,
Lokesh

> 
> I guess with recent cpuidle patches, this needs to be also done
> during runtime for am335x and am437x. Maybe Dave or Keerthy have
> more comments on that part?
> 
> Regards,
> 
> Tony
> 
