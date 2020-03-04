Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4E11797AC
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Mar 2020 19:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDSRk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Mar 2020 13:17:40 -0500
Received: from muru.com ([72.249.23.125]:58832 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgCDSRj (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Mar 2020 13:17:39 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D15978185;
        Wed,  4 Mar 2020 18:18:22 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:17:34 -0800
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
Message-ID: <20200304181734.GZ37466@atomide.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
 <20200228095346.32177-3-lokeshvutla@ti.com>
 <20200303163259.GU37466@atomide.com>
 <dfe74d0a-a092-474c-5c66-402ab0724a8f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe74d0a-a092-474c-5c66-402ab0724a8f@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

* Lokesh Vutla <lokeshvutla@ti.com> [200304 04:45]:
> Hi Tony,
> 
> On 03/03/20 10:02 PM, Tony Lindgren wrote:
> > Hi,
> > 
> > * Lokesh Vutla <lokeshvutla@ti.com> [200228 09:55]:
> >> omap_dm_timer_enable() restores the entire context(including counter)
> >> based on 2 conditions:
> >> - If get_context_loss_count is populated and context is lost.
> >> - If get_context_loss_count is not populated update unconditionally.
> >>
> >> Case2 has a side effect of updating the counter register even though
> >> context is not lost. When timer is configured in pwm mode, this is
> >> causing undesired behaviour in the pwm period.
> >>
> >> Instead of using get_context_loss_count call back, implement cpu_pm
> >> notifier with context save and restore support. And delete the
> >> get_context_loss_count callback all together.
> > 
> > Thanks for getting this going.
> > 
> > I noticed system timers are not working properly now though. Not
> 
> Can you provide me details on how you are testing and on which SoC?

Hmm I guess with any SoC with gp timer as a clockevent as long as the
system is idle enough for interrupts. I was seeing this at least on
omap4, it may not show up with NFSroot because interrupts.

> But context should be saved when awake is enabled. In this case how to make sure
> the registers are accessible? Driver heavily uses pm_runtime calls for most
> register access. When timer is running the register are made accessible but I am
> worried about the case when timer is not running and trying to save context.
> 
> Also in CLUSTER_PM_EXIT case,  how to guarantee that registers are accessible?

Well below is a version of your patch updated along the lines I described
above. That's on top of the preparatory 1.5/2 patch I just sent for
"clocksource: timer-ti-dm: Prepare for using cpuidle".

It now seems to work for me bsed on quick testing. I have also not
tested yet with the rest of the series. And we still need to run timer
tests on some idle SoC.

> > For the OMAP_TIMER_ALWON checks, I believe am335x and am437x have
> > OMAP_TIMER_ALWON set for timers but will still have context lost
> > in deeper idle states as only the PMIC is enabled.
> > 
> > For those cases, at least runtime_suspend and resume functions
> > need to save and restore context based on setting some flag
> > maybe based on of_machine_is_compatible() or soc_device_match().
> 
> hmm..then it is better to not mark as alwon in case of am335x and am43xx no? I
> don't see the flag being used for anything else other that context save and restore.

Yeah or change the flag during runtime. But let's assume we have
the flag properly set for this series.

Regards,

Tony

8< ------------------------
From tony Mon Sep 17 00:00:00 2001
From: Lokesh Vutla <lokeshvutla@ti.com>
Date: Fri, 28 Feb 2020 15:23:43 +0530
Subject: [PATCH] clocksource: timer-ti-dm: Implement cpu_pm notifier for
 context save and restore

omap_dm_timer_enable() restores the entire context(including counter)
based on 2 conditions:
- If get_context_loss_count is populated and context is lost.
- If get_context_loss_count is not populated update unconditionally.

Case2 has a side effect of updating the counter register even though
context is not lost. When timer is configured in pwm mode, this is
causing undesired behaviour in the pwm period.

Instead of using get_context_loss_count call back, implement cpu_pm
notifier with context save and restore support. And delete the
get_context_loss_count callback all together.

Suggested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
[tony@atomide.com: removed pm_runtime calls from cpuidle calls]
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 99 ++++++++++++++++++-------------
 include/clocksource/timer-ti-dm.h |  3 +-
 2 files changed, 60 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -20,6 +20,7 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/device.h>
@@ -92,6 +93,47 @@ static void omap_timer_restore_context(struct omap_dm_timer *timer)
 				timer->context.tclr);
 }
 
+static void omap_timer_save_context(struct omap_dm_timer *timer)
+{
+	timer->context.tclr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
+	timer->context.twer =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG);
+	timer->context.tldr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_LOAD_REG);
+	timer->context.tmar =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_MATCH_REG);
+	timer->context.tier = readl_relaxed(timer->irq_ena);
+	timer->context.tsicr =
+			omap_dm_timer_read_reg(timer, OMAP_TIMER_IF_CTRL_REG);
+}
+
+static int omap_timer_context_notifier(struct notifier_block *nb,
+				       unsigned long cmd, void *v)
+{
+	struct omap_dm_timer *timer;
+
+	timer = container_of(nb, struct omap_dm_timer, nb);
+
+	switch (cmd) {
+	case CPU_CLUSTER_PM_ENTER:
+		if ((timer->capability & OMAP_TIMER_ALWON) ||
+		    !atomic_read(&timer->enabled))
+			break;
+		omap_timer_save_context(timer);
+		break;
+	case CPU_CLUSTER_PM_ENTER_FAILED:
+	case CPU_CLUSTER_PM_EXIT:
+		if ((timer->capability & OMAP_TIMER_ALWON) ||
+		    !atomic_read(&timer->enabled))
+			break;
+		omap_timer_restore_context(timer);
+		break;
+	}
+
+	return NOTIFY_OK;
+}
+
 static int omap_dm_timer_reset(struct omap_dm_timer *timer)
 {
 	u32 l, timeout = 100000;
@@ -208,21 +250,7 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
 static void omap_dm_timer_enable(struct omap_dm_timer *timer)
 {
-	int c;
-
 	pm_runtime_get_sync(&timer->pdev->dev);
-
-	if (!(timer->capability & OMAP_TIMER_ALWON)) {
-		if (timer->get_context_loss_count) {
-			c = timer->get_context_loss_count(&timer->pdev->dev);
-			if (c != timer->ctx_loss_count) {
-				omap_timer_restore_context(timer);
-				timer->ctx_loss_count = c;
-			}
-		} else {
-			omap_timer_restore_context(timer);
-		}
-	}
 }
 
 static void omap_dm_timer_disable(struct omap_dm_timer *timer)
@@ -515,8 +543,6 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 
-	/* Save the context */
-	timer->context.tclr = l;
 	return 0;
 }
 
@@ -532,13 +558,6 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
 	__omap_dm_timer_stop(timer, timer->posted, rate);
 
-	/*
-	 * Since the register values are computed and written within
-	 * __omap_dm_timer_stop, we need to use read to retrieve the
-	 * context.
-	 */
-	timer->context.tclr =
-			omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -561,9 +580,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -585,9 +601,6 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tmar = match;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -611,8 +624,6 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -634,8 +645,6 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -649,9 +658,6 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	omap_dm_timer_enable(timer);
 	__omap_dm_timer_int_enable(timer, value);
 
-	/* Save the context */
-	timer->context.tier = value;
-	timer->context.twer = value;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -679,9 +685,6 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
-	/* Save the context */
-	timer->context.tier &= ~mask;
-	timer->context.twer &= ~mask;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -756,6 +759,12 @@ static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 
 	atomic_set(&timer->enabled, 0);
 
+	if (timer->capability & OMAP_TIMER_ALWON ||
+	    !timer->func_base)
+	    return 0;
+
+	omap_timer_save_context(timer);
+
 	return 0;
 }
 
@@ -763,6 +772,10 @@ static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
 {
 	struct omap_dm_timer *timer = dev_get_drvdata(dev);
 
+	if (!(timer->capability & OMAP_TIMER_ALWON) &&
+	    timer->func_base)
+		omap_timer_restore_context(timer);
+
 	atomic_set(&timer->enabled, 1);
 
 	return 0;
@@ -838,7 +851,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 		timer->id = pdev->id;
 		timer->capability = pdata->timer_capability;
 		timer->reserved = omap_dm_timer_reserved_systimer(timer->id);
-		timer->get_context_loss_count = pdata->get_context_loss_count;
+	}
+
+	if (!(timer->capability & OMAP_TIMER_ALWON)) {
+		timer->nb.notifier_call = omap_timer_context_notifier;
+		cpu_pm_register_notifier(&timer->nb);
 	}
 
 	if (pdata)
@@ -893,6 +910,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (!strcmp(dev_name(&timer->pdev->dev),
 			    dev_name(&pdev->dev))) {
+			if (!(timer->capability & OMAP_TIMER_ALWON))
+				cpu_pm_unregister_notifier(&timer->nb);
 			list_del(&timer->node);
 			ret = 0;
 			break;
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -110,13 +110,12 @@ struct omap_dm_timer {
 	unsigned reserved:1;
 	unsigned posted:1;
 	struct timer_regs context;
-	int (*get_context_loss_count)(struct device *);
-	int ctx_loss_count;
 	int revision;
 	u32 capability;
 	u32 errata;
 	struct platform_device *pdev;
 	struct list_head node;
+	struct notifier_block nb;
 };
 
 int omap_dm_timer_reserve_systimer(int id);
-- 
2.25.1
