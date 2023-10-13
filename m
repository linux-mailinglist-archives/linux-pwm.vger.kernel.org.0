Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F59A7C8C77
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 19:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJMRm3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 13:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJMRm3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 13:42:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24F1A9
        for <linux-pwm@vger.kernel.org>; Fri, 13 Oct 2023 10:42:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB8-0004VI-BI; Fri, 13 Oct 2023 19:42:26 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB7-001RgZ-SP; Fri, 13 Oct 2023 19:42:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qrMB7-00Filf-JH; Fri, 13 Oct 2023 19:42:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 03/11] pwm: berlin: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
Date:   Fri, 13 Oct 2023 19:42:08 +0200
Message-ID: <20231013174204.1457085-16-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
References: <20231013174204.1457085-13-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1408; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dOsHu6q/m7LbyQ3bXDFBgpzDqVE4iyrsm5j9RJk8vlU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKYFwIc31ipOFLCVHaOe3w3xOEFfVG8Mm/Ik59 fOD4tZWINOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSmBcAAKCRCPgPtYfRL+ Tt8MB/9/AM3nfX1oSBo0xhyWZt2v/Y9Q5vZ60/eGIYwppxYpvhRdaMwahPRRkAEKroh9cfmUR/G AP43yBh7UEY5CkJz9iMvVTD5vu832CKDMoKcRQ1QrB3sCleil5HWN8kaD2PpujwV3h24IN62uhI qzAf0RBOxMORSiv5El2cJNu4b5Us3dP4U9v/hnwYgt9wo1yGMfTGl/rAI+elmIIxcTkwtuyiwIA 6fhPZMazBk6kSlTAPrOQN60BKdlAqJQjodQvzfEN4N92L8xocmK5qnCP+Y3T49NzP0r1b3SenzE 6NLLzI9wPrf2KQheA4fNC01rXoqo77lLSBFvG3xBpzrfdiR1
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
 drivers/pwm/pwm-berlin.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index ba2d79991769..442913232dc0 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -226,7 +226,6 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int berlin_pwm_suspend(struct device *dev)
 {
 	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
@@ -267,17 +266,16 @@ static int berlin_pwm_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
-			 berlin_pwm_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
+				berlin_pwm_resume);
 
 static struct platform_driver berlin_pwm_driver = {
 	.probe = berlin_pwm_probe,
 	.driver = {
 		.name = "berlin-pwm",
 		.of_match_table = berlin_pwm_match,
-		.pm = &berlin_pwm_pm_ops,
+		.pm = pm_ptr(&berlin_pwm_pm_ops),
 	},
 };
 module_platform_driver(berlin_pwm_driver);
-- 
2.42.0

