Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C1A4D869A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Mar 2022 15:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242241AbiCNOSZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Mar 2022 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242228AbiCNOSY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Mar 2022 10:18:24 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6DB1A395
        for <linux-pwm@vger.kernel.org>; Mon, 14 Mar 2022 07:17:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVN-00053b-JU; Mon, 14 Mar 2022 15:17:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVN-000f3Y-UA; Mon, 14 Mar 2022 15:17:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nTlVL-0097bI-CW; Mon, 14 Mar 2022 15:16:59 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-clk@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>
Subject: [PATCH v8 12/16] pwm: atmel: Simplify using devm_clk_get_prepared()
Date:   Mon, 14 Mar 2022 15:16:39 +0100
Message-Id: <20220314141643.22184-13-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
References: <20220314141643.22184-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1792; i=uwe@kleine-koenig.org; h=from:subject; bh=F+lsIvR0WcqPrEshBFzqfFli6sCNnJ0t7gDZjmtwGG8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiL04SR1DLwD9vJWqdeT3nSamG8lGxE8Z3d01WVuU8 78E3QAGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYi9OEgAKCRDB/BR4rcrsCeFkB/ 99NpD4xxD2/hFjxLXsJvKVGQ+7cs5yDxyA5fWIr9CNNtbv/AcvwVKKSbsQ5n4Jgjmw7tokU00WPTpd 8hXrue8l3CF5SxbummHWudih7SVy1B0iYSrfffGotlAhWHpnhMEBeZiUuWyMTyESwhfh5TE1gFtmY4 C184Vio6aO1yzTeU04D2D3xA7VTtE60QB/TH4+fjrtsc0UhPvRhvIIDOMHdPRmHsLQgqT1bx9L6qo9 +7WDab4j9Q0QTRvjNfJQYzBMyDgxadfcjaFpQIAgKEXjORS/YFbycq3LyWHuI4DHoZD/lmekGB4IBQ duX7GR/SNQO9hv1LUoZMbcP73wXF9A
X-Developer-Key: i=uwe@kleine-koenig.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With devm_clk_get_prepared() caring to unprepare the clock the error
path and remove callback can be simplified accordingly.

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 98b34ea9f38e..309c31e40ce4 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -480,16 +480,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
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
 	atmel_pwm->chip.npwm = 4;
@@ -497,16 +491,12 @@ static int atmel_pwm_probe(struct platform_device *pdev)
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
@@ -515,8 +505,6 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 
 	pwmchip_remove(&atmel_pwm->chip);
 
-	clk_unprepare(atmel_pwm->clk);
-
 	return 0;
 }
 
-- 
2.35.1

