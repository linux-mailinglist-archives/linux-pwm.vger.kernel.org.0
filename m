Return-Path: <linux-pwm+bounces-1012-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B96683C1F2
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90AFF1C22A29
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FABE3B19D;
	Thu, 25 Jan 2024 12:11:00 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5D45C0E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184660; cv=none; b=IR+oNtwNudO5ygei/Ru9nRrOr0flloTwiPrRmwdXVx4vrCcr4WFi74YjeGo1ANt4dpRNgh2T1bcpVpzscIVWw402fer4fvvkV7QzTuBTHDDFvQ0e3bhMesLSqwvRVN2zT12n1IOUxnQ1SmhjBE6GopYT4f3DxN+X+FGjiS65O/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184660; c=relaxed/simple;
	bh=drUK8CPnDdwgQVYE19JQZ1JYcqRkvpoCDmnK/uMOCDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EZXlNP9OgXlz7IYdAJTI63GRfWt9IV+FRylKenIJ4pJj3Smw2CI7G4/QpsDnz6cj4U4mRCWbkvAjBWXMm+oRRXtqbJDjcQMUXH4F8U4+CutZHIph9UpISzf3MTMTaRfgma2zPczRr5idavwhTPdSy1/uxavBNHHokple0WAFpoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZJ-0004MG-1z; Thu, 25 Jan 2024 13:10:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZI-002HSh-2V; Thu, 25 Jan 2024 13:10:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZH-007n2G-3C;
	Thu, 25 Jan 2024 13:10:52 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-pwm@vger.kernel.org
Cc: Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v5 061/111] pwm: imx27: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:23 +0100
Message-ID:  <5d6f5a50b0b9642896503abeb91ea194c455fa68.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2468; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=drUK8CPnDdwgQVYE19JQZ1JYcqRkvpoCDmnK/uMOCDk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk+BrLe8yBGhMf1MLy+YAJzfV7igkXIBnG3NM qaL3Aim9qWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPgQAKCRCPgPtYfRL+ TtlQCACtbyZHXw5MXBHPRIhc52AM7ylcqrLylgLKnbh5oUDEp+vadKVG+pvnR+wx8ng/MYNXS8F 11LgQ+27ow8SIobjcSxI5fYOCzRgpyoQLJXtHG3fs4CqmcY0Rrzo0Rlm332nBnyIlrjGmztG+ij qliAnknqwr+spXUlP1yeYQTmxtaq3FAIiavQWxsKdNY1A3LTm+3SueU67Pf3R/XNpW22X5byRcs YCk0FfWRKkNPoPxyiT6zv+MNbdfXfUdxexIH/5hDtZX/WWSZUYOkE4aSpJ6NqD5wdwL91CVq665 F6/tjASRIP5G1H1iPkDr+MnLjhEKGDMal5CweghxQDGH5t2c
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-imx27 driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

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


