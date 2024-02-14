Return-Path: <linux-pwm+bounces-1342-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C598545A7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73F9EB2262C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7104D18AF4;
	Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAB414004
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903269; cv=none; b=ntJbkf9h9l4wbTq41phAC1W9neqHU5tLkJJ8H6ts3KkoWAu2JgTIqxGhOkDx/m3yA6DHsRId+9Rs+6BxbzVb2q05XJ1wwWJ/GZq1QHLlO11o1TJL8x5wf7khguNpFS+Q6PRbuXTWySZYWogwDaz4HkTCcukBcO/parnUfQbkeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903269; c=relaxed/simple;
	bh=LhbTElevK1SEGlAvvQGicYhtRcwh3998mK2KCzfbR+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBN7+ilLYeEaS5/GQGcW27zr49PM4HaR+MayewSbHw158YipSbjvCnFN2Qp92WqbosrXcJkj6aPan3lUA0unucNIwR+ht1S4Yioc6W6VvhTod8oXteAB35OQ4sWQBmaa6Wmu8dMg8WihfVp66rhMjk1Ht7zesBG7wZZLEDufVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004fd-KY; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBF-3U; Wed, 14 Feb 2024 10:34:24 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2P-06;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 040/164] pwm: fsl-ftm: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:27 +0100
Message-ID:  <b3c75dea5b2944402b14944fdf71a5db0e26cbd7.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1839; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=LhbTElevK1SEGlAvvQGicYhtRcwh3998mK2KCzfbR+M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh4RiJgroax8c5bvsigfriiga7rIQMs7hUrk kWYZRX9FoCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIeAAKCRCPgPtYfRL+ Tk5xCACeVcp+P2yNnM6jAPJLq0kPJ7eN5VTsNGYQEaa7iefGRX8igUdX2aJZZSt9ct0tV/Pmf7u w53eHniH34CX5C5fz/LML1kOxLpQjcYIe0mx9ffnPFG5iJGlvpwJVEnhPsyzlXPmcs/d30vDtWu WJ++szGgMkg26Jezsz9mJy8Ue8ciYzxz20gDtuSkj9TlOp5a/J+ZFMqqzLDtgEanr1aI5JPgGD3 xFlS8ekAIKB7CUH9pmrylTkqF9n+JMVeC78RBM5GK63m28penXyYTT7gj8R2F1IU3/7RozSMcAq HdMRL2DCiDYW7loRWoyAP+CfnURRYZtFbcnaJKmVhjQQt92X
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-fsl-ftm driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index b4f8dff60c50..2510c10ca473 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -40,7 +40,6 @@ struct fsl_pwm_periodcfg {
 };
 
 struct fsl_pwm_chip {
-	struct pwm_chip chip;
 	struct mutex lock;
 	struct regmap *regmap;
 
@@ -55,7 +54,7 @@ struct fsl_pwm_chip {
 
 static inline struct fsl_pwm_chip *to_fsl_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct fsl_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void ftm_clear_write_protection(struct fsl_pwm_chip *fpc)
@@ -398,15 +397,14 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	void __iomem *base;
 	int ret;
 
-	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
-	if (!fpc)
-		return -ENOMEM;
-	chip = &fpc->chip;
+	chip = devm_pwmchip_alloc(&pdev->dev, 8, sizeof(*fpc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	fpc = to_fsl_chip(chip);
 
 	mutex_init(&fpc->lock);
 
 	fpc->soc = of_device_get_match_data(&pdev->dev);
-	chip->dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -446,9 +444,7 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(fpc->ipg_clk))
 		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
 
-
 	chip->ops = &fsl_pwm_ops;
-	chip->npwm = 8;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
-- 
2.43.0


