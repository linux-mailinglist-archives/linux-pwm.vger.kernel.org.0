Return-Path: <linux-pwm+bounces-1381-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD308545C5
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4EA289D4C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF791643A;
	Wed, 14 Feb 2024 09:34:39 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3521418B1A
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903279; cv=none; b=gcjFnP64jT+Yrscusih+NJwysHoxIXauRYHSmHRrHnKCoD1j1/UStc+bPj3fpS6RsYTf/uFgRbc+e+MiVged11e/GM5kSm0bRrS1fUd3RNOq94YwIPAz/yPgBUb59d36yW4+wAGeX3mjIUaajXwp21kfQBVrZd7MlPHhNAi73S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903279; c=relaxed/simple;
	bh=efjqoTt2JNTkS/blkL8nCUoyaB7R1fYI93LJBT5sUFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spiXhYX3IouobG6FtBfPAxTa8ypXiimp3IfK/6GbSC/sNTkF/8i7HXX6eiTbt5t+XKgICLWQUU4nuMDE92J7T8hA18pWaj3GFZ1p+bFwC6lZH9+b2cxBL7IO5D1IuL6O7Sy0N4hmFxM0KHn1DPhWk4zhl7FLwrqK+YencW2srY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBex-000544-Ot; Wed, 14 Feb 2024 10:34:31 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-000fD0-KV; Wed, 14 Feb 2024 10:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-004Y4R-1k;
	Wed, 14 Feb 2024 10:34:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v6 069/164] pwm: mediatek: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:56 +0100
Message-ID:  <513b2037c00ebf2f3a69472f4b99adaf4fb40d83.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=efjqoTt2JNTkS/blkL8nCUoyaB7R1fYI93LJBT5sUFk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiaeLfnYLOw4DotMB2SXw03iCB2wYUsxsOpk cYDh43ACSaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyImgAKCRCPgPtYfRL+ TnthB/91VfbI7Gnxixao020csS6NwOC2xRsfijHkmra/QOHIKisTw/QsU5yq7ml5F8jBoFb+C1q Gf5s2PPhlexsn8Q3fGs2LISIaseVvU+CfkuZejsVr9oU69DO/bwOPeQM1bvcywQ17fipCSgNEjb 4gfHujipg9I+syZdnxCK9UdvjHQYfUY9rB3SHSBDzWqUfFlnKVu4ZjxKGPZDSAbmTzOlnnc6UUz QOMw3xM1eW2oghJKfENs4NGOuQkGiuu1PZcL3Z9ZDq8X8UO78fFgC/z8GJnzfHYmrubaJ6M17x8 2kjZhLTumvzbtPrCaU/JDtglaKs86O3M6wL7z1dkF4NXD9/v
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-mediatek driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mediatek.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 6cf7543a3826..c5fca0f1ebc7 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -42,7 +42,6 @@ struct pwm_mediatek_of_data {
 
 /**
  * struct pwm_mediatek_chip - struct representing PWM chip
- * @chip: linux PWM chip representation
  * @regs: base address of PWM chip
  * @clk_top: the top clock generator
  * @clk_main: the clock used by PWM core
@@ -50,7 +49,6 @@ struct pwm_mediatek_of_data {
  * @soc: pointer to chip's platform data
  */
 struct pwm_mediatek_chip {
-	struct pwm_chip chip;
 	void __iomem *regs;
 	struct clk *clk_top;
 	struct clk *clk_main;
@@ -69,7 +67,7 @@ static const unsigned int mtk_pwm_reg_offset_v2[] = {
 static inline struct pwm_mediatek_chip *
 to_pwm_mediatek_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pwm_mediatek_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int pwm_mediatek_clk_enable(struct pwm_chip *chip,
@@ -232,21 +230,26 @@ static const struct pwm_ops pwm_mediatek_ops = {
 
 static int pwm_mediatek_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_mediatek_chip *pc;
+	const struct pwm_mediatek_of_data *soc;
 	unsigned int i;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	soc = of_device_get_match_data(&pdev->dev);
 
-	pc->soc = of_device_get_match_data(&pdev->dev);
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_pwm_mediatek_chip(chip);
+
+	pc->soc = soc;
 
 	pc->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->regs))
 		return PTR_ERR(pc->regs);
 
-	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, pc->soc->num_pwms,
+	pc->clk_pwms = devm_kmalloc_array(&pdev->dev, soc->num_pwms,
 				    sizeof(*pc->clk_pwms), GFP_KERNEL);
 	if (!pc->clk_pwms)
 		return -ENOMEM;
@@ -261,7 +264,7 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_main),
 				     "Failed to get main clock\n");
 
-	for (i = 0; i < pc->soc->num_pwms; i++) {
+	for (i = 0; i < soc->num_pwms; i++) {
 		char name[8];
 
 		snprintf(name, sizeof(name), "pwm%d", i + 1);
@@ -272,11 +275,9 @@ static int pwm_mediatek_probe(struct platform_device *pdev)
 					     "Failed to get %s clock\n", name);
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pwm_mediatek_ops;
-	pc->chip.npwm = pc->soc->num_pwms;
+	chip->ops = &pwm_mediatek_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add() failed\n");
 
-- 
2.43.0


