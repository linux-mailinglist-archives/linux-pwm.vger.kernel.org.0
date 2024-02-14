Return-Path: <linux-pwm+bounces-1394-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A71608545D0
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3701C27045
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6086718038;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8414004
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=aMmmlKxWRHWDMJaUBoxv1T26VFK1/nIGcSptfRZsk+HnjctD2JwZO2c2hPNyh2gv9f9i+j0Bma5nCVCBX6/2yuxcHZrNdQUHS7VreGpusyWFfG9LJ4SEZD6386gIihxa/81EJYtnUlNelPNpwdxsjZVgAo1nJt7X4frC7rb0GQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=YueCg21h/g25MKMKARZ45TJCGLxrFoGwudR+oda8Sbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lG/FEDiPTgQnPNawJujRvOTMQ6mlEzg3aRhB+cwBp5cS5+MM+Kdje7QT0k/V+rqP8zQPC3XiRyk9zq29aIZLpuOFzU9PxkrScTUb8PTQELSvNDQiMPgSlDNbFal9HyC16isjXwRj61XS0ljj+em3nvIzkeVMot9OtrplX3Pl3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005Q4-Gx; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000fEa-Cz; Wed, 14 Feb 2024 10:34:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-004Y66-14;
	Wed, 14 Feb 2024 10:34:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 095/164] pwm: rz-mtu3: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:22 +0100
Message-ID:  <b05ffb9bcaf4ddb6305f8505715a5542805e3227.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2385; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=YueCg21h/g25MKMKARZ45TJCGLxrFoGwudR+oda8Sbc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi4mXH0kZJz88+of59QTXggz8nb4Rsk7q141 oYbjH8b9kiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIuAAKCRCPgPtYfRL+ ThJdB/9y+KmAa32XQ7C2kzhHC2QUWoMJ9XY7M3fkP1EZeK901rIOo9QHzsdKPY6S2A4tUskHhA0 uj6sQtqLZ0RH8hrQR4mgQvV5R1xFuDNUvWqqRME/XqT6D5RHXhEI4BL7BUNm5fOL2Uh2PB059bO WUdOgddFTsxBRYqR9SELQwz2nYd7X9g8IQxM5dkgfxXy7ApexJcdeKFTu87i60saixSfivTmnlw RV5I8NJx9M2R9w626frVq2UMnFkg3HEVl2Oty1HInsSFTy6AXkG5TsAbdVVYVdFrg/gF4/qSQMF 8+HHMbz+KK9T8/mDEhQoLI3XOl1Z8B20rf55CFa02Dt7W6Gk
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rz-mtu3 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rz-mtu3.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index a129ae4ef338..ab39bd37edaf 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -61,7 +61,6 @@ struct rz_mtu3_pwm_channel {
 /**
  * struct rz_mtu3_pwm_chip - MTU3 pwm private data
  *
- * @chip: MTU3 pwm chip data
  * @clk: MTU3 module clock
  * @lock: Lock to prevent concurrent access for usage count
  * @rate: MTU3 clock rate
@@ -72,7 +71,6 @@ struct rz_mtu3_pwm_channel {
  */
 
 struct rz_mtu3_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	struct mutex lock;
 	unsigned long rate;
@@ -92,7 +90,7 @@ static const struct rz_mtu3_channel_io_map channel_map[] = {
 
 static inline struct rz_mtu3_pwm_chip *to_rz_mtu3_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rz_mtu3_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void rz_mtu3_pwm_read_tgr_registers(struct rz_mtu3_pwm_channel *priv,
@@ -481,10 +479,11 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 	unsigned int i, j = 0;
 	int ret;
 
-	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
-	if (!rz_mtu3_pwm)
-		return -ENOMEM;
-	chip = &rz_mtu3_pwm->chip;
+	chip = devm_pwmchip_alloc(&pdev->dev, RZ_MTU3_MAX_PWM_CHANNELS,
+				  sizeof(*rz_mtu3_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 
 	rz_mtu3_pwm->clk = parent_ddata->clk;
 
@@ -519,14 +518,12 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	chip->dev = &pdev->dev;
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
 				       chip);
 	if (ret < 0)
 		return ret;
 
 	chip->ops = &rz_mtu3_pwm_ops;
-	chip->npwm = RZ_MTU3_MAX_PWM_CHANNELS;
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
-- 
2.43.0


