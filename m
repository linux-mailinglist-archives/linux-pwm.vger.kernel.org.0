Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F22157B37BC
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Sep 2023 18:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjI2QTc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 29 Sep 2023 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjI2QT3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 29 Sep 2023 12:19:29 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B951B3
        for <linux-pwm@vger.kernel.org>; Fri, 29 Sep 2023 09:19:27 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD6-0007p1-5y; Fri, 29 Sep 2023 18:19:24 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-009r5o-PV; Fri, 29 Sep 2023 18:19:23 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qmGD5-00616H-GN; Fri, 29 Sep 2023 18:19:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 08/11] pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_probe()
Date:   Fri, 29 Sep 2023 18:19:15 +0200
Message-Id: <20230929161918.2410424-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
References: <20230929161918.2410424-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2012; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=eGQaFPI1j5OM4Vw9Y+9vM8ImfPUlpuzgkeUWjXyAfrc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlFvj9IxUvSaOJ5uLH7AXCFqaJ/kuVQqNi01cQl UXjhrEz9OSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZRb4/QAKCRCPgPtYfRL+ Tr0iCACyhG9SRQ/Fcacfx4dX0iVqvVErC9VB2kQRmSk/+XDXTgv0eOpDWqqekWV83Pcj6evoW1Z WVrJP4URh5VvA44eQ1MJIdXE9yUZzhgZSrB0Z0MDUhgE1chWypa416YlqZ68cXcRZNSlcIcBbEd AfW4jEpxeW+rtBLQaEitzc0jzDGM9W3nWtA4trkLpdDrlo0qQaZznMIr4S7/0McNepKICq1Ork2 ApXMPaVG0qdP0JR8ioqFSX72iGMFc4p0UHvvQ6YNRNgf1NFGLZ3gTZxMMo4V/nnDu5r/5ohWi0E ufSzdLUf/9xjoqn9EBHDovlHTTSy482wjKpcOZJx3JC0OpxU
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

Using devm_pwmchip_add() allows to drop pwmchip_remove() from the remove
function which makes this function empty. Then there is no user of
drvdata left and platform_set_drvdata() can be dropped, too.

Further simplify and improve error returning using dev_err_probe().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index a3020bf164c8..42bd9608bc1e 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -243,10 +243,8 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
 		chn->clk_rate = clk_get_rate(clk_pwm);
 	}
 
-	if (!i) {
-		dev_err(spc->dev, "no available PWM channels\n");
-		return -ENODEV;
-	}
+	if (!i)
+		return dev_err_probe(spc->dev, -ENODEV, "no available PWM channels\n");
 
 	spc->num_pwms = i;
 
@@ -267,7 +265,6 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(spc->base);
 
 	spc->dev = &pdev->dev;
-	platform_set_drvdata(pdev, spc);
 
 	ret = sprd_pwm_clk_init(spc);
 	if (ret)
@@ -277,20 +274,13 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 	spc->chip.ops = &sprd_pwm_ops;
 	spc->chip.npwm = spc->num_pwms;
 
-	ret = pwmchip_add(&spc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, &spc->chip);
 	if (ret)
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
 
 	return ret;
 }
 
-static void sprd_pwm_remove(struct platform_device *pdev)
-{
-	struct sprd_pwm_chip *spc = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&spc->chip);
-}
-
 static const struct of_device_id sprd_pwm_of_match[] = {
 	{ .compatible = "sprd,ums512-pwm", },
 	{ },
@@ -303,7 +293,6 @@ static struct platform_driver sprd_pwm_driver = {
 		.of_match_table = sprd_pwm_of_match,
 	},
 	.probe = sprd_pwm_probe,
-	.remove_new = sprd_pwm_remove,
 };
 
 module_platform_driver(sprd_pwm_driver);
-- 
2.40.1

