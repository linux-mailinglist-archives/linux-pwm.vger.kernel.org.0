Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2BB38FB04
	for <lists+linux-pwm@lfdr.de>; Tue, 25 May 2021 08:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbhEYGhM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 02:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbhEYGhM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 02:37:12 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E81DC061574
        for <linux-pwm@vger.kernel.org>; Mon, 24 May 2021 23:35:43 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llQf5-0006kr-Ku; Tue, 25 May 2021 08:35:31 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1llQf3-0002er-UN; Tue, 25 May 2021 08:35:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] pwm: imx1: Simplify using devm_pwmchip_add()
Date:   Tue, 25 May 2021 08:35:28 +0200
Message-Id: <20210525063528.947017-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210525063528.947017-1-u.kleine-koenig@pengutronix.de>
References: <20210525063528.947017-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_pwmchip_add() we can drop pwmchip_remove() from the device
remove callback. The latter can then go away, too and as this is the
only user of platform_get_drvdata(), the respective call to
platform_set_drvdata() can go, too.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

as some other patches before this depends on my patch that introduces
devm_pwmchip_add().

Best regards
Uwe

 drivers/pwm/pwm-imx1.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index e73858a8e464..bcd849496f8d 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -141,8 +141,6 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 	if (!imx)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, imx);
-
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_ipg),
@@ -161,14 +159,7 @@ static int pwm_imx1_probe(struct platform_device *pdev)
 	if (IS_ERR(imx->mmio_base))
 		return PTR_ERR(imx->mmio_base);
 
-	return pwmchip_add(&imx->chip);
-}
-
-static int pwm_imx1_remove(struct platform_device *pdev)
-{
-	struct pwm_imx1_chip *imx = platform_get_drvdata(pdev);
-
-	return pwmchip_remove(&imx->chip);
+	return devm_pwmchip_add(&pdev->dev, &imx->chip);
 }
 
 static struct platform_driver pwm_imx1_driver = {
@@ -177,7 +168,6 @@ static struct platform_driver pwm_imx1_driver = {
 		.of_match_table = pwm_imx1_dt_ids,
 	},
 	.probe = pwm_imx1_probe,
-	.remove = pwm_imx1_remove,
 };
 module_platform_driver(pwm_imx1_driver);
 
-- 
2.30.2

