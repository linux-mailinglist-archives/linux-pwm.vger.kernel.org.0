Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6E7C8C7F
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjJMRmf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMRmd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:33 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEAAABE
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMBA-0004Xh-7i; Fri, 13 Oct 2023 19:42:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-001Rgz-MA; Fri, 13 Oct 2023 19:42:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-00FimG-Ce; Fri, 13 Oct 2023 19:42:27 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 11/11] pwm: tiehrpwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:16 +0200
Message-ID: <20231013174204.1457085-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=IMzNzVIjj1Ek/nD50Dk9wTyZn0n86R6RfH8ILG9VoLI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYF53eib/CvJu7aXLxetYx0w9KvFFU4vgIQ8Q BTa5bxhzUmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBeQAKCRCPgPtYfRL+ TrNoCACzN5HD1HJqL2woe3M4u6ym0EztrD28Qm+ZFff3UuNxrezRwTAUNXeg0W2helIFfYTo7eD nA3l6dHUOfQYYxTSTdozx7bt3/YUXFYJM1sHxINBsVMLmhLhbO/kRXRm4xN4SJIcW71nNsu8wHC kCcRBKEJ1W5tCBm2mRvebqvI6JCrbxUGtdkKJqz3DL06mwkmCK1u+cC08dW2MFGeq7YDbO+nwOY 5x1z4DbifoU6IGYBhZW0Eo3vfEr6WlJCBw5i8IGn4XBdr7k9tKf998QaXjlZ+Llt3mo9t7i6BvY /OKIQooTTL/BuhIIii/CKZf65iEZsGnXuw+WdbfxpXmewFcO
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 66ac2655845f..af231fa74fa9 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -521,7 +521,6 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 {
 	pm_runtime_get_sync(pc->chip.dev);
@@ -589,16 +588,15 @@ static int ehrpwm_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ehrpwm_pwm_pm_ops, ehrpwm_pwm_suspend,
-			 ehrpwm_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ehrpwm_pwm_pm_ops, ehrpwm_pwm_suspend,
+				ehrpwm_pwm_resume);
 
 static struct platform_driver ehrpwm_pwm_driver = {
 	.driver = {
 		.name = "ehrpwm",
 		.of_match_table = ehrpwm_of_match,
-		.pm = &ehrpwm_pwm_pm_ops,
+		.pm = pm_ptr(&ehrpwm_pwm_pm_ops),
 	},
 	.probe = ehrpwm_pwm_probe,
 	.remove_new = ehrpwm_pwm_remove,
-- 
2.42.0

