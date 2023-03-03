Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672136A9FBF
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjCCSzb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbjCCSzU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:20 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B931714F
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:08 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYV-0006Ab-1h; Fri, 03 Mar 2023 19:54:59 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001cTb-DA; Fri, 03 Mar 2023 19:54:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYT-001ujm-L1; Fri, 03 Mar 2023 19:54:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org
Subject: [PATCH 03/30] pwm: atmel: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:18 +0100
Message-Id: <20230303185445.2112695-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=pFCjXBrXUBoRy/uL5FpUfgBsjZ3sNmM8W0JkDTbn/6w=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMaQwOb7mu3T0ePShVe1XP6rzGZst7V9+PdZ++nHWBpND3 KZaS7tsOhmNWRgYuRhkxRRZ6oq0xCZIrPlvV7KEG2YQKxPIFAYuTgGYyLI3HAxt0S/a+qSaXMxU PS6qZssWKN+/1Wn+94fxHkWRyvqw8zJpLWfEdmq0//uy5OT3x1pf3sc1CV42FBIK+27h/Wmn0gS PzuOWgY12jQ8yfVfKHUk4yqt/Io2fcxOjJOu1BczBEjYStRlaR1TUds/bOilJpvzq33SVNL73sZ 4PE3kOrLy1hF/tFNPS37W3rsYIq6Q8dgx4KyOeerA5YZKm2l7uvEPyCSJFReWezQz79/znLL1Xf XinT8M0oWij/d1n4nYXtnHqeJ5+cs3uxvb2pa9unszk/CD7bx6vYD53u39NqOb95JBWe7HsW70i V/b6fDtXvt3Qwnu9epKO24x/JjtfKmQ8+iGgGX9j7T89AA==
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
 drivers/pwm/pwm-atmel.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index cdbc23649032..0c567d9623cd 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -511,15 +511,13 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int atmel_pwm_remove(struct platform_device *pdev)
+static void atmel_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
 
 	pwmchip_remove(&atmel_pwm->chip);
 
 	clk_unprepare(atmel_pwm->clk);
-
-	return 0;
 }
 
 static struct platform_driver atmel_pwm_driver = {
@@ -528,7 +526,7 @@ static struct platform_driver atmel_pwm_driver = {
 		.of_match_table = of_match_ptr(atmel_pwm_dt_ids),
 	},
 	.probe = atmel_pwm_probe,
-	.remove = atmel_pwm_remove,
+	.remove_new = atmel_pwm_remove,
 };
 module_platform_driver(atmel_pwm_driver);
 
-- 
2.39.1

