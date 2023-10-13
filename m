Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E3F7C8C7B
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjJMRmc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMRmc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:32 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864CDA9
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-0004WQ-Sk; Fri, 13 Oct 2023 19:42:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-001Rgw-FH; Fri, 13 Oct 2023 19:42:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB9-00FimC-64; Fri, 13 Oct 2023 19:42:27 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 10/11] pwm: tiecap: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:15 +0200
Message-ID: <20231013174204.1457085-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Ri/mWOwoqDUd5X1pQcPpUEvF4Hv5wqsu48zXQOMPSGg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYF4bipc7FEf5L+kmYsGO6NvoWGw2HtE691Wa RPmuNpgeSWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBeAAKCRCPgPtYfRL+ TsP9B/43f+gMItUs2QX5bS72Gu4GNAPzS9Ifj08774VJE6yR5yxOob0i3cZhtmS4xyI2tIpCzIz H0XXe3rBek+vFcoJKaYrH004apJoJDD0UB3EaA+IGrFISKlBKmyPr1l7ijMzzlHgCMKODZsQFEL OWbsMGmiwAGh2JzD1pVW7JY18VNkwOvoFyfAFOB6P6mvqIrDAf1kWoC7oYQZFY3FG9doCLy8CQH BY+1OELIs4jpj1Yl0MC6e4p9S2qDLRKv/powBLnwMHTuPKAf6CW9dIB9dj1hDRPOFZG9kcBL5Ti bWfhlm73yqiqnZKtzBHXB7/hfHlXD2uMaLANt/0sW/4Qulk8
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
 drivers/pwm/pwm-tiecap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 11e3549cf103..d974f4414ac9 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -269,7 +269,6 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
 {
 	pm_runtime_get_sync(pc->chip.dev);
@@ -312,15 +311,14 @@ static int ecap_pwm_resume(struct device *dev)
 	ecap_pwm_restore_context(pc);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(ecap_pwm_pm_ops, ecap_pwm_suspend, ecap_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(ecap_pwm_pm_ops, ecap_pwm_suspend, ecap_pwm_resume);
 
 static struct platform_driver ecap_pwm_driver = {
 	.driver = {
 		.name = "ecap",
 		.of_match_table = ecap_of_match,
-		.pm = &ecap_pwm_pm_ops,
+		.pm = pm_ptr(&ecap_pwm_pm_ops),
 	},
 	.probe = ecap_pwm_probe,
 	.remove_new = ecap_pwm_remove,
-- 
2.42.0

