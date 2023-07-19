Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120B7759E9B
	for <lists+linux-pwm@lfdr.de>; Wed, 19 Jul 2023 21:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjGSTc0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 19 Jul 2023 15:32:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSTcZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 19 Jul 2023 15:32:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70CD5199A
        for <linux-pwm@vger.kernel.org>; Wed, 19 Jul 2023 12:32:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCuJ-0001w0-Ih; Wed, 19 Jul 2023 21:32:19 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCuI-000fjW-HQ; Wed, 19 Jul 2023 21:32:18 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qMCuH-006B7B-Nz; Wed, 19 Jul 2023 21:32:17 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: atmel: Simplify using devm functions
Date:   Wed, 19 Jul 2023 21:32:13 +0200
Message-Id: <20230719193213.4053199-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2457; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=2fgzCuBOSnIpgm4cVPikzxFE57IlpFW7mksehlIJmZM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkuDo6sBNTBguGasgdjcLt7SrjJUckfP4uAXFkY hyRatZ0xCSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLg6OgAKCRCPgPtYfRL+ TqjnB/sHLEyVvvkI34uiClwdk2wmRvTLbj1FoNe/VebRqEFKO++ejqP6neQYYaKWKel7smTTtG2 Wm/3dZAWGoTjlvzDJH0t2jsmyeDmcrOfEvDvaNaAb0RtLdvDVNs9LC6F8/3KnVGHRgb+b5cxoE3 dMNgGogDslFCzmCNHlB4DY7KXgbNtz3TUSDqC7t69Eol18jTmEO4G+6JfyjjecYcMNyRln6lfQ+ eGznTVoji3yYWdATobAwm2T+MvZOZYOnFDQ5T5zpI+d/OI1gvqY5NMo8kX7ypQhMSddYDGtQEHu WzeZyi7fqhYpYTDjb/9NKBNQz1Xh1zzr+HSexypSlJ5OJlNx
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

For all resources used by the driver there is a devm variant to allocate
these. This makes it unnecessary to implement an error path or a remove
function.

While at it also use dev_err_probe() to compact returning an error.

With the remove callback gone, there is no user of driver data left, so
the call to platform_set_drvdata() can also be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 38 ++++++++------------------------------
 1 file changed, 8 insertions(+), 30 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 5f7d286871cf..ade0331159f7 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -482,42 +482,21 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(atmel_pwm->base))
 		return PTR_ERR(atmel_pwm->base);
 
-	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	atmel_pwm->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(atmel_pwm->clk))
-		return PTR_ERR(atmel_pwm->clk);
-
-	ret = clk_prepare(atmel_pwm->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
-		return ret;
-	}
+		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
+				     "failed to get prepared PWM clock\n");
 
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
-	ret = pwmchip_add(&atmel_pwm->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
-		goto unprepare_clk;
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &atmel_pwm->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to add PWM chip\n");
 
-	platform_set_drvdata(pdev, atmel_pwm);
-
-	return ret;
-
-unprepare_clk:
-	clk_unprepare(atmel_pwm->clk);
-	return ret;
-}
-
-static void atmel_pwm_remove(struct platform_device *pdev)
-{
-	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&atmel_pwm->chip);
-
-	clk_unprepare(atmel_pwm->clk);
+	return 0;
 }
 
 static struct platform_driver atmel_pwm_driver = {
@@ -526,7 +505,6 @@ static struct platform_driver atmel_pwm_driver = {
 		.of_match_table = of_match_ptr(atmel_pwm_dt_ids),
 	},
 	.probe = atmel_pwm_probe,
-	.remove_new = atmel_pwm_remove,
 };
 module_platform_driver(atmel_pwm_driver);
 

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

