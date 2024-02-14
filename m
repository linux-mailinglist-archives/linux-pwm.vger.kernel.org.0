Return-Path: <linux-pwm+bounces-1334-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 998A6854591
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C1F1F2E030
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8507D1862F;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8FD175A7
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=HPuX+ceeji5+5jKh0XpXKPrGdZGfaFGOoHEuwB/eu0K1XUQNhBI0shY+x83p2MKyTSukfxw/Ypk83QCuK71DmvfZMyasFLpUkz3m7uqZxQpBUJq/Jm5zbAHx7EnHJz1ykAIh7Dk0GLxR9gCRw0LJ46B4o5rNAED0NgkL/lWCdOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=gyrgGlXTWMnebiB+hz+WH9nrN2SBwKfFMXH7r00+5dc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m+c9Nf1ABjdIqdqJ7nnhJ+2YSsKFSM70Xb9njLPOlBLVbGZomH2VzA72E179DEx4LZJY09taXyRYd1U9LV7HGJyAtfcsT8FRNnjS4hTd0GIy8sVaNV6jl4WZsgK03qegzMFovWEBf2xLn0jlq2GVeeAJSPLiVDx7wBAs9rcF2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-0004Ya-OW; Wed, 14 Feb 2024 10:34:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-000f9e-P7; Wed, 14 Feb 2024 10:34:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-004Y1G-2H;
	Wed, 14 Feb 2024 10:34:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Alexander Shiyan <shc_work@mail.ru>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 025/164] pwm: clps711x: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:12 +0100
Message-ID:  <334e633bb8e4c26dc59883b068466387769b65f9.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2072; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gyrgGlXTWMnebiB+hz+WH9nrN2SBwKfFMXH7r00+5dc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhnaOjCBHGn+o3Ok1bhX2UuEaK5pP+4nxTtw Y7mKhj77zGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIZwAKCRCPgPtYfRL+ TpQUCACTA48IuaJcdy+Fxk0TIVBsStrCdx6SpohDDGeuSnPQaWFkYtE30BesEY1u7IUFLoY/wpz wCmN71AhHPrlWqr1Uj+poAmfUj0gAm9rFnDNpkN4y5fnUsswXIyCbb7g+mPJUYvSSswTSLHlJ83 UNaIfprDAmKGyAGbVoXHXtKr23EshX8G/ty3GbJsz08xrUIPBzDiZ7LCqMsy63kgB2dDCzvgUrd EbPK1THpdS3YTGRaQPfrJNGSBXkTKvCadzykEaWuPLOosNQIxKZjtr9i4WIw1Cd4RQ1d4Ov4+UM RD9UmBX2Rc6DJTKHqwFzs1XeCL/VuCLSAHaNWo8mMe+Tu7hw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-clps711x driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clps711x.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index f3b4af7963be..c950e1dbd2b8 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -12,7 +12,6 @@
 #include <linux/pwm.h>
 
 struct clps711x_chip {
-	struct pwm_chip chip;
 	void __iomem *pmpcon;
 	struct clk *clk;
 	spinlock_t lock;
@@ -20,7 +19,7 @@ struct clps711x_chip {
 
 static inline struct clps711x_chip *to_clps711x_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct clps711x_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -76,11 +75,13 @@ static const struct pwm_ops clps711x_pwm_ops = {
 
 static int clps711x_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct clps711x_chip *priv;
 
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 2, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_clps711x_chip(chip);
 
 	priv->pmpcon = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->pmpcon))
@@ -90,13 +91,11 @@ static int clps711x_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->clk))
 		return PTR_ERR(priv->clk);
 
-	priv->chip.ops = &clps711x_pwm_ops;
-	priv->chip.dev = &pdev->dev;
-	priv->chip.npwm = 2;
+	chip->ops = &clps711x_pwm_ops;
 
 	spin_lock_init(&priv->lock);
 
-	return devm_pwmchip_add(&pdev->dev, &priv->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static const struct of_device_id __maybe_unused clps711x_pwm_dt_ids[] = {
-- 
2.43.0


