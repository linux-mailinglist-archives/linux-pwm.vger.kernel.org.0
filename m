Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D01758478
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGRSTR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjGRSTP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745DE10FC
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001ov-KP; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-000Qn3-Ot; Tue, 18 Jul 2023 20:18:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-005uns-MK; Tue, 18 Jul 2023 20:18:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 08/18] pwm: imx1: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:39 +0200
Message-Id: <20230718181849.3947851-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1999; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PRX8QfuH0dt//opl4hExK+7v7pWnKJs/Z0ADGbhZ9e4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbwizvUNYgNAnG6JsL7e04Ewwq1+6Tyn2g/U 6rZv7SYY3SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW8AAKCRCPgPtYfRL+ ToKtCACoy/PhCGeZwG7CTMD+ml4qnnxger4Qm/HmvPKcrk/uGJ9dY411BU257kg083lf43soTc8 wSfRTAQdS0rXYB9114F2XnYPXq/ahDSlIeP2wNPkqaT8twTZtQHilMZ3Z8AwK4rShK2b95EkaRi zR5k+aB3AbGhd1fSHKcc3xyzAzm1NyepZRNilyZ2mrwQOyvxtqnu4j9CsAJDaaygIuoaWm+RFUE p4ZqH9GrCFD2/z3w+A9BGPNKCXPzyVpGCKgqTF7aardLhpufd4rfGRT3jz3U2FT3fJrer8G8VlO 5picX8khf3TllVicAKT1mZny672UaYp4D8Zlf7vd409yHVJY
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

This prepares the pwm-imx1 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx1.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index 1f2eb1c8ff6c..e4ecbd6a2e63 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -29,10 +29,9 @@ struct pwm_imx1_chip {
 	struct clk *clk_ipg;
 	struct clk *clk_per;
 	void __iomem *mmio_base;
-	struct pwm_chip chip;
 };
 
-#define to_pwm_imx1_chip(chip)	container_of(chip, struct pwm_imx1_chip, chip)
+#define to_pwm_imx1_chip(chip)	pwmchip_priv(chip)
 
 static int pwm_imx1_clk_prepare_enable(struct pwm_chip *chip)
 {
@@ -158,11 +157,13 @@ MODULE_DEVICE_TABLE(of, pwm_imx1_dt_ids);
 
 static int pwm_imx1_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx1_chip *imx;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (!imx)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*imx));
+	if (!chip)
 		return -ENOMEM;
+	imx = to_pwm_imx1_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -174,15 +175,14 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx1_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx1_ops;
+	chip->npwm = 1;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver pwm_imx1_driver = {
-- 
2.39.2

