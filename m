Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28A96A9FAC
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Mar 2023 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjCCSzU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Mar 2023 13:55:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCCSzQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Mar 2023 13:55:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9A81B31F
        for <linux-pwm@vger.kernel.org>; Fri,  3 Mar 2023 10:55:02 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-0006AU-Pw; Fri, 03 Mar 2023 19:54:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYU-001cTX-3l; Fri, 03 Mar 2023 19:54:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pYAYT-001ujj-DV; Fri, 03 Mar 2023 19:54:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     kernel@pengutronix.de, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 02/30] pwm: atmel-tcb: Convert to platform remove callback returning void
Date:   Fri,  3 Mar 2023 19:54:17 +0100
Message-Id: <20230303185445.2112695-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
References: <20230303185445.2112695-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3GlNnOz2MtF+RCy3uc/VVXQMVqysqqFD9V6WoCSxiaQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkAkHnNF5rBx7tUYOXq5l5nt6DU0MNQPqJtnNig krJT5kNPYWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAJB5wAKCRDB/BR4rcrs CfmQB/9fCdplTw5eXzEZwMmtb6QRrt4TsQrTTbtbZAq/T+YniKaEaCU3Lx+yR6CxUIoHXcSaxCR bHBbyAUHDvl8ibQhN2lBpo5KjbCog60nOyL6f2qs3Ea25PDo/ze0jWVzz4mpK1ytxD9x5LM0Nm2 ks8JMKV3rs1I5b3JAeORVeHNxH/tlL1Kjc3CD/+3+WCfDjuLsO+sCV3VTgtH6iIWaQA9eBiwE4M KDKntBP20yNVbQ3XcUwRCK7WNRY0uOwKQugfEui2gNOAq30zVqpcR6uAhrE/P9zygJXZ0eqhFo7 1jgGp1jGfLDh742LxK0hMhaAs+1dsnjiFbhWZVBW+7lixpcU
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
 drivers/pwm/pwm-atmel-tcb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 2837b4ce8053..4a116dc44f6e 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -500,7 +500,7 @@ static int atmel_tcb_pwm_probe(struct platform_device *pdev)
 	return err;
 }
 
-static int atmel_tcb_pwm_remove(struct platform_device *pdev)
+static void atmel_tcb_pwm_remove(struct platform_device *pdev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = platform_get_drvdata(pdev);
 
@@ -509,8 +509,6 @@ static int atmel_tcb_pwm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(tcbpwm->slow_clk);
 	clk_put(tcbpwm->slow_clk);
 	clk_put(tcbpwm->clk);
-
-	return 0;
 }
 
 static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
@@ -564,7 +562,7 @@ static struct platform_driver atmel_tcb_pwm_driver = {
 		.pm = &atmel_tcb_pwm_pm_ops,
 	},
 	.probe = atmel_tcb_pwm_probe,
-	.remove = atmel_tcb_pwm_remove,
+	.remove_new = atmel_tcb_pwm_remove,
 };
 module_platform_driver(atmel_tcb_pwm_driver);
 
-- 
2.39.1

