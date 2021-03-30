Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181EC34F0CB
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Mar 2021 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232636AbhC3SSd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Mar 2021 14:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhC3SSR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Mar 2021 14:18:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F4AC061574
        for <linux-pwm@vger.kernel.org>; Tue, 30 Mar 2021 11:18:16 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRIwK-0007hw-Sz; Tue, 30 Mar 2021 20:18:08 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lRIwI-0000Dw-IE; Tue, 30 Mar 2021 20:18:06 +0200
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
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 3/6] pwm: atmel: Simplify using devm_clk_get_prepared()
Date:   Tue, 30 Mar 2021 20:17:52 +0200
Message-Id: <20210330181755.204339-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
References: <20210330181755.204339-1-u.kleine-koenig@pengutronix.de>
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 5813339b597b..d65e23da2582 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -415,16 +415,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
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
@@ -435,23 +429,18 @@ static int atmel_pwm_probe(struct platform_device *pdev)
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
 {
 	struct atmel_pwm_chip *atmel_pwm = platform_get_drvdata(pdev);
 
-	clk_unprepare(atmel_pwm->clk);
 	mutex_destroy(&atmel_pwm->isr_lock);
 
 	return pwmchip_remove(&atmel_pwm->chip);
-- 
2.30.2

