Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4544173492
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgB1JzL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:55:11 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34190 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgB1JzK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:55:10 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9sxU7043763;
        Fri, 28 Feb 2020 03:54:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883700;
        bh=Pjufu2eGrt7Aaby9tzI02Biy3FURAMOPpklyQUL5Lno=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=p9UybdfUJpsHnrHC12RIgNjD4llfN/8j0TvUExAvGbV+1HGa8NJZMZr/t2JXtgGeK
         dsZ153SLHnjCAsu22v3JgPfyaxBAvD4gZphRdtvmi49xSprq/xGV0TCmmfGHUpsGJ4
         SZ32v+QSEs4sBe7is7OksqD3fZWiMM3kDLGynDD0=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9sxGN016181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:54:59 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:54:59 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:54:59 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01S9sbB8125348;
        Fri, 28 Feb 2020 03:54:56 -0600
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
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 5/5] clocksource: timer-ti-dm: Enable autoreload in set_pwm
Date:   Fri, 28 Feb 2020 15:23:46 +0530
Message-ID: <20200228095346.32177-6-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200228095346.32177-1-lokeshvutla@ti.com>
References: <20200228095346.32177-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

dm timer ops set_load() api allows to configure the load value and to
set the auto reload feature. But auto reload feature is independent of
load value and should be part of configuring pwm. This way pwm can be
disabled by disabling auto reload feature using set_pwm() so that the
current pwm cycle will be completed. Else pwm disabling causes the
cycle to be stopped abruptly.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/clocksource/timer-ti-dm.c          | 16 +++++-----------
 drivers/pwm/pwm-omap-dmtimer.c             |  8 +++++---
 include/linux/platform_data/dmtimer-omap.h |  5 ++---
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index b776ad3ee924..ba1c2adab88f 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -527,21 +527,13 @@ static int omap_dm_timer_stop(struct omap_dm_timer *timer)
 	return 0;
 }
 
-static int omap_dm_timer_set_load(struct omap_dm_timer *timer, int autoreload,
+static int omap_dm_timer_set_load(struct omap_dm_timer *timer,
 				  unsigned int load)
 {
-	u32 l;
-
 	if (unlikely(!timer))
 		return -EINVAL;
 
 	omap_dm_timer_enable(timer);
-	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
-	if (autoreload)
-		l |= OMAP_TIMER_CTRL_AR;
-	else
-		l &= ~OMAP_TIMER_CTRL_AR;
-	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_LOAD_REG, load);
 
 	omap_dm_timer_disable(timer);
@@ -570,7 +562,7 @@ static int omap_dm_timer_set_match(struct omap_dm_timer *timer, int enable,
 }
 
 static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
-				 int toggle, int trigger)
+				 int toggle, int trigger, int autoreload)
 {
 	u32 l;
 
@@ -580,12 +572,14 @@ static int omap_dm_timer_set_pwm(struct omap_dm_timer *timer, int def_on,
 	omap_dm_timer_enable(timer);
 	l = omap_dm_timer_read_reg(timer, OMAP_TIMER_CTRL_REG);
 	l &= ~(OMAP_TIMER_CTRL_GPOCFG | OMAP_TIMER_CTRL_SCPWM |
-	       OMAP_TIMER_CTRL_PT | (0x03 << 10));
+	       OMAP_TIMER_CTRL_PT | (0x03 << 10) | OMAP_TIMER_CTRL_AR);
 	if (def_on)
 		l |= OMAP_TIMER_CTRL_SCPWM;
 	if (toggle)
 		l |= OMAP_TIMER_CTRL_PT;
 	l |= trigger << 10;
+	if (autoreload)
+		l |= OMAP_TIMER_CTRL_AR;
 	omap_dm_timer_write_reg(timer, OMAP_TIMER_CTRL_REG, l);
 
 	omap_dm_timer_disable(timer);
diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 88a3c5690fea..9e4378dc6897 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -183,7 +183,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	if (timer_active)
 		omap->pdata->stop(omap->dm_timer);
 
-	omap->pdata->set_load(omap->dm_timer, true, load_value);
+	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
@@ -192,7 +192,8 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	omap->pdata->set_pwm(omap->dm_timer,
 			      pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
 			      true,
-			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			      true);
 
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
@@ -222,7 +223,8 @@ static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 	omap->pdata->set_pwm(omap->dm_timer,
 			      polarity == PWM_POLARITY_INVERSED,
 			      true,
-			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+			      PWM_OMAP_DMTIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			      true);
 	mutex_unlock(&omap->mutex);
 
 	return 0;
diff --git a/include/linux/platform_data/dmtimer-omap.h b/include/linux/platform_data/dmtimer-omap.h
index 3173b7b6ff6f..95d852aef130 100644
--- a/include/linux/platform_data/dmtimer-omap.h
+++ b/include/linux/platform_data/dmtimer-omap.h
@@ -30,12 +30,11 @@ struct omap_dm_timer_ops {
 	int	(*stop)(struct omap_dm_timer *timer);
 	int	(*set_source)(struct omap_dm_timer *timer, int source);
 
-	int	(*set_load)(struct omap_dm_timer *timer, int autoreload,
-			    unsigned int value);
+	int	(*set_load)(struct omap_dm_timer *timer, unsigned int value);
 	int	(*set_match)(struct omap_dm_timer *timer, int enable,
 			     unsigned int match);
 	int	(*set_pwm)(struct omap_dm_timer *timer, int def_on,
-			   int toggle, int trigger);
+			   int toggle, int trigger, int autoreload);
 	int	(*get_pwm_status)(struct omap_dm_timer *timer);
 	int	(*set_prescaler)(struct omap_dm_timer *timer, int prescaler);
 
-- 
2.23.0

