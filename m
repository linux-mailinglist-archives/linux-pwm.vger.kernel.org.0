Return-Path: <linux-pwm+bounces-1419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8878545EC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C59B1C21D06
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D631AADF;
	Wed, 14 Feb 2024 09:34:47 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7637219477
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903286; cv=none; b=PKQK+TpYxrcbnZhWf/waGx8AnK97ODe8HqGavGRr3uQw3cumS4DJ4DzgEXG/KRAZFX6gsDpi0dwfK1WGQrzSqPLMMd2opX0eLBT4Cs6vv9vLRSRdxwgsUJhCNLGaLLkhojNs5zBTNKmDNUkI0cksFr1EZBO8oHVwX9rgsbxn8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903286; c=relaxed/simple;
	bh=T/U7wQnCa/nBPtaaTnKA2tY72R4dDiZtK4LWdIBSJd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUMQctPgycJnsMuVbgpRMyqWkEfp+NDPQKA+yYxt12oOK+7iZikvhGOb8HmcgPKRrAwznHYF99tO4+tRGRNZj6+8folvcoOPeX9q3GmH9UXiW+pIAS8srk057ubVZvHDgDh/YhltuTB1937mQ3eB0Ok8K3K4l+7fG8VMrMRAvKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005mH-Id; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-000fFz-TE; Wed, 14 Feb 2024 10:34:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-004Y7h-2c;
	Wed, 14 Feb 2024 10:34:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 117/164] pwm: stm32: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:44 +0100
Message-ID:  <59e5dfff2b878cc8590e286572672e4f10e35380.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2070; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=T/U7wQnCa/nBPtaaTnKA2tY72R4dDiZtK4LWdIBSJd4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjRsLdl8HTUa9tf6qIs+zvnxTpj//AqG0X++ ldOrCB7T1eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI0QAKCRCPgPtYfRL+ Tu6/B/477D5/A7oJB9f/BCRHZQWbXLL6oXepDfsU47gcf24GXzWckRUa2n8Rqdd/N4URAzUpcng QoWNKG5EiIW/stnDW/Fr9WxNS+3kZw4quDzkWcw+aosSTnstAtrM8uI1gQdxfEy6aWOuhuQnS0S X1xBRUp9v2dVbkizu0+a0AAOrbtrVgh2rMLKXiDWhTYbKz6xHdZnlnNf3HLdCXkpxK96WQWJeJ/ ozDH2tVMAE52haznrJX5TZ6pbjP/ScQoKzLEl2AjJfNXu6U7ma8ohFQa2H/l9Eu0mjDCN3jpiV1 eOORhbGtaT96LiRrSk8FkgoUtiZWGOArvSlrqsow37mhdCpm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-stm32 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 1440b706ee57..0c028d17c075 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -27,7 +27,6 @@ struct stm32_breakinput {
 };
 
 struct stm32_pwm {
-	struct pwm_chip chip;
 	struct mutex lock; /* protect pwm config/enable */
 	struct clk *clk;
 	struct regmap *regmap;
@@ -40,7 +39,7 @@ struct stm32_pwm {
 
 static inline struct stm32_pwm *to_stm32_pwm_dev(struct pwm_chip *chip)
 {
-	return container_of(chip, struct stm32_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static u32 active_channels(struct stm32_pwm *dev)
@@ -632,14 +631,16 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 	struct stm32_timers *ddata = dev_get_drvdata(pdev->dev.parent);
 	struct pwm_chip *chip;
 	struct stm32_pwm *priv;
-	unsigned int num_enabled;
+	unsigned int npwm, num_enabled;
 	unsigned int i;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-	chip = &priv->chip;
+	npwm = stm32_pwm_detect_channels(ddata->regmap, &num_enabled);
+
+	chip = devm_pwmchip_alloc(dev, npwm, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_stm32_pwm_dev(chip);
 
 	mutex_init(&priv->lock);
 	priv->regmap = ddata->regmap;
@@ -655,9 +656,7 @@ static int stm32_pwm_probe(struct platform_device *pdev)
 
 	stm32_pwm_detect_complementary(priv);
 
-	chip->dev = dev;
 	chip->ops = &stm32pwm_ops;
-	chip->npwm = stm32_pwm_detect_channels(ddata->regmap, &num_enabled);
 
 	/* Initialize clock refcount to number of enabled PWM channels. */
 	for (i = 0; i < num_enabled; i++)
-- 
2.43.0


