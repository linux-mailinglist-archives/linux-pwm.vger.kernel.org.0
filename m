Return-Path: <linux-pwm+bounces-1388-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DC58545CC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE1F21F2CD59
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FB917591;
	Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D312E54
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903280; cv=none; b=GnRWoydBdbGnld12LrXMhJfE/MmZlbIAQYLuHEJnGbXNYGejVJos90B7MBeCZYiYMvvyqOzPN0D25MQuuju/S5E5YQ3p/P0ZxfNptcJ78Azx9m0mscI19V8899hKRIUeNz+YnmwhlyKN1fjvowHF/p48w33uQchLO/P3YvxDqig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903280; c=relaxed/simple;
	bh=IKTf684HbAbCFxV/P3BN2Q+Ew9cnAV7p+JKFfoj1v3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fB5tzv1R4+zq1OChcJWCAiAdU0fxWfnwfGePdebAGsiSdkUwi7gz99VQGjsy589hrRXbaUL1HvUpXm3j920WUZuiJmw8sOdyefIVFcRB1BlQIA2NfeHnFm50n+ECMAbAIgYardnGrMIdNN8/zqFBDEeJ7wohC3ezF2YSRr/BA1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-0005NI-8x; Wed, 14 Feb 2024 10:34:34 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000fEM-SF; Wed, 14 Feb 2024 10:34:31 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-004Y5q-2Y;
	Wed, 14 Feb 2024 10:34:31 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Heiko Stuebner <heiko@sntech.de>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 091/164] pwm: rochchip: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:32:18 +0100
Message-ID:  <301657442c578cc8d330ad2b07463d59fed4bff6.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2308; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=IKTf684HbAbCFxV/P3BN2Q+Ew9cnAV7p+JKFfoj1v3k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIizoVhC0FRyoze4sZvNk4frGiCMCNVmrvi9M JGTTXoVeSKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIswAKCRCPgPtYfRL+ To66B/9bBWqw86Vi8ALhIjsb6DA2j/fZlrFMRghd87lmbzOpKe6/tZdipPrZgwiwVXriuSOudXZ /CwapgIrtBTNdkqOnRN3qAzSLbHBEpSplM/x5v9X8OtEO0M1rS/Lo64rWB4t2lZsDxAKGBD2h9o UfJhjI/XHr7X8Mj5SVrx0bAkzMgPJXRnHzAId1ZdkPDnSewMV3i01WzEwhRiIu4pk7s4NiqRPGL XCohn1umvYkQswCTDMbtglvViPlMNxH67zvh4WesNLKiugpsBA5F9iqXo25BKUngE5YQ5lYdhm+ 9b7H6NmCNMYOIooRfxcjJFAVxpBcbLZvvZ9fIjJpJPcmwsg8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct rockchip_pwm_chip. Use the pwm_chip as driver
data instead of the rockchip_pwm_chip to get access to the pwm_chip in
rockchip_pwm_remove() without using pc->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rockchip.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index a7c647e37837..c001eb6b17ae 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -296,6 +296,7 @@ MODULE_DEVICE_TABLE(of, rockchip_pwm_dt_ids);
 
 static int rockchip_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rockchip_pwm_chip *pc;
 	u32 enable_conf, ctrl;
 	bool enabled;
@@ -304,6 +305,7 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
 	if (!pc)
 		return -ENOMEM;
+	chip = &pc->chip;
 
 	pc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->base))
@@ -337,18 +339,18 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 
 	pc->data = device_get_match_data(&pdev->dev);
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &rockchip_pwm_ops;
-	pc->chip.npwm = 1;
+	chip->dev = &pdev->dev;
+	chip->ops = &rockchip_pwm_ops;
+	chip->npwm = 1;
 
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = (ctrl & enable_conf) == enable_conf;
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 		goto err_pclk;
@@ -372,9 +374,10 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 
 static void rockchip_pwm_remove(struct platform_device *pdev)
 {
-	struct rockchip_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->pclk);
 	clk_unprepare(pc->clk);
-- 
2.43.0


