Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104CD766687
	for <lists+linux-pwm@lfdr.de>; Fri, 28 Jul 2023 10:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjG1IL6 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 28 Jul 2023 04:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjG1ILb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 28 Jul 2023 04:11:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B91F3AB1
        for <linux-pwm@vger.kernel.org>; Fri, 28 Jul 2023 01:11:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPIZ7-00052I-Ga; Fri, 28 Jul 2023 10:11:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPIZ6-002fNR-Nz; Fri, 28 Jul 2023 10:11:12 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qPIZ5-008S6E-Sp; Fri, 28 Jul 2023 10:11:11 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2] pwm: atmel: Simplify using devm functions
Date:   Fri, 28 Jul 2023 10:11:05 +0200
Message-Id: <20230728081105.595161-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5BDb4lnapcJD9aVhX2R255TUCTQkGk36VXRTmH24CKg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkw3gYc/UKSgLmaqMAgHX7QCvQGvV1lz2yrtabz J6VfizeO3qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZMN4GAAKCRCPgPtYfRL+ Tp2SCACTQPV/DsIcM3ZFRleVB/8BloyLXti/VQ0yk+Qiz0kz7tCR2Kp5vjZS15UbmrkR1DEvgfi +p+VZwmylyjPE+ol0FxyIroj2wgD+JOgE6k4JoS1PFQLa0wUuWqtWVXxRS9TqQhSTCdyqkuUicI OLU0QoTwrH0UY2xjrKlZWLGY3AHogp9KZCJZIDblJoDXHxgcwHSIpJn4jh7XvxkgTiLaBpDmG0N JhI1Kwn5Kfic/bkFCtyBvWcFJMbBzMo5Dld1CeRD92DpFYX2ZJ2H6EyIqAXmbfAs/Gd4ikG7b0T qxkOm2iTsc2/f+zYxTM94YCDp86XF1RQJvRIcfSYodZRb255
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
these. This simplifies the error path in the probe callback and allows
to drop the remove callback.

While at it also use dev_err_probe() to compact returning an error.

With the remove callback gone, there is no user of driver data left, so
the call to platform_set_drvdata() can also be dropped.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes compared to (implicit) v1:

 - Rebased on pwm/for-next due to conflicts with commit a2f68c7e312f
   ("pwm: atmel: Enable clk when pwm already enabled in bootloader")
 - Adapt changelog as now the error path in probe is still used while it
   could be dropped before commit a2f68c7e312f.
   
Thanks
Uwe

 drivers/pwm/pwm-atmel.c | 33 +++++++--------------------------
 1 file changed, 7 insertions(+), 26 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 03c7810416b8..1f73325d1bea 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -517,15 +517,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
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
@@ -533,42 +528,28 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
 	if (ret < 0)
-		goto unprepare_clk;
+		return ret;
 
-	ret = pwmchip_add(&atmel_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &atmel_pwm->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
+		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 		goto disable_clk;
 	}
 
-	platform_set_drvdata(pdev, atmel_pwm);
-
-	return ret;
+	return 0;
 
 disable_clk:
 	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
 
-unprepare_clk:
-	clk_unprepare(atmel_pwm->clk);
 	return ret;
 }
 
-static void atmel_pwm_remove(struct platform_device *pdev)
-{
-	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&atmel_pwm->chip);
-
-	clk_unprepare(atmel_pwm->clk);
-}
-
 static struct platform_driver atmel_pwm_driver = {
 	.driver = {
 		.name = "atmel-pwm",
 		.of_match_table = of_match_ptr(atmel_pwm_dt_ids),
 	},
 	.probe = atmel_pwm_probe,
-	.remove_new = atmel_pwm_remove,
 };
 module_platform_driver(atmel_pwm_driver);
 

base-commit: a2f68c7e312f94c8f78740449a88e8d7308ab18d
-- 
2.39.2

