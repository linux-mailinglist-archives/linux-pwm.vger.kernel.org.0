Return-Path: <linux-pwm+bounces-1425-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA723854602
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B606B22F73
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6795C1B7EF;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477819BA2
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903287; cv=none; b=BTCVXiZ7NcPj90iUVaFfqOTS2nS56KKfEPUUbJgJ/PcXv+FU1dV7ivacs0dNhGPGrsOyHw+h4sf5WKYOa1xTndXgJXGLO458VY7iFjdJxIRppGYKkbPaNBSgJg1k860LZGMbo/QUOXBEwApizSGTOC9C5MyfCtlakBGdVsPeiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903287; c=relaxed/simple;
	bh=3v6X/rsxer0vDPK7DKg5bXut2iQNblBHiv/m7ZhnHuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXGc/u31azpjahBH0m2tqO+NSEBYKyeKTNz7qoCvRRKWc1y7y7m1I4O6uWgANtC5kYQDRn1j0FJJINfVKNEbNjFp8RA5yiJCXat+xTIDNt90wkit4v87FZhVIt6bNDFkBeHfZVLXfDRcG1CvTfRsLc5uAWmfXr5QLVMGF0RHc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-0005V0-5E; Wed, 14 Feb 2024 10:34:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-000fEs-3E; Wed, 14 Feb 2024 10:34:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBez-004Y6N-04;
	Wed, 14 Feb 2024 10:34:33 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 099/164] pwm: samsung: Simplify by using devm functions in probe
Date: Wed, 14 Feb 2024 10:32:26 +0100
Message-ID:  <d46ec625c14c460039082f74ec8ca3084b7c8e3a.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2301; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3v6X/rsxer0vDPK7DKg5bXut2iQNblBHiv/m7ZhnHuY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi9JgUZ1qPpDDBkOWLudUXKLXy1s3CQlmeMd X1eK4wZ7P6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIvQAKCRCPgPtYfRL+ TkDECACOQhL3yH4vO+rA5qPmJEOOHzv6MLKcO3Cvdj6aq+DSb+1yq9+x16z5AuhgyzgFUmopefY DAnN7FxMHjLrX+KCzhiBhErdQkB4CM8Qr1jmLq/4914ZQ/USoTzx00oI112ko5qPHbJkMku0KzW LY6w40l5kgP4WL8voUyTrnF6sR1lYgftUaG7HmPxA1CEv+q6iGBMN5EyLezxjIyaVYlETWZ8m4S odZMZEN+bgvH6qt9njfe1Kuu1UOkd5iP+KnMNSo5mWNZYGwXQSjd4HRzUgSVFXr2484m5alH+iS tmhQVfVvAPgmBG9OGQNIzT1vjd6YKDI10vL92/Ip3Pfe0d2V
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With using devm_clk_get_enabled() and devm_pwmchip_add() the
.remove_new() callback can be dropped and an error path in .probe()
simplified.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index cabdcdf37ec9..81a2e66e927e 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -577,18 +577,12 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	if (IS_ERR(our_chip->base))
 		return PTR_ERR(our_chip->base);
 
-	our_chip->base_clk = devm_clk_get(&pdev->dev, "timers");
+	our_chip->base_clk = devm_clk_get_enabled(&pdev->dev, "timers");
 	if (IS_ERR(our_chip->base_clk)) {
 		dev_err(dev, "failed to get timer base clk\n");
 		return PTR_ERR(our_chip->base_clk);
 	}
 
-	ret = clk_prepare_enable(our_chip->base_clk);
-	if (ret < 0) {
-		dev_err(dev, "failed to enable base clock\n");
-		return ret;
-	}
-
 	for (chan = 0; chan < SAMSUNG_PWM_NUM; ++chan)
 		if (our_chip->variant.output_mask & BIT(chan))
 			pwm_samsung_set_invert(our_chip, chan, true);
@@ -599,10 +593,9 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, chip);
 
-	ret = pwmchip_add(chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
-		clk_disable_unprepare(our_chip->base_clk);
 		return ret;
 	}
 
@@ -614,16 +607,6 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void pwm_samsung_remove(struct platform_device *pdev)
-{
-	struct pwm_chip *chip = platform_get_drvdata(pdev);
-	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
-
-	pwmchip_remove(chip);
-
-	clk_disable_unprepare(our_chip->base_clk);
-}
-
 static int pwm_samsung_resume(struct device *dev)
 {
 	struct pwm_chip *chip = dev_get_drvdata(dev);
@@ -666,7 +649,6 @@ static struct platform_driver pwm_samsung_driver = {
 		.of_match_table = of_match_ptr(samsung_pwm_matches),
 	},
 	.probe		= pwm_samsung_probe,
-	.remove_new	= pwm_samsung_remove,
 };
 module_platform_driver(pwm_samsung_driver);
 
-- 
2.43.0


