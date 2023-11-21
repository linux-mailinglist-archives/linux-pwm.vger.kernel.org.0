Return-Path: <linux-pwm+bounces-57-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F867F2F88
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1C31C217E9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479F054F82;
	Tue, 21 Nov 2023 13:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E4E10C7
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:04 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-0005Q5-8G; Tue, 21 Nov 2023 14:51:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-00Aays-Fx; Tue, 21 Nov 2023 14:51:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-004xdN-6f; Tue, 21 Nov 2023 14:51:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 039/108] pwm: apple: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:41 +0100
Message-ID: <20231121134901.208535-40-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EWFaSHTVoFTH6Q8XFdZqH8m+52FGb/WrCzVZKfXOE7M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV3gF0Dt26f+Jj0a8Rx27Z5PSPEkLvevmwOf 3dfY7agPSWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1dwAKCRCPgPtYfRL+ Tk0iB/4vG0QF7RRk4LEOjieZxNWkY/6kdzySkcqaSHsuKUhFVVzhDqnzpl7lo5YQpA3cGiySqXB 6rnOa+hvfp2S0Uv1ClQ0yIcCtUAIo4jxITiEn+Xx2G9Sk7xkdsO7pr9B8n5AceSiougOWg12aJa nZTkEP6NLCeqVyyMgvuUx1ComrQtil74wlqbb/FVa3jf7Ok6Sy5OLOKakow/9q6V2aRJK/Lin+8 nWURTy2kNumXKrgijWTSbJ0PDaVWPnBPFRP54ehOiQ0abLZ8uK8HyrFZg0QG3meMR8gcLqJzlOM Ve1fxR7+dFgt2Ir6Hdq4nauMzLYQVew92aowuB1dTzV0TOlO
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-apple driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-apple.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-apple.c b/drivers/pwm/pwm-apple.c
index 4d755b628d9e..1560b6f88821 100644
--- a/drivers/pwm/pwm-apple.c
+++ b/drivers/pwm/pwm-apple.c
@@ -32,14 +32,13 @@
 #define APPLE_PWM_CTRL_OUTPUT_ENABLE BIT(14)
 
 struct apple_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	u64 clkrate;
 };
 
 static inline struct apple_pwm *to_apple_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct apple_pwm, chip);
+	return pwmchip_priv(chip);
 }
 
 static int apple_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -103,13 +102,16 @@ static const struct pwm_ops apple_pwm_ops = {
 
 static int apple_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct apple_pwm *fpwm;
 	struct clk *clk;
 	int ret;
 
-	fpwm = devm_kzalloc(&pdev->dev, sizeof(*fpwm), GFP_KERNEL);
-	if (!fpwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*fpwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+
+	fpwm = to_apple_pwm(chip);
 
 	fpwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(fpwm->base))
@@ -129,11 +131,9 @@ static int apple_pwm_probe(struct platform_device *pdev)
 	if (fpwm->clkrate > NSEC_PER_SEC)
 		return dev_err_probe(&pdev->dev, -EINVAL, "pwm clock out of range");
 
-	fpwm->chip.dev = &pdev->dev;
-	fpwm->chip.npwm = 1;
-	fpwm->chip.ops = &apple_pwm_ops;
+	chip->ops = &apple_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "unable to add pwm chip");
 
-- 
2.42.0


