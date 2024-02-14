Return-Path: <linux-pwm+bounces-1402-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AA48545D4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10986289C4D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398A618B1A;
	Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2914F168CC
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903282; cv=none; b=RpaBu1rM1uSIOmnqc12TkFk/XrBeiWiIGMO+OgPdrVEidig0VaarieRGOmv/XgU2TDT2gBVDHgx5K75lOjsNUACe2nH+nDDcYu8VhXORtyxLsyM0fHPFH1aOEuJxMr12CdmCKDQwTgglXnvgYHVulVprG9ZYFtznjgnK76Y0zzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903282; c=relaxed/simple;
	bh=jmPPmv4t7ppQME5IyV1XKNNruh/1smWbDkdXdk2AWsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oHpQInd0fRFrXA0d+MY7YY+Vlw5zGSuTXAzK42Xc3ULSbgJ5rmzZO4UAkO8O82Kcy2voN0d4uY/vLvu9eDZJSZ9irPTFEeLy2yeEaOJEBNMiyg/yUrSFDfATfJGlFYUI7CPc6vbB2vCsgwvc9qYLPmSvFP0R8qzmXCX2NnrFlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005Pb-Cx; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000fEX-9Q; Wed, 14 Feb 2024 10:34:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-004Y63-0i;
	Wed, 14 Feb 2024 10:34:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 094/164] pwm: rz-mtu3: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:21 +0100
Message-ID:  <707f2aced94a235f244022f10202ce7730b1168b.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5478; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=jmPPmv4t7ppQME5IyV1XKNNruh/1smWbDkdXdk2AWsQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi3Qr57eA3xP5YRwuke9mrM2GcVxwmnvyp8l p3EcCDMfA6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyItwAKCRCPgPtYfRL+ Tsr7B/0fNkU5iIci/afuNJT8UmGnXLABy4TSOTLsRw1KX79DWIM0p8LiBW+LXuV0B0HFPtcEySW q8hFo4lIk0JXRLdeH+10/Je1Ih/flASrEa09gHn+PzHuh82cLdHcC0l9QpD6CTCbHtqR/K678Fd wkJXwMcUhPxySYTVDBNEWDji76WnoKJAOb3D5TP3/Ksv3lFaMX7dGBiH2OxwjBdBWST/wjXxIVZ xiRi0b/GCOAZ8fhR/6ft1TkJcunQ4f+PxR16dmFcyE6n0xiAyW31H4PLrwmMtnyZt9X3zu/AWn9 qgcmXPpjl44BLByzzvMsyagp8cUTGvgj3NicBWUVDDi0Hr3z
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct rz_mtu3_pwm_chip. Use the pwm_chip as driver
data and devm callback parameter instead of the rz_mtu3_pwm_chip to get
access to the pwm_chip in various functions without using
rz_mtu3_pwm->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rz-mtu3.c | 43 ++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-rz-mtu3.c b/drivers/pwm/pwm-rz-mtu3.c
index acdc45ff90cf..a129ae4ef338 100644
--- a/drivers/pwm/pwm-rz-mtu3.c
+++ b/drivers/pwm/pwm-rz-mtu3.c
@@ -211,15 +211,15 @@ static void rz_mtu3_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&rz_mtu3_pwm->lock);
 }
 
-static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
-			      struct pwm_device *pwm)
+static int rz_mtu3_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	struct rz_mtu3_pwm_channel *priv;
 	u32 ch;
 	u8 val;
 	int rc;
 
-	rc = pm_runtime_resume_and_get(pwmchip_parent(&rz_mtu3_pwm->chip));
+	rc = pm_runtime_resume_and_get(pwmchip_parent(chip));
 	if (rc)
 		return rc;
 
@@ -243,9 +243,9 @@ static int rz_mtu3_pwm_enable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 	return 0;
 }
 
-static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
-				struct pwm_device *pwm)
+static void rz_mtu3_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 	struct rz_mtu3_pwm_channel *priv;
 	u32 ch;
 
@@ -265,7 +265,7 @@ static void rz_mtu3_pwm_disable(struct rz_mtu3_pwm_chip *rz_mtu3_pwm,
 
 	mutex_unlock(&rz_mtu3_pwm->lock);
 
-	pm_runtime_put_sync(pwmchip_parent(&rz_mtu3_pwm->chip));
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static int rz_mtu3_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -416,7 +416,7 @@ static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled) {
 		if (enabled)
-			rz_mtu3_pwm_disable(rz_mtu3_pwm, pwm);
+			rz_mtu3_pwm_disable(chip, pwm);
 
 		return 0;
 	}
@@ -428,7 +428,7 @@ static int rz_mtu3_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	if (!enabled)
-		ret = rz_mtu3_pwm_enable(rz_mtu3_pwm, pwm);
+		ret = rz_mtu3_pwm_enable(chip, pwm);
 
 	return ret;
 }
@@ -442,7 +442,8 @@ static const struct pwm_ops rz_mtu3_pwm_ops = {
 
 static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev)
 {
-	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 
 	clk_disable_unprepare(rz_mtu3_pwm->clk);
 
@@ -451,7 +452,8 @@ static int rz_mtu3_pwm_pm_runtime_suspend(struct device *dev)
 
 static int rz_mtu3_pwm_pm_runtime_resume(struct device *dev)
 {
-	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 
 	return clk_prepare_enable(rz_mtu3_pwm->clk);
 }
@@ -462,17 +464,19 @@ static DEFINE_RUNTIME_DEV_PM_OPS(rz_mtu3_pwm_pm_ops,
 
 static void rz_mtu3_pwm_pm_disable(void *data)
 {
-	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = data;
+	struct pwm_chip *chip = data;
+	struct rz_mtu3_pwm_chip *rz_mtu3_pwm = to_rz_mtu3_pwm_chip(chip);
 
 	clk_rate_exclusive_put(rz_mtu3_pwm->clk);
-	pm_runtime_disable(pwmchip_parent(&rz_mtu3_pwm->chip));
-	pm_runtime_set_suspended(pwmchip_parent(&rz_mtu3_pwm->chip));
+	pm_runtime_disable(pwmchip_parent(chip));
+	pm_runtime_set_suspended(pwmchip_parent(chip));
 }
 
 static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 {
 	struct rz_mtu3 *parent_ddata = dev_get_drvdata(pdev->dev.parent);
 	struct rz_mtu3_pwm_chip *rz_mtu3_pwm;
+	struct pwm_chip *chip;
 	struct device *dev = &pdev->dev;
 	unsigned int i, j = 0;
 	int ret;
@@ -480,6 +484,7 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 	rz_mtu3_pwm = devm_kzalloc(&pdev->dev, sizeof(*rz_mtu3_pwm), GFP_KERNEL);
 	if (!rz_mtu3_pwm)
 		return -ENOMEM;
+	chip = &rz_mtu3_pwm->chip;
 
 	rz_mtu3_pwm->clk = parent_ddata->clk;
 
@@ -494,7 +499,7 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 	}
 
 	mutex_init(&rz_mtu3_pwm->lock);
-	platform_set_drvdata(pdev, rz_mtu3_pwm);
+	platform_set_drvdata(pdev, chip);
 	ret = clk_prepare_enable(rz_mtu3_pwm->clk);
 	if (ret)
 		return dev_err_probe(dev, ret, "Clock enable failed\n");
@@ -514,15 +519,15 @@ static int rz_mtu3_pwm_probe(struct platform_device *pdev)
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-	rz_mtu3_pwm->chip.dev = &pdev->dev;
+	chip->dev = &pdev->dev;
 	ret = devm_add_action_or_reset(&pdev->dev, rz_mtu3_pwm_pm_disable,
-				       rz_mtu3_pwm);
+				       chip);
 	if (ret < 0)
 		return ret;
 
-	rz_mtu3_pwm->chip.ops = &rz_mtu3_pwm_ops;
-	rz_mtu3_pwm->chip.npwm = RZ_MTU3_MAX_PWM_CHANNELS;
-	ret = devm_pwmchip_add(&pdev->dev, &rz_mtu3_pwm->chip);
+	chip->ops = &rz_mtu3_pwm_ops;
+	chip->npwm = RZ_MTU3_MAX_PWM_CHANNELS;
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-- 
2.43.0


