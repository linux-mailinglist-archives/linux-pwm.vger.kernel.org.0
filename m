Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA40A7B37BF
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbjI2QTc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjI2QT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501CE1AE
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-0007pW-CU; Fri, 29 Sep 2023 18:19:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-009r5s-Vx; Fri, 29 Sep 2023 18:19:24 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-00616L-Mm; Fri, 29 Sep 2023 18:19:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 09/11] pwm: vt8500: Simplify using devm functions
Date:   Fri, 29 Sep 2023 18:19:16 +0200
Message-Id: <20230929161918.2410424-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2795; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=FJNOyAxzATbLhbsQS66EfbdvtZ2s0b2e76dKLbuAUn8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj+/BiKgxM3yFS8ifonjeE+Fc5ehA51xYGuY ZK+ohvjOMyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb4/gAKCRCPgPtYfRL+ Tm0kB/9CZaXJD3rH7yyA8xt/cNUy0OHq/7be1ekXgDHhOCu0f8yoohEl1temrPM12ndk+jcnElk FUC0hAydmPsCA5po4Bx4vfkszNDUju8YOCHrfoOjOY19g9la6fKj2QjLXYVkHD8Mmz6SkUPeR+X kHV0+9I0c8stQkAbnJa9FQU+LC4vtNFLLIlJuvdmoLSYqIw+SFJywT9jZrDOupZrP6n7jstT++z MLAIq0x/QH9mZPBB8t34Bs2em+SzI7jsaNeX7jfBg0+0qx9Mz0ep4B3l77slGEeVEgPlrvoeopC wOzHVeCkuJd0fqzqbHCEZFvQtf093LgoaFVkbXHqLXGIV41J
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
can go away, too. With vt8500_pwm_remove() the last user of
platform_get_drvdata() is gone and so platform_set_drvdata() can be
dropped, too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-vt8500.c | 42 +++++++++-------------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 6d46db51daac..25fee12d2131 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -236,10 +236,8 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (!np) {
-		dev_err(&pdev->dev, "invalid devicetree node\n");
-		return -EINVAL;
-	}
+	if (!np)
+		return dev_err_probe(&pdev->dev, -EINVAL, "invalid devicetree node\n");
 
 	vt8500 = devm_kzalloc(&pdev->dev, sizeof(*vt8500), GFP_KERNEL);
 	if (vt8500 == NULL)
@@ -249,45 +247,23 @@ static int vt8500_pwm_probe(struct platform_device *pdev)
 	vt8500->chip.ops = &vt8500_pwm_ops;
 	vt8500->chip.npwm = VT8500_NR_PWMS;
 
-	vt8500->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(vt8500->clk)) {
-		dev_err(&pdev->dev, "clock source not specified\n");
-		return PTR_ERR(vt8500->clk);
-	}
+	vt8500->clk = devm_clk_get_prepared(&pdev->dev, NULL);
+	if (IS_ERR(vt8500->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(vt8500->clk), "clock source not specified\n");
 
 	vt8500->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vt8500->base))
 		return PTR_ERR(vt8500->base);
 
-	ret = clk_prepare(vt8500->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to prepare clock\n");
-		return ret;
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &vt8500->chip);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-	ret = pwmchip_add(&vt8500->chip);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip\n");
-		clk_unprepare(vt8500->clk);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, vt8500);
-	return ret;
-}
-
-static void vt8500_pwm_remove(struct platform_device *pdev)
-{
-	struct vt8500_chip *vt8500 = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&vt8500->chip);
-
-	clk_unprepare(vt8500->clk);
+	return 0;
 }
 
 static struct platform_driver vt8500_pwm_driver = {
 	.probe		= vt8500_pwm_probe,
-	.remove_new	= vt8500_pwm_remove,
 	.driver		= {
 		.name	= "vt8500-pwm",
 		.of_match_table = vt8500_pwm_dt_ids,
-- 
2.40.1

