Return-Path: <linux-pwm+bounces-1347-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B042085459E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D3061F2E047
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C47118E14;
	Wed, 14 Feb 2024 09:34:30 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC24182B5
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903270; cv=none; b=lsBcKPdSoadvuskEfAdUtj/4XhCJZDj/ghomMZz9xsrV0PCWyCFkJfYfsvtfzKL7g+onhUjL4Xmk7d7TWEQMInuoQkLL91AdX05dTaTn1s9DOnuQSat5jyULz3aALlSb8/A8a+SjK/AA9U4Wu7X9bYJz20iLNqtd5jvOrZny+2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903270; c=relaxed/simple;
	bh=tmSY9TV+saWn7jW+VdJPG0QKWTGZ4WuVLLOZAllb2EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTQGpy2lYu6RngK3V/BE22VRuGrTn1vWiNf7G31Q3/pl/Op2KpA52JhCWc4WLjIGvnZBdtneABrRuCDlgfocbqriZ81LoVYq0Sz2cejnUFTD7l7qbEIvYOXMZXgUCpIkFxn64sNVFOJj8cAToGMDp8rCwOj+arkRahbKYjKOrLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-0004hh-Ea; Wed, 14 Feb 2024 10:34:25 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-000fBg-W1; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeq-004Y2n-2x;
	Wed, 14 Feb 2024 10:34:24 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 046/164] pwm: img: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:33 +0100
Message-ID:  <d99e00af2ff09cd3587d9a7c51dc8e0e13f85208.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1807; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tmSY9TV+saWn7jW+VdJPG0QKWTGZ4WuVLLOZAllb2EQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIh/XSYdxlnkMSsg6dKYwEftMbgx6p/LfkWU+ LqqnmCSTVGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIfwAKCRCPgPtYfRL+ TnyyCACOniHLPmrcAG1dkxjMfHJnAOVih3hLEblzsTLIEdOrQkLMuhsUMsWk2bFPoKNAvG4zpK2 nh26Nql2p+u6dffcmEH1VD2VwA1WEGjZJihWKEzzc/rnmWFKUhaGSABp1rVjBlZT3PYsR+83QC1 ZmmZChgnkCb9XAj9mxngzedT3v3WFXEfJkRyuyugcAdEhwuTR/ywfZVBjpBUzAkv0+6WwUkhFNJ nJ4/sMol+X49qPQ5svPTQgL51LXAuXZb2Jm3lUQwPGmBxkhYat9b1R/09YOy4j0OH6C4u43YNGs I4LNNj1fY99GDgClrHjYvvQxcP2wjIV1+37GlLBmdQVfpYwT
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-img driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-img.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index e99d5bc979c2..d79a96679a26 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -59,7 +59,6 @@ struct img_pwm_soc_data {
 };
 
 struct img_pwm_chip {
-	struct pwm_chip	chip;
 	struct clk	*pwm_clk;
 	struct clk	*sys_clk;
 	void __iomem	*base;
@@ -73,7 +72,7 @@ struct img_pwm_chip {
 
 static inline struct img_pwm_chip *to_img_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct img_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline void img_pwm_writel(struct img_pwm_chip *imgchip,
@@ -263,10 +262,10 @@ static int img_pwm_probe(struct platform_device *pdev)
 	struct pwm_chip *chip;
 	struct img_pwm_chip *imgchip;
 
-	imgchip = devm_kzalloc(&pdev->dev, sizeof(*imgchip), GFP_KERNEL);
-	if (!imgchip)
-		return -ENOMEM;
-	chip = &imgchip->chip;
+	chip = devm_pwmchip_alloc(&pdev->dev, IMG_PWM_NPWM, sizeof(*imgchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imgchip = to_img_pwm_chip(chip);
 
 	imgchip->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imgchip->base))
@@ -318,9 +317,7 @@ static int img_pwm_probe(struct platform_device *pdev)
 	do_div(val, clk_rate);
 	imgchip->min_period_ns = val;
 
-	chip->dev = &pdev->dev;
 	chip->ops = &img_pwm_ops;
-	chip->npwm = IMG_PWM_NPWM;
 
 	ret = pwmchip_add(chip);
 	if (ret < 0) {
-- 
2.43.0


