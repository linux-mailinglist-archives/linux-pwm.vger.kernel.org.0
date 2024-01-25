Return-Path: <linux-pwm+bounces-1040-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB49D83C215
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096FF1C227B0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487145023;
	Thu, 25 Jan 2024 12:11:06 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687953FE3F
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184666; cv=none; b=t/GnwbG701xdC+lR+TLRR6pMcT/vS3mn7OOzprYlKiwxQ+pelknz+4cOT8jMOmsiaLWYfc1riIGfNgUAfqBEa3fgR1uejJeyH9SkIR5RWk8K/lL0cKEo1IzUzuHQDFcPQjwZcGyL1qSis+/XacZTw81q3NCWkNSv+O+G263DNv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184666; c=relaxed/simple;
	bh=as3S2egeJ/QZdTUEgNrgJSJQI7Am97f8zTw8M8Bg5WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jm83OiyIkEA2SdPEhRt//LNi3zwXVWIvqvx+RxdHpwN0sgl5w8GJJmX/VNtMsTUXLnLhCojrx4YpBhWsdomzwxNk4Zc2mbunZ+3pb5zMG5mAiY4ScTpA4FlyWNK2HBFxATak6mIpDskq2hKX7FXCO8Oi/pCOsPF5CVjv7aYeqnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZR-0004d8-AP; Thu, 25 Jan 2024 13:11:01 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-002HVI-J9; Thu, 25 Jan 2024 13:10:59 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZP-007n4z-1e;
	Thu, 25 Jan 2024 13:10:59 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Sean Anderson <sean.anderson@seco.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 102/111] pwm: xilinx: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:10:04 +0100
Message-ID:  <d894c301ece78f875c3f40eca9c419739385643e.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3206; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=as3S2egeJ/QZdTUEgNrgJSJQI7Am97f8zTw8M8Bg5WY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+xN9oc1YRMXX3AynlpRvrvMmCCIXir8Cjx4 BnW/FFqx6iJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPsQAKCRCPgPtYfRL+ Tm45CACp+YZ/zWPGZv9AUc/cZ4no3uHmpyJ4kAp6Zi9zW6qArfTFNW1Sj/AGlm4B6YKoRLWGyeh hsGTt/WK4CNSocALAyeYUvv4gPAcqEV3KA3iK+ZX/0DCuN++M0Q8Zufemw4c/FcJga6bbGnbotG PaA5p2ueL2Nvsq5PaTsNXbnwLrDPMcIj7malzTwAt5+jN/5KtOLpqXouIOX9k9Yrgn11lTTNUzL U5h+mpQh9dLjC/gibD/ZdaSHGzdin/xMrGd1cBgQ1komaGTSvJQgqg5fsS3+YDgTfjtMXgHPOIM vb2MBAVoSjMJwLVz7B4A4bBHk2ReuLouc28oK8Fu/v16IXq6
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-xilinx driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-xilinx.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 5f3c2a6fed11..465ac9617256 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -80,15 +80,10 @@ unsigned int xilinx_timer_get_period(struct xilinx_timer_priv *priv,
 #define TCSR_PWM_CLEAR (TCSR_MDT | TCSR_LOAD)
 #define TCSR_PWM_MASK (TCSR_PWM_SET | TCSR_PWM_CLEAR)
 
-struct xilinx_pwm_device {
-	struct pwm_chip chip;
-	struct xilinx_timer_priv priv;
-};
-
 static inline struct xilinx_timer_priv
 *xilinx_pwm_chip_to_priv(struct pwm_chip *chip)
 {
-	return &container_of(chip, struct xilinx_pwm_device, chip)->priv;
+	return pwmchip_get_drvdata(chip);
 }
 
 static bool xilinx_timer_pwm_enabled(u32 tcsr0, u32 tcsr1)
@@ -213,8 +208,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	int ret;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
+	struct pwm_chip *chip;
 	struct xilinx_timer_priv *priv;
-	struct xilinx_pwm_device *xilinx_pwm;
 	u32 pwm_cells, one_timer, width;
 	void __iomem *regs;
 
@@ -225,11 +220,11 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "could not read #pwm-cells\n");
 
-	xilinx_pwm = devm_kzalloc(dev, sizeof(*xilinx_pwm), GFP_KERNEL);
-	if (!xilinx_pwm)
-		return -ENOMEM;
-	platform_set_drvdata(pdev, xilinx_pwm);
-	priv = &xilinx_pwm->priv;
+	chip = devm_pwmchip_alloc(dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = xilinx_pwm_chip_to_priv(chip);
+	platform_set_drvdata(pdev, chip);
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(regs))
@@ -278,10 +273,8 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, ret, "Clock enable failed\n");
 	clk_rate_exclusive_get(priv->clk);
 
-	xilinx_pwm->chip.dev = dev;
-	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
-	xilinx_pwm->chip.npwm = 1;
-	ret = pwmchip_add(&xilinx_pwm->chip);
+	chip->ops = &xilinx_pwm_ops;
+	ret = pwmchip_add(chip);
 	if (ret) {
 		clk_rate_exclusive_put(priv->clk);
 		clk_disable_unprepare(priv->clk);
@@ -293,11 +286,12 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 
 static void xilinx_pwm_remove(struct platform_device *pdev)
 {
-	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct xilinx_timer_priv *priv = xilinx_pwm_chip_to_priv(chip);
 
-	pwmchip_remove(&xilinx_pwm->chip);
-	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
-	clk_disable_unprepare(xilinx_pwm->priv.clk);
+	pwmchip_remove(chip);
+	clk_rate_exclusive_put(priv->clk);
+	clk_disable_unprepare(priv->clk);
 }
 
 static const struct of_device_id xilinx_pwm_of_match[] = {
-- 
2.43.0


