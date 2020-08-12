Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B299242687
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Aug 2020 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHLIDL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Aug 2020 04:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHLIDL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Aug 2020 04:03:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A807C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 12 Aug 2020 01:03:10 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5liy-0007gS-Av; Wed, 12 Aug 2020 10:03:04 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1k5lix-0002wN-JJ; Wed, 12 Aug 2020 10:03:03 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: atmel: Make use of dev_err_probe()
Date:   Wed, 12 Aug 2020 10:02:59 +0200
Message-Id: <20200812080259.4431-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add an error message for failure points that currently lack a message
and convert dev_err to dev_err_probe() which does the right thing for
-EPROBE_DEFER. Also slightly simplify the error handling.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 6161e7e3e9ac..aa0b36695dc7 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -415,17 +415,18 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	atmel_pwm->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(atmel_pwm->base))
-		return PTR_ERR(atmel_pwm->base);
+		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->base),
+				     "Failed to remap register space\n");
 
 	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(atmel_pwm->clk))
-		return PTR_ERR(atmel_pwm->clk);
+		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
+				     "Failed to get clock\n");
 
 	ret = clk_prepare(atmel_pwm->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to prepare PWM clock\n");
 
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
@@ -436,17 +437,14 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&atmel_pwm->chip);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
-		goto unprepare_clk;
+		clk_unprepare(atmel_pwm->clk);
+		return dev_err_probe(&pdev->dev, ret,
+				     "Failed to add PWM chip\n");
 	}
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
-	return ret;
-
-unprepare_clk:
-	clk_unprepare(atmel_pwm->clk);
-	return ret;
+	return 0;
 }
 
 static int atmel_pwm_remove(struct platform_device *pdev)
-- 
2.27.0

