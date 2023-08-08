Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C61D7746AC
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjHHS7D (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjHHS6q (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:46 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36F9175DE9
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-0006zJ-S8; Tue, 08 Aug 2023 19:19:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00224Q-7Z; Tue, 08 Aug 2023 19:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-00BTBY-1k; Tue, 08 Aug 2023 19:19:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 022/101] pwm: imx1: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:12 +0200
Message-Id: <20230808171931.944154-23-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2017; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=4gOJM5IBrpLIkLxj5Bh69owmlQl9Bs/nvKKHorq4In0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njJS/AJduh1vICieGvKJ4jqo2KYzcBc+GgLo SnU7k296gKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4yQAKCRCPgPtYfRL+ TiRLCACRfs2LUE0G8ygWoy8yOrdkjKKRFzITjTts0pq6xQq95yE+VFtWiWW39Ca13e1kHYrrynl LjKa9HJk7yg5qIpNWqhVlbfrI0IqNcAZX8N4q5DgEMa8RMtMKk/0HliZP9vUycNAqno9RPeKsT5 HFuMLcRFR1DSnFcw63+RiifgQOusSTbNMr3D5I8JAPg8MQP3i8NCGEqqtXxklrGCuGF7mZ3FZJp FcuRjUKYgfBYRrFuYfhZxgixLcbxAlTkFQxy6xLLRcShBlXRvhnB6rdLaaLKKYc7FNc8P6AtAZC YIN+vQp1NMOt29cm8YEe11bh0P+s7AblOY4AihvAI0GDoT48
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-imx1 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx1.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index d175d895f22a..e4cf6e957b63 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -28,10 +28,9 @@ struct pwm_imx1_chip {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	void __iomem *mmio_base;
-	struct pwm_chip chip;
 };
 
-#define to_pwm_imx1_chip(chip)	container_of(chip, struct pwm_imx1_chip, chip)
+#define to_pwm_imx1_chip(chip)	pwmchip_priv(chip)
 
 static int pwm_imx1_clk_prepare_enable(struct pwm_chip *chip)
 {
@@ -156,11 +155,13 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx1_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (!imx)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = to_pwm_imx1_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -172,15 +173,13 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx1_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx1_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver pwm_imx1_driver = {
-- 
2.40.1

