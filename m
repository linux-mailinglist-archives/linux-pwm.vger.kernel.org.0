Return-Path: <linux-pwm+bounces-1367-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69578545B5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79F651F2E0AB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9F612E6C;
	Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF71616419
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903274; cv=none; b=IE5W4eKX9hYXfPedzpoEUHLohUvn7fhL0SArgl8AQhmRTiOAt8NvAJQWRULfUR1AmP9VX0f64KG8Dl3lkluGdelLgRFtht7KRQL9s6pzzL8B8KgX/E3alPApMaGPJuiQJpcc8Ilr9iwYAnwAMpmrFiMaa4zVdaX1ljMgGXXiZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903274; c=relaxed/simple;
	bh=XNZvdNvoFWfhcTgC23QnqOOAiS5t8GlSW4OiyL8hcOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xn8mXXg+E8AldLGgZPOcYhCTUQnWhBkXmsE9wmFNmS8AiISOHSDmQCzFWrRy67YOC2Yq6JB3bYvm9lp6hljZ7/3LtkSZSZO4TQ6ZgZeOHVXmIm6R39jpLTt0ryl3qL6CmibvRz72rvqFD2/VUx4z4wpDNGVoz+iVMU3s4yQt0Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-0004tS-HS; Wed, 14 Feb 2024 10:34:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-000fCM-NR; Wed, 14 Feb 2024 10:34:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-004Y3V-25;
	Wed, 14 Feb 2024 10:34:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	linux-pwm@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 057/164] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:44 +0100
Message-ID:  <14a081c097b4e7c7f346ca6557ece8d16ad5749d.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XNZvdNvoFWfhcTgC23QnqOOAiS5t8GlSW4OiyL8hcOA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiMvb2gubr14AxRlY4WROnhR9+pwh990PEu3 j17nKIMT7qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIjAAKCRCPgPtYfRL+ ToSOCAC7NUJNUT8ejYQZtxeQRvmzeO27EqQ772FN7t4Ew0NRxCDpttq0taJ2uydpXAosXzyl4bx djV99gQrwo/ibSe/HqJPktG2Lxw4mLBvKYiKCzRKizscVW23Ho8ix3OEPwPJdIEcNexYGYNecHR eSzHv0a/o0UqeAnOWEjmAZc5ItN0r9Ggtlv+60a5PCwpqe5CWKVJjsAeAglOW9+e1hxu+XRMjg1 xVS24Icos8oGf3ITavMSPdP8BtWrzSqhxi8fFLWs3iEdKD48dVCdHQXYehmNP7trCZrmMd5MJDE b/JROeBK950/ghe20JDtzLnjq+m2kCAEpoW6kPqgQUbNjCPf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-jz4740 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-jz4740.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 4d39f61b86ff..da4bf543d357 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -25,14 +25,13 @@ struct soc_info {
 };
 
 struct jz4740_pwm_chip {
-	struct pwm_chip chip;
 	struct regmap *map;
 	struct clk *clk[];
 };
 
 static inline struct jz4740_pwm_chip *to_jz4740(struct pwm_chip *chip)
 {
-	return container_of(chip, struct jz4740_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static bool jz4740_pwm_can_use_chn(struct pwm_chip *chip, unsigned int channel)
@@ -224,6 +223,7 @@ static const struct pwm_ops jz4740_pwm_ops = {
 static int jz4740_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct jz4740_pwm_chip *jz;
 	const struct soc_info *info;
 
@@ -231,10 +231,10 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	jz = devm_kzalloc(dev, struct_size(jz, clk, info->num_pwms),
-			      GFP_KERNEL);
-	if (!jz)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, info->num_pwms, struct_size(jz, clk, info->num_pwms));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	jz = to_jz4740(chip);
 
 	jz->map = device_node_to_regmap(dev->parent->of_node);
 	if (IS_ERR(jz->map)) {
@@ -242,11 +242,9 @@ static int jz4740_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(jz->map);
 	}
 
-	jz->chip.dev = dev;
-	jz->chip.ops = &jz4740_pwm_ops;
-	jz->chip.npwm = info->num_pwms;
+	chip->ops = &jz4740_pwm_ops;
 
-	return devm_pwmchip_add(dev, &jz->chip);
+	return devm_pwmchip_add(dev, chip);
 }
 
 static const struct soc_info jz4740_soc_info = {
-- 
2.43.0


