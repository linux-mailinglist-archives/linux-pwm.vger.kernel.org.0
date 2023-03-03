Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA816A9FC4
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjCCSze (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjCCSzV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD421EFCE
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006Nz-HC; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001cUr-R0; Fri, 03 Mar 2023 19:55:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001ukj-0W; Fri, 03 Mar 2023 19:55:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kernel@pengutronix.de, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 19/30] pwm: samsung: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:34 +0100
Message-Id: <20230303185445.2112695-20-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1631; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=O8JDZmZIgjMwEr4lKcC5KC3SI4hyLS5O1WHmmCd4ACY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJD+urETRJKcN3tGkScRpngsSWWj13MOVX/o sA2Gn2gLMiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCQwAKCRDB/BR4rcrs CYZXB/9OmLOE52AEw3oirog5BImozxV+NA94rkO7DXRpdXlEPnd5b+BwfDBzSImIALFQwnA8gtu H6VGc0znhTyem4yJOeWbq1nNgh3I9UXLl4pmrqCPgyaFa0vVpdof2A9kF2o8VNsKs9dVDgLu0Ye s0mc/cr8Sdg2ooLPWUhdKgDaC7vlpbac0HaO29j+Tfbg6m9LVBAgnwXp/ncTccY+wFmKJgL//Zn K7dwhDkJTpTxkaZYPruYh/S+0JV66QZNd8LJGgBBFlgf+EC/AMXODFlFMgWfNZyefq1PVKFeUKf Xh0ZUA8RoMaHSl/QGqF41FdDRvtuscF26M2qsR+ZN4YmKpuo
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 drivers/pwm/pwm-samsung.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 9c5b4f515641..e8828f57ab15 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -621,15 +621,13 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_samsung_remove(struct platform_device *pdev)
+static void pwm_samsung_remove(struct platform_device *pdev)
 {
 	struct samsung_pwm_chip *chip = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&chip->chip);
 
 	clk_disable_unprepare(chip->base_clk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -676,7 +674,7 @@ static struct platform_driver pwm_samsung_driver = {
 		.of_match_table = of_match_ptr(samsung_pwm_matches),
 	},
 	.probe		= pwm_samsung_probe,
-	.remove		= pwm_samsung_remove,
+	.remove_new	= pwm_samsung_remove,
 };
 module_platform_driver(pwm_samsung_driver);
 
-- 
2.39.1

