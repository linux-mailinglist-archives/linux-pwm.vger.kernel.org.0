Return-Path: <linux-pwm+bounces-1008-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9977B83C1E8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E16290920
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A4D33CC9;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3D45C1C
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184659; cv=none; b=BVf8bgUmIsbUvirb6SODfuB6O4DesnLHdnZL5Ez8ppywTkzrx/Pu6MPcVQI9RbfUBpsuwrs6dthDpfu3ehmueLrjIH2x94pwmv83dD9+B5c43o6gFyevws0a3GgqwbrMiDyUD+GHrMt1YbG4E9F6RTbhp98zyRda/krRA9mGwfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184659; c=relaxed/simple;
	bh=XNZvdNvoFWfhcTgC23QnqOOAiS5t8GlSW4OiyL8hcOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cu8/jcdVMXAGlGq86E2OPXOmgQQh9YxB5YzdrdWbYNMoJbRj04e7bW9Ofn9xDKrTicZ3KJUHTx57Tu0SgSn5sOG1EBAN3rD5HfUZfQkWP/k/crGYYmsKfZf7X89KLWa/Zfuz97Qf+9iDebwS+ZBGqLa0AzNcS4vw4e9L+VsCOck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-0004O7-U8; Thu, 25 Jan 2024 13:10:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-002HSv-Qs; Thu, 25 Jan 2024 13:10:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-007n2W-2Q;
	Thu, 25 Jan 2024 13:10:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Paul Cercueil <paul@crapouillou.net>,
	linux-pwm@vger.kernel.org
Cc: linux-mips@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v5 065/111] pwm: jz4740: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:27 +0100
Message-ID:  <2aff52f98cf953318cc533156bd0a51e77cac911.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2167; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XNZvdNvoFWfhcTgC23QnqOOAiS5t8GlSW4OiyL8hcOA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+GpS6FqJD/kVJ6RjHF1G60u0kC10BRZn8Y1 8fuf08766SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPhgAKCRCPgPtYfRL+ Tu4WB/wPKpcxPgvPwcoYrdYRp1aa0U459vyt1zLyIEfUXdOU+m1IspQsS+2+NNh/SODry0JUK0f xghpBUNJ4LnJmwCYETsSS9HaCwRM+hCCzCfSHK0i+/LhbxsSrKJBw4S/DsMg/t/IfwJrnlR71eY CBOobv5Dihi8Yomj4bb9SepqgmdmZKHB9msaDz8+6Q2u0i5ugq2BxGCZogKTqjf+N8zGV0v5jMd NTq3qfX4GoAnHvUB/KxoF7c3BF9q7amL8YunluMA0tDDW0NRy4cHp2NiTt1CN1/CAy2EJlApOw4 eqPmG3LtqVM+pwAsS8S1k9o14cEZEpP1/Jcbm16dZJTuyIHj
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


