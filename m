Return-Path: <linux-pwm+bounces-1016-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411F483C1F8
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7FD290E3A
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268CE3FE2B;
	Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF22A3C097
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184661; cv=none; b=NG/BDhYhCEYYx5bSrA0mlj8JaNnKu1p+ROnI3gZ/SGxQFVjxorklAzSx+lBJqNrnn0zxqmsCbkn6Ulxjq00n9r+f612G0detxMS+55B8m7g3Uy3l0LGt3L5moPRCgM16qLzI2yhqSWzouOiTH+CAqFsPi8EEqh7sgd9/Qk+eIKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184661; c=relaxed/simple;
	bh=nnLB39d4Dq7GESc2CH6a0ZaZkcY0XcppuPeifH9tG5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifYqPzggigi6hLOqMtNOsrgQyB/mFE8E2+PhNba/gFlb875RNQNNGZAiqI6aaoS6iHJAQsw0VWJV0d8G7cxczx9sVhbNAxAEtxwOOeOvAC/gZo8VmfeklyeYp1dvZQl4iYPFEuhmC2i0HTDSdM1HzUxwsv3TobCGtCre6xOheSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZM-0004SN-56; Thu, 25 Jan 2024 13:10:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-002HTb-0f; Thu, 25 Jan 2024 13:10:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-007n3E-31;
	Thu, 25 Jan 2024 13:10:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 076/111] pwm: ntxec: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:38 +0100
Message-ID:  <99eaade6f1b2beec375ee51f5f45139148638f86.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3506; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=nnLB39d4Dq7GESc2CH6a0ZaZkcY0XcppuPeifH9tG5w=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+TFHbYVnguuZU6OxnQJxKZlQ62HA7xQXlQu GlhFfSCth2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPkwAKCRCPgPtYfRL+ TjyfB/9QUkpWSQfagmsLxCTQcU1WggUv28P+iAhEOg8tPs+fgb3QN2h/EhD69oXKgiPwyeY5t1G 6MUg92cELZ6WGlbv7KTp0KEmfWIW6yg5aUJ4siI/+39fob0swRIjfWKB6flZLjtnGi2JGhFcCcJ t1TpgYmPMMJalDvM0volv9va73JhOImgeG4boost7Ta6H8caxybm4RHvGlArNHyeLyhtYFmkMlz LsQ9aJ8GSL56t1WpNeymxcUETcp5A3h97etXTg7YreBJW3ycHJh2WopCOJWehJeRLoey0wnAb+s 12S2+Oa8bvtg+Wwll/gwitILBT5mnXNU1t4e8curdf57BnOX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-ntxec driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ntxec.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-ntxec.c b/drivers/pwm/pwm-ntxec.c
index 78606039eda2..4cc019a0c4ef 100644
--- a/drivers/pwm/pwm-ntxec.c
+++ b/drivers/pwm/pwm-ntxec.c
@@ -25,12 +25,11 @@
 
 struct ntxec_pwm {
 	struct ntxec *ec;
-	struct pwm_chip chip;
 };
 
 static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ntxec_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 #define NTXEC_REG_AUTO_OFF_HI	0xa1
@@ -57,7 +56,7 @@ static struct ntxec_pwm *ntxec_pwm_from_chip(struct pwm_chip *chip)
 static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
 						   int period, int duty)
 {
-	struct ntxec_pwm *priv = ntxec_pwm_from_chip(chip);
+	struct ntxec *ec = ntxec_pwm_from_chip(chip)->ec;
 
 	/*
 	 * Changes to the period and duty cycle take effect as soon as the
@@ -77,13 +76,13 @@ static int ntxec_pwm_set_raw_period_and_duty_cycle(struct pwm_chip *chip,
 		{ NTXEC_REG_DUTY_LOW, ntxec_reg8(duty) },
 	};
 
-	return regmap_multi_reg_write(priv->ec->regmap, regs, ARRAY_SIZE(regs));
+	return regmap_multi_reg_write(ec->regmap, regs, ARRAY_SIZE(regs));
 }
 
 static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 			   const struct pwm_state *state)
 {
-	struct ntxec_pwm *priv = ntxec_pwm_from_chip(chip);
+	struct ntxec *ec = ntxec_pwm_from_chip(chip)->ec;
 	unsigned int period, duty;
 	int res;
 
@@ -110,18 +109,18 @@ static int ntxec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm_dev,
 		if (res)
 			return res;
 
-		res = regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
+		res = regmap_write(ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(1));
 		if (res)
 			return res;
 
 		/* Disable the auto-off timer */
-		res = regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8(0xff));
+		res = regmap_write(ec->regmap, NTXEC_REG_AUTO_OFF_HI, ntxec_reg8(0xff));
 		if (res)
 			return res;
 
-		return regmap_write(priv->ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(0xff));
+		return regmap_write(ec->regmap, NTXEC_REG_AUTO_OFF_LO, ntxec_reg8(0xff));
 	} else {
-		return regmap_write(priv->ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
+		return regmap_write(ec->regmap, NTXEC_REG_ENABLE, ntxec_reg8(0));
 	}
 }
 
@@ -135,22 +134,19 @@ static const struct pwm_ops ntxec_pwm_ops = {
 
 static int ntxec_pwm_probe(struct platform_device *pdev)
 {
-	struct ntxec *ec = dev_get_drvdata(pdev->dev.parent);
 	struct ntxec_pwm *priv;
 	struct pwm_chip *chip;
 
 	device_set_of_node_from_dev(&pdev->dev, pdev->dev.parent);
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = ntxec_pwm_from_chip(chip);
 
-	priv->ec = ec;
+	priv->ec = dev_get_drvdata(pdev->dev.parent);
 
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ntxec_pwm_ops;
-	chip->npwm = 1;
 
 	return devm_pwmchip_add(&pdev->dev, chip);
 }
-- 
2.43.0


