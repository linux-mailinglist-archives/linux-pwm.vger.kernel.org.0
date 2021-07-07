Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B733BECEC
	for <lists+linux-pwm@lfdr.de>; Wed,  7 Jul 2021 19:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhGGRUi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 7 Jul 2021 13:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbhGGRUi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 7 Jul 2021 13:20:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0635DC06175F
        for <linux-pwm@vger.kernel.org>; Wed,  7 Jul 2021 10:17:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1BBM-0002Rd-03; Wed, 07 Jul 2021 19:17:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1AkP-0002f6-Sg; Wed, 07 Jul 2021 18:50:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m1APj-0006IL-4A; Wed, 07 Jul 2021 18:28:43 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 16/47] pwm: imx27: Simplify using devm_pwmchip_add()
Date:   Wed,  7 Jul 2021 18:28:04 +0200
Message-Id: <20210707162835.1772882-17-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
References: <20210707162835.1772882-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This allows to drop the platform_driver's remove function. This is the
only user of driver data so this can go away, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index f6588a96fbd9..ea91a2f81a9f 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -313,8 +313,6 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (imx == NULL)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, imx);
-
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
@@ -342,16 +340,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (!(pwmcr & MX3_PWMCR_EN))
 		pwm_imx27_clk_disable_unprepare(imx);
 
-	return pwmchip_add(&imx->chip);
-}
-
-static int pwm_imx27_remove(struct platform_device *pdev)
-{
-	struct pwm_imx27_chip *imx;
-
-	imx = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&imx->chip);
+	return devm_pwmchip_add(&pdev->dev, &imx->chip);
 }
 
 static struct platform_driver imx_pwm_driver = {
@@ -360,7 +349,6 @@ static struct platform_driver imx_pwm_driver = {
 		.of_match_table = pwm_imx27_dt_ids,
 	},
 	.probe = pwm_imx27_probe,
-	.remove = pwm_imx27_remove,
 };
 module_platform_driver(imx_pwm_driver);
 
-- 
2.30.2

