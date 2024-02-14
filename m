Return-Path: <linux-pwm+bounces-1452-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1141854611
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862681F2E109
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCD414AB8;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4681AADC
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=kOSAxIdHh96tYlgeCXu8nWXh327ZlAKa5jMwdCiCzs4WKRc0b3HK98ww6ngKwdpEmK8X0f964ESCh8Po1XM3EoTbyErduAG8Jjgx4uewJqPMujrtN06rJJNWfpIofXaFEU2s9jZ4CO9Bp0TqzRKR1KqDKKi6nXGq69aYTwPeU6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=CDg5DENx7fvJJUTQlX8qtwT+uKgrppGqalaIRu7TUN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnV44xXlLzZj4dtpQrcnB5YMCJe1x5qG20NxkpuLPwN0PMd3rBO7Fj5GWLeY4YoVtwb4itYwQCx5xTm15qdASGkkempxcIcIBlci3AaA02oe3jFhHztc6ONnzy2uzQDc1d931CTcu6hx0d8dS4k75Q4Ogr38YAPEb9RMgel5r48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf9-00067p-BJ; Wed, 14 Feb 2024 10:34:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-000fHg-UO; Wed, 14 Feb 2024 10:34:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-004Y9b-2m;
	Wed, 14 Feb 2024 10:34:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 144/164] pwm: visconti: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:11 +0100
Message-ID:  <24e779de69365686bb004742cd8f07cbda131212.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1937; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=CDg5DENx7fvJJUTQlX8qtwT+uKgrppGqalaIRu7TUN4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjwdq4+uf6XzbzYVktvkHDMdzHqqDZa1hs6b eBpbuEABn2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI8AAKCRCPgPtYfRL+ TlAJB/9vOvYOV3xw60esZZRMywJ09sW49Fc3wVXrxYVeA6Dr4wirit1dng8w6XBsrjRvzmXtds2 g/gckAYc+twR/4TMp3OJqJKka2KAu3aGRnU2hzBYydpDsTgAlYK2cOez4rTJYT3KaZ0Yhvu6UWA v2ciUH6cuSlt9B/xS3FVfrWLnLelGTJWr/Yr9YMuwGN4ZwSnyj81FiYsnZ+H+bt+TB2ouZXgteS XTH3je5v/T/w+fPg3vsbAGoJH7CAmCSDiQTtttcjYROZdNLzFwORqUJegBUx9wTrDrQkm+edHH6 bMRMvm4bhrHTYcVo2OtW+8twZZa3k3wKqiIkNx928kLpbbDe
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-visconti driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-visconti.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-visconti.c b/drivers/pwm/pwm-visconti.c
index 8d736d558122..9e55380957be 100644
--- a/drivers/pwm/pwm-visconti.c
+++ b/drivers/pwm/pwm-visconti.c
@@ -34,13 +34,12 @@
 #define PIPGM_PWMC_POLARITY_MASK	GENMASK(5, 5)
 
 struct visconti_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 };
 
 static inline struct visconti_pwm_chip *visconti_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct visconti_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int visconti_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -134,22 +133,22 @@ static const struct pwm_ops visconti_pwm_ops = {
 static int visconti_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct visconti_pwm_chip *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, 4, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = visconti_pwm_from_chip(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
 		return PTR_ERR(priv->base);
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &visconti_pwm_ops;
-	priv->chip.npwm = 4;
+	chip->ops = &visconti_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Cannot register visconti PWM\n");
 
-- 
2.43.0


