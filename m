Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 589351734BA
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgB1J6C (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:58:02 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:47992 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgB1J6B (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:58:01 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9vuK3118918;
        Fri, 28 Feb 2020 03:57:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883876;
        bh=fUxWB1g81MbmPcVm0AN6Xj8PxgfO5kpoeK1cwYzWuYg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=MDKI1solmXPmH8if1TmCB19wEYxnUp97KoFNlK9Z+30ZANJmY8k0cHyqaEZMsCfKE
         7oUeUbwNt/LVtUqLRB34tvtxoZ/4z7OwDHRuQca3DwSrJjYKajY4yyxX3vJ+ZmMPHM
         0Lu20me4O+ojRXGjiURxIJp8CNGuNdaFdwQi8KrM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9vui2029480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:57:56 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:57:55 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:57:55 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01S9vhLH115767;
        Fri, 28 Feb 2020 03:57:53 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 3/6] pwm: omap-dmtimer: Fix pwm enabling sequence
Date:   Fri, 28 Feb 2020 15:26:48 +0530
Message-ID: <20200228095651.32464-4-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200228095651.32464-1-lokeshvutla@ti.com>
References: <20200228095651.32464-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To configure DM timer in pwm mode the following needs to be set in
OMAP_TIMER_CTRL_REG using set_pwm callback:
- Set toggle mode on PORTIMERPWM output pin
- Set trigger on overflow and match on PORTIMERPWM output pin.
- Set auto reload

This is a one time configuration and needs to be set before the start of
the dm timer. But the current driver tries to set the same configuration
for every period/duty cycle update, which is not needed. So move the pwm
setup before enabling timer and do not update it in pwm_omap_dmtimer_config.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index a24a630ccdb9..bc338619232d 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -77,6 +77,11 @@ static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
 	mutex_lock(&omap->mutex);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     true);
+
 	pwm_omap_dmtimer_start(omap);
 	mutex_unlock(&omap->mutex);
 
@@ -193,11 +198,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
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

