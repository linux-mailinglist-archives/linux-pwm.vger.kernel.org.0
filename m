Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354A46A9FB2
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjCCSzX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjCCSzR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C465F1C59A
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-0006KU-5S; Fri, 03 Mar 2023 19:55:02 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001cUQ-Cj; Fri, 03 Mar 2023 19:55:01 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-001uka-EI; Fri, 03 Mar 2023 19:55:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 16/30] pwm: omap-dmtimer: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:31 +0100
Message-Id: <20230303185445.2112695-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1833; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=gI7UCFw4A7U4FcF3f79s7J63Fx5OcCdQi8jXZMg+fpc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkI3abLWl6rCWtXrBZRKrUk/m6iejzDryhraz 2nH03pRFvCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCNwAKCRDB/BR4rcrs CVPwB/4g6tBkiCYBADHpVRO9WFqUHkYX5tABA0qJoRnnPHLebXDdfTQuYtmsLzf8Io17Y0bCJOS i87TqWndfW/08datZSFE0BYPR8m2EgXpPisI+CuEgcc/gvjIJq5LnpAvnM5JubmN+pzrnY6Ut83 oTwT0dt8PuK4733YJmRcXCeuTK/8H6QW6IFPk+lVJU6yOAyLrTZaGx8Kvd7wx701RVDyWKvVEYn lcfWkSfUZmqjXyJ7sIm5ZgHImCcLG0Epp3L9wca4Mhf75ecogfp2hQSweYcFLrgXF2o22gJmj2b 5hFiWcbA1x4Ht8gofLz5f7UkjL7Rri6ufohBxASlFzcjl7bS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is (mostly) ignored
and this typically results in resource leaks. To improve here there is a
quest to make the remove callback return void. In the first step of this
quest all drivers are converted to .remove_new() which already returns
void.

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index fa800fcf31d4..4889fbd8a431 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -441,7 +441,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
+static void pwm_omap_dmtimer_remove(struct platform_device *pdev)
 {
 	struct pwm_omap_dmtimer_chip *omap = platform_get_drvdata(pdev);
 
@@ -455,8 +455,6 @@ static int pwm_omap_dmtimer_remove(struct platform_device *pdev)
 	put_device(&omap->dm_timer_pdev->dev);
 
 	mutex_destroy(&omap->mutex);
-
-	return 0;
 }
 
 static const struct of_device_id pwm_omap_dmtimer_of_match[] = {
@@ -471,7 +469,7 @@ static struct platform_driver pwm_omap_dmtimer_driver = {
 		.of_match_table = of_match_ptr(pwm_omap_dmtimer_of_match),
 	},
 	.probe = pwm_omap_dmtimer_probe,
-	.remove	= pwm_omap_dmtimer_remove,
+	.remove_new = pwm_omap_dmtimer_remove,
 };
 module_platform_driver(pwm_omap_dmtimer_driver);
 
-- 
2.39.1

