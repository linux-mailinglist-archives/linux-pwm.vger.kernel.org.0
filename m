Return-Path: <linux-pwm+bounces-1018-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A284283C1FB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54216290E3F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48F345028;
	Thu, 25 Jan 2024 12:11:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08716405F9
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184661; cv=none; b=KH9adPTPGbrXh9pO6UicYnDMce0N6SYaGehTXHw5SYxKMoGdLaItuHPjb9PNJvP3ta9+wHd5oZehYk9+i9cPe21uCo+tO3c5+PGhEw/0qs5r+OucqDjIjFXZZGxGX5rISVpk/p9bPDM2HAYwCUdY3WEoC7s4Po++ePJQv+YKJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184661; c=relaxed/simple;
	bh=r+uiUVOaGWwe7N2kbIo8z2q+oQVmCrs97Q6G78FFDzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldjz+awWAhkde1GxPXwnav1O9T+dUbd8AjDX5OW8kTs1mw2QfQ5C2wjCmUM5nJmhSPq8obwIJVTWEkerCHZ/ai88BTTG4QQywClUAloBpDTNuiYsKdxMBlMzBN9h8lADpeMvyUW/cE8VP5a/ado3X1GTz6O3voK1jUd6AlbrsOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZN-0004Um-Gq; Thu, 25 Jan 2024 13:10:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-002HTv-V1; Thu, 25 Jan 2024 13:10:55 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-007n3Y-2r;
	Thu, 25 Jan 2024 13:10:55 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 081/111] pwm: rcar: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:43 +0100
Message-ID:  <461995bfe1d43af40eb7b4905be96df325cbfcc2.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2449; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=r+uiUVOaGWwe7N2kbIo8z2q+oQVmCrs97Q6G78FFDzs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+ZCHA312WeFgtgrg7u+RsUcDdTsgvbczr3s cKZCnn8nlGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPmQAKCRCPgPtYfRL+ TqEzB/4w0E79pCTgBojoyf2dKsrRrKR+Fr4n02+pfLAZsuJL/NSg0sLSqOPVu5MqFHgbntxgDeU RQbMJ/5hjRrAPX8CeoNZN3scugU1HIUTjw/BZEp3IzeZRenCwSuk3FFSUjbBLWH9crI/GHDDAFW iEwIG7r6+R2HOA5lri/wism6JqxHZy6reXnVkJ4xH15DCpXOYZLcHtPT5V9C/wNocdeyC+fErS/ Se6m8M8uVxCwixyL5jnvp/vgoQ9Vz9qFLHVuUu21LFRMGl9Nj3ikKQ5kJrnI6jkk5zZ74LVOwIH d5vSXO9yCZb43PQEsFG5lNPaFJSuEqlvU9s49kzukFP2MmFR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-rcar driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-rcar.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 4838762137d1..435d5587fd55 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -38,14 +38,13 @@
 #define  RCAR_PWMCNT_PH0_SHIFT	0
 
 struct rcar_pwm_chip {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct rcar_pwm_chip *to_rcar_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct rcar_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void rcar_pwm_write(struct rcar_pwm_chip *rp, u32 data,
@@ -202,12 +201,14 @@ static const struct pwm_ops rcar_pwm_ops = {
 
 static int rcar_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct rcar_pwm_chip *rcar_pwm;
 	int ret;
 
-	rcar_pwm = devm_kzalloc(&pdev->dev, sizeof(*rcar_pwm), GFP_KERNEL);
-	if (rcar_pwm == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*rcar_pwm));
+	if (chip == NULL)
 		return -ENOMEM;
+	rcar_pwm = to_rcar_pwm_chip(chip);
 
 	rcar_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rcar_pwm->base))
@@ -219,15 +220,13 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(rcar_pwm->clk);
 	}
 
-	platform_set_drvdata(pdev, rcar_pwm);
+	platform_set_drvdata(pdev, chip);
 
-	rcar_pwm->chip.dev = &pdev->dev;
-	rcar_pwm->chip.ops = &rcar_pwm_ops;
-	rcar_pwm->chip.npwm = 1;
+	chip->ops = &rcar_pwm_ops;
 
 	pm_runtime_enable(&pdev->dev);
 
-	ret = pwmchip_add(&rcar_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
 		pm_runtime_disable(&pdev->dev);
@@ -239,9 +238,9 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 
 static void rcar_pwm_remove(struct platform_device *pdev)
 {
-	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&rcar_pwm->chip);
+	pwmchip_remove(chip);
 
 	pm_runtime_disable(&pdev->dev);
 }
-- 
2.43.0


