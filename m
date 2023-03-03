Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B136C6A9FBC
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjCCSza (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjCCSzT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F32168AD
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYa-0006PA-Cw; Fri, 03 Mar 2023 19:55:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-001cVC-JB; Fri, 03 Mar 2023 19:55:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001ulF-ED; Fri, 03 Mar 2023 19:55:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 26/30] pwm: tegra: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:41 +0100
Message-Id: <20230303185445.2112695-27-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1700; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Hb55anhnO38PV0SBYU/sABiE7lIwGdy/JXcXyRuEONA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJeeLHtNSVt3V9gRI2ztB1xarxIUHZ6cJc4N Z2EioOguraJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCXgAKCRDB/BR4rcrs CdCqB/9QCBRTjz925V5ciuYtQryEnjrjQ262hv8LY1+AvAdjlPi2dxWBWcKckMOyvSPiYkoKDJX 7yqg8B1ATah+8fevJWUNU4aam4ftR5o8NiiidG+LiZ5tZqv3Y8jarbP9ZgF7Mm7sjRQdmTtsHSz phvYR+P7yMR6NzhC78sfoj1exIFCI7ngkNhc64UR7IajNb9OGMKsLhtHVnPv8qQJrR2c/qcqm0D Rh0jQBr/0JS7WAJNaFMrJ82vlNOCrq+REWTAOEu6BbTkXLXl5aWFbWjpe6WBhJ+8RBO8wa34TWw UdJxe6JxXQU9lNPtNDmId078fYEBwnyoIffd8XEGic55EW9E
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
 drivers/pwm/pwm-tegra.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 249dc0193297..5810abf66e2a 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -350,7 +350,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int tegra_pwm_remove(struct platform_device *pdev)
+static void tegra_pwm_remove(struct platform_device *pdev)
 {
 	struct tegra_pwm_chip *pc = platform_get_drvdata(pdev);
 
@@ -359,8 +359,6 @@ static int tegra_pwm_remove(struct platform_device *pdev)
 	reset_control_assert(pc->rst);
 
 	pm_runtime_force_suspend(&pdev->dev);
-
-	return 0;
 }
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
@@ -434,7 +432,7 @@ static struct platform_driver tegra_pwm_driver = {
 		.pm = &tegra_pwm_pm_ops,
 	},
 	.probe = tegra_pwm_probe,
-	.remove = tegra_pwm_remove,
+	.remove_new = tegra_pwm_remove,
 };
 
 module_platform_driver(tegra_pwm_driver);
-- 
2.39.1

