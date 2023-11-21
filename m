Return-Path: <linux-pwm+bounces-80-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6177F2FA4
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7B39281ACA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A7153806;
	Tue, 21 Nov 2023 13:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC9510F0
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-0006AW-5X; Tue, 21 Nov 2023 14:52:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-00Ab1F-St; Tue, 21 Nov 2023 14:52:00 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAW-004xg3-Jw; Tue, 21 Nov 2023 14:52:00 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 078/108] pwm: rcar: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:20 +0100
Message-ID: <20231121134901.208535-79-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=/7NzeUVBkwLO5GckTSQRjmmzgIbFt754JEX9aLhGMus=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWiPuyL3GFOO2vf5lTW6i+VZQao5bX5OAgy7 UkPrk3au/KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1ogAKCRCPgPtYfRL+ TgLLB/4nDtX60tAb4qMIaa2EgvjZeiGgxps7CpLkQS+aZsL5Zgepx8VoMbXJ2Oz2V3HLNf7Cgqi cSmbqld1VVJcgqJ7PhsxPdTuXvyMPRaP6wQXbzSB3k23OKu6oi3Cu0TkMBTb4SdrjWNbExR9tKe E9UtkFB31xu6Zob1/uweksS+TAvisQ5yTdUjxfQRABRx6eFQbbA2GPhpZHLrya1igkBrBympmaJ zarNyvwZliT3RF55Tqhz5WERrUdR+3wUrx1xQwQribTxHZ3q7FR1vzO6WOa7R+4OwSugi6r+I+S p9Gib9/yDugfGGyQYc+tE2m/e0dOLx5y+Cdk+rAXHn3CXE/E
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rcar driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 4838762137d1..f67f2c664c6a 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -38,14 +38,13 @@
 #define  RCAR_PWMCNT_PH0_SHIFT	0
 
 struct rcar_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rcar_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data,
@@ -202,12 +201,14 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rcar_pwm_chip *rcar_pwm;
 	int ret;
 
-	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
-	if (rcar_pwm == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*rcar_pwm));
+	if (chip == NULL)
 		return -ENOMEM;
+	rcar_pwm = to_rcar_pwm_chip(chip);
 
 	rcar_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcar_pwm->base))
@@ -219,15 +220,13 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
-	platform_set_drvdata(pdev, rcar_pwm);
+	platform_set_drvdata(pdev, chip);
 
-	rcar_pwm->chip.dev = &pdev->dev;
-	rcar_pwm->chip.ops = &rcar_pwm_ops;
-	rcar_pwm->chip.npwm = 1;
+	chip->ops = &rcar_pwm_ops;
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pwmchip_add(&rcar_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
 		pm_runtime_disable(&pdev->dev);
@@ -239,9 +238,9 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 static void rcar_pwm_remove(struct platform_device *pdev)
 {
-	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&rcar_pwm->chip);
+	pwmchip_remove(chip);
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.42.0


