Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9368F17A13E
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2020 09:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgCEI2d (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 5 Mar 2020 03:28:33 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:48198 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbgCEI2d (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 5 Mar 2020 03:28:33 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0258SLfn031634;
        Thu, 5 Mar 2020 02:28:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583396901;
        bh=+wWqJn3udznWbM64C22Er4Xy1eH3ux44So4v/CeH0/0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=nFM9/bfI0kUFbhxFhVpWi/H0Yl2t6o31p1V50M3qaV46yHtGOeu2sgh2Kf3IO+WM6
         FJizpME7EyMH8TOXfoecHZpe08vf3h9w+Ds+YBX3YhsxCAigsc8SpRZQbppydwteY8
         9eHcifuP9v8oJD7xAdYZJSlMpZVC6MobMPYS/Z7I=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0258SK0C066415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 02:28:20 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 02:28:20 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 02:28:20 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0258S9kT067014;
        Thu, 5 Mar 2020 02:28:17 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Tony Lindgren <tony@atomide.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH v3 2/6] clocksource: timer-ti-dm: Prepare for using cpuidle
Date:   Thu, 5 Mar 2020 13:57:11 +0530
Message-ID: <20200305082715.15861-3-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200305082715.15861-1-lokeshvutla@ti.com>
References: <20200305082715.15861-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

Let's add runtime_suspend and resume functions and atomic enabled
flag. This way we can use these when converting to use cpuidle
for saving and restoring device context.

And we need to maintain the driver state in the driver as documented
in "9. Autosuspend, or automatically-delayed suspends" in the
Documentation/power/runtime_pm.rst document related to using driver
private lock and races with runtime_suspend().

Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clocksource/timer-ti-dm.c | 36 ++++++++++++++++++++++++++-----
 include/clocksource/timer-ti-dm.h |  1 +
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index bf132d321ecc..dae91969018d 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -460,7 +460,7 @@ __u32 omap_dm_timer_modify_idlect_mask(__u32 inputmask)
 
 int omap_dm_timer_trigger(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
@@ -659,7 +659,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 {
 	unsigned int l;
 
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return 0;
 	}
@@ -671,7 +671,7 @@ static unsigned int omap_dm_timer_read_status(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev)))
+	if (unlikely(!timer || !atomic_read(&timer->enabled)))
 		return -EINVAL;
 
 	__omap_dm_timer_write_status(timer, value);
@@ -681,7 +681,7 @@ static int omap_dm_timer_write_status(struct omap_dm_timer *timer, unsigned int
 
 static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not iavailable or enabled.\n", __func__);
 		return 0;
 	}
@@ -691,7 +691,7 @@ static unsigned int omap_dm_timer_read_counter(struct omap_dm_timer *timer)
 
 static int omap_dm_timer_write_counter(struct omap_dm_timer *timer, unsigned int value)
 {
-	if (unlikely(!timer || pm_runtime_suspended(&timer->pdev->dev))) {
+	if (unlikely(!timer || !atomic_read(&timer->enabled))) {
 		pr_err("%s: timer not available or enabled.\n", __func__);
 		return -EINVAL;
 	}
@@ -719,6 +719,29 @@ int omap_dm_timers_active(void)
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
@@ -760,6 +783,8 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
 	if (IS_ERR(timer->io_base))
 		return PTR_ERR(timer->io_base);
 
+	platform_set_drvdata(pdev, timer);
+
 	if (dev->of_node) {
 		if (of_find_property(dev->of_node, "ti,timer-alwon", NULL))
 			timer->capability |= OMAP_TIMER_ALWON;
@@ -905,6 +930,7 @@ static struct platform_driver omap_dm_timer_driver = {
 	.driver = {
 		.name   = "omap_timer",
 		.of_match_table = of_match_ptr(omap_timer_match),
+		.pm = &omap_dm_timer_pm_ops,
 	},
 };
 
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 7d9598dc578d..eef5de300731 100644
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
2.23.0

