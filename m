Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B01E6A9FC2
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjCCSzd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjCCSzV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C415154
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYb-0006T0-UC; Fri, 03 Mar 2023 19:55:05 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYa-001cVR-Gj; Fri, 03 Mar 2023 19:55:04 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001ulJ-KC; Fri, 03 Mar 2023 19:55:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 27/30] pwm: tiecap: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:42 +0100
Message-Id: <20230303185445.2112695-28-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1462; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=A1tLtYafrvmMIFlCg/5ZLEDvxlDJQJ5NUTrDRybTcmQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJiYcCPBURKmrpsS64l2dypvBmyezF2+gNGw 4TxslPfFLaJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCYgAKCRDB/BR4rcrs CYyhB/9gVZE02yMevZxjBIBK+5lfXjB7dkcb9hW/wg9f2HiCF//TD1yXdoaoTBU+tiORybpOTsT BjBxvpU90Y8h5A9sGuH8zNK5gWnSwzFyoroMqSaOH0cOuSCs8qMYm6QJZdJtVBmcJVHXwN16ibW 8jRYPyuDBnHMc4pPS7qrg6FxUe3kCWTifFtdD0MC0QtHUTfHWkvG4RoYzze+0w6wsriwxP8HKqw nzZaODo+9XQDqjHdy75UtfrMA8pgerG5uaUQqjDNx0ECy7dQQORNaBs1MAprQaDfvwdboEdnYXG r27Iu6ACb3/9Koio5g8VcV1Tk4kBbFkBNsJonqSp0u2ZsK/x
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
 drivers/pwm/pwm-tiecap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 4701f0c9b921..109449956307 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -265,11 +265,9 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int ecap_pwm_remove(struct platform_device *pdev)
+static void ecap_pwm_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -326,7 +324,7 @@ static struct platform_driver ecap_pwm_driver = {
 		.pm = &ecap_pwm_pm_ops,
 	},
 	.probe = ecap_pwm_probe,
-	.remove = ecap_pwm_remove,
+	.remove_new = ecap_pwm_remove,
 };
 module_platform_driver(ecap_pwm_driver);
 
-- 
2.39.1

