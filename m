Return-Path: <linux-pwm+bounces-987-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A08083C1D2
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFF911C22BF9
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6A645037;
	Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2828374F5
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184654; cv=none; b=aP6OFwccnC8IZcUDtg1t9gkmqZYfMn0aJNWvZ0Fm49bA70bnbJQZoGBLyiRlvzH4HYo1N8AYjt1ZdKzebec6IWGGOt1MekEnQ/uTe70DO3+/R6xsva/ZGP2V5pVUJBelmQ2CuVcSiwzfLmRYeA1OySFKAYVcZ0UxwIR/DFZ1ys0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184654; c=relaxed/simple;
	bh=gyrgGlXTWMnebiB+hz+WH9nrN2SBwKfFMXH7r00+5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NaoVsnc27DLMsPYieXkcwtRkTzvAdg7pNG1r++TI1aCup4GacsSZvhNoMAQib78Hs3UB/ibs3vJQJSL9T+lYsJz9hSFdkjechAPp4fR8AI7GhNbktsWcwRUCHjxa56lVuH8okGwaxWZmP5XbrGZhAN5mRbdk8YN0n6Ac9GruYO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-0004Is-1u; Thu, 25 Jan 2024 13:10:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-002HS3-DA; Thu, 25 Jan 2024 13:10:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-007n1b-14;
	Thu, 25 Jan 2024 13:10:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shiyan <shc_work@mail.ru>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 052/111] pwm: clps711x: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:14 +0100
Message-ID:  <b8961cbf198100a0e0814b16d15cc9175f7c4976.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gyrgGlXTWMnebiB+hz+WH9nrN2SBwKfFMXH7r00+5dc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk93mtoZRyWudm1BUXmc9BtNwlBmywQ1/B3Jz HCnQsCwdWuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPdwAKCRCPgPtYfRL+ TnWNB/4mmUjrRAHYVj0jSHnjtG2K8vmGaLx/+qfdqceud8IEQ2EvNaBDAZ/RKtEjiByyUVDllEZ nuAnrG26Z+5RaOZ3gCT5DNu6aYyL17xrTNRFCXoc5rd3effrQkEBIHLXDbP6lE1Npy9M4fK6LAZ DMWt1P/ok1CLWikaCzMTH8wuWt2H0DiMyR3H6OiVdQYIc/4pf4JxgOVEKgV4TmF5fNOhyQ1egAO aX9Pbx0LtIW0Fg9pA//la30KlgS3C7h+J6K3K45ra6Ki54NKJaUYcWpB9Er7SZq4FEaDfGdWay6 A83vCJqh/mCsizIuZSRR4kjw7pdzyAMHU3+HFHO3ScjKg2dN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-clps711x driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clps711x.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index f3b4af7963be..c950e1dbd2b8 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -12,7 +12,6 @@
 #include <linux/pwm.h>
 
 struct clps711x_chip {
-	struct pwm_chip chip;
 	void __iomem *pmpcon;
 	struct clk *clk;
 	spinlock_t lock;
@@ -20,7 +19,7 @@ struct clps711x_chip {
 
 static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct clps711x_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -76,11 +75,13 @@ static const struct pwm_ops clps711x_pwm_ops = {
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct clps711x_chip *priv;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_clps711x_chip(chip);
 
 	priv->pmpcon = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->pmpcon))
@@ -90,13 +91,11 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	priv->chip.ops = &clps711x_pwm_ops;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.npwm = 2;
+	chip->ops = &clps711x_pwm_ops;
 
 	spin_lock_init(&priv->lock);
 
-	return devm_pwmchip_add(&pdev->dev, &priv->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
-- 
2.43.0


