Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED027583ED
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbjGRRz5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbjGRRz5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 13:55:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C64C0
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 10:55:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLovS-00073e-53; Tue, 18 Jul 2023 19:55:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLovR-000QIT-8r; Tue, 18 Jul 2023 19:55:53 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLovQ-005uL3-EK; Tue, 18 Jul 2023 19:55:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: berlin: Simplify using devm functions
Date:   Tue, 18 Jul 2023 19:55:45 +0200
Message-Id: <20230718175545.3946935-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2160; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=KrkoKyxJp8KGGMu0YnyEUjlyUd/XLTSOAEJro4oqEIc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttIgpNQquYMgY92lFAB05FmZ6l43szc2yTgcP 94YAA0Fl+2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbSIAAKCRCPgPtYfRL+ TuGKB/44UI3OOUfwSJ2NCfRUqA20cM5pU8FjEjeNBLc0UNULW9YZsJaYWKrZ3S78uEqaF8vU66j M1HKNG21r1shzuYA0/hLerkGZYI5h7yn7XqPwvl5ip8Kx0WsM6QjhuP9bLxRnNjVB1+mi0tUHmE vtwE8SAyjLggXc7ZON8pqehVnYm3YQOF0+Pqw3xd+24UpXGR0WlFIXYtWeKqjlG3OEHWIohDEdp pCa15RUtzwd7SzQf1QgMCSPNXOo6spd00Y3jTL5le487hMmsbVfxAuNuNwLd0O9du75+Yz2WhDB 3O0xhAh0KEHk9Kx15Y0cyywfb3fN6uhpc5nocfkQguYz4caZ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
dropped from the error path and the remove callback. With
devm_pwmchip_add() pwmchip_remove() can be dropped. Then the remove
callback is empty and can go away, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 38dcd0c99efd..8d685d097c21 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -209,39 +209,23 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(bpc->base))
 		return PTR_ERR(bpc->base);
 
-	bpc->clk = devm_clk_get(&pdev->dev, NULL);
+	bpc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(bpc->clk))
 		return PTR_ERR(bpc->clk);
 
-	ret = clk_prepare_enable(bpc->clk);
-	if (ret)
-		return ret;
-
 	bpc->chip.dev = &pdev->dev;
 	bpc->chip.ops = &berlin_pwm_ops;
 	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
 
-	ret = pwmchip_add(&bpc->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(bpc->clk);
-		return ret;
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &bpc->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
 	platform_set_drvdata(pdev, bpc);
 
 	return 0;
 }
 
-static void berlin_pwm_remove(struct platform_device *pdev)
-{
-	struct berlin_pwm_chip *bpc = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&bpc->chip);
-
-	clk_disable_unprepare(bpc->clk);
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int berlin_pwm_suspend(struct device *dev)
 {
@@ -290,7 +274,6 @@ static SIMPLE_DEV_PM_OPS(berlin_pwm_pm_ops, berlin_pwm_suspend,
 
 static struct platform_driver berlin_pwm_driver = {
 	.probe = berlin_pwm_probe,
-	.remove_new = berlin_pwm_remove,
 	.driver = {
 		.name = "berlin-pwm",
 		.of_match_table = berlin_pwm_match,

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
prerequisite-patch-id: c856e0baabfc22d250b7ce881427cdb74613e69a
-- 
2.39.2

