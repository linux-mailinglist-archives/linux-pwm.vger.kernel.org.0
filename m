Return-Path: <linux-pwm+bounces-983-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3883C1D3
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F7F9290E4B
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C40745032;
	Thu, 25 Jan 2024 12:10:54 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8211344368
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184654; cv=none; b=USvAVgSpOa46mdtNPexSlVqFDPA81ukLqPXsUhMJOe2bQr7ZS8CSRcxBs9xTzI9UPMJwt0xxhd4KknkMj0lirT1xe9ZHREjtqMOvr2bdUo6QK7RdqqtlnuglAT3fmVXjlTlw/djs5CJbM9QhqYU0yc0nd1Fmm1o1ML4kGwzIekg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184654; c=relaxed/simple;
	bh=u09bAlZCYe9ZqxMNX4bi+tIh6MWYvJyYs/iFuE1kLeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egKTqCSDbtl2kcrq0/Mku7UM8iCwypKMQ20tup55RUUpgBML0M1LaQoeyVsDk8ZfqJcSfmXJVfWGyoqukpHukdtyNihWpzukca2G/k8PSUML6qDSVecZirDeuxOjYdKuGOYh3CuojpmFsJ172zzTCtLReoQamGMzUA00QiIeS0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZG-0004HD-E5; Thu, 25 Jan 2024 13:10:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-002HRp-Rl; Thu, 25 Jan 2024 13:10:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZF-007n1P-2W;
	Thu, 25 Jan 2024 13:10:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 049/111] pwm: berlin: Make use of devm_pwmchip_alloc() function
Date: Thu, 25 Jan 2024 13:09:11 +0100
Message-ID:  <6b4a7aa88ea10bc7718e239a154848550889329a.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=u09bAlZCYe9ZqxMNX4bi+tIh6MWYvJyYs/iFuE1kLeI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9zl3k5evJKP1O17+8Kr4bYwGUbs67qOU1SV NjQbJoQFg2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPcwAKCRCPgPtYfRL+ Tv1FB/4m8nEL5/shcOM/yHFLWW1jo1guy/RGUKeDbIA8q/r0IjVj7LUtEiM4UK9+pNFgQYLRBiQ rRezJ/XyXyW8jRHlPLQjYwKml/WIYymAPqjXvipNKMsAWianmziPei0zPUdlk4h9oFchrmlj9kc FLhJQo3Ppb0r3A5ROb0Z3U89dab8lcdvEIAT3Kl8f0NSPdQjPO5pU1S9Mi04h69sZycKjyvd9Pu Rx3Q5AdBq/E+xYpq2lB4h7ZNIIj/viwVvgwXVmWxvngOWc7F/u2GlxqQKXEHlGatcMsQP0i1YhD ViLbFnDnKu3dCp20sXHfi+JLxdbMvWVa6b+GAmfc/Qn3Z4sE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-berlin driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-berlin.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
index 442913232dc0..831aed228caf 100644
--- a/drivers/pwm/pwm-berlin.c
+++ b/drivers/pwm/pwm-berlin.c
@@ -49,7 +49,6 @@ struct berlin_pwm_channel {
 };
 
 struct berlin_pwm_chip {
-	struct pwm_chip chip;
 	struct clk *clk;
 	void __iomem *base;
 	struct berlin_pwm_channel channel[BERLIN_PWM_NUMPWMS];
@@ -57,7 +56,7 @@ struct berlin_pwm_chip {
 
 static inline struct berlin_pwm_chip *to_berlin_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct berlin_pwm_chip, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static inline u32 berlin_pwm_readl(struct berlin_pwm_chip *bpc,
@@ -198,12 +197,14 @@ MODULE_DEVICE_TABLE(of, berlin_pwm_match);
 
 static int berlin_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct berlin_pwm_chip *bpc;
 	int ret;
 
-	bpc = devm_kzalloc(&pdev->dev, sizeof(*bpc), GFP_KERNEL);
-	if (!bpc)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, BERLIN_PWM_NUMPWMS, sizeof(*bpc));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	bpc = to_berlin_pwm_chip(chip);
 
 	bpc->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(bpc->base))
@@ -213,25 +214,24 @@ static int berlin_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(bpc->clk))
 		return PTR_ERR(bpc->clk);
 
-	bpc->chip.dev = &pdev->dev;
-	bpc->chip.ops = &berlin_pwm_ops;
-	bpc->chip.npwm = BERLIN_PWM_NUMPWMS;
+	chip->ops = &berlin_pwm_ops;
 
-	ret = devm_pwmchip_add(&pdev->dev, &bpc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0)
 		return dev_err_probe(&pdev->dev, ret, "failed to add PWM chip\n");
 
-	platform_set_drvdata(pdev, bpc);
+	platform_set_drvdata(pdev, chip);
 
 	return 0;
 }
 
 static int berlin_pwm_suspend(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		channel->enable = berlin_pwm_readl(bpc, i, BERLIN_PWM_ENABLE);
@@ -247,7 +247,8 @@ static int berlin_pwm_suspend(struct device *dev)
 
 static int berlin_pwm_resume(struct device *dev)
 {
-	struct berlin_pwm_chip *bpc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct berlin_pwm_chip *bpc = to_berlin_pwm_chip(chip);
 	unsigned int i;
 	int ret;
 
@@ -255,7 +256,7 @@ static int berlin_pwm_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < bpc->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct berlin_pwm_channel *channel = &bpc->channel[i];
 
 		berlin_pwm_writel(bpc, i, channel->ctrl, BERLIN_PWM_CONTROL);
-- 
2.43.0


