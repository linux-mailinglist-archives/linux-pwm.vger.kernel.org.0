Return-Path: <linux-pwm+bounces-1329-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A64854595
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E25B227BF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C925182BB;
	Wed, 14 Feb 2024 09:34:27 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3E14015
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903266; cv=none; b=GjbGGsag+LBR+e71SaVuBqa9A3ULh2qnTxE1y8iF8bNfwtOv0J84F+w8sJuS9W45rLN6os9iPsQNMko6LnwU7r7wudFai7ifhsaGE8zBWDXuDoz49mclKLJwDUmKWFxSWM5BIL4OZ3/7knHb5YbPQ0TcFpLIYWrY7C42KA4SyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903266; c=relaxed/simple;
	bh=cxUQ+QHHD0E7s3PsvfSSzC/e5lq6tNORX/pznhSgxRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0pQhyhBTEvcQOcppKZp9VUaF3KkOba95X6M9J/z7MRitDeh5HFpNr128IDV/QxHqIdcjvA8Y3tuxKffA82A4H4XNq4ml6IPvAUOMN5QfarDg/R8LEuI/cxVA+r0v7Rr3E8cv7+/5FPr8d6lHm422InH0VjnNjJqIjczWquSVCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-0004YP-H1; Wed, 14 Feb 2024 10:34:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-000f9a-Lm; Wed, 14 Feb 2024 10:34:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-004Y1D-1t;
	Wed, 14 Feb 2024 10:34:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 024/164] pwm: clk: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:11 +0100
Message-ID:  <c02ccc955fe7a0aec7ce0ccaf5cd2bd902ae687f.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1814; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=cxUQ+QHHD0E7s3PsvfSSzC/e5lq6tNORX/pznhSgxRQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhmvKrvSP+WjD0vZIvxmDnj2cKu9i8V8+5j4 hJBX4M+roeJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIZgAKCRCPgPtYfRL+ TvINB/9eSqINhVBGloDPnFr3mtmPTaU8VvNlosXpboTSkpU9CTiLxGnujIag0+AZ1G7/pfTS0yg uWYFpNDVKXJ3Z87PZKALEj7XaxBOlDPA40U9kMy4zbuR/EjGm1ID2WZSBxK6H2/ophPwrPQLr4w VjfW7PR0vNw+rSK+LxuwDxAvVNuI1dLpnjONeeh+g+ltvwnM2xz6KtaOy9ZSDdFWdUW8dW4IjQR hBHNWey55kCr/zLeuW0GVnMY6GLCEgkknPUn6Xpb7HcyXoFAsmAZxLk+zFEP9JiHj8yQMlumMJx k7o7g3/VZLNA3xXe7qrkEQACLfd9Nnzk5K28E+odofyZwfx0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-clk driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Also convert the to_pwm_clk_chip() helper macro to a static inline to
get some type safety.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-clk.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
index aef35d9a6a61..c19a482d7e28 100644
--- a/drivers/pwm/pwm-clk.c
+++ b/drivers/pwm/pwm-clk.c
@@ -28,12 +28,14 @@
 #include <linux/pwm.h>
 
 struct pwm_clk_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	bool clk_enabled;
 };
 
-#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, chip)
+static inline struct pwm_clk_chip *to_pwm_clk_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int pwm_clk_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
@@ -85,19 +87,17 @@ static int pwm_clk_probe(struct platform_device *pdev)
 	struct pwm_clk_chip *pcchip;
 	int ret;
 
-	pcchip = devm_kzalloc(&pdev->dev, sizeof(*pcchip), GFP_KERNEL);
-	if (!pcchip)
-		return -ENOMEM;
-	chip = &pcchip->chip;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*pcchip));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	pcchip = to_pwm_clk_chip(chip);
 
 	pcchip->clk = devm_clk_get_prepared(&pdev->dev, NULL);
 	if (IS_ERR(pcchip->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(pcchip->clk),
 				     "Failed to get clock\n");
 
-	chip->dev = &pdev->dev;
 	chip->ops = &pwm_clk_ops;
-	chip->npwm = 1;
 
 	ret = pwmchip_add(chip);
 	if (ret < 0)
-- 
2.43.0


