Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0068E758474
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Jul 2023 20:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGRSTQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 18 Jul 2023 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjGRSTN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 18 Jul 2023 14:19:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D6A10F1
        for <linux-pwm@vger.kernel.org>; Tue, 18 Jul 2023 11:19:05 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHp-0001om-KE; Tue, 18 Jul 2023 20:19:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHl-000Qmy-KB; Tue, 18 Jul 2023 20:18:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qLpHk-005unv-SL; Tue, 18 Jul 2023 20:18:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 09/18] pwm: imx27: Make use of devm_pwmchip_alloc() function
Date:   Tue, 18 Jul 2023 20:18:40 +0200
Message-Id: <20230718181849.3947851-10-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
References: <20230718181849.3947851-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=quSWeWG2gIkIxByrCpyyVbIv99w1IvWiLvMunfAZG74=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkttbxCgLNv9Myk/FKQyAXAKuqOQTHw0c6TurGo GigibXh3DqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLbW8QAKCRCPgPtYfRL+ Ts7+B/wOMldvZskQTb60nNdCHOTQc2/YX6jpmqH3KK1m4rCy6ZdZcvxtgroDkmh4riHcOuozN6X +G2R/pHvQRUs3UGaUsArU97JklJf5jaonxdTlT11uDn4MEVTtcSAjizjb4YSAo9uL+dZbluE5L1 zQxqw2MGNkLP9UlvHcL5HxP5SpiWqdEijlDGNZ4W9BH/cOPMgKyEOlqeBNznxuDbCaxkiX6yy4Q 5xxPEJWWSYiC6rRvOk7zsZO7N0nbedH2oeQzyr/hGTm+zeFUOEM7YMG0YQphU4k90Wan5AbXUl6 N/y/PGgUPkS5kGahgwQ2W6YRIISAfjW6/GjdL46K0bq5LtXh
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

This prepares the pwm-imx27 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 29a3089c534c..1f64c4b5b793 100644
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
@@ -307,13 +309,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx27_chip *imx;
 	int ret;
 	u32 pwmcr;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (imx == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, sizeof(*imx));
+	if (!chip)
 		return -ENOMEM;
+	imx = pwmchip_priv(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -325,9 +329,8 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx27_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx27_ops;
+	chip->npwm = 1;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
@@ -342,7 +345,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (!(pwmcr & MX3_PWMCR_EN))
 		pwm_imx27_clk_disable_unprepare(imx);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver imx_pwm_driver = {
-- 
2.39.2

