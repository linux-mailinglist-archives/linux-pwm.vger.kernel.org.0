Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B59177BF7
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Mar 2020 17:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgCCQdE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Mar 2020 11:33:04 -0500
Received: from muru.com ([72.249.23.125]:58612 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgCCQdE (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 3 Mar 2020 11:33:04 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 86D4180EE;
        Tue,  3 Mar 2020 16:33:47 +0000 (UTC)
Date:   Tue, 3 Mar 2020 08:32:59 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Keerthy <j-keerthy@ti.com>, Dave Gerlach <d-gerlach@ti.com>
Subject: Re: [PATCH v2 2/5] clocksource: timer-ti-dm: Implement cpu_pm
 notifier for context save and restore
Message-ID: <20200303163259.GU37466@atomide.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
 <20200228095346.32177-3-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095346.32177-3-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

* Lokesh Vutla <lokeshvutla@ti.com> [200228 09:55]:
> omap_dm_timer_enable() restores the entire context(including counter)
> based on 2 conditions:
> - If get_context_loss_count is populated and context is lost.
> - If get_context_loss_count is not populated update unconditionally.
> 
> Case2 has a side effect of updating the counter register even though
> context is not lost. When timer is configured in pwm mode, this is
> causing undesired behaviour in the pwm period.
> 
> Instead of using get_context_loss_count call back, implement cpu_pm
> notifier with context save and restore support. And delete the
> get_context_loss_count callback all together.

Thanks for getting this going.

I noticed system timers are not working properly now though. Not
sure what might cause that, but I spotted few issues below.

> --- a/drivers/clocksource/timer-ti-dm.c
> +++ b/drivers/clocksource/timer-ti-dm.c
...
> +static void omap_timer_save_context(struct omap_dm_timer *timer)
> +{
> +	pm_runtime_get_sync(&timer->pdev->dev);
> +	timer->context.tclr =
> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
> +	timer->context.twer =
> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
> +	timer->context.tldr =
> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
> +	timer->context.tmar =
> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
> +	timer->context.tier = readl_relaxed(timer->irq_ena);
> +	timer->context.tsicr =
> +			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
> +	pm_runtime_put_sync(&timer->pdev->dev);
> +}

We must not use pm_runtime functions here, these notifiers run
at a point when runtime PM is out of the picture already. And
we really don't want to tag any modules with pm_runtime_irq_safe()
as it takes a permanent use count on the parent device.

Instead, just add atomic_t awake that runtime_resume sets at the end,
and runtime_suspend clears first thing. Then you can check for awake
here, and there's nothing to do here if !awake.

And then runtime_suspend should save the context too and
runtime_resume restore it :)

> @@ -827,6 +830,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
>  	list_for_each_entry(timer, &omap_timer_list, node)
>  		if (!strcmp(dev_name(&timer->pdev->dev),
>  			    dev_name(&pdev->dev))) {
> +			if (!(timer->capability & OMAP_TIMER_ALWON))
> +				cpu_pm_unregister_notifier(&timer->nb);
>  			list_del(&timer->node);
>  			ret = 0;
>  			break;

For the OMAP_TIMER_ALWON checks, I believe am335x and am437x have
OMAP_TIMER_ALWON set for timers but will still have context lost
in deeper idle states as only the PMIC is enabled.

For those cases, at least runtime_suspend and resume functions
need to save and restore context based on setting some flag
maybe based on of_machine_is_compatible() or soc_device_match().

I guess with recent cpuidle patches, this needs to be also done
during runtime for am335x and am437x. Maybe Dave or Keerthy have
more comments on that part?

Regards,

Tony
