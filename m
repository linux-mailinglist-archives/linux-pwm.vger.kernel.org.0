Return-Path: <linux-pwm+bounces-45-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895C47F2F7B
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9CA1C2186E
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09A8E53812;
	Tue, 21 Nov 2023 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C5E10D3
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:57 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-0005Qz-Fk; Tue, 21 Nov 2023 14:51:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-00Aaz0-27; Tue, 21 Nov 2023 14:51:53 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-004xdV-P6; Tue, 21 Nov 2023 14:51:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Thierry Reding <thierry.reding@gmail.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 041/108] pwm: atmel: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:43 +0100
Message-ID: <20231121134901.208535-42-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3190; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=UYq2sSQ1srq1cQXKD4rrxuO6dK7bAqzNfNrafRanFwo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV5bPPxdllMlAJMFDxXbTbW1UgSFeDbFKUFs XIFHbrUCCqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1eQAKCRCPgPtYfRL+ Tuq7CAC03fltAbfsRFKC7N5Y8FlZM9Vt2iv9L4NU6jWkmOe3bVdQTi0jsJ5CRePQtGnX0IbUlu7 0ZLA81ieT4NFgvez9TNhpFWqesqL7dUTJa8+mYE6qv5j8AQCX5+pi++dksTcDjlyoj6BDgyWipw 82FlONDwU2ZPhsb2BEEE0ZHoQI0ws2XhbplqL5rO2r2oGFAZUkcIYM0i9FEOx0jlDbtvkYs9Cz3 5sXil6WFlLx4nYUpkjrSfzHsHi1mQIg4XoVV86w1nB3AklWL8aYGZtPgOoXsU+ByFqTXnNzAoRo 6EtZgQbHx2XJT0y7haGoJRiGbMaXOu4h3LN/pDX6PYH+o88O
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

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


