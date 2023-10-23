Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBA77D3E3B
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Oct 2023 19:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjJWRq5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 Oct 2023 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWRqw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 Oct 2023 13:46:52 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1940D7E
        for <linux-pwm@vger.kernel.org>; Mon, 23 Oct 2023 10:46:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0p-0001ME-II; Mon, 23 Oct 2023 19:46:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0n-003lPY-TM; Mon, 23 Oct 2023 19:46:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1quz0n-004VCw-Jo; Mon, 23 Oct 2023 19:46:45 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v3 02/11] pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Mon, 23 Oct 2023 19:46:19 +0200
Message-ID: <20231023174616.2282067-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
References: <20231023174616.2282067-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=6g7/sQIw5ZMOMB4wGVep21VAbsziWpGO132pn4n7rAw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlNrFqOcpku7VFJpwx3t1G11MjfX1tEr1tu0ow5 y5ClR6O8gqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTaxagAKCRCPgPtYfRL+ ThOcCACebwQ+gLv3fmyb/3FB8EfnIoRcpXn9kawPcaGCuSsaXd607D9EklgaDDmtyGf8g3/8+s2 UPEPYXjcXe6WdmNm0+XXTsayaHM0g/CgX0x28osoL73SPZOp0oWLM3SfsAYP9y5geOu5YEwR78d 4QNHGQzYAnZ4Nu//A2B0tnQMucx0n0qJ8r56DBgYAM4OmdJRyblI8cI6i/2Dzm5elsMiJKD78lq 4Mq2Sr3XEMLw6oJzXWzNW2KviDYwY09P3Js6vYm7Ql4TZifrAf00A5a9EIFd+sbKUM1O5BO0VwI kPt7ZLbc9p5UiU73UxqinXWKVRjIZSwsjnHRARrAocmAmbeF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
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

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-tcb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 98b33c016c3c..d42c897cb85e 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -489,7 +489,6 @@ static const struct of_device_id atmel_tcb_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_tcb_pwm_dt_ids);
 
-#ifdef CONFIG_PM_SLEEP
 static int atmel_tcb_pwm_suspend(struct device *dev)
 {
 	struct atmel_tcb_pwm_chip *tcbpwm = dev_get_drvdata(dev);
@@ -522,16 +521,15 @@ static int atmel_tcb_pwm_resume(struct device *dev)
 
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
2.42.0

