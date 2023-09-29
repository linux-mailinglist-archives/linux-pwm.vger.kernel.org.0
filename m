Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9FA7B37B7
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbjI2QTa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbjI2QT2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:28 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3242E1A4
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-0007oR-MU; Fri, 29 Sep 2023 18:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-009r5g-9f; Fri, 29 Sep 2023 18:19:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-006169-0a; Fri, 29 Sep 2023 18:19:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 06/11] pwm: spear: Simplify using devm functions
Date:   Fri, 29 Sep 2023 18:19:13 +0200
Message-Id: <20230929161918.2410424-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2764; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=G5mX8UF7P9rKHh2lK8rFtEAtA+bx11d8c6Q8ImEm3F0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlSxH78cnKOmMom1K211ZZrc7pKSsyckOc2suChrbkhn0 aY3ylKdjMYsDIxcDLJiiiz2jWsyrarkIjvX/rsMM4iVCWQKAxenAExEcSX7f//X37O++ZlvMlv5 S+nb0ssWi//NP9V6NNV7beziO9f0g/93n9YK0jXcWPdGfOra0Et8fl3ONtITH02OjYjVNmlcaV3 b3FZVy9+3qNXU+qioXfSWPmtelUVvjKQsShzNAlRDnqyLuNmXuyrurDv3rZ3+W5nlXhUzz3RaZm vp9qFFc177dY6alqVLrs/99eLyy7b1Ged2S/6/m9CakZDxbMqxCIFsT/FpJ+afPVv78yrrw4Jgx iizczoZCqbPWzQ1M+YL2PPxMm8sZv9jZv+INS/BQVmDf9vKz9yBx/7V6vh3CSfaR/GJPrp6eWKw uoNXuE7Ive0e0V59VnevrP4x58V2O7mMz4086ScM49cBAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_clk_get_prepared() the call to clk_unprepare() can be dropped
from the error path and the remove callback. With devm_pwmchip_add()
pwmchip_remove() can be dropped. Then the remove callback is empty and
can go away, too. With spear_pwm_remove() the last user of
platform_get_drvdata() is gone and so platform_set_drvdata() can be
dropped, too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index 4e1cfd8d7c03..0ebdf99453fa 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -207,26 +207,21 @@ static int spear_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
-		return PTR_ERR(pc->clk);
-
-	platform_set_drvdata(pdev, pc);
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
+				     "Failed to get clock\n");
 
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &spear_pwm_ops;
 	pc->chip.npwm = NUM_PWM;
 
-	ret = clk_prepare(pc->clk);
-	if (ret)
-		return ret;
-
 	if (of_device_is_compatible(np, "st,spear1340-pwm")) {
 		ret = clk_enable(pc->clk);
-		if (ret) {
-			clk_unprepare(pc->clk);
-			return ret;
-		}
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to enable clk\n");
+
 		/*
 		 * Following enables PWM chip, channels would still be
 		 * enabled individually through their control register
@@ -238,23 +233,11 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		clk_disable(pc->clk);
 	}
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->clk);
-		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-	return ret;
-}
-
-static void spear_pwm_remove(struct platform_device *pdev)
-{
-	struct spear_pwm_chip *pc = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&pc->chip);
-
-	/* clk was prepared in probe, hence unprepare it here */
-	clk_unprepare(pc->clk);
+	return 0;
 }
 
 static const struct of_device_id spear_pwm_of_match[] = {
@@ -271,7 +254,6 @@ static struct platform_driver spear_pwm_driver = {
 		.of_match_table = spear_pwm_of_match,
 	},
 	.probe = spear_pwm_probe,
-	.remove_new = spear_pwm_remove,
 };
 
 module_platform_driver(spear_pwm_driver);
-- 
2.40.1

