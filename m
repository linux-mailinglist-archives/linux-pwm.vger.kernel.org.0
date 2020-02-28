Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45AFC1734B2
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Feb 2020 10:58:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgB1J6F (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Feb 2020 04:58:05 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55546 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgB1J6E (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Feb 2020 04:58:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01S9vx5C011947;
        Fri, 28 Feb 2020 03:57:59 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582883879;
        bh=fs0KZTPJtZZlBP7pB30VsjNcC7vtHtoLJB0mbseDTu8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FqQft/eqKV61MhNjXdSkIkphqOjSA/TWTZ55rE8lVao9X/GzbZJkIH/ii/Ry5523i
         B/gzz4uYHb7b3FgN1r69UxqbnbrmKnByQUdLoV82KZcc0sohxQx3ajqfchy/EFgzre
         YucDGF77uZC9rVFF+QDvRyQEZyrvrOtT0iGz9Apw=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01S9vxPI029494
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Feb 2020 03:57:59 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 28
 Feb 2020 03:57:59 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 28 Feb 2020 03:57:59 -0600
Received: from uda0131933.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 01S9vhLI115767;
        Fri, 28 Feb 2020 03:57:56 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Tony Lindgren <tony@atomide.com>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Vignesh R <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH v2 4/6] pwm: omap-dmtimer: Fix pwm disabling sequence
Date:   Fri, 28 Feb 2020 15:26:49 +0530
Message-ID: <20200228095651.32464-5-lokeshvutla@ti.com>
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

pwm_omap_dmtimer_disable() calls .stop callback which abruptly stops the
timer counter. This doesn't complete the current pwm cycle and
immediately disables the pwm. Instead disable the auto reload
functionality which allows to complete the current pwm cycle and then
disables the timer.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 drivers/pwm/pwm-omap-dmtimer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index bc338619232d..89b3c25d02b8 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -93,8 +93,16 @@ static void pwm_omap_dmtimer_disable(struct pwm_chip *chip,
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
 
+	/*
+	 * Disable auto reload so that the current cycle gets completed and
+	 * then the counter stops.
+	 */
 	mutex_lock(&omap->mutex);
-	omap->pdata->stop(omap->dm_timer);
+	omap->pdata->set_pwm(omap->dm_timer,
+			     pwm_get_polarity(pwm) == PWM_POLARITY_INVERSED,
+			     true, OMAP_TIMER_TRIGGER_OVERFLOW_AND_COMPARE,
+			     false);
+
 	mutex_unlock(&omap->mutex);
 }
 
-- 
2.23.0

