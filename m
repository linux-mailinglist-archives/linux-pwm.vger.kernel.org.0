Return-Path: <linux-pwm+bounces-1025-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6219C83C201
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 943961C22D84
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C396C405F9;
	Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5A745025
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184662; cv=none; b=QugEX2WET2e98aI1lomvO/xbFqIMig2sDJNING1TXJ7UFA9C0yCwJGxdra7IT5enBnNc+EKuSK/s4IOp6BOIIP9fn1QYTssfsNOWWjfLrPxFmS65TdZgkKM4dpfuBUNkfwM0SKxy4m4xQU2gkkKp0RqRBhQVzM1CunwNGVFoI/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184662; c=relaxed/simple;
	bh=VIKtQeNc28S+9vnaXLuQBIHJEpLUxSeuQo+aTe1Dpts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aWpvM5YmrUTX0iccrh5yemqsWcPPzRBtSDp2EEtyn/cTrpjlbt/NJFocgbMFg1jxpB9xfCZ0H8fSmTxrTxaPH69Ih+aIf7n5AkMt1kl1DHrO/aeN60Z9xPSnMVwkHH2BTCwVTe0UpiT6F/eUSIbJx88ExrU6DEH+Q3LMpMr2PqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-0004XN-8i; Thu, 25 Jan 2024 13:10:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-002HUJ-UP; Thu, 25 Jan 2024 13:10:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-007n40-2m;
	Thu, 25 Jan 2024 13:10:56 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Walle <mwalle@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 087/111] pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:49 +0100
Message-ID:  <eba4f163b407831e27d1de769fe3a8ef29ad1f0d.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VIKtQeNc28S+9vnaXLuQBIHJEpLUxSeuQo+aTe1Dpts=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRN/gvKl33JT0j/F6/0Mjqj4J62h5nuJIGDGUd2LZpje j3dbtueTkZjFgZGLgZZMUUW+8Y1mVZVcpGda/9dhhnEygQyhYGLUwAmEh/KwdB5eObSxYusZ77W l4/8p+RZfLy1RdpM2vBV+UT9PIcqGymFrJ1LFrnJs9RIzDUoUtZI9eYO6glVaUqLbjMxstTYcMt h7k1Vde+kRY6iAdfuzHmWrpugqmJxMpIraLEyX4z3M2m1jIfzudsmdxhOM9j96Fq18JxVIXPkLX P6+GS25SW9evf7kzLjwc7roS7nJ35U2XK1/LB4nu8NYe5p3MJ35+ZUdScWbXt/a2qrzjn1xcW99 3ZV+06cYid4b/8EqV+X/btmxT/RCdy0ybDYcUv41aiExS9KN/B87Ny9pohpZfmHk3ZxrQyLL8pb Ox/gmPB5cYS71BeB1kd1/bEVxerdm3N2vJntkzi30FAEAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sl28cpld driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 88b01ff9e460..934378d6a002 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -81,14 +81,13 @@
 	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
 
 struct sl28cpld_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 offset;
 };
 
 static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sl28cpld_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
@@ -213,9 +212,10 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = sl28cpld_pwm_from_chip(chip);
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!priv->regmap) {
@@ -231,10 +231,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the pwm_chip structure */
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
-	chip->npwm = 1;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret) {
-- 
2.43.0


