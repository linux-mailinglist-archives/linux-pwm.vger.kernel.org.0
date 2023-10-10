Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951F87BF4C3
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442607AbjJJHv0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442600AbjJJHvW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:22 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B50B6
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00085x-3D; Tue, 10 Oct 2023 09:51:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-000bim-LM; Tue, 10 Oct 2023 09:51:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-00CvmX-C5; Tue, 10 Oct 2023 09:51:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 02/11] pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:03 +0200
Message-Id: <20231010075112.755178-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1524; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=SzKV8jKaqvT8DZF/BhY4vmdm5P9Q1JiMpCdaCBw5ojA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJe5FTbag4f5B7svF9UTB2Hc84AmwjYaWqpw mAwd40vEWSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCXgAKCRCPgPtYfRL+ Tky7B/wPWfRL7TLQmx9YR6/v5t7lS39zuxyN+EQ4CSS1PKxNyf+wtjUU0J3vLmIYl2xBRIlfuWJ e8512+IUfIYk7epdXCgr1H3kyMu4zKz+IhrxIeooF57McJ4Y6+PMVEsbWRuW11gWOfxEIftX5FC EImXKj6Ivk+W4b3XrVhWCONd7ZbdGDrN2g+g1KDLa6D8+jPFi8XvezuQIasnUungDCjZvMY3Ude NPO2b4mcMkKZif691eIYn5wMCO02qbRujGL0J5SJXr96cna2FdT4aY7MD1hUqHBSIN9/GlEvKBh fa7Qpl8ee8rNzVTKgHgeTMA5xk0Rj3HsoQX5YTQ+xhfgLOrq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This macro has the advantage over SIMPLE_DEV_PM_OPS that we don't have to
care about when the functions are actually used, so the corresponding
#ifdef can be dropped.

Also make use of pm_ptr() to discard all PM related stuff if CONFIG_PM
isn't enabled.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index c00dd37c5fbd..a2be4cb4c073 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -490,7 +490,6 @@ static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 
-#ifdef CONFIG_PM_SLEEP
 static int atmel_tcb_pwm_suspend(struct device *dev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
@@ -523,16 +522,15 @@ static int atmel_tcb_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
-			 atmel_tcb_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(atmel_tcb_pwm_pm_ops, atmel_tcb_pwm_suspend,
+				atmel_tcb_pwm_resume);
 
 static struct platform_driver atmel_tcb_pwm_driver = {
 	.driver = {
 		.name = "atmel-tcb-pwm",
 		.of_match_table = atmel_tcb_pwm_dt_ids,
-		.pm = &atmel_tcb_pwm_pm_ops,
+		.pm = pm_ptr(&atmel_tcb_pwm_pm_ops),
 	},
 	.probe = atmel_tcb_pwm_probe,
 	.remove_new = atmel_tcb_pwm_remove,
-- 
2.40.1

