Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA51827B1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 05:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387714AbgCLEXN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 00:23:13 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55978 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731627AbgCLEXN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 00:23:13 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C4N4hq048108;
        Wed, 11 Mar 2020 23:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583986984;
        bh=1LVBRb1Toe8tpkzms37NWh85pb0RjtoY5pPclCPsJ+g=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=lH0rmwPoQVMh6Uvga9FMlwtMTb83L70NyDuGnKxC2dwrIZTK7mJ/Ma9yNqCSr8+Ew
         aKzb+2nD/03r0muQA7pFeMQrEBtOiRp0+Jrmd+p1pKce9A+uAq/ButdSc+973ISpYv
         6gW9PR1R4i+/GDBtLHcWaDNpQjXWCo1BHjtmVPkY=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C4N4SK039260
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 23:23:04 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 23:23:03 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 23:23:03 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C4Mvgh065984;
        Wed, 11 Mar 2020 23:23:01 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 1/5] pwm: omap-dmtimer: Drop unused header file
Date:   Thu, 12 Mar 2020 09:52:06 +0530
Message-ID: <20200312042210.17344-2-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200312042210.17344-1-lokeshvutla@ti.com>
References: <20200312042210.17344-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_omap_dmtimer.h is used only:
- to typedef struct omap_dm_timer to pwm_omap_dmtimer
- for macro PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE
Rest of the file is pretty mush unsed. So reuse omap_dm_timer
and OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE in pwm-omap-dmtimer.c
and delete the header file.

Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c                | 20 ++---
 include/clocksource/timer-ti-dm.h             |  3 +-
 .../linux/platform_data/pwm_omap_dmtimer.h    | 90 -------------------
 3 files changed, 10 insertions(+), 103 deletions(-)
 delete mode 100644 include/linux/platform_data/pwm_omap_dmtimer.h

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 9e4378dc6897..e4f5f710bfaa 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -20,8 +20,8 @@
 #include <linux/mutex.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
+#include <clocksource/timer-ti-dm.h>
 #include <linux/platform_data/dmtimer-omap.h>
-#include <linux/platform_data/pwm_omap_dmtimer.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
@@ -34,7 +34,7 @@
 struct pwm_omap_dmtimer_chip {
 	struct pwm_chip chip;
 	struct mutex mutex;
-	pwm_omap_dmtimer *dm_timer;
+	struct omap_dm_timer *dm_timer;
 	const struct omap_dm_timer_ops *pdata;
 	struct platform_device *dm_timer_pdev;
 };
@@ -190,10 +190,9 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 		load_value, load_value,	match_value, match_value);
 
 	omap->pdata->set_pwm(omap->dm_timer,
-			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			      true,
-			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE,
-			      true);
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     true);
 
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
@@ -221,10 +220,9 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 	 */
 	mutex_lock(&omap->mutex);
 	omap->pdata->set_pwm(omap->dm_timer,
-			      polarity == PWM_POLARITY_INVERSED,
-			      true,
-			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE,
-			      true);
+			     polarity == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     true);
 	mutex_unlock(&omap->mutex);
 
 	return 0;
@@ -246,7 +244,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	struct pwm_omap_dmtimer_chip *omap;
 	struct dmtimer_platform_data *timer_pdata;
 	const struct omap_dm_timer_ops *pdata;
-	pwm_omap_dmtimer *dm_timer;
+	struct omap_dm_timer *dm_timer;
 	u32 v;
 	int ret = 0;
 
diff --git a/include/clocksource/timer-ti-dm.h b/include/clocksource/timer-ti-dm.h
index 25f05235866e..531ca87fcd08 100644
--- a/include/clocksource/timer-ti-dm.h
+++ b/include/clocksource/timer-ti-dm.h
@@ -248,8 +248,7 @@ int omap_dm_timers_active(void);
 
 /*
  * The below are inlined to optimize code size for system timers. Other code
- * should not need these at all, see
- * include/linux/platform_data/pwm_omap_dmtimer.h
+ * should not need these at all.
  */
 #if defined(CONFIG_ARCH_OMAP1) || defined(CONFIG_ARCH_OMAP2PLUS)
 static inline u32 __omap_dm_timer_read(struct omap_dm_timer *timer, u32 reg,
diff --git a/include/linux/platform_data/pwm_omap_dmtimer.h b/include/linux/platform_data/pwm_omap_dmtimer.h
deleted file mode 100644
index e7d521e48855..000000000000
--- a/include/linux/platform_data/pwm_omap_dmtimer.h
+++ /dev/null
@@ -1,90 +0,0 @@
-/*
- * include/linux/platform_data/pwm_omap_dmtimer.h
- *
- * OMAP Dual-Mode Timer PWM platform data
- *
- * Copyright (C) 2010 Texas Instruments Incorporated - http://www.ti.com/
- * Tarun Kanti DebBarma <tarun.kanti@ti.com>
- * Thara Gopinath <thara@ti.com>
- *
- * Platform device conversion and hwmod support.
- *
- * Copyright (C) 2005 Nokia Corporation
- * Author: Lauri Leukkunen <lauri.leukkunen@nokia.com>
- * PWM and clock framework support by Timo Teras.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
- *
- * THIS SOFTWARE IS PROVIDED ``AS IS'' AND ANY EXPRESS OR IMPLIED
- * WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
- * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
- * NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
- * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- * ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
- * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- * You should have received a copy of the  GNU General Public License along
- * with this program; if not, write  to the Free Software Foundation, Inc.,
- * 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef __PWM_OMAP_DMTIMER_PDATA_H
-#define __PWM_OMAP_DMTIMER_PDATA_H
-
-/* clock sources */
-#define PWM_OMAP_DMTIMER_SRC_SYS_CLK			0x00
-#define PWM_OMAP_DMTIMER_SRC_32_KHZ			0x01
-#define PWM_OMAP_DMTIMER_SRC_EXT_CLK			0x02
-
-/* timer interrupt enable bits */
-#define PWM_OMAP_DMTIMER_INT_CAPTURE			(1 << 2)
-#define PWM_OMAP_DMTIMER_INT_OVERFLOW			(1 << 1)
-#define PWM_OMAP_DMTIMER_INT_MATCH			(1 << 0)
-
-/* trigger types */
-#define PWM_OMAP_DMTIMER_TRIGGER_NONE			0x00
-#define PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW		0x01
-#define PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE	0x02
-
-struct omap_dm_timer;
-typedef struct omap_dm_timer pwm_omap_dmtimer;
-
-struct pwm_omap_dmtimer_pdata {
-	pwm_omap_dmtimer *(*request_by_node)(struct device_node *np);
-	pwm_omap_dmtimer *(*request_specific)(int timer_id);
-	pwm_omap_dmtimer *(*request)(void);
-
-	int	(*free)(pwm_omap_dmtimer *timer);
-
-	void	(*enable)(pwm_omap_dmtimer *timer);
-	void	(*disable)(pwm_omap_dmtimer *timer);
-
-	int	(*get_irq)(pwm_omap_dmtimer *timer);
-	int	(*set_int_enable)(pwm_omap_dmtimer *timer, unsigned int value);
-	int	(*set_int_disable)(pwm_omap_dmtimer *timer, u32 mask);
-
-	struct clk *(*get_fclk)(pwm_omap_dmtimer *timer);
-
-	int	(*start)(pwm_omap_dmtimer *timer);
-	int	(*stop)(pwm_omap_dmtimer *timer);
-	int	(*set_source)(pwm_omap_dmtimer *timer, int source);
-
-	int	(*set_load)(pwm_omap_dmtimer *timer, int autoreload,
-			unsigned int value);
-	int	(*set_match)(pwm_omap_dmtimer *timer, int enable,
-			unsigned int match);
-	int	(*set_pwm)(pwm_omap_dmtimer *timer, int def_on,
-			int toggle, int trigger);
-	int	(*set_prescaler)(pwm_omap_dmtimer *timer, int prescaler);
-
-	unsigned int (*read_counter)(pwm_omap_dmtimer *timer);
-	int	(*write_counter)(pwm_omap_dmtimer *timer, unsigned int value);
-	unsigned int (*read_status)(pwm_omap_dmtimer *timer);
-	int	(*write_status)(pwm_omap_dmtimer *timer, unsigned int value);
-};
-
-#endif /* __PWM_OMAP_DMTIMER_PDATA_H */
-- 
2.23.0

