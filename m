Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288506A9FB5
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjCCSzZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjCCSzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556E91F4B7
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006O1-JR; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001cUx-TV; Fri, 03 Mar 2023 19:55:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYW-001ukd-Ku; Fri, 03 Mar 2023 19:55:00 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 17/30] pwm: rcar: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:32 +0100
Message-Id: <20230303185445.2112695-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1651; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FHa/6oZuzUv+EOb4L/3Osug6YriNk9twQuuShEg/IBk=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkI73HvCaN7qPRS1uRMPIB4Fs8RuMXN4gT9BP 0NZ2BaIrJSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCOwAKCRDB/BR4rcrs CZGrB/9dnW3kgIQa+x4ZzXsGUZzM0f7ES3u8AGoIowmA/WhDQ4NG1wUx6ozi/xY6BmfGV9TbWdt x91+049nHScVJNPQUvvLvi6vdGWMYOHbJSKzo5DKvlYJ5Vfqjf1SV2ndIEVUc0DcCqk1N1PJS98 A+FQlWgSjRcFAfh3iL43+0AtxFWOZNVOdCDRc5HSY3Il2RtFeM6IaWitpG25d+qMPf1NWivQhr2 6hxskVWgAIfIjoofamuTYQVc4gdMRTB2Q6tozjQoqoVTfKooFM8BimJ46v/TOswgwX0ocumT9nR ChwRxXCpBksnnS1/m+mDo1Otx0S+IKWU0lxqumRMclupl4oe
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
 drivers/pwm/pwm-rcar.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 55f46d09602b..e9d8646dc331 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -238,15 +238,13 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int rcar_pwm_remove(struct platform_device *pdev)
+static void rcar_pwm_remove(struct platform_device *pdev)
 {
 	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&rcar_pwm->chip);
 
 	pm_runtime_disable(&pdev->dev);
-
-	return 0;
 }
 
 static const struct of_device_id rcar_pwm_of_table[] = {
@@ -257,7 +255,7 @@ MODULE_DEVICE_TABLE(of, rcar_pwm_of_table);
 
 static struct platform_driver rcar_pwm_driver = {
 	.probe = rcar_pwm_probe,
-	.remove = rcar_pwm_remove,
+	.remove_new = rcar_pwm_remove,
 	.driver = {
 		.name = "pwm-rcar",
 		.of_match_table = of_match_ptr(rcar_pwm_of_table),
-- 
2.39.1

