Return-Path: <linux-pwm+bounces-1417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1898545EB
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06F51C270D9
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FD91AACA;
	Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D245218EC3
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903285; cv=none; b=JyLfvRLUK8DBSErEAU3M8LNS3hwyc2XdlG+ZzBEk3+UJFG2CWlSLUEFXPYbZ0/33Nkh0gTtQKqrQT2a2JKVFz1caCY3S3qeGq4149gMTsBQ9M2CTvRUtyMp8QOow+93Ty2f2qpxoun1bz0I0ZAqiTuSvbwh+NlIGoaQllhGhqKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903285; c=relaxed/simple;
	bh=5crgfzM9h8QstH1wGkHc8bfPWS3UUWzoWy5opErr66o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QC1O0zOJQcYMeEcOno0J/Bp1tFt7q9gyWXX3WETHd8a2B0NhwSybsDNYQjRdkuVGIMefGS5yebRe9afOv/JyGKHVQ9lZbxBv99a2lS7VwRHbCfY0Tj7ODgGQVHmW3+yNhQ2r8SNK7auCf4EIQ8ovlyjr8X1u19MjksMbOdEBUF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005w6-CK; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGg-IM; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8P-1b;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Hammer Hsieh <hammerh0314@gmail.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 128/164] pwm: sunplus: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:32:55 +0100
Message-ID:  <192be7e428eff17dd922c9c0d0d168225b89bb34.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1960; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5crgfzM9h8QstH1wGkHc8bfPWS3UUWzoWy5opErr66o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjeKVMSyI7KmB2SVkwLX88Eno2LbG1bhgLAZ XU8dFmXbCiJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI3gAKCRCPgPtYfRL+ Ti/LCACVWLYaMPgrn2CdLKAWaBEz2KiWdTm8CK5cdWliS56/L9RsJJA9NbdrDGURvQQssUuVqxN b8l06rEI0Z4/VMBoHFnjt7LoJZ49EXZrkbj/dbKS68O4GcB3rWD6Qh59pEoq6Cd0pMEDJc8Mm8e u3Uuz/iF0QXYi1GEFdrv5S/yi4WThIRFPqtbv5FQucvWpTfQoVVkNiqq0HyCsBW8ivH6qLK52Ic FkA65vucIjBSWcsI72ywTeW3P4kqzB8Nsq/CZDlsB36ay0ssCRzmgnzqA6v7Q4xt9NqnkdCwc4r 1A5TcOm6EinjpBJDX2e/gDKuWONCylWE33VZ8r8UFXil95z+
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-sunplus driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sunplus.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-sunplus.c b/drivers/pwm/pwm-sunplus.c
index 773e2f80526e..b342b843247b 100644
--- a/drivers/pwm/pwm-sunplus.c
+++ b/drivers/pwm/pwm-sunplus.c
@@ -43,14 +43,13 @@
 #define SP7021_PWM_NUM			4
 
 struct sunplus_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
 };
 
 static inline struct sunplus_pwm *to_sunplus_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct sunplus_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int sunplus_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -175,12 +174,14 @@ static void sunplus_pwm_clk_release(void *data)
 static int sunplus_pwm_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct sunplus_pwm *priv;
 	int ret;
 
-	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(dev, SP7021_PWM_NUM, sizeof(*priv));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	priv = to_sunplus_pwm(chip);
 
 	priv->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->base))
@@ -203,11 +204,9 @@ static int sunplus_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	priv->chip.dev = dev;
-	priv->chip.ops = &sunplus_pwm_ops;
-	priv->chip.npwm = SP7021_PWM_NUM;
+	chip->ops = &sunplus_pwm_ops;
 
-	ret = devm_pwmchip_add(dev, &priv->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Cannot register sunplus PWM\n");
 
-- 
2.43.0


