Return-Path: <linux-pwm+bounces-994-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F52183C1DD
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 041C81F22874
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A1A45C1B;
	Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE0045035
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184656; cv=none; b=seyyCNtjGoEGkTTTA05ROn0Ict2u5EJKuNqwBKFfRKcidAbVaqRwD3r2YGUpBPiIVuX/q+Ve5u0oypa9hXxxoptRhGd/1JqH+sJAleUo/unBN8zsk5Umdq2EoRD+ukI9qzvLwFAxcDBjzXLe1TJqIoPTHeHggdebtifTOtGUJns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184656; c=relaxed/simple;
	bh=o0cVfZhddFtCWqqsKm/jq5w34FGtAp38ZdgI98XUaM4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qooA2JcNZ7lKyb9pb8v8gYdOVM4TG8IFfqzsuo4333y6HXNBGYEvy97vwVTF/5Y/tBwosnz7Zp7req6MY2/JzN7RTRhJ5B2vUa7WvLeHaLZPl6P0/j0GDLiSgVewMeYccv6ipH/VEuqC3W9qxdia8MGMmbVROjJ7n/ra1tDdA0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-0004L8-8k; Thu, 25 Jan 2024 13:10:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-002HSS-Ev; Thu, 25 Jan 2024 13:10:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-007n1z-1F;
	Thu, 25 Jan 2024 13:10:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 058/111] pwm: hibvt: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:20 +0100
Message-ID:  <eae04f95245e97862e3c6ba9165375b780be626b.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2999; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=o0cVfZhddFtCWqqsKm/jq5w34FGtAp38ZdgI98XUaM4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9+Vu9FWP9m/enDD7A1nmKZmmSB1b3+3TQqM NEfyHXaprGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPfgAKCRCPgPtYfRL+ TrjuB/9+xrNwiI3gR5kwXtydpGK5fJi89ZmDahK0Tt+iHIZMbTGVwfXoAUpwGHO1VxNYb2XqKth +FHfZVPFfWGz2X3EozheKjo0XMC2+QXFd2mr9qwhiJCrFiV8OEu1oHBkHAiOChIY43jVrcfh7em MgoaCF/nZ90TajLvgu+yexlrxSyXRAXi1PTjTTUillwk9QpEIGaV/Kvf3m4MgfwGpJirvtTclVp guChv7Xh/JDM2l7mzbZ6c8IuvV9QYA3FM8VTjhU/XNNdv/eGKF9hH6hLtqj2/57t9uXndScd2K7 EWeRWRLwlBFsqXWHaOqUzPAC+49S5GxxeT9Fn3Vn7sR4cI6C
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-hibvt driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-hibvt.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index c435776e2f78..65d53717610b 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -33,7 +33,6 @@
 #define PWM_DUTY_MASK       GENMASK(31, 0)
 
 struct hibvt_pwm_chip {
-	struct pwm_chip	chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
@@ -65,7 +64,7 @@ static const struct hibvt_pwm_soc hi3559v100_soc_info = {
 
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct hibvt_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static void hibvt_pwm_set_bits(void __iomem *base, u32 offset,
@@ -191,12 +190,14 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct pwm_chip	*chip;
 	struct hibvt_pwm_chip *pwm_chip;
 	int ret, i;
 
-	pwm_chip = devm_kzalloc(&pdev->dev, sizeof(*pwm_chip), GFP_KERNEL);
-	if (pwm_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, soc->num_pwms, sizeof(*pwm_chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
 	pwm_chip->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(pwm_chip->clk)) {
@@ -205,9 +206,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pwm_chip->clk);
 	}
 
-	pwm_chip->chip.ops = &hibvt_pwm_ops;
-	pwm_chip->chip.dev = &pdev->dev;
-	pwm_chip->chip.npwm = soc->num_pwms;
+	chip->ops = &hibvt_pwm_ops;
 	pwm_chip->soc = soc;
 
 	pwm_chip->base = devm_platform_ioremap_resource(pdev, 0);
@@ -228,29 +227,31 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	msleep(30);
 	reset_control_deassert(pwm_chip->rstc);
 
-	ret = pwmchip_add(&pwm_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		clk_disable_unprepare(pwm_chip->clk);
 		return ret;
 	}
 
-	for (i = 0; i < pwm_chip->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		hibvt_pwm_set_bits(pwm_chip->base, PWM_CTRL_ADDR(i),
 				PWM_KEEP_MASK, (0x1 << PWM_KEEP_SHIFT));
 	}
 
-	platform_set_drvdata(pdev, pwm_chip);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void hibvt_pwm_remove(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct hibvt_pwm_chip *pwm_chip;
 
-	pwm_chip = platform_get_drvdata(pdev);
+	chip = platform_get_drvdata(pdev);
+	pwm_chip = to_hibvt_pwm_chip(chip);
 
-	pwmchip_remove(&pwm_chip->chip);
+	pwmchip_remove(chip);
 
 	reset_control_assert(pwm_chip->rstc);
 	msleep(30);
-- 
2.43.0


