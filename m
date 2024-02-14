Return-Path: <linux-pwm+bounces-1326-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5A5854587
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D53F1C21A9B
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB491758D;
	Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B191757A
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=qRjqlbquTsZfTcyFbYrgRmcROM1iuAa2ACrSx8e/EadpBBKAsheZ6UJdjnLPEdPOSLHE8o1Ycb6+1p0XZPxseQ0h/PGPE0Z5U5Fso9IBc9SvjP3J0RrSaNErZKA37RQ0tutQMMbrY3Y4Ot6vLUGE4Xx/2cyI3lHovfwALFfqVGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=a/oPV7jA+XRSFfuYa8Te7aDSBlzQr4lMUCddipHmYqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oI6/glHTRCxEOOT6LVkztcWkIW+qZDiW9EPYmZ2Ws8rxankg6UkA3/RufDYZcx3DOgIg8CpZxVLqt7d73OJoEcvkxeDF7NGcjWECiNJ9qTe/JnMIqKb6Q+GDZ5T4OZlDb/jetLn0jALwntFxd8ocgwuNtApnfyugfYJ+WOyPqO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-0004Ov-OO; Wed, 14 Feb 2024 10:34:19 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-000f7L-BI; Wed, 14 Feb 2024 10:34:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBel-004Y0J-0s;
	Wed, 14 Feb 2024 10:34:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 010/164] pwm: atmel: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:30:57 +0100
Message-ID:  <f2a83af5660de461b4dcaf76929e9813bddfeff1.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1892; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=a/oPV7jA+XRSFfuYa8Te7aDSBlzQr4lMUCddipHmYqg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhWdKgDRAwFWJ7oj7uKs2oJcSqn6/LEno4MN 8aYJ1orAzOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIVgAKCRCPgPtYfRL+ ThtPCACTzWajUNiVOexvOXLVZzKMuIHhdUIy7xFYY0SE9HdgzKYeIlE7e4j7afKzl79vG3aomIU exqW07VVZogOGmYa0RmnpdGCYfWMv1W/XFHB0nyOpk3pCwCLCz43AqC3ay0mZkZqWtRR/mXL6JF EiEmOBuy2zpkQrjl51HEr30msvT+56qX0AjBbgOG9LpqXdev+85yCTvlICsyUfD+B6qshqCUBNd 0mIzvWvOcR4zoxm9zV4MdTfrNuktoWpjh0dTs9E0IIZ6igre1VShkkmHQThJbkNyt4gO+dw8D9z RvbbPtFKx3onlqefNCJyVYc3H4M7k5m8TLWCm4Q9VXyt4aOS
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
 drivers/pwm/pwm-atmel.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 96e1676a5c51..bfb408804d6a 100644
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
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 atmel_pwm_readl(struct atmel_pwm_chip *chip,
@@ -505,10 +504,11 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	struct pwm_chip *chip;
 	int ret;
 
-	atmel_pwm = devm_kzalloc(&pdev->dev, sizeof(*atmel_pwm), GFP_KERNEL);
-	if (!atmel_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 4, sizeof(*atmel_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
 
+	atmel_pwm = to_atmel_pwm_chip(chip);
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
 
 	atmel_pwm->update_pending = 0;
@@ -523,10 +523,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(atmel_pwm->clk),
 				     "failed to get prepared PWM clock\n");
 
-	chip = &atmel_pwm->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &atmel_pwm_ops;
-	chip->npwm = 4;
 
 	ret = atmel_pwm_enable_clk_if_on(chip, true);
 	if (ret < 0)
-- 
2.43.0


