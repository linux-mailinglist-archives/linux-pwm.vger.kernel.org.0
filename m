Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5B7C8C7D
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjJMRme (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjJMRmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6114C0
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:30 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-0004VH-Va; Fri, 13 Oct 2023 19:42:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB7-001RgW-Lx; Fri, 13 Oct 2023 19:42:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB7-00Filb-CT; Fri, 13 Oct 2023 19:42:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 02/11] pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:07 +0200
Message-ID: <20231013174204.1457085-15-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=s/RV24x+4N1RGFR3t5c6VN7LdTx9o4dgt4gZk2Ko4IU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYFvOfYkPZlP+Jfegu7rqc8ZRLcQf0EnuKpZJ 4l4FAa640SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBbwAKCRCPgPtYfRL+ TnbYCACScNJ+1b9T5NGFT33n31DvEdNEquTWmRA211f/+zzTcWhmRKkRjFIr3LNbWTq/79SiTp/ /ghOSo+jKa95GjW9deoJse54lXmbCk6A8gB3luKL9FMbdd9RO8dybQf0pzZW4lvy4tJvUmiJIzy G5kFtaZuDXqq5/4VwNeR0RvF4p3JZ/5B1CfpUZW6z8LG/fRZX/15xblot4BP3q5QyrBQuR4EQY+ eoKC57BTL0R0GYru4dLAqinKg79j0jMb+O/T29B3GjeW/7bTVwm230OenBrZitG05enbVBx+tzX QUHrIJBNxyqs6sYVmnbBlxJmJcB7EgCjx36rahZvBqpm7Yl1
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

