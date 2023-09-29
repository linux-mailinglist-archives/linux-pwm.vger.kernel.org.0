Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71C47B37BB
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjI2QTb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbjI2QT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF834BE
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-0007nX-Tj; Fri, 29 Sep 2023 18:19:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-009r5P-FS; Fri, 29 Sep 2023 18:19:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-00615s-5U; Fri, 29 Sep 2023 18:19:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        linux-pwm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 02/11] pwm: bcm2835: Simplify using devm functions
Date:   Fri, 29 Sep 2023 18:19:09 +0200
Message-Id: <20230929161918.2410424-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=3r0FgbKKWywHyu97lKZLbiJhWaeiE/Te8MGsVjZUgq4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj2+j75KWoUa/ENFiYyJzzRXAKMiXMv0CdW7 BnVaCL+dAmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb49gAKCRCPgPtYfRL+ TnGpCACdNCmjB0oRPbpkp4Rp2OzioyAoEJV1UqDvHKC4867qqNrf5IGB1n9xKyXheendfmeHBK0 t0XtzhrgZvl4Z2/Z6jT79OWaT6cCzrgqHK4+Q7Vel4OB/ahn/jNEtMkJu04Tg/1xk46wMh9pvOf OFtzzSKv4bFQ2796JkJTeTIiDeJJ8F+xh2c/frBCR5HFP+IO87jzCdIuX+aioP5aWbLOjvYtkMz 7OgrPZZmHfEbl03XM7rbfa8QfVEdB5sJsS8PUTNBHiWov/71C+m+m7FCJe+OuyISkrhx5DCFHyo lBYhTI6bzpNFk1/NsrUMxY5nTMeBlToXR/0bWKPqP61JfHHz
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

With devm_clk_get_enabled() the call to clk_disable_unprepare() can be
dropped from the error path and the remove callback. With
devm_pwmchip_add() pwmchip_remove() can be dropped. Then the remove
callback is empty and can go away, too. With bcm2835_pwm_remove() the only
user of platform_get_drvdata() is gone and so platform_set_drvdata() can
be dropped from .probe(), too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index bdfc2a5ec0d6..7261e57159b1 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -147,39 +147,21 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pc->base))
 		return PTR_ERR(pc->base);
 
-	pc->clk = devm_clk_get(&pdev->dev, NULL);
+	pc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "clock not found\n");
 
-	ret = clk_prepare_enable(pc->clk);
-	if (ret)
-		return ret;
-
 	pc->chip.dev = &pdev->dev;
 	pc->chip.ops = &bcm2835_pwm_ops;
 	pc->chip.npwm = 2;
 
-	platform_set_drvdata(pdev, pc);
-
-	ret = pwmchip_add(&pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
 	if (ret < 0)
-		goto add_fail;
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to add pwmchip\n");
 
 	return 0;
-
-add_fail:
-	clk_disable_unprepare(pc->clk);
-	return ret;
-}
-
-static void bcm2835_pwm_remove(struct platform_device *pdev)
-{
-	struct bcm2835_pwm *pc = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&pc->chip);
-
-	clk_disable_unprepare(pc->clk);
 }
 
 static const struct of_device_id bcm2835_pwm_of_match[] = {
@@ -194,7 +176,6 @@ static struct platform_driver bcm2835_pwm_driver = {
 		.of_match_table = bcm2835_pwm_of_match,
 	},
 	.probe = bcm2835_pwm_probe,
-	.remove_new = bcm2835_pwm_remove,
 };
 module_platform_driver(bcm2835_pwm_driver);
 
-- 
2.40.1

