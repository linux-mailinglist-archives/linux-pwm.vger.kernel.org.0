Return-Path: <linux-pwm+bounces-1036-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8238283C212
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0021F230C6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D29445022;
	Thu, 25 Jan 2024 12:11:05 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CFE3A1B6
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184665; cv=none; b=GKO962QcYCagyAWnombuFvXpDGEanZPYVKP0K0a1FDScSNESby20zyc6/QMEiNZXYkbC6Qx5sr2fO7BI4MiAe+wyOstwlJmMafmb8L366Lr5v75aRxn0xzjKiCSt1SmBWmbLJ6jSL6RDdRiWmKzmXcF/tDp1sXxcWvRphhBFjDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184665; c=relaxed/simple;
	bh=ZntXgTZI9dQH8TWQ+94AuqHDVkwvSRMP95xrnBIG4co=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RymjNI8jba16RUwkrRc1TsnJEArrtCiLmrmBaYnAcHiugwFoElQ8wwXc/XnBSA6yhTugIQR+lZA947jO/LgcOZEbUsBCKc4RDJdsDQ9pKP3ZKWbvUXkQOGSez6r/a47xJ5K8Dqg3GZYeed/VFgmlgQMG16lNY/Hm0RU6FwRlV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZL-0004Rd-Jv; Thu, 25 Jan 2024 13:10:55 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-002HTQ-Ef; Thu, 25 Jan 2024 13:10:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZK-007n32-1C;
	Thu, 25 Jan 2024 13:10:54 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	linux-pwm@vger.kernel.org
Cc: linux-riscv@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 073/111] pwm: microchip-core: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:35 +0100
Message-ID:  <42fb7450f73c1eb1aa33fb4d896eca75b526116f.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2673; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ZntXgTZI9dQH8TWQ+94AuqHDVkwvSRMP95xrnBIG4co=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+Q1dKVs0JHErbbeNbC2+bO54n74VgU1f/GY j14HOAMR2aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPkAAKCRCPgPtYfRL+ TlbRB/0ZaybKGvcUCZ+JG/DCa1UFPNGyeluNTTtTGh6mZXqSh1Z8ish+tVSLumPbjayVPxhOEEQ FFpE3KnW5NXEaphs7vruX/l/1ZSAqKPlIsRFmkegWqnm1NQ68omVP82COMiZZ2d0BX+q/5vEeYO gbpDE42ms7UxbzRZ0LibcOme9MjXfdV7vpDwNGl3A/P4SILKwlyAzSOncRiPjmYopDU61AWk/tH r0Ffpj0Xei5NlPmHX8nWcDy7Lapz53DSAFSPJSMo//fm05oRot46ObG00Mwxx3e5WVV8kKIaVgt HrRtdbhDplrCx9TW6smjU97PYcEpRHCt3kKVPbxPIoDSRpyn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-microchip-core driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-microchip-core.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-microchip-core.c b/drivers/pwm/pwm-microchip-core.c
index c0c53968f3e9..c1f2287b8e97 100644
--- a/drivers/pwm/pwm-microchip-core.c
+++ b/drivers/pwm/pwm-microchip-core.c
@@ -54,7 +54,6 @@
 #define MCHPCOREPWM_TIMEOUT_MS	100u
 
 struct mchp_core_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct mutex lock; /* protects the shared period */
@@ -65,7 +64,7 @@ struct mchp_core_pwm_chip {
 
 static inline struct mchp_core_pwm_chip *to_mchp_core_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct mchp_core_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void mchp_core_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -447,13 +446,15 @@ MODULE_DEVICE_TABLE(of, mchp_core_of_match);
 
 static int mchp_core_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct mchp_core_pwm_chip *mchp_core_pwm;
 	struct resource *regs;
 	int ret;
 
-	mchp_core_pwm = devm_kzalloc(&pdev->dev, sizeof(*mchp_core_pwm), GFP_KERNEL);
-	if (!mchp_core_pwm)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 16, sizeof(*mchp_core_pwm));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	mchp_core_pwm = to_mchp_core_pwm(chip);
 
 	mchp_core_pwm->base = devm_platform_get_and_ioremap_resource(pdev, 0, &regs);
 	if (IS_ERR(mchp_core_pwm->base))
@@ -470,9 +471,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 
 	mutex_init(&mchp_core_pwm->lock);
 
-	mchp_core_pwm->chip.dev = &pdev->dev;
-	mchp_core_pwm->chip.ops = &mchp_core_pwm_ops;
-	mchp_core_pwm->chip.npwm = 16;
+	chip->ops = &mchp_core_pwm_ops;
 
 	mchp_core_pwm->channel_enabled = readb_relaxed(mchp_core_pwm->base + MCHPCOREPWM_EN(0));
 	mchp_core_pwm->channel_enabled |=
@@ -485,7 +484,7 @@ static int mchp_core_pwm_probe(struct platform_device *pdev)
 	writel_relaxed(1U, mchp_core_pwm->base + MCHPCOREPWM_SYNC_UPD);
 	mchp_core_pwm->update_timestamp = ktime_get();
 
-	ret = devm_pwmchip_add(&pdev->dev, &mchp_core_pwm->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to add pwmchip\n");
 
-- 
2.43.0


