Return-Path: <linux-pwm+bounces-1400-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8035A8545DB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BB861F2E119
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2EB1865A;
	Wed, 14 Feb 2024 09:34:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2C318B04
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903281; cv=none; b=G+aRpzoEs5BPP+2Pfrqw8rDnvMVHTiHGep4zBSX5TEX8ZzRXDqg4mFNJVrXQCTGo3dOYH07+MQb3k5WqjCYJxPG8cuRDL5Lp2tYVXYxI58Mf4nMf1HG1rj+GW5eC3WBAWNbF44Wbk5L+H+yp/7+TtvAnR9euGkLtXA4WL3Wo+Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903281; c=relaxed/simple;
	bh=gQ9w7kaOKKUHbgFvVUOT6nuqeGO2O8KLl+bQfhtHlNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DJj4nktXwB29a3r0xQ7WjBg/fuzQr4yeYKueBHNFU4THEa0kVDewcvDcZ73+c0dXsj8rEOfdJoHosbhVufSV5QIGkQ1nmIyF1xYNOH6/uhgDCbasdxBFanll0LvETLrEj8tUsbx9/HHZM6PE7ttLp7/jj8LWdwGjsx8dK27h5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-0005IR-1w; Wed, 14 Feb 2024 10:34:33 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-000fDw-VJ; Wed, 14 Feb 2024 10:34:30 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-004Y5P-2t;
	Wed, 14 Feb 2024 10:34:30 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 084/164] pwm: pxa: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:11 +0100
Message-ID:  <bee8ae436a9dfb8539637cbb7269a208f787a62a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2352; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gQ9w7kaOKKUHbgFvVUOT6nuqeGO2O8KLl+bQfhtHlNU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIirlPx6FbXt8npEp4mTyBH3wNGbT5YIDM6fy saffF6fbtSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIqwAKCRCPgPtYfRL+ TpZ/B/43s48cSAIW6ymgylKVxy5vgpr5A1VkZo24/4rs4G7zlDoJI7Bby5DeoIiaLp3FFBOM2mD U4MJst+q+HG23vq0y8pcWhxJY9gGWBiAckcxzMjn2h4GOwIfB1yfuYlwo2tHnEINS8RdUhWt4Zs yjYw75w6GiSissGkff7zFLf/rkvVknVUo5tcyImHqTJxgelh86kIrYSzzpFDnOqE9XKWBdcmGUM 4LQjAaPkoMjSPqBVyLDmnbxyn9xslVpXjqzcKI2Hjnr3aBAZOSLa+fngaYZFkzaw4TgMeRLNZK+ eMtQecv/wIfKBwtFvA1k8uUYGNPA9s9k6xoa6N+PITmGU4Ky
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-pxa driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 61b74fa1d348..bb7bb48b2e6d 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -49,7 +49,6 @@ MODULE_DEVICE_TABLE(platform, pwm_id_table);
 #define PWMDCR_FD	(1 << 10)
 
 struct pxa_pwm_chip {
-	struct pwm_chip	chip;
 	struct device	*dev;
 
 	struct clk	*clk;
@@ -58,7 +57,7 @@ struct pxa_pwm_chip {
 
 static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct pxa_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -159,6 +158,7 @@ MODULE_DEVICE_TABLE(of, pwm_of_match);
 static int pwm_probe(struct platform_device *pdev)
 {
 	const struct platform_device_id *id = platform_get_device_id(pdev);
+	struct pwm_chip *chip;
 	struct pxa_pwm_chip *pc;
 	int ret = 0;
 
@@ -168,26 +168,27 @@ static int pwm_probe(struct platform_device *pdev)
 	if (id == NULL)
 		return -EINVAL;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (pc == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev,
+				  (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1,
+				  sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_pxa_pwm_chip(chip);
 
 	pc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pc->clk))
 		return PTR_ERR(pc->clk);
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &pxa_pwm_ops;
-	pc->chip.npwm = (id->driver_data & HAS_SECONDARY_PWM) ? 2 : 1;
+	chip->ops = &pxa_pwm_ops;
 
 	if (IS_ENABLED(CONFIG_OF))
-		pc->chip.of_xlate = of_pwm_single_xlate;
+		chip->of_xlate = of_pwm_single_xlate;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
-- 
2.43.0


