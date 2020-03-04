Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFC60179794
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Mar 2020 19:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgCDSKU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Mar 2020 13:10:20 -0500
Received: from muru.com ([72.249.23.125]:58812 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgCDSKU (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Mar 2020 13:10:20 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 471448185;
        Wed,  4 Mar 2020 18:11:03 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:10:14 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCH v2 1.5/5] clocksource: timer-ti-dm: Prepare for using cpuidle
Message-ID: <20200304181014.GY37466@atomide.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
 <20200228095346.32177-2-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228095346.32177-2-lokeshvutla@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Let's add runtime_suspend and resume functions and atomic enabled
flag. This way we can use these when converting to use cpuidle
for saving and restoring device context.

And we need to maintain the driver state in the driver as documented
in "9. Autosuspend, or automatically-delayed suspends" in the
Documentation/power/runtime_pm.rst document related to using driver
private lock and races with runtime_suspend().

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clocksource/timer-ti-dm.c | 36 ++++++++++++++++++++++++++-----
 include/clocksource/timer-ti-dm.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -491,7 +491,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 int omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
@@ -690,7 +690,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
 	}
@@ -702,7 +702,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
+	if (unlikely(!timer || !atomic_read(&timer->enabled)))
 		return -EINVAL;
 
 	__omap_dm_timer_write_status(timer, value);
@@ -712,7 +712,7 @@ static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int
 
 static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not iavailable or enabled.\n", __func__);
 		return 0;
 	}
@@ -722,7 +722,7 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
@@ -750,6 +750,29 @@ int omap_dm_timers_active(void)
 	return 0;
 }
 
+static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
+{
+	struct omap_dm_timer *timer = dev_get_drvdata(dev);
+
+	atomic_set(&timer->enabled, 0);
+
+	return 0;
+}
+
+static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
+{
+	struct omap_dm_timer *timer = dev_get_drvdata(dev);
+
+	atomic_set(&timer->enabled, 1);
+
+	return 0;
+}
+
+static const struct dev_pm_ops omap_dm_timer_pm_ops = {
+	SET_RUNTIME_PM_OPS(omap_dm_timer_runtime_suspend,
+			   omap_dm_timer_runtime_resume, NULL)
+};
+
 static const struct of_device_id omap_timer_match[];
 
 /**
@@ -800,6 +823,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
+	platform_set_drvdata(pdev, timer);
+
 	if (dev->of_node) {
 		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
 			timer->capability |= OMAP_TIMER_ALWON;
@@ -946,6 +971,7 @@ static struct platform_driver omap_dm_timer_driver = {
 	.driver = {
 		.name   = "omap_timer",
 		.of_match_table = of_match_ptr(omap_timer_match),
+		.pm = &omap_dm_timer_pm_ops,
 	},
 };
 
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -105,6 +105,7 @@ struct omap_dm_timer {
 	void __iomem	*pend;		/* write pending */
 	void __iomem	*func_base;	/* function register base */
 
+	atomic_t enabled;
 	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
-- 
2.25.1
