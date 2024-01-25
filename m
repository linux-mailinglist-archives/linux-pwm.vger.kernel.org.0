Return-Path: <linux-pwm+bounces-979-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EDD83C203
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABFBB23E36
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5B3C097;
	Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F9405F9
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184653; cv=none; b=c3lAgvaWw2ATpcnZIAKJFxrYOAEhoU32mCCBtGMvkXlS4ZMbAUtep65fWq78njd8Rewc7mtr88Ws/vS1fKuQ20d26Bq9/zpfej78+H8w5zCrk22dyZ++W2em49Oov6xe+G22qi4bb/y+jPE4wmMfqj9yyqxnQxhyP4tVZieGa7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184653; c=relaxed/simple;
	bh=neQkkkXDHUEM9dSo5MAWe6moa15OMaMntAJ6c9xCReQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TCoKhj0uGvgtlnyK44n2Is6xnL5M0TOGeg9ZvshphPM1vCu2wsaE5TEIQ0rTYcuNdwcXkazbsWih3EGUvBjN0Z7jV4rzty1/ApzCo/zHaDXdKL03Oc2adNawRSkR7dxx3HaSbW5fUlbNlPoHh5COSlt3OB4CBvS9P+89TxK7Cjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-0004Dw-RI; Thu, 25 Jan 2024 13:10:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-002HRc-5v; Thu, 25 Jan 2024 13:10:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-007n1D-0K;
	Thu, 25 Jan 2024 13:10:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 046/111] pwm: bcm2835: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:08 +0100
Message-ID:  <eb16ae40404a3e9bdbf696dc03bf05b71f2e106f.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2088; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=neQkkkXDHUEM9dSo5MAWe6moa15OMaMntAJ6c9xCReQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9vN3MiJgOE+8YM2JmyCFJtFosL4WRveO87u BWJ/eitXHuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPbwAKCRCPgPtYfRL+ TqLxB/9YKXtEWsPi9SVOPdPwSqXSRyHuCh8NojbANO7EqjpTT1pGQVTVnb5qnW1DJSRvdotYx5h Mr6vqdqqjQ5S6HzBmSq3uZuBMT9BLE2nbJnERTyOqnV8fJY0Y2ZLn5o7PPWrTgsLBt6j1KJDndX 3vs1gGuLXp3WzKuV1kWYRLVIbx0j+tdXX1grM6bdDKVHzPfH9/lPlI0IchuqbvPPqlXfPE316dS 6ZjQKW0G3GfLrR3ZGfLUiTmDLAyTjeUaVNs0YXE2bu4NCXBiKKSOfI48DzdycrU76p8vl2Jr9um jtbN+O/wFriJPdEwRNSqG90zFVLqgDILuUSA+zhZFebM74Sm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-bcm2835 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm2835.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 283cf27f25ba..a7450c98368d 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -24,7 +24,6 @@
 #define PERIOD_MIN		0x2
 
 struct bcm2835_pwm {
-	struct pwm_chip chip;
 	struct device *dev;
 	void __iomem *base;
 	struct clk *clk;
@@ -33,7 +32,7 @@ struct bcm2835_pwm {
 
 static inline struct bcm2835_pwm *to_bcm2835_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct bcm2835_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int bcm2835_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -135,12 +134,14 @@ static void devm_clk_rate_exclusive_put(void *data)
 
 static int bcm2835_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct bcm2835_pwm *pc;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_bcm2835_pwm(chip);
 
 	pc->dev = &pdev->dev;
 
@@ -168,14 +169,12 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, -EINVAL,
 				     "failed to get clock rate\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &bcm2835_pwm_ops;
-	pc->chip.atomic = true;
-	pc->chip.npwm = 2;
+	chip->atomic = true;
+	chip->ops = &bcm2835_pwm_ops;
 
 	platform_set_drvdata(pdev, pc);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to add pwmchip\n");
-- 
2.43.0


