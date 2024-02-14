Return-Path: <linux-pwm+bounces-1325-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45967854584
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78A7F1C21F9F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EF4A18057;
	Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCC18028
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=BtCbVAfYCeP/MIgVQokqua64Qu5WpUMzntxkVHLiyZn1qbkoZIowrwpV22q89sXC45PpdfCatjzXNGAdzz0Lvpjl6puCGf6t7OgVFHWqNPsQpnbeA8hAoNRIhQezbCtUR7ASx0e2W3H2qcHTVRgC2YlAyyw1OVynTDRfEhIOP7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=H2gBKJqPhxEH02LxqBcE7cgJijeXYph95OqB+mGaqEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+5TqlNNK3RNIf63Vq8zJ4yYjSw1RSM8W+8Qb4c68S7/XLyGBiL0tmD+Ev6eL8/vpOyE10/9GkMrjYMwbsKsHwrhzIFTFK6uk5qxm+VxMiwHmZolxJ97jfJu+32kock6bGxU67pUeYkFE/zHGqznKjmi3+ABg20ZGuTQx3SuvIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-0004OZ-BQ; Wed, 14 Feb 2024 10:34:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-000f6n-Sl; Wed, 14 Feb 2024 10:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-004Y07-2b;
	Wed, 14 Feb 2024 10:34:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	linux-pwm@vger.kernel.org
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 007/164] pwm: apple: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:30:54 +0100
Message-ID:  <34cf20a82ca07bb4ec0578b193daa5caed37825e.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=H2gBKJqPhxEH02LxqBcE7cgJijeXYph95OqB+mGaqEU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhS+MJ39Sqrsto1kA5NlX83PDmaY2icjOsha rLePYYgEuKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIUgAKCRCPgPtYfRL+ TneTB/9Uu3TN3IUSipI7OGzVG7GRlfSeOty7pM8L2m3CkkdsACKFIGn2/OqPg4/it9WNlXHzCK1 4hbCuPBrAvkLlzw/5o4/66SHgVvViFkF8Q41a1+6yO60Yua/r95OiPrMNiu4IOdWN85hkWJwdPt qy89+JAJelGvF5G7hkyhy22EzogTtNX43qMx3bk4NOFn7UyqosvkMTaxyANy0pfIHUIs9auE03O J6qy8nt2OBG5qQrGjDJdQ33WfLFDoGy1eJYyn0ZAnfSAZUFa16EpoOhqNm6+PhjJnZkH1pOkcJw 77l5KXK5VLpXv9VCgYbqka2SZcEgDN7WliWU8Ov+VnwdvNuq
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-apple driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-apple.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
index 4d755b628d9e..6e58aca2f13c 100644
--- a/drivers/pwm/pwm-apple.c
+++ b/drivers/pwm/pwm-apple.c
@@ -32,14 +32,13 @@
 #define APPLE_PWM_CTRL_OUTPUT_ENABLE BIT(14)
 
 struct apple_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	u64 clkrate;
 };
 
 static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct apple_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -103,13 +102,16 @@ static const struct pwm_ops apple_pwm_ops = {
 
 static int apple_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct apple_pwm *fpwm;
 	struct clk *clk;
 	int ret;
 
-	fpwm = devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
-	if (!fpwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*fpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	fpwm = to_apple_pwm(chip);
 
 	fpwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fpwm->base))
@@ -129,11 +131,9 @@ static int apple_pwm_probe(struct platform_device *pdev)
 	if (fpwm->clkrate > NSEC_PER_SEC)
 		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
 
-	fpwm->chip.dev = &pdev->dev;
-	fpwm->chip.npwm = 1;
-	fpwm->chip.ops = &apple_pwm_ops;
+	chip->ops = &apple_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
 
-- 
2.43.0


