Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 414067B37C0
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjI2QTc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233420AbjI2QTb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:31 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE681A4
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-0007nu-9W; Fri, 29 Sep 2023 18:19:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-009r5X-Su; Fri, 29 Sep 2023 18:19:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD4-006161-Jg; Fri, 29 Sep 2023 18:19:22 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 04/11] pwm: imx-tpm: Simplify using devm functions
Date:   Fri, 29 Sep 2023 18:19:11 +0200
Message-Id: <20230929161918.2410424-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=Vf9eLQ4D2emyuwU26S5RXcy4ATOu7LfDfnIsT7/7fjw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj4ydcpCzIU4FL/bzecaNu1wUN40R/feN6wG EXh7MeeKMGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb4+AAKCRCPgPtYfRL+ TkE4B/4rBZD9qS0/b0Vzhmr7C5ciOkr5Ge1h3xMBzTWkPcneFvrVhN0aNLz7GZs8UzslftXNxqt BgLQ/r4nCedws/xNgElcjaydd9365GA9alFL0MNgO9PPpLwpAFKjYBE7/2+9i2dftNIDZd0vXNt jvH5W+ULWbpT7TdhAASgIKZs14ARAP5/n8dFKA4lDIM78XdUKQFMz4MVypW5FSIcPg9QTiVC+iq VLCGEcelQc3MptXZ6gqX/ENg9G46zCD0dZmbbIy+okiRaSeFAgYEd2xPdmfucjI5/oD992nQsNZ EmL+rGR/pUStDj/xgIiXF+9mW1XbpC5hOSoFR6OWknqQ1V7W
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
callback is empty and can go away, too.

Also use dev_err_probe() for simplified (and improved) error reporting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx-tpm.c | 29 +++++------------------------
 1 file changed, 5 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-imx-tpm.c b/drivers/pwm/pwm-imx-tpm.c
index 98ab65c89685..3ffc89b4f3fe 100644
--- a/drivers/pwm/pwm-imx-tpm.c
+++ b/drivers/pwm/pwm-imx-tpm.c
@@ -351,18 +351,11 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 	if (IS_ERR(tpm->base))
 		return PTR_ERR(tpm->base);
 
-	tpm->clk = devm_clk_get(&pdev->dev, NULL);
+	tpm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(tpm->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(tpm->clk),
 				     "failed to get PWM clock\n");
 
-	ret = clk_prepare_enable(tpm->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"failed to prepare or enable clock: %d\n", ret);
-		return ret;
-	}
-
 	tpm->chip.dev = &pdev->dev;
 	tpm->chip.ops = &imx_tpm_pwm_ops;
 
@@ -372,22 +365,11 @@ static int pwm_imx_tpm_probe(struct platform_device *pdev)
 
 	mutex_init(&tpm->lock);
 
-	ret = pwmchip_add(&tpm->chip);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
-		clk_disable_unprepare(tpm->clk);
-	}
+	ret = devm_pwmchip_add(&pdev->dev, &tpm->chip);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-	return ret;
-}
-
-static void pwm_imx_tpm_remove(struct platform_device *pdev)
-{
-	struct imx_tpm_pwm_chip *tpm = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&tpm->chip);
-
-	clk_disable_unprepare(tpm->clk);
+	return 0;
 }
 
 static int __maybe_unused pwm_imx_tpm_suspend(struct device *dev)
@@ -437,7 +419,6 @@ static struct platform_driver imx_tpm_pwm_driver = {
 		.pm = &imx_tpm_pwm_pm,
 	},
 	.probe	= pwm_imx_tpm_probe,
-	.remove_new = pwm_imx_tpm_remove,
 };
 module_platform_driver(imx_tpm_pwm_driver);
 
-- 
2.40.1

