Return-Path: <linux-pwm+bounces-1404-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7F28545DA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1A471C27092
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D5318E0F;
	Wed, 14 Feb 2024 09:34:42 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3051759F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903282; cv=none; b=aIae+g1xMBPgXF0uVxIlz0p1yhZwmDLg2OBLSlSFU7LGUHX1ecOrIVMLHKxx/wcTxZtWTX/lLMSjBa5KUmlczkIZX5lkr4aOrbT2PC9synPHVIf1R+lS43yubOxO26jHEDizifY7t3RQtpGQs9fqPvILFMb+zOIZLSOw9sNsiOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903282; c=relaxed/simple;
	bh=o5zZQs/yELtRnFV47mC3M7DYy7Sz7CHVJZ2nMHsXK+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aW7jCQj2Vl/EaBZm2NalgJLO2Ox72x1yudUOsa69Oxevb5LrQ8AO5ePBLng3FFX8dbOOryahVu3pJdcni+inT8uwmXR/WjPN/WfSYlzHJnkqQz9Ew+1N+s4goduwlQKINgAGjalFMyNq6/ytNQuGr/4RL3VwR8M9MTW4LBB+OfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-0005cu-TT; Wed, 14 Feb 2024 10:34:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-000fFG-6e; Wed, 14 Feb 2024 10:34:34 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf0-004Y6z-0P;
	Wed, 14 Feb 2024 10:34:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Walle <mwalle@kernel.org>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 106/164] pwm: sl28cpld: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:33 +0100
Message-ID:  <ee687086f7fc78264fac723f65ddc96cb7518c03.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=o5zZQs/yELtRnFV47mC3M7DYy7Sz7CHVJZ2nMHsXK+E=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHUcdn93mTdbakOrFvb1BKVT1/jOrpm7mqZI1PAeaT JdmORh2MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCR+/PZ/0cn/Xgqs3iuzYxt fa6Sn11ypVYqL+WJWaUUb8SrKPgpQyaLKdvplYznyphL1RHPv7U7vnvMULNtou3nvj/K2VNETht sVt+5eM+ni8t9M3hWtS547MoZ9iuKNTOi4VuGXtW+kvZVe6bc6jirwcjvz3KzxyWqp/G4965p2+ K4wkWj1wgaT2Te4u7jKPm/Jb5SSdc/tWR1uMnEpTOcP//VcBfvLjQRE5m2fM7381bNzPw/G7bvm fiEe3u5dP28Z4mXE36qO76SzHW+vsNIf4a6W5X59X57/Ynn/9842fjszMNcodlnD8mlZV7X9/b2 UeXdwH1ep/MlQ7j2DdFp1xfMYeVr5/27Xs0254RWus17AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sl28cpld driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sl28cpld.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-sl28cpld.c b/drivers/pwm/pwm-sl28cpld.c
index 88b01ff9e460..934378d6a002 100644
--- a/drivers/pwm/pwm-sl28cpld.c
+++ b/drivers/pwm/pwm-sl28cpld.c
@@ -81,14 +81,13 @@
 	regmap_write((priv)->regmap, (priv)->offset + (reg), (val))
 
 struct sl28cpld_pwm {
-	struct pwm_chip chip;
 	struct regmap *regmap;
 	u32 offset;
 };
 
 static inline struct sl28cpld_pwm *sl28cpld_pwm_from_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sl28cpld_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int sl28cpld_pwm_get_state(struct pwm_chip *chip,
@@ -213,9 +212,10 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = sl28cpld_pwm_from_chip(chip);
 
 	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!priv->regmap) {
@@ -231,10 +231,7 @@ static int sl28cpld_pwm_probe(struct platform_device *pdev)
 	}
 
 	/* Initialize the pwm_chip structure */
-	chip = &priv->chip;
-	chip->dev = &pdev->dev;
 	chip->ops = &sl28cpld_pwm_ops;
-	chip->npwm = 1;
 
 	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret) {
-- 
2.43.0


