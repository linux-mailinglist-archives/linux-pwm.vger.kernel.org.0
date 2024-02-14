Return-Path: <linux-pwm+bounces-1360-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8618545AF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2185E1F2E028
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A43168CD;
	Wed, 14 Feb 2024 09:34:32 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE98E18C36
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903271; cv=none; b=py1cyd0gDMeeNeKlX34yFdzul3DR4KDXDGSITdpWU7JwzUlWUUy9j35oLzpbH2ZC2ayyYDZ26pICqsLtSP31K+uLQm1PlHHZYrPX58mx6UsP/3nZUzEQJ+qcdQrEGC+nGBPcMAbmybatr9DzC/i4kNkvuHiqyXAwf4ShkwZ7+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903271; c=relaxed/simple;
	bh=4UWwN6hGhiY3Lx7k+3TOX6wn+Xv0GX/Yqr4Jly9g4dU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYEZcA1UmahBQKKbuK6hx9Ed7sb1dc9vGvvHluHznbXkjprdwqHSfXXWcXqRIpZ7q/ggq3+PlHxSH1A/E+kelM8QPukCRdZV+9dwJ1XgMRxH8OS7iDpZjJ2e8OzMxguFUbtYg5l59BL+YLP7z9hjWvw5MAtiOsSinkCynN3iYxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBes-0004kP-7l; Wed, 14 Feb 2024 10:34:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-000fBt-Fs; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y2z-1K;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v6 049/164] pwm: imx27: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:36 +0100
Message-ID:  <3da748c80e9bbe29e7c119190dbc4bd67d159f22.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2566; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4UWwN6hGhiY3Lx7k+3TOX6wn+Xv0GX/Yqr4Jly9g4dU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiCoMyHMnax0/a5dj1s9bzyMpQ5xVyhOVTUA Bwp3ETRb1uJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIggAKCRCPgPtYfRL+ ToLiCACtMp9qRiqlRtgeSPqkkWCu+MrQfUFpPF2i6qdpImT3z1MaizkXm8kHeTJt+/0ICnuv+3p w/Fl+s4BOPJLmt2z6poDDyB2OlKlU3QhgPt20BCxVCPkYl+jRM+2GCMVwzHe9wMtF9zjqTZuWNF EOUml6N4SAYv7rR2NOw3rrAphdEB/7CDwJHe2+05MQoeSPTfR4s9/4CsK9275JKPH9Fn9pGBG6D k2HYMhf79EFHqhGyznpiwaWMGjnfqKIutFWs2lJ3Cla+Vzvde/grZLwxye/VRfSVyuXhTB7BD2C WeUEdqe9cbEsB02+LUOH4LPUd1HmyZ2ykVyvEBLlh/j7elx3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-imx27 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Also convert the to_pwm_imx27_chip() helper macro to a static inline to
get some type safety.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 5d796453519a..54589f0b3b78 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -83,7 +83,6 @@ struct pwm_imx27_chip {
 	struct clk	*clk_ipg;
 	struct clk	*clk_per;
 	void __iomem	*mmio_base;
-	struct pwm_chip	chip;
 
 	/*
 	 * The driver cannot read the current duty cycle from the hardware if
@@ -93,7 +92,10 @@ struct pwm_imx27_chip {
 	unsigned int duty_cycle;
 };
 
-#define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
+static inline struct pwm_imx27_chip *to_pwm_imx27_chip(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static int pwm_imx27_clk_prepare_enable(struct pwm_imx27_chip *imx)
 {
@@ -306,13 +308,15 @@ MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);
 
 static int pwm_imx27_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct pwm_imx27_chip *imx;
 	int ret;
 	u32 pwmcr;
 
-	imx = devm_kzalloc(&pdev->dev, sizeof(*imx), GFP_KERNEL);
-	if (imx == NULL)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, 1, sizeof(*imx));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	imx = to_pwm_imx27_chip(chip);
 
 	imx->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
 	if (IS_ERR(imx->clk_ipg))
@@ -324,9 +328,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(imx->clk_per),
 				     "failed to get peripheral clock\n");
 
-	imx->chip.ops = &pwm_imx27_ops;
-	imx->chip.dev = &pdev->dev;
-	imx->chip.npwm = 1;
+	chip->ops = &pwm_imx27_ops;
 
 	imx->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(imx->mmio_base))
@@ -341,7 +343,7 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 	if (!(pwmcr & MX3_PWMCR_EN))
 		pwm_imx27_clk_disable_unprepare(imx);
 
-	return devm_pwmchip_add(&pdev->dev, &imx->chip);
+	return devm_pwmchip_add(&pdev->dev, chip);
 }
 
 static struct platform_driver imx_pwm_driver = {
-- 
2.43.0


