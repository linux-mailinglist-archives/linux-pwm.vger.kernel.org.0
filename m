Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DA36A9FBB
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjCCSz3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCCSzT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:19 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16C01A499
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:06 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-0006OC-RG; Fri, 03 Mar 2023 19:55:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYZ-001cV3-3F; Fri, 03 Mar 2023 19:55:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYX-001ul1-IU; Fri, 03 Mar 2023 19:55:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH 22/30] pwm: sprd: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:37 +0100
Message-Id: <20230303185445.2112695-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=OvrjyFl895DiZRMyGAvH1jFT9yZxaF84nIHFH/v/dLc=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkJOM+eBhdQBJ4YYD6Jrl4q/kt4iefuQ/4pXJ f71buofskOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJCTgAKCRDB/BR4rcrs CYleCACZ/6oMZCBLY99UUG2UapcA8UlPIeuZU3p3iubpyRxPPFf7t266T0j9De/VhPYVEdAw5p+ u9yUAYHoJhXHlGbD3ph9pGD1n0/hpKiRGrMlTeAFhbf0Skr/2jM5OtejpdymlCU4U5XZ6lTVbMC rLu6HuzrUm6K/lLfic6C68FaEfAqrckTXPPFoQuDfP7Kc6Uk+vq5aaRC/rl3akoZWeA50KaY3Xw XhMrviHIaX6UG/Bt+v/c3e2FZuZkPm0AJyTOH5yyZBdcszpEKoTiPC87IEXRxDge0J5hUJSNvgi KyUGwyBCuAkli2iENYmw7aKsX+TpVnBoO1aeBj1NY3EJ7J58
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
 drivers/pwm/pwm-sprd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index d866ce345f97..3b69fe6ecdac 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -279,13 +279,11 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int sprd_pwm_remove(struct platform_device *pdev)
+static void sprd_pwm_remove(struct platform_device *pdev)
 {
 	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&spc->chip);
-
-	return 0;
 }
 
 static const struct of_device_id sprd_pwm_of_match[] = {
@@ -300,7 +298,7 @@ static struct platform_driver sprd_pwm_driver = {
 		.of_match_table = sprd_pwm_of_match,
 	},
 	.probe = sprd_pwm_probe,
-	.remove = sprd_pwm_remove,
+	.remove_new = sprd_pwm_remove,
 };
 
 module_platform_driver(sprd_pwm_driver);
-- 
2.39.1

