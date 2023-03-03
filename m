Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582886A9FB6
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbjCCSz0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbjCCSzS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:18 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24AE31F4AB
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006Nx-F5; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYY-001cUo-NY; Fri, 03 Mar 2023 19:55:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001ul6-Qi; Fri, 03 Mar 2023 19:55:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 23/30] pwm: sti: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:38 +0100
Message-Id: <20230303185445.2112695-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ifUrpXUpZxFlYqqdHSJQVpCxfjjjCiiVEjoL90dH+Ps=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJS/5WqbFswn0TVXarWoZ2AwWNIFXX2imr09 76+VtV2Ih2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCUgAKCRDB/BR4rcrs CYphCACeLchzODXVIWLXW/HHEEkhiL9eV0+2t75+UrSZ5b+VB755DQuL1L7tF5Ro6dkzvynzGv1 oF1+dadvKp3//T9X+2mphOMcHa+uXxyLYHO1tdPSt4Hhhc05EYbzZxcI2IKGkFjx1c5VN13Nabc KEz10olYMAy19AxmR9Kc9x19fJkPyQeyavkQDvHXuLReHawZ+Zfw0vLUWAsSz7lHRc1ch2tYVmC Rpd0/WL9bjXjr/EHcoop6J0dnD7J1DTnk9ZlnaAqcKg18PQ1C/BWFPtcN+5Z3XYdgCf5gAs2PHw 6nPbfGvSrWuKWyFAUr2sRj2FWTqkvWiRsCVl4/FHjXO8XvFM
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
 drivers/pwm/pwm-sti.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 44b1f93256b3..b1d1373648a3 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -669,7 +669,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int sti_pwm_remove(struct platform_device *pdev)
+static void sti_pwm_remove(struct platform_device *pdev)
 {
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
 
@@ -677,8 +677,6 @@ static int sti_pwm_remove(struct platform_device *pdev)
 
 	clk_unprepare(pc->pwm_clk);
 	clk_unprepare(pc->cpt_clk);
-
-	return 0;
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
@@ -693,7 +691,7 @@ static struct platform_driver sti_pwm_driver = {
 		.of_match_table = sti_pwm_of_match,
 	},
 	.probe = sti_pwm_probe,
-	.remove = sti_pwm_remove,
+	.remove_new = sti_pwm_remove,
 };
 module_platform_driver(sti_pwm_driver);
 
-- 
2.39.1

