Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38D07379631
	for <lists+linux-pwm@lfdr.de>; Mon, 10 May 2021 19:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhEJRnK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 May 2021 13:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhEJRnH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 May 2021 13:43:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CECADC06175F
        for <linux-pwm@vger.kernel.org>; Mon, 10 May 2021 10:42:01 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9ug-0005HK-FT; Mon, 10 May 2021 19:41:50 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lg9uf-0006aZ-P3; Mon, 10 May 2021 19:41:49 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-clk@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@pengutronix.de, linux-pwm@vger.kernel.org
Subject: [PATCH v7 3/6] pwm: atmel: Simplify using devm_clk_get_prepared()
Date:   Mon, 10 May 2021 19:41:39 +0200
Message-Id: <20210510174142.986250-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
References: <20210510174142.986250-1-u.kleine-koenig@pengutronix.de>
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

With devm_clk_get_prepared() caring to unprepare the clock the error
path and remove callback can be simplified accordingly.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 29b5ad03f715..d08d389c90b3 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -424,16 +424,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(atmel_pwm->base))
 		return PTR_ERR(atmel_pwm->base);
 
-	atmel_pwm->clk = devm_clk_get(&pdev->dev, NULL);
+	atmel_pwm->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(atmel_pwm->clk))
 		return PTR_ERR(atmel_pwm->clk);
 
-	ret = clk_prepare(atmel_pwm->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to prepare PWM clock\n");
-		return ret;
-	}
-
 	atmel_pwm->chip.dev = &pdev->dev;
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.of_xlate = of_pwm_xlate_with_flags;
@@ -443,16 +437,12 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	ret = pwmchip_add(&atmel_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip %d\n", ret);
-		goto unprepare_clk;
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, atmel_pwm);
 
 	return ret;
-
-unprepare_clk:
-	clk_unprepare(atmel_pwm->clk);
-	return ret;
 }
 
 static int atmel_pwm_remove(struct platform_device *pdev)
@@ -461,7 +451,6 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 
 	pwmchip_remove(&atmel_pwm->chip);
 
-	clk_unprepare(atmel_pwm->clk);
 	mutex_destroy(&atmel_pwm->isr_lock);
 
 	return 0;
-- 
2.30.2

