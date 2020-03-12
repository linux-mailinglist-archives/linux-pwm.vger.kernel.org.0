Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B02461827B7
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Mar 2020 05:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387758AbgCLEXQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Mar 2020 00:23:16 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387756AbgCLEXP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Mar 2020 00:23:15 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02C4NAsb048186;
        Wed, 11 Mar 2020 23:23:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583986990;
        bh=yfnmLmGqZuF901NMzFzpc45U1ki5pwP1FoJ5cXVm0Gs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=flpdtK8UGKXOtYAp3k90usk+H0Ie8fbWlz1Yyao4DHETWGv9CH1iOkiGFD9WE8GMS
         6YhsN05mEq0On1GFMXRxlQWyor9bz7ba4TMEGDYhQ+3IDx+wuKC/tpPpN3H36dfbZX
         RuHP0raFe/P/MAgnR6oVvRgY0cdmT6cpQf5D0WBM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02C4NALN039572
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 23:23:10 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 23:23:10 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 23:23:10 -0500
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02C4Mvgj065984;
        Wed, 11 Mar 2020 23:23:07 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v3 3/5] pwm: omap-dmtimer: Fix pwm enabling sequence
Date:   Thu, 12 Mar 2020 09:52:08 +0530
Message-ID: <20200312042210.17344-4-lokeshvutla@ti.com>
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

To configure DM timer is pwm mode the following needs to be set in
OMAP_TIMER_CTRL_REG using set_pwm callback:
- Set toggle mode on PORTIMERPWM output pin
- Set trigger on overflow and match on PORTIMERPWM output pin.
- Set auto reload

This is a one time configuration and needs to be set before the start of
the dm timer. But the current driver tries to set the same configuration
for every period/duty cycle update, which is not needed. So move the pwm
setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 92aac6c86b95..85b17b49980b 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -81,6 +81,11 @@ static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
 	mutex_lock(&omap->mutex);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     true);
+
 	pwm_omap_dmtimer_start(omap);
 	mutex_unlock(&omap->mutex);
 
@@ -197,11 +202,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	omap->pdata->set_pwm(omap->dm_timer,
-			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
-			     true);
-
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
 		pwm_omap_dmtimer_start(omap);
-- 
2.23.0

