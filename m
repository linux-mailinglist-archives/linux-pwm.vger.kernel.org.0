Return-Path: <linux-pwm+bounces-1430-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA38A8545F9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34FBD1F2E09D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780DA1B952;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B119BA6
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903288; cv=none; b=RYjACXq2dAwpL9zBHLxjCkkS46yUq4SlfJIIaxsUgRSmwWNYV+1kCy7zJ8qITvkXtrKddOboi6DOJ9k02/cTBu8KJO7ajpGoL51i/rvxSv7p+7PMrtaRx9Kbb+yq4sFsm+AAjHNaAj2ewbhYTryrxlNW3tjbKjJ2deEw2nW9pJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903288; c=relaxed/simple;
	bh=bb3OdQLFQZOKu55pM36RRQwMS946qtIh93ka66AfKQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJ1b4Shu7MuGt09XeiWWZQP2Ycu2dV+tQbVE7KMgDlcX2Y8Nh0ktJeO+rYa8unJ6PnRGJUbwpa4o8OHrPF5rjoMhsbhkGO4SoxC8TenSY3+htzzTW3A0B0L0giceYS+w0s9Y/Z4/aCU62lYNNLGuVvJHA/4BkGsXbacImxAcCKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-0005gc-FE; Wed, 14 Feb 2024 10:34:38 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-000fFX-QG; Wed, 14 Feb 2024 10:34:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-004Y7F-2O;
	Wed, 14 Feb 2024 10:34:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 110/164] pwm: sprd: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:37 +0100
Message-ID:  <543213f44686ee72d8f88897bf2ca616e837ae44.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bb3OdQLFQZOKu55pM36RRQwMS946qtIh93ka66AfKQI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjJhhj5D+t2qXRwil/kCgtSpN18np0yir/KM P9ksaFJobOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIyQAKCRCPgPtYfRL+ Tq5uB/97UPDBH1jNyjEWoPd9MoPa0iVQBT9Oelbmr4ufq2AyPrNe1xcPG3WCD+C0WRDF/6bapkV XEjli9E6g3FApYqYWiOx46op0pB90pBodtoge0JYp6J+dTU7IOfLxx1aj+TrTd2PzJxH6QUVFBx vS9cR0xlNDa8y61maoeTx5vXJ1JcG3BiUe2AmBUIPQPCK+FnoTCnrYzLFZA7/TmyI9hq8k3cRHH 6Nx+uCSnX5EHkvK1Ktm+K3v8I9XUlTSY4wR/LQ/UJ26HPONSiZAjrm4CU5IgkkGoDR2g7peHqWe QT9b4PnnUjsKu3dI5nHkQgVRE+YiDyag7YfMK02eVChFJ32u
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sprd driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sprd.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index a38f50c3dc00..4c76ca5e4cdd 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -34,13 +34,12 @@ struct sprd_pwm_chn {
 
 struct sprd_pwm_chip {
 	void __iomem *base;
-	struct pwm_chip chip;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 };
 
 static inline struct sprd_pwm_chip* sprd_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sprd_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -248,6 +247,7 @@ static int sprd_pwm_clk_init(struct device *dev,
 
 static int sprd_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct sprd_pwm_chip *spc;
 	struct sprd_pwm_chn chn[SPRD_PWM_CHN_NUM];
 	int ret, npwm;
@@ -256,9 +256,10 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 	if (npwm < 0)
 		return npwm;
 
-	spc = devm_kzalloc(&pdev->dev, sizeof(*spc), GFP_KERNEL);
-	if (!spc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, npwm, sizeof(*spc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	spc = sprd_pwm_from_chip(chip);
 
 	spc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(spc->base))
@@ -266,11 +267,9 @@ static int sprd_pwm_probe(struct platform_device *pdev)
 
 	memcpy(spc->chn, chn, sizeof(chn));
 
-	spc->chip.dev = &pdev->dev;
-	spc->chip.ops = &sprd_pwm_ops;
-	spc->chip.npwm = npwm;
+	chip->ops = &sprd_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &spc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		dev_err(&pdev->dev, "failed to add PWM chip\n");
 
-- 
2.43.0


