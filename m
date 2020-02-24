Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5D1169D7A
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 06:22:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXFWo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 00:22:44 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33618 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBXFWo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 00:22:44 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O5McIS008110;
        Sun, 23 Feb 2020 23:22:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582521758;
        bh=ub/AkC4hs4nhHqp695yVuvYgShg1yFbpNjw0ND9BGFs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=P1AOjG0SSSkR2d9+ntppckjA5xVxxCXWEaNpg1S4WWfmjhF0R57sIqt6vRj81kX1f
         No85l72baHonoJNFi86DaDod4Kr6xVR2cj2do4IdVYKZoZg5nBMMWQCZWS3pGY0wyb
         Z/sXWOMGRfeTjTzt5YDgxYRRDvaoDX8FzXWwHCNg=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O5McwX114243;
        Sun, 23 Feb 2020 23:22:38 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 23
 Feb 2020 23:22:38 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 23 Feb 2020 23:22:38 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MPN7012421;
        Sun, 23 Feb 2020 23:22:35 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 3/4] pwm: omap-dmtimer: Do not disable pwm before changing period/duty_cycle
Date:   Mon, 24 Feb 2020 10:51:34 +0530
Message-ID: <20200224052135.17278-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200224052135.17278-1-lokeshvutla@ti.com>
References: <20200224052135.17278-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Only the Timer control register(TCLR) can be updated only when the timer
is stopped. Registers like Counter register(TCRR), loader register(TLDR),
match register(TMAR) can be updated when the counter is running. Since
TCLR is not updated in pwm_omap_dmtimer_config(), do not stop the
timer for period/duty_cycle update.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index f13be7216847..58c61559e72f 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -102,7 +102,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	u32 load_value, match_value;
 	struct clk *fclk;
 	unsigned long clk_rate;
-	bool timer_active;
 
 	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
@@ -178,25 +177,12 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
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
 	omap->pdata->set_load(omap->dm_timer, true, load_value);
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

