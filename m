Return-Path: <linux-pwm+bounces-1435-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0008E8545FD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02D528A7C9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7205EBE5B;
	Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A991A701
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903289; cv=none; b=HyawjskA+WmxZmHiGbCHE65ILhxJtOdi6LPUXWr554Db0OfgGIyBzx1nI2j7uNyblrITfDCkqZ+60G4727NkmrZNF2u0PealxbnrhlWWYyi29sI7lnImAeEhXFIN1lUb5GhO+k4geo//bPbOdrvXuZbS5XZAwYgv/EQ2ogbvjYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903289; c=relaxed/simple;
	bh=wTHot0rCpWKiBWRtIdmgUzbIiXlsK2MsHRkggFr4Eu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PH+O8Pfh+QFmAEhIA4v/WyL0Kp7BOCEbNfsHF9djB6hRZOnLluKJnejCd4tJcyMXAX2XxsfAQiYBygN1ff0opVfIrK52FrKJKH9pldkSpHOWy1QRVh1hfBxXhX05yrIiK1nftrg0Sw4ZOgkBEGK7Oby5LH8ACnCoYhaAnEVAE+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005pL-H8; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fGD-FG; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-004Y7x-1G;
	Wed, 14 Feb 2024 10:34:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 121/164] pwm: stm32-lp: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:48 +0100
Message-ID:  <04af7b3d00bc932dd025200a3bf74527c29ca47a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1583; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=wTHot0rCpWKiBWRtIdmgUzbIiXlsK2MsHRkggFr4Eu0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjWfsROWMer2NPaGM8yPEtjhSeNg1XRlolg8 AWibishgfCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI1gAKCRCPgPtYfRL+ TgWUB/4y5vvEIFNjKDCx+K+e0lnQAquLBXIOyrCvlRTM8vqRsMv7KoBhHJvLFg8qouNbV+kYFf5 1UB3e+nPKQf26XZrNHZxD9C2PliRnTkH8SghTrdTQ6Ch/up7RgLTJBDgYZcFxJkX81Hpg68FpQY uVw981KCUCJUR6ZWuF/Yx2SmpJ/9lm/RL2n6pBYIzJdOh4dtn+7MmHWSP5Y+5WDw170r7feOlYG tLwXdqBrA7ehW28wQN6bGwBpLj3XJXMC2MPMzdqQ9Xm0SAIB++IE8rqaj7gyTtP/auOd764igOR 2Z/68WgrXM9Asoo/a3v7Q6DUTYAmq35xWNRqK54Msj0C0IdS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stm32-lp driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 958043bc5c92..989731256f50 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -18,14 +18,13 @@
 #include <linux/pwm.h>
 
 struct stm32_pwm_lp {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct regmap *regmap;
 };
 
 static inline struct stm32_pwm_lp *to_stm32_pwm_lp(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm_lp, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /* STM32 Low-Power Timer is preceded by a configurable power-of-2 prescaler */
@@ -200,16 +199,14 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	struct pwm_chip *chip;
 	int ret;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_lp(chip);
 
 	priv->regmap = ddata->regmap;
 	priv->clk = ddata->clk;
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &stm32_pwm_lp_ops;
-	chip->npwm = 1;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
-- 
2.43.0


