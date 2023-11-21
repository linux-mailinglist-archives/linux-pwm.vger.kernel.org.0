Return-Path: <linux-pwm+bounces-77-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E597F2FA2
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A1961F240BA
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D2554F86;
	Tue, 21 Nov 2023 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6722110F2
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:07 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAa-0006Hw-MB; Tue, 21 Nov 2023 14:52:04 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-00Ab1f-Bt; Tue, 21 Nov 2023 14:52:02 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAY-004xge-31; Tue, 21 Nov 2023 14:52:02 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 085/108] pwm: spear: Make use of devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:50:27 +0100
Message-ID: <20231121134901.208535-86-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2228; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mNY4nxSmQEktElUNAFUQLRUK3zDlGO6/+c2FO+pl/JE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSYrasYPvLPlo832qp4UGmT8Qodk36pFfYiL8I5jhrIW 7R8+Xyxk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFN4eIUgIlsN2D/nzOx3uycnxfjF9+D TW8+2szb97NCo75QT+5g8j8PhbVCu1Nb6wUXbLI9c3OfQWtxpXJI0L+XlXtY+p/phfRMP3Tj097 Thf0tPxObZt4+96Dd5uGpry8e37zP7j6lYcGnH8mBrMda4ssPsjd2z5PYfUsrN3jLk4P/Hx8Nn7 3y+Pmnmz8XhjofvrPjz7yagIk7IyKltl9liLsW4btsRdtu7+LSCMGyS3aFUlxcD6U9snK//irW8 u2RX9skd0Tv7q+8dY/yXe/7iPh92pbH0L9Yc3lKmPk3/oMWUiXZ/xd9DFaUdt654mjvNxk3Gxvp qN+MeuzKgbv/fnCUnifdm1rmr7898oK28+OvsnOKWXNCAQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-spear driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-spear.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index ff991319feef..5679732cd77e 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -53,12 +53,11 @@
 struct spear_pwm_chip {
 	void __iomem *mmio_base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct spear_pwm_chip *to_spear_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct spear_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline u32 spear_pwm_readl(struct spear_pwm_chip *chip, unsigned int num,
@@ -194,13 +193,15 @@ static const struct pwm_ops spear_pwm_ops = {
 static int spear_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct pwm_chip *chip;
 	struct spear_pwm_chip *pc;
 	int ret;
 	u32 val;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, NUM_PWM, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_spear_pwm_chip(chip);
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
@@ -211,9 +212,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "Failed to get clock\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &spear_pwm_ops;
-	pc->chip.npwm = NUM_PWM;
+	chip->ops = &spear_pwm_ops;
 
 	if (of_device_is_compatible(np, "st,spear1340-pwm")) {
 		ret = clk_enable(pc->clk);
@@ -232,7 +231,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		clk_disable(pc->clk);
 	}
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.42.0


