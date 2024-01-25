Return-Path: <linux-pwm+bounces-995-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 821AD83C1DE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36FEA1F23411
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8D46438;
	Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5994502C
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184656; cv=none; b=fN8L8mUz553Et6E6xJ1vnPlldPQlLoi2iWWIOocaIQpsQeIWOwrz6hF9NzMMVe1mvvN2rua8j80oBACxI3pi+518f658I+R2WcoUZRkl5QrZ7wy/7bkAqA579X0FcSH/DBdmDa8YnfnADx7JGrcHfn3TDK/Nr1+pkKLtUAgZ840=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184656; c=relaxed/simple;
	bh=aG7UA8f5YtQLMNn3yaSXY6L/D5w+FeAjYY2K5j6vW28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWopQ+HmM1WsatiXXnevLLU5o846JccKuO5T3GotrxMwM/uBNV7KIM696JHzbv5awiyRsu0kxh43bbxvhqkJGOWRtEmbibcka3lg+REut2y+CRCAJRtrnf5FH3fFpF1w3OHWTpaQwR/YdjwksqdfLySs/eWRZTYMnyD25lSqx98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-0004IQ-Sv; Thu, 25 Jan 2024 13:10:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-002HRz-73; Thu, 25 Jan 2024 13:10:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-007n1X-0Q;
	Thu, 25 Jan 2024 13:10:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 051/111] pwm: clk: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:13 +0100
Message-ID:  <5c8f6b0552ecc92843b9ac25cd60e2805104dadb.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2400; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=aG7UA8f5YtQLMNn3yaSXY6L/D5w+FeAjYY2K5j6vW28=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk91B8ct/Yv++d6M8kQx2ZDO5trDH/NcLqCj9 7oOgutqYX2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPdQAKCRCPgPtYfRL+ TiQMB/4zFVg76uwIstS5qqz+QJGgWPdoNFJpZWwPyMzfgVWI4o2M6ZrVLMJ2qPAwAPRstas2j74 OW4DKCpxjpi49yF0iLScms3GH/uJ6vlrqiVj132BHxhaROGqHOoIb4pCC+zi2grlpeJmGpbnHq0 o4J8Q7ZW4HeiGYNqmfCiAOOmCsufD1NDR+CbED2JYHoGzVZ6U9M0Nk6LMx6D0UeJ3Bxq74u2Gyw nI4H+ldoGsvEmymUjQlyMQlkMWVyb1WUw3ogNkqTaGGvFWc9widy7ZaoIe+zptNECC38dd+ZhwQ roGAH9ymdt8bt7NPq3M6zbRGV/Gz2dBuFjDI1J/TPqVqQOlQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-clk driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index 9dd88b386907..c19a482d7e28 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -28,12 +28,14 @@
 #include <linux/pwm.h>
 
 struct pwm_clk_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	bool clk_enabled;
 };
 
-#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
+static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -81,35 +83,36 @@ static const struct pwm_ops pwm_clk_ops = {
 
 static int pwm_clk_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_clk_chip *pcchip;
 	int ret;
 
-	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
-	if (!pcchip)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pcchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pcchip = to_pwm_clk_chip(chip);
 
 	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
-	pcchip->chip.dev = &pdev->dev;
-	pcchip->chip.ops = &pwm_clk_ops;
-	pcchip->chip.npwm = 1;
+	chip->ops = &pwm_clk_ops;
 
-	ret = pwmchip_add(&pcchip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwm chip\n");
 
-	platform_set_drvdata(pdev, pcchip);
+	platform_set_drvdata(pdev, chip);
 	return 0;
 }
 
 static void pwm_clk_remove(struct platform_device *pdev)
 {
-	struct pwm_clk_chip *pcchip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct pwm_clk_chip *pcchip = to_pwm_clk_chip(chip);
 
-	pwmchip_remove(&pcchip->chip);
+	pwmchip_remove(chip);
 
 	if (pcchip->clk_enabled)
 		clk_disable(pcchip->clk);
-- 
2.43.0


