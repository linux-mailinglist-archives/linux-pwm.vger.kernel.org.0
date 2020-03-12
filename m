Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9912C1827B9
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 05:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgCLEXT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 00:23:19 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47588 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgCLEXS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 00:23:18 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C4NDla051590;
        Wed, 11 Mar 2020 23:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583986993;
        bh=gxKT17BT/JrDTWMisO596gib9N8ksFwLrosZSsfzl1k=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DMRg9lsEIEGz20ttsi1W3diVviWtx9Qdk5WnH/c5OvWfVf71QX0R7WBl2VGaSp9zg
         IE8OQGcF74XFZdapgLC7xZvMewAd0Bkb+ysRlnyCdXJ1OMwoDWCZl90sveW73D1GLt
         XWsHw+fGzASCOaAJjxdHL6cmSlPgeArxb61bU8nM=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C4NDM6039624
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 23:23:13 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 23:23:13 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 23:23:13 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C4Mvgk065984;
        Wed, 11 Mar 2020 23:23:10 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 4/5] pwm: omap-dmtimer: Do not disable pwm before changing period/duty_cycle
Date:   Thu, 12 Mar 2020 09:52:09 +0530
Message-ID: <20200312042210.17344-5-lokeshvutla@ti.com>
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

Only the Timer control register(TCLR) cannot be updated when the timer
is running. Registers like Counter register(TCRR), loader register(TLDR),
match register(TMAR) can be updated when the counter is running. Since
TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
timer for period/duty_cycle update.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 85b17b49980b..c56e7256e923 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -19,6 +19,13 @@
  * Limitations:
  * - When PWM is stopped, timer counter gets stopped immediately. This
  *   doesn't allow the current PWM period to complete and stops abruptly.
+ * - When PWM is running and changing both duty cycle and period,
+ *   we cannot prevent in software that the output might produce
+ *   a period with mixed settings. Especially when period/duty_cyle
+ *   is updated while the pwm pin is high, current pwm period/duty_cycle
+ *   can get updated as below based on the current timer counter:
+ *   	- period for current cycle =  current_period + new period
+ *   	- duty_cycle for current period = current period + new duty_cycle.
  */
 
 #include <linux/clk.h>
@@ -111,7 +118,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	u32 load_value, match_value;
 	struct clk *fclk;
 	unsigned long clk_rate;
-	bool timer_active;
 
 	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
@@ -187,25 +193,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	load_value = (DM_TIMER_MAX - period_cycles) + 1;
 	match_value = load_value + duty_cycles - 1;
 
-	/*
-	 * We MUST stop the associated dual-mode timer before attempting to
-	 * write its registers, but calls to omap_dm_timer_start/stop must
-	 * be balanced so check if timer is active before calling timer_stop.
-	 */
-	timer_active = pm_runtime_active(&omap->dm_timer_pdev->dev);
-	if (timer_active)
-		omap->pdata->stop(omap->dm_timer);
-
 	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	/* If config was called while timer was running it must be reenabled. */
-	if (timer_active)
-		pwm_omap_dmtimer_start(omap);
-
 	mutex_unlock(&omap->mutex);
 
 	return 0;
-- 
2.23.0

