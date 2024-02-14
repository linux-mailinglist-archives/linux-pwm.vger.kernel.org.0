Return-Path: <linux-pwm+bounces-1437-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47D3854601
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8447D1C213AA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A632913AF3;
	Wed, 14 Feb 2024 09:34:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDA1AACB
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903289; cv=none; b=UvXVkm70AJRDG8eAhNq9sbMB2biC8MJFPCeWCBvuGHjB4vgAqXgdsBDfZskK8B0+g1/uZMEoqKqpJdA5veIR3pqkETeV1HgrZiT0DTrYjF2C8Z8DFnbqnrf0yiUDk3ZWmaKf+LFFRy5F0fM3k2xB4z51/SCuwlZA2RM01HFtLZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903289; c=relaxed/simple;
	bh=Bq4gK46k4bMEHnDGw5vzMWIw4Mxs6RiMnEaOZk00EBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EIjpA4LAG4iVT+3O0V9PQy81Dke8CV+H/QRrOliwh69VnsDurTf+MG4tiDtgX0R/F9wPnTmCaOBgyNGfGxZlShKGugAqHk3BadGAQ27FgBRSm36GS5XrK3VLyA6A9NZ+M0xEYMu7i1/FfNNuPo4pM+IK11nDstuCiDUzPXEjBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-000655-Ny; Wed, 14 Feb 2024 10:34:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-000fHM-64; Wed, 14 Feb 2024 10:34:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-004Y9G-0M;
	Wed, 14 Feb 2024 10:34:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 139/164] pwm: tiehrpwm: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:06 +0100
Message-ID:  <62fbac428cae0942f8e88234bf249537fcd890a3.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1837; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Bq4gK46k4bMEHnDGw5vzMWIw4Mxs6RiMnEaOZk00EBI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjqoslzBeP8TNXalImcEEWt4Hba/B3opAwT9 f/CwIz/IIuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI6gAKCRCPgPtYfRL+ Tuj9B/4hC0WtCt47qjLaFx/C6F4T9Yf+NlwdmZstIFiGsewnldl+ciE6tP1fuOYG5H20tW26NTz sy/p7+aWKNjRHolnUYuRbjOfPMR+UYsDOA4Ft18zjG4V3iRLwxJCA7paM+qOWBsv4cBZ0KjGseU WQIY4wIMLDg4Rb3Cpb4G7aemomf7xHiENmewQheqJP5BpiCtxdb2xAkdtlU+c8WtvLl5WycRs0b +c6c9EMMTokscsiE/AvJqENQOZW2tBtVYe2Z52nYZDdbHHE9liLp4NPwwUT/K6/uQpyxEGp/4Lg nX0vG1p/FgLuYM6QYvN4GfW51AYyL7sAWr8X6Nury7Ai6lvT
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-tiecap driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 9a7c72196173..e5104725d9b7 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -105,7 +105,6 @@ struct ehrpwm_context {
 };
 
 struct ehrpwm_pwm_chip {
-	struct pwm_chip chip;
 	unsigned long clk_rate;
 	void __iomem *mmio_base;
 	unsigned long period_cycles[NUM_PWM_CHANNEL];
@@ -116,7 +115,7 @@ struct ehrpwm_pwm_chip {
 
 static inline struct ehrpwm_pwm_chip *to_ehrpwm_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ehrpwm_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u16 ehrpwm_read(void __iomem *base, unsigned int offset)
@@ -454,9 +453,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM_CHANNEL, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_ehrpwm_pwm_chip(chip);
 
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
@@ -475,10 +475,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	chip = &pc->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ehrpwm_pwm_ops;
-	chip->npwm = NUM_PWM_CHANNEL;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
-- 
2.43.0


