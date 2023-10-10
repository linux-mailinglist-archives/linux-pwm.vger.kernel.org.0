Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C077BF4C1
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Oct 2023 09:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442595AbjJJHvZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 10 Oct 2023 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442598AbjJJHvV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 10 Oct 2023 03:51:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA13BB4
        for <linux-pwm@vger.kernel.org>; Tue, 10 Oct 2023 00:51:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-00086M-Fh; Tue, 10 Oct 2023 09:51:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WP-000bis-2U; Tue, 10 Oct 2023 09:51:17 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qq7WO-00Cvmk-PZ; Tue, 10 Oct 2023 09:51:16 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 04/11] pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Tue, 10 Oct 2023 09:51:05 +0200
Message-Id: <20231010075112.755178-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
References: <20231010075112.755178-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=iYDXGJGWUBfWT5vIf3vehYDyoPsCipPyumwrYXWQO9M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlJQJgcooHDNye5hATcAWTtUKkL4ka/8nDh+ouw 5harhtzpluJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSUCYAAKCRCPgPtYfRL+ ThWvB/9rrJ8MJwwDRqE4K4KhSKvEyJnSgPONSjPKgbPZ8P56q6RqpLQUStU6TVBPWz4r+i13U8+ 2yMcXfU++li+Pg0xAxKYy4M8I+i096XcwVBGX7vLN3MvZ6boITgCOogJvkGOuxsIW+mf8VXAZuw xXjrC0Mk2r614tPJs2sBREa9lxfijxizTQpL9wKkuw0IkliKpXU6zju8iWwwq8S5HKXe2pq7Q9e peaN5YKREpdGeSL932TqulyMvVJbetl7xlbJ0OpYK23Mikhtr2krSIL8u8m9bHLCkLw42SFS2kC nmjCUf0wcQuuE2ZjYPPpKFS4n+cTPcUl4JfmDz69++4ZqoeI
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
 drivers/pwm/pwm-brcmstb.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index a3faa9a3de7c..7510b85dd9dd 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -283,7 +283,6 @@ static void brcmstb_pwm_remove(struct platform_device *pdev)
 	clk_disable_unprepare(p->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
@@ -297,14 +296,11 @@ static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_enable(p->clk);
-
-	return 0;
+	return clk_enable(p->clk);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
-			 brcmstb_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(brcmstb_pwm_pm_ops, brcmstb_pwm_suspend,
+				brcmstb_pwm_resume);
 
 static struct platform_driver brcmstb_pwm_driver = {
 	.probe = brcmstb_pwm_probe,
@@ -312,7 +308,7 @@ static struct platform_driver brcmstb_pwm_driver = {
 	.driver = {
 		.name = "pwm-brcmstb",
 		.of_match_table = brcmstb_pwm_of_match,
-		.pm = &brcmstb_pwm_pm_ops,
+		.pm = pm_ptr(&brcmstb_pwm_pm_ops),
 	},
 };
 module_platform_driver(brcmstb_pwm_driver);
-- 
2.40.1

