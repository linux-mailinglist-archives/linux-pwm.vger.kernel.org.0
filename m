Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF77C72C9
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379525AbjJLQbU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379578AbjJLQbE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:04 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2978FCA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:03 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaS-000560-Jo; Thu, 12 Oct 2023 18:31:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaR-001C7x-6n; Thu, 12 Oct 2023 18:30:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-00F5Ot-Tw; Thu, 12 Oct 2023 18:30:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 042/109] pwm: atmel: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:10 +0200
Message-ID: <20231012162827.1002444-153-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UYq2sSQ1srq1cQXKD4rrxuO6dK7bAqzNfNrafRanFwo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNubs5nz+WRfpMYfIRsQnPNbt21UNI9MFtkaWsG4tYZ Xdd4dDqZDRmYWDkYpAVU2Sxb1yTaVUlF9m59t9lmEGsTCBTGLg4BWAicfXsv1m7RLmk3ZcG9Zy+ fXly1mnV0ms7Dna4rn19RO2pwIpp/3iVdt5bIPJR3K7t6wEbzk7fpPyi+o/R82rVkrnr3FnL5XJ SGyR8LZTVc1O7DhY+vfOvi+V2bGh/lte5w57u/7jZM8V/Pd3dNVvu2SmpXPWNrkI39ScsWX34FM PssI3nzi456cx5z9huZeySshv+9eesm1vevOpRclv/Pnnh5NxYmS9tehr5dSxc14/9j2cWjOgT3 KTZeUFrw6kp8/o433pGbJzIt/fSDu4z055rF3/2CzxXLMmR5fjiTLg5s4R//oSpnYsZbDbfEJX8 9D4yuXfbq8bpq1a7JXbeUZy4zFEjIW1+WHD7JBal2PglAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-atmel driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 4ef91fe6f147..673d80c79ec7 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -77,7 +77,6 @@ struct atmel_pwm_data {
 };
 
 struct atmel_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	const struct atmel_pwm_data *data;
@@ -99,7 +98,7 @@ struct atmel_pwm_chip {
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct atmel_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 atmel_pwm_readl(struct atmel_pwm_chip *chip,
@@ -473,7 +472,7 @@ static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 	if (!sr)
 		return 0;
 
-	cnt = bitmap_weight(&sr, atmel_pwm->chip.npwm);
+	cnt = bitmap_weight(&sr, chip->npwm);
 
 	if (!on)
 		goto disable_clk;
@@ -481,9 +480,8 @@ static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(pwmchip_parent(chip),
-				"failed to enable clock for pwm %pe\n",
-				ERR_PTR(ret));
+			dev_err_probe(pwmchip_parent(chip), ret,
+				"failed to enable clock for pwm\n");
 
 			cnt = i;
 			goto disable_clk;
@@ -501,12 +499,14 @@ static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 
 static int atmel_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct atmel_pwm_chip *atmel_pwm;
 	int ret;
 
-	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
-	if (!atmel_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*atmel_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	atmel_pwm = to_atmel_pwm_chip(chip);
 
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
 
@@ -522,15 +522,13 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
 				     "failed to get prepared PWM clock\n");
 
-	atmel_pwm->chip.dev = &pdev->dev;
-	atmel_pwm->chip.ops = &atmel_pwm_ops;
-	atmel_pwm->chip.npwm = 4;
+	chip->ops = &atmel_pwm_ops;
 
-	ret = atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, true);
+	ret = atmel_pwm_enable_clk_if_on(chip, true);
 	if (ret < 0)
 		return ret;
 
-	ret = devm_pwmchip_add(&pdev->dev, &atmel_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 		goto disable_clk;
@@ -539,7 +537,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, false);
+	atmel_pwm_enable_clk_if_on(chip, false);
 
 	return ret;
 }
-- 
2.42.0

