Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8043BEC2E
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhGGQbh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 12:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhGGQbh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 12:31:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD96C061574
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 09:28:56 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APu-0004Nu-EF; Wed, 07 Jul 2021 18:28:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APt-0002cz-Sx; Wed, 07 Jul 2021 18:28:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APm-0006Jk-On; Wed, 07 Jul 2021 18:28:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 40/47] pwm: omap-dmtimer: Don't check the return code of pwmchip_remove()
Date:   Wed,  7 Jul 2021 18:28:28 +0200
Message-Id: <20210707162835.1772882-41-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwmchip_remove() returns always 0. Don't use the value to make it
possible to eventually change the function to return void. Also the
driver core ignores the return value of pwm_omap_dmtimer_remove()
and considers the device removed anyhow. So returning early results
in a resource leak.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 507a2d945b90..fa800fcf31d4 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -444,11 +444,8 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 {
 	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
-	int ret;
 
-	ret = pwmchip_remove(&omap->chip);
-	if (ret)
-		return ret;
+	pwmchip_remove(&omap->chip);
 
 	if (pm_runtime_active(&omap->dm_timer_pdev->dev))
 		omap->pdata->stop(omap->dm_timer);
-- 
2.30.2

