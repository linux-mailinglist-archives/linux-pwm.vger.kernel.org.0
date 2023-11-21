Return-Path: <linux-pwm+bounces-47-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7B7F2F81
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1EB2FB21188
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7257253815;
	Tue, 21 Nov 2023 13:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4324B10DC
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAR-0005Vt-S6; Tue, 21 Nov 2023 14:51:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-00AazX-Mp; Tue, 21 Nov 2023 14:51:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAQ-004xe1-Ds; Tue, 21 Nov 2023 14:51:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Alexander Shiyan <shc_work@mail.ru>
Cc: linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 049/108] pwm: clps711x: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:51 +0100
Message-ID: <20231121134901.208535-50-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2239; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=uttibuUPMCE6ihNNpyBu3/EYsQLKMrwihagoZRONhP4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLWCptSq9X/VovEsSoHud9NnIAxIHGrKYju6v KIgotuh6oWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1ggAKCRCPgPtYfRL+ TplRB/4izZLM4P5IaiOngM/teoKrWYswcLCMO4DURHvHCVjz5NG2qmiEnCsvSBdw8cFRWmTf9nA mnUeOS42OEcqEYA7fGwcCLoH3oSfcAFgt/izjOoAEyZ0jzP17Q5SrLXXEqZffAbVw+5m2h7s26y 8KxRXAUk2g6mDX3nHYBYAKd5+ukUgIExuddYKTBpIzQOjrxv8BzK4gZ+2SqQwJHi5/hVo4lEnEq 6b8P0ZIW1Muk+RL4IClmfnY3hOJ4EoTJY6/zkDW7AmPNtMktdmh+aMIU8+c7HMb2ds3Llg4DIxt 4Sacfh8hPVKb7S0F90p2EDajlSZf80UCkNvoeTnHjP0dwEb7
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-clps711x driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clps711x.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 42179b3f7ec3..f8a05a11a5d0 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -12,7 +12,6 @@
 #include <linux/pwm.h>
 
 struct clps711x_chip {
-	struct pwm_chip chip;
 	void __iomem *pmpcon;
 	struct clk *clk;
 	spinlock_t lock;
@@ -20,7 +19,7 @@ struct clps711x_chip {
 
 static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct clps711x_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -85,11 +84,13 @@ static struct pwm_device *clps711x_pwm_xlate(struct pwm_chip *chip,
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct clps711x_chip *priv;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_clps711x_chip(chip);
 
 	priv->pmpcon = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->pmpcon))
@@ -99,15 +100,13 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	priv->chip.ops = &clps711x_pwm_ops;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.npwm = 2;
-	priv->chip.of_xlate = clps711x_pwm_xlate;
-	priv->chip.of_pwm_n_cells = 1;
+	chip->ops = &clps711x_pwm_ops;
+	chip->of_xlate = clps711x_pwm_xlate;
+	chip->of_pwm_n_cells = 1;
 
 	spin_lock_init(&priv->lock);
 
-	return devm_pwmchip_add(&pdev->dev, &priv->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
-- 
2.42.0


