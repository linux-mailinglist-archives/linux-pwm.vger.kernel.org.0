Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5D67746A6
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbjHHS7B (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjHHS6n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C6F175DF4
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:02 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN2-000715-M7; Tue, 08 Aug 2023 19:19:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN1-00224e-Nm; Tue, 08 Aug 2023 19:19:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-00BTBb-7g; Tue, 08 Aug 2023 19:19:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 023/101] pwm: imx27: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:13 +0200
Message-Id: <20230808171931.944154-24-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RgnykwYCpMw4lp2lUTNLLcnZ9Ub/zXFAkuw7XRB7BYg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njKArUWvdxiY4KEkRLjEudhFax8rPgnlOhd5 ip8QfexE5WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4ygAKCRCPgPtYfRL+ TtooCACd11buI6v2X00UNAl7+IYih7LyuD+mmUSZIlOGBgU8GIUd4kHMUstlN+MrHHEc3b5KfO9 AI+0eQGxTgZIvLWtoMFjVutPFQ/qcr4PLMIvw3DhiuGYFP/1K/5qdWI7J+Q36u427NHOB+G0JPz YbR+1oVeQtXBYJcO/F2BAiUH6we3QQncD5NG2S2fCSrO1Fx9FUnL3fXnbEMKVwj7/kggWcokAGn jYfwxcw1AocmuvRXcDRTJbUYcecAuBg7DVLV4SopLFJ+k/lfrAXUtci5ZJ4LH0wDWJCOTpE0Drp H96gdHzNRlbmX39JvKhzVpODcgg/HCoghWle4B0NfEzAu23W
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

This prepares the pwm-imx27 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 7d9bc43f12b0..79af72fbcec3 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -83,7 +83,6 @@ struct pwm_imx27_chip {
 	struct clk	*clk_ipg;
 	struct clk	*clk_per;
 	void __iomem	*mmio_base;
-	struct pwm_chip	chip;
 
 	/*
 	 * The driver cannot read the current duty cycle from the hardware if
@@ -93,7 +92,10 @@ struct pwm_imx27_chip {
 	unsigned int duty_cycle;
 };
 
-#define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
+static inline struct pwm_imx27_chip *to_pwm_imx27_chip(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
@@ -306,13 +308,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx27_chip *imx;
 	int ret;
 	u32 pwmcr;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (imx == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = pwmchip_priv(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -324,9 +328,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx27_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
@@ -341,7 +343,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (!(pwmcr & MX3_PWMCR_EN))
 		pwm_imx27_clk_disable_unprepare(imx);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver imx_pwm_driver = {
-- 
2.40.1

