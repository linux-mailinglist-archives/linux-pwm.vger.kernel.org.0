Return-Path: <linux-pwm+bounces-1374-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D368545C9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4F65B22C67
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A5718635;
	Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3421759F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903276; cv=none; b=ZG/v6+C292/gxiZ/h/6bFNco7Tv4JFTGmPv9BybgmVsqud5Ozji7SBKynF3uWbYu3PpEdSy2aJ/0+V0g1PHHJE9OYOlSD6TRhlNunJQvHF3C5WSpK5rCFe5Onm1lUm2YZsptuINu8rtW11TwNqkEdafa19yTouJvUDJGq/LyS+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903276; c=relaxed/simple;
	bh=3da8qrj1JzLsfU2rOYyBMIHXaXMB5GdW4GAulxI0eRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5kPQ/IsAEWSJG1riKH+vLZ8MdKZYoQoRdZKi6MiSoME8b063KfHgBjOCMt3KsqKcLVjS8/3LP8rb+xfvnRsvjl2xspTLgs4QT8a7q2T4EozstiDd3qI6YSsh5uMa6SyH6cNsX7KiqE3m/d9HPb5Y0Ir+1CKzRpyk+tI3H9NaBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-0004xK-89; Wed, 14 Feb 2024 10:34:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-000fCc-FA; Wed, 14 Feb 2024 10:34:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-004Y3p-1G;
	Wed, 14 Feb 2024 10:34:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Vladimir Zapolskiy <vz@mleia.com>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 062/164] pwm: lpc18xx-sct: Prepare removing pwm_chip from driver data
Date: Wed, 14 Feb 2024 10:31:49 +0100
Message-ID:  <b7bf8c421ff754ec3e985ec6235f4ddd6e5e27a4.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2552; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3da8qrj1JzLsfU2rOYyBMIHXaXMB5GdW4GAulxI0eRc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHRPt47KY1T6/9gq5HHjvGb+wAk/v/H1sZZW3ZSZfi frnd4+tk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJnK7jYOiJTpA9uXbFniLL K1F3mrI5Bf7WqC/Z9vqu+5bdG9zWKR6wyWOM7Lt5R2m2sBbb6T0vcv+yWv+r1U4X/DWtRDWybVG 65FZOxijVrgTe+9KL07doMvRWRIckXvuxQpvZMY9rI7vZz3pbjejUWf9nymlEMfyYtr/M7cvB7r Nb4hryC2NUXsW98Iy3vR7i+SmQ8+/p14av5b87zFx8p+tlgH2yR9OVsuxJXkz5d8/vu+2wuHFJ5 I3QpZVx1yTk5jD6r9kcOWFLpHPw7c/sJT3ibJOPyT698z3GWUn/TbpWEJfSFNsa7ZP9h9I6FkXn P5kY52PFt4+pev22Lt5nCrZfbB5u+x1Y4DLDTJFnkoIqAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will drop struct
pwm_chip chip from struct lpc18xx_pwm_chip. Use the pwm_chip as driver
data instead of the lpc18xx_pwm_chip to get access to the pwm_chip in
lpc18xx_pwm_remove() without using lpc18xx_pwm->chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 46eeca27d9ab..9b1e8141aec7 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -348,6 +348,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_pwm_of_match);
 
 static int lpc18xx_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct lpc18xx_pwm_chip *lpc18xx_pwm;
 	int ret;
 	u64 val;
@@ -356,6 +357,7 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 				   GFP_KERNEL);
 	if (!lpc18xx_pwm)
 		return -ENOMEM;
+	chip = &lpc18xx_pwm->chip;
 
 	lpc18xx_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(lpc18xx_pwm->base))
@@ -386,9 +388,9 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm->min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC,
 						  lpc18xx_pwm->clk_rate);
 
-	lpc18xx_pwm->chip.dev = &pdev->dev;
-	lpc18xx_pwm->chip.ops = &lpc18xx_pwm_ops;
-	lpc18xx_pwm->chip.npwm = LPC18XX_NUM_PWMS;
+	chip->dev = &pdev->dev;
+	chip->ops = &lpc18xx_pwm_ops;
+	chip->npwm = LPC18XX_NUM_PWMS;
 
 	/* SCT counter must be in unify (32 bit) mode */
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CONFIG,
@@ -420,21 +422,22 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	val |= LPC18XX_PWM_PRE(0);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL, val);
 
-	ret = pwmchip_add(&lpc18xx_pwm->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "pwmchip_add failed\n");
 
-	platform_set_drvdata(pdev, lpc18xx_pwm);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static void lpc18xx_pwm_remove(struct platform_device *pdev)
 {
-	struct lpc18xx_pwm_chip *lpc18xx_pwm = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	u32 val;
 
-	pwmchip_remove(&lpc18xx_pwm->chip);
+	pwmchip_remove(chip);
 
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_CTRL,
-- 
2.43.0


