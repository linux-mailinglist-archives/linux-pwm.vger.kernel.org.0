Return-Path: <linux-pwm+bounces-1024-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8FA83C1FF
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C9C1C22C13
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B393D558;
	Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC88545023
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184662; cv=none; b=WrpmUfSBsFDEGp6Yl46S1f7b7fcW6psZeBSF+AU29DD4EPImYdSIUAKT4qI7THDWASX5pplji8M4cGhswnK15ElgS8cTcnA8gBp+MdelTbq2xO13Cf4PRwiW9qrzebzUEK+ViYMxy4Py0nCRIpsAZQU+P9Q3i6om9qBMR91R0WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184662; c=relaxed/simple;
	bh=VozU5L5NMz6wgASKq5oPkZ6sBtiFu031Fwib3A9Q4QU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzEa/1Y54od/Ud+WbjLI4A7Hi2gft3ZeO8BZLg0OkjKz+gULzkGmQ5QKvDsuIGhmnZIUv0yaxpJVDvZR3uErQAVFBRuOYPpfATxQodblKocf+TX6W1HEfqtPsYodnNC1gY4Y+hPpb54lEioQcQ7QpMU0p6NUjleOm//QpfOVA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZO-0004Xh-EV; Thu, 25 Jan 2024 13:10:58 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-002HUM-3B; Thu, 25 Jan 2024 13:10:57 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-007n45-05;
	Thu, 25 Jan 2024 13:10:57 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 088/111] pwm: spear: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:50 +0100
Message-ID:  <eaf017bb5f62b2a9339ef6db57a26b785afc3c90.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VozU5L5NMz6wgASKq5oPkZ6sBtiFu031Fwib3A9Q4QU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+hMigyaOJRc6IBXSQTRRdnnqgvGsEbHhhaa rDmoGuvOhmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPoQAKCRCPgPtYfRL+ TuwkCACz7OjOaS+9VgEKGRVVFL4XgCJSLpxulgPjx7NE+Sn6aqVghHfqzc/sBcbpFeZCgcjam5G EOzjssNZ16nzA4kH4FXEa9gMDZJdlG8x6903CrqD57wKapPcB7/u2j8b9xwDf62ubw7worl2vt/ M0jxjAtcmSDcVRH8RzQ4Vlb5DlVCcnDU+71exGATinys9Lfqq8T0gyl6h1sS+sJiUbTp+XrwsEb ZC1wBSWMC2XsQo43v48w0xkGUbW5tlYFa0CgB9CLJsRg8k7NjZ+pT8GEMfcsMNMjBXiC7qYp7ZT xHx+GDaDrWFBB08hCHe9Y8bRGVML+z/URCqaSUOdpCt7mgqY
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
 drivers/pwm/pwm-spear.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-spear.c b/drivers/pwm/pwm-spear.c
index ff991319feef..6c6f3b38c835 100644
--- a/drivers/pwm/pwm-spear.c
+++ b/drivers/pwm/pwm-spear.c
@@ -48,17 +48,15 @@
  *
  * @mmio_base: base address of pwm chip
  * @clk: pointer to clk structure of pwm chip
- * @chip: linux pwm chip representation
  */
 struct spear_pwm_chip {
 	void __iomem *mmio_base;
 	struct clk *clk;
-	struct pwm_chip chip;
 };
 
 static inline struct spear_pwm_chip *to_spear_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct spear_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 spear_pwm_readl(struct spear_pwm_chip *chip, unsigned int num,
@@ -194,13 +192,15 @@ static const struct pwm_ops spear_pwm_ops = {
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
@@ -211,9 +211,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
 				     "Failed to get clock\n");
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &spear_pwm_ops;
-	pc->chip.npwm = NUM_PWM;
+	chip->ops = &spear_pwm_ops;
 
 	if (of_device_is_compatible(np, "st,spear1340-pwm")) {
 		ret = clk_enable(pc->clk);
@@ -232,7 +230,7 @@ static int spear_pwm_probe(struct platform_device *pdev)
 		clk_disable(pc->clk);
 	}
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.43.0


