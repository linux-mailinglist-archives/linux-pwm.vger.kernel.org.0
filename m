Return-Path: <linux-pwm+bounces-1443-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184F9854605
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAAE528A8B9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A9714004;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0D199BC
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903290; cv=none; b=J0Su3Sv+5UT9J5eRF7lvOG2rVj/amoSHl+/oqJZSCQUPGJif1zg0ncHik0/5Na4j6fPeq5nsQ9QjoyjIX2P6gOgMNIyvc6eEZ23Q2misn4QWruIbZUCE9G4wwK1IJgmuGNQEJgeDh/IbQUozazAvV2oPQWCPyi1dSS+PIq0lnZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903290; c=relaxed/simple;
	bh=DhwVfYK3PSVBUzZ2FBq5DeLipOrGjyXL7mQwfO9Ate8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O/lw8vzTa/51vK4ufr9dtQ8RgeEWBGZksKEi4w22122sLss1drZe1M8anvq5r2g8rmfG/TjuXG6l4iAoz6Gm+5O0XPGTOQOiwmfYUoxC38HsuBX4+S2/JWJUDigH9D4EZfq+tTrNh+mpB+PAyC/mQ8gNFOpdad7vpB4xl0VgwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005nZ-SR; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fG6-57; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-004Y7p-0H;
	Wed, 14 Feb 2024 10:34:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 119/164] pwm: stm32-lp: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:46 +0100
Message-ID:  <df47d1aff9b529c9a4762b6ba339a18cecba1497.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=DhwVfYK3PSVBUzZ2FBq5DeLipOrGjyXL7mQwfO9Ate8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjTLu8CxBTkFi4qgs8ztGE1w3A0T1K4W9gN1 Cf6LJm4zEqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI0wAKCRCPgPtYfRL+ TqylCACvPMxKFHFT15Jn4qEunBjFxMOoreUu6c1bQn0YeYAJE92+RJJrGaq/H5m8Y0oJXkRh2ah 0+tWpqd9Xo6AjXK/turnQ8KpIxTiPKZ0zIJBhKDCuXZ118TeLWjZ08AAvpm4FbtCyA3ehpVcQCr kLW4ZH/C1bcX15IpZ/LLZuiR8l9qokNWcYjWsQe76+6QxYDScfEBhbg2+tfsxN6YF2YAr6grLSK 2oqEdkFkyO9R4cYl+h5cdgo5vwWfA7SpxOEMAPQCY/Fp5RWPrxcXxIw41dr4+2twuCUAKnQD/BH zp1n2M7sNTgMEJrpoDvsmd429z1jC8PkbYGENujrDOBBC/hN
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct stm32_pwm_lp. Use the pwm_chip as driver
data instead of the stm32_pwm_lp to get access to the pwm_chip in
stm32_pwm_lp_suspend() without using priv->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index bbab6be314a8..b46d8193dd0f 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -197,6 +197,7 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 {
 	struct stm32_lptimer *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct stm32_pwm_lp *priv;
+	struct pwm_chip *chip;
 	int ret;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
@@ -205,28 +206,29 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.ops = &stm32_pwm_lp_ops;
-	priv->chip.npwm = 1;
+	chip = &priv->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &stm32_pwm_lp_ops;
+	chip->npwm = 1;
 
-	ret = devm_pwmchip_add(&pdev->dev, &priv->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return ret;
 
-	platform_set_drvdata(pdev, priv);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static int stm32_pwm_lp_suspend(struct device *dev)
 {
-	struct stm32_pwm_lp *priv = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	struct pwm_state state;
 
-	pwm_get_state(&priv->chip.pwms[0], &state);
+	pwm_get_state(&chip->pwms[0], &state);
 	if (state.enabled) {
 		dev_err(dev, "The consumer didn't stop us (%s)\n",
-			priv->chip.pwms[0].label);
+			chip->pwms[0].label);
 		return -EBUSY;
 	}
 
-- 
2.43.0


