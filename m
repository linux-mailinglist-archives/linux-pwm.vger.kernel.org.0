Return-Path: <linux-pwm+bounces-1447-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C290885460A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D5E1F2E062
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1861428B;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EB5199C2
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=JulAhtZouDjgzAfdcXBK9l7T3LnyOA4VfvVNu8516gKwptyWTsKc+rDtkgPLphukQsB17q24hnFxDuzbRgC4ao5HEAx97fhX2cCBfubZdkz/UJAtR2waw19z1AlN2fOW7KRLTaKhVdwzJ2qSO02KrY05vhxAFNptksXIvWEWZPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=GGp6F/CrVh/Zyzhl9/Ss3sSpbkBZs8PpI1fWsL4vDOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKdDW62nJJz708n9mWpvbwoiHJxqSa3tDLdCFD9QJnQfkig3eFPjhdB7auXJ0jYPR4Awtufz7mFCTp+KRyDCrwCIwLVNDd449edtMUoSAiqkIShZP6kILxbLI1b1Xpt1exaWj2cAXi0J1hHKtKBVVo4ng85PTs/ERS8jGpqzzIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-00061u-55; Wed, 14 Feb 2024 10:34:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-000fH7-IO; Wed, 14 Feb 2024 10:34:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-004Y91-1Z;
	Wed, 14 Feb 2024 10:34:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 135/164] pwm: tiecap: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:33:02 +0100
Message-ID:  <af7846109c0df225126c8e5cd186b89ace70afc0.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GGp6F/CrVh/Zyzhl9/Ss3sSpbkBZs8PpI1fWsL4vDOM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjm+28C5M/vRBV49Gz6bEjhNecq9iEdQxi8p qu4GxG8TXWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI5gAKCRCPgPtYfRL+ TtR3B/wK16HAuC6m+Y++oHfZYXanKSqY89tarGMVGvKzN5+bAfu/dUoXYKqRxTiHKYHW5T68LKB ElEp8gpOaK5x75gSYED/JwJS9qfXa10ESVOJjmQSDlGFRy08CISIOGVN8s3HAiToyARAUFv9CoM +MpetolDbiPedMIVfyg+xlUoFNLC0m7NoiKZuy4Vkvk/KUmo4a35QCRQ53+vlZBvkzpLkJtzUbe GzvjTzXqYfgJA+QE4c5SlhOEAVaAOC9jyKC60DwpwoVvr0YElQZ/uhgN+JFfkFR3o/PGT5QVXHf HQy5Dh2NB1sXzzkL6legxmuKrehOnDh7LfdGQwDDys5q8fKu
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-tegra driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index 558b244f074a..d6c2b1b1387e 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -32,7 +32,6 @@ struct ecap_context {
 };
 
 struct ecap_pwm_chip {
-	struct pwm_chip chip;
 	unsigned int clk_rate;
 	void __iomem *mmio_base;
 	struct ecap_context ctx;
@@ -40,7 +39,7 @@ struct ecap_pwm_chip {
 
 static inline struct ecap_pwm_chip *to_ecap_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct ecap_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 /*
@@ -222,9 +221,10 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 	struct clk *clk;
 	int ret;
 
-	pc = devm_kzalloc(&pdev->dev, sizeof(*pc), GFP_KERNEL);
-	if (!pc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pc = to_ecap_pwm_chip(chip);
 
 	clk = devm_clk_get(&pdev->dev, "fck");
 	if (IS_ERR(clk)) {
@@ -245,10 +245,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	chip = &pc->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &ecap_pwm_ops;
-	chip->npwm = 1;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
-- 
2.43.0


