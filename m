Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EED1869CC
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 12:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730743AbgCPLQE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 07:16:04 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42432 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgCPLQE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 07:16:04 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02GBFkXO027347;
        Mon, 16 Mar 2020 06:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584357346;
        bh=5GFR0zmTtB7qSbEnCC6j5jEJTCXk+OZE/p83GzR6PJQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=eO7Wz6cg9RtqHU4eSTTl+7OiAVCh7XhPDGansi/weo5P9ZxSv4AElNGHENOziIoBk
         eYlZzKio9pkcYd3GVBmPCxblCuobDjPFzWe8YjPp00NvlP8rodmAHjGtSfqg7x3WpY
         ZiRURLDb4ei3hqYVoFwnLTUXzDOzszZpMiPd6kI4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02GBFkik011371
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 06:15:46 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 06:15:46 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 06:15:46 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02GBFgS5074628;
        Mon, 16 Mar 2020 06:15:43 -0500
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
Subject: [PATCH v4 3/6] clocksource: timer-ti-dm: Implement cpu_pm notifier for context save and restore
Date:   Mon, 16 Mar 2020 16:44:53 +0530
Message-ID: <20200316111453.15441-1-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200305082715.15861-4-lokeshvutla@ti.com>
References: <20200305082715.15861-4-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

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
Changes since v3:
- Fixed checkpatch warnings.

 drivers/clocksource/timer-ti-dm.c | 97 ++++++++++++++++++-------------
 include/clocksource/timer-ti-dm.h |  3 +-
 2 files changed, 58 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index dae91969018d..cf4f30df99c2 100644
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
@@ -179,21 +221,7 @@ static int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 
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
@@ -484,8 +512,6 @@ static int omap_dm_timer_start(struct omap_dm_timer *timer)
 		omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	}
 
-	/* Save the context */
-	timer->context.tclr = l;
 	return 0;
 }
 
@@ -501,13 +527,6 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 
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
@@ -530,9 +549,6 @@ static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_TRIGGER_REG, 0);
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tldr = load;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -554,9 +570,6 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_MATCH_REG, match);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
-	timer->context.tmar = match;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -580,8 +593,6 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	l |= trigger << 10;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -603,8 +614,6 @@ static int omap_dm_timer_set_prescaler(struct omap_dm_timer *timer,
 	}
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
-	/* Save the context */
-	timer->context.tclr = l;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -618,9 +627,6 @@ static int omap_dm_timer_set_int_enable(struct omap_dm_timer *timer,
 	omap_dm_timer_enable(timer);
 	__omap_dm_timer_int_enable(timer, value);
 
-	/* Save the context */
-	timer->context.tier = value;
-	timer->context.twer = value;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -648,9 +654,6 @@ static int omap_dm_timer_set_int_disable(struct omap_dm_timer *timer, u32 mask)
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_WAKEUP_EN_REG) & ~mask;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_WAKEUP_EN_REG, l);
 
-	/* Save the context */
-	timer->context.tier &= ~mask;
-	timer->context.twer &= ~mask;
 	omap_dm_timer_disable(timer);
 	return 0;
 }
@@ -725,6 +728,11 @@ static int __maybe_unused omap_dm_timer_runtime_suspend(struct device *dev)
 
 	atomic_set(&timer->enabled, 0);
 
+	if (timer->capability & OMAP_TIMER_ALWON || !timer->func_base)
+		return 0;
+
+	omap_timer_save_context(timer);
+
 	return 0;
 }
 
@@ -732,6 +740,9 @@ static int __maybe_unused omap_dm_timer_runtime_resume(struct device *dev)
 {
 	struct omap_dm_timer *timer = dev_get_drvdata(dev);
 
+	if (!(timer->capability & OMAP_TIMER_ALWON) && timer->func_base)
+		omap_timer_restore_context(timer);
+
 	atomic_set(&timer->enabled, 1);
 
 	return 0;
@@ -798,7 +809,11 @@ static int omap_dm_timer_probe(struct platform_device *pdev)
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
@@ -852,6 +867,8 @@ static int omap_dm_timer_remove(struct platform_device *pdev)
 	list_for_each_entry(timer, &omap_timer_list, node)
 		if (!strcmp(dev_name(&timer->pdev->dev),
 			    dev_name(&pdev->dev))) {
+			if (!(timer->capability & OMAP_TIMER_ALWON))
+				cpu_pm_unregister_notifier(&timer->nb);
 			list_del(&timer->node);
 			ret = 0;
 			break;
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index eef5de300731..25f05235866e 100644
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
2.23.0

