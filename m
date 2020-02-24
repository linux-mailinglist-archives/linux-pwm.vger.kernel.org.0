Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5C7A169D7D
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2020 06:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBXFWm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Feb 2020 00:22:42 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38618 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgBXFWm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Feb 2020 00:22:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MZf9102853;
        Sun, 23 Feb 2020 23:22:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582521755;
        bh=DmPDknj86LwdpII9Aksa/QDx3c8Iyxx+zls4lzf1VkA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=q0cmMg/CN5QLDj9dkJR5oGTfPx9NFojt6lPeyThpML+1s05UizzUr3vi7oLPEaAPS
         b/jY2afQrwHhzWSb53MoXtupjR4ILMtId5AzD8ToYx9l9nuYLzklfNHuB/M4Ljd5Zy
         mC4st3kvIMo8GrpnCqZmg/ZXfjFfrKuqcxlYkdjE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01O5MZ9Z090181
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 23 Feb 2020 23:22:35 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Sun, 23
 Feb 2020 23:22:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Sun, 23 Feb 2020 23:22:35 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01O5MPN6012421;
        Sun, 23 Feb 2020 23:22:32 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 2/4] pwm: omap-dmtimer: Fix pwm enabling sequence
Date:   Mon, 24 Feb 2020 10:51:33 +0530
Message-ID: <20200224052135.17278-3-lokeshvutla@ti.com>
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

To configure DM timer is pwm mode the following needs to be set in
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
 drivers/pwm/pwm-omap-dmtimer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 2e35bf9a7936..f13be7216847 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -73,6 +73,10 @@ static int pwm_omap_dmtimer_enable(struct pwm_chip *chip,
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
 	mutex_lock(&omap->mutex);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
+
 	pwm_omap_dmtimer_start(omap);
 	mutex_unlock(&omap->mutex);
 
@@ -189,10 +193,6 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
-	omap->pdata->set_pwm(omap->dm_timer,
-			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
-			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE);
-
 	/* If config was called while timer was running it must be reenabled. */
 	if (timer_active)
 		pwm_omap_dmtimer_start(omap);
-- 
2.23.0

