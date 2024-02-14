Return-Path: <linux-pwm+bounces-1345-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F091885459A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1CD328816F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B497918C28;
	Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0BD1643A
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903269; cv=none; b=nQdzV37itpYh74xEXZ5eKGqivFA0fuHHtwH60gtnG0U8r2jpk1pJ/f3PWaHgtYUT5f7w0Jza8GjtlrlINhzPMCHwVlRj68DR3wa9Y3OZWE1RlNUupBuYvvhahhJk3WCJGh9r5bSH4dKRChxv/RMv8+ykXk60i2KMk4dxKTaoVUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903269; c=relaxed/simple;
	bh=1IU06WwcBSvhyrQSFg8Gb3Az6umu1p84rbM7k18PusA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=joydbDK+k2ilfgWwy49E5KxnCA7jfH+fAkGUI58LRMHawZO7lm5tydOtkgqPMSqA0O+oE1KD8drWqDkwO5rRGNiJYJbyUb82Ib8WrspVL1kyB0KdYfilQoO7bKd3R3ShyIzzueqDacfqhNRCHCv4Yip6NrnmLlMNA5KD03AgDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-0004fK-Ey; Wed, 14 Feb 2024 10:34:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fBB-V4; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-004Y2L-2q;
	Wed, 14 Feb 2024 10:34:23 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 039/164] pwm: fsl-ftm: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:26 +0100
Message-ID:  <2cf27e2929505c05f84501d6fce96f23eba03fc3.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3840; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1IU06WwcBSvhyrQSFg8Gb3Az6umu1p84rbM7k18PusA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh3+iIlJ8j7M9i6meUh4J2vyVkjJWce2+E8s CxxbubabK6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIdwAKCRCPgPtYfRL+ Th1YB/47ugWm744Z5amYAjfpALmD9VZ7YX7pAqlbb5el4Xm/phuouQon5Rhr4bBDeoJzzJC2BEb C2As/ktZ7fXv6Z1AgaOJv1txRuG49oa3CMFj395uus9Xlm6xvgMsfsFZ7Z9AbMIO/92HZ03ZZhP 35uFqA/o/McErFfMET7H6ckOMUWxS17F3yvUEQIJkU5CusJR/nORjYioO4ei52BbKsnRJwxZGVk No7BmF1KENO7szonsTyJC2LM6fV8fX6e1jLJjWyt7eIiOSDUhYkl/SDVN5LYuSTFAcEeXkG9XXi YdUxNEvg/UEBguQDdJefATo7UaJaDWhstFN8nB6rrGjDleON
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct fsl_pwm_chip. Use the pwm_chip as driver data
instead of the fsl_pwm_chip to get access to the pwm_chip in
fsl_pwm_suspend() and fsl_pwm_resume() without using fpc->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-fsl-ftm.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-fsl-ftm.c b/drivers/pwm/pwm-fsl-ftm.c
index 47f1f5ac39cf..b4f8dff60c50 100644
--- a/drivers/pwm/pwm-fsl-ftm.c
+++ b/drivers/pwm/pwm-fsl-ftm.c
@@ -393,6 +393,7 @@ static const struct regmap_config fsl_pwm_regmap_config = {
 
 static int fsl_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct fsl_pwm_chip *fpc;
 	void __iomem *base;
 	int ret;
@@ -400,11 +401,12 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 	fpc = devm_kzalloc(&pdev->dev, sizeof(*fpc), GFP_KERNEL);
 	if (!fpc)
 		return -ENOMEM;
+	chip = &fpc->chip;
 
 	mutex_init(&fpc->lock);
 
 	fpc->soc = of_device_get_match_data(&pdev->dev);
-	fpc->chip.dev = &pdev->dev;
+	chip->dev = &pdev->dev;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -423,16 +425,16 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_SYS]);
 	}
 
-	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(fpc->chip.dev, "ftm_fix");
+	fpc->clk[FSL_PWM_CLK_FIX] = devm_clk_get(&pdev->dev, "ftm_fix");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_FIX]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_FIX]);
 
-	fpc->clk[FSL_PWM_CLK_EXT] = devm_clk_get(fpc->chip.dev, "ftm_ext");
+	fpc->clk[FSL_PWM_CLK_EXT] = devm_clk_get(&pdev->dev, "ftm_ext");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_EXT]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_EXT]);
 
 	fpc->clk[FSL_PWM_CLK_CNTEN] =
-				devm_clk_get(fpc->chip.dev, "ftm_cnt_clk_en");
+				devm_clk_get(&pdev->dev, "ftm_cnt_clk_en");
 	if (IS_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]))
 		return PTR_ERR(fpc->clk[FSL_PWM_CLK_CNTEN]);
 
@@ -445,16 +447,16 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 		fpc->ipg_clk = fpc->clk[FSL_PWM_CLK_SYS];
 
 
-	fpc->chip.ops = &fsl_pwm_ops;
-	fpc->chip.npwm = 8;
+	chip->ops = &fsl_pwm_ops;
+	chip->npwm = 8;
 
-	ret = devm_pwmchip_add(&pdev->dev, &fpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to add PWM chip: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, fpc);
+	platform_set_drvdata(pdev, chip);
 
 	return fsl_pwm_init(fpc);
 }
@@ -462,14 +464,15 @@ static int fsl_pwm_probe(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int fsl_pwm_suspend(struct device *dev)
 {
-	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
 	regcache_cache_only(fpc->regmap, true);
 	regcache_mark_dirty(fpc->regmap);
 
-	for (i = 0; i < fpc->chip.npwm; i++) {
-		struct pwm_device *pwm = &fpc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
@@ -488,11 +491,12 @@ static int fsl_pwm_suspend(struct device *dev)
 
 static int fsl_pwm_resume(struct device *dev)
 {
-	struct fsl_pwm_chip *fpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct fsl_pwm_chip *fpc = to_fsl_chip(chip);
 	int i;
 
-	for (i = 0; i < fpc->chip.npwm; i++) {
-		struct pwm_device *pwm = &fpc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!test_bit(PWMF_REQUESTED, &pwm->flags))
 			continue;
-- 
2.43.0


