Return-Path: <linux-pwm+bounces-1428-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6DA8545F3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B48128A699
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6959C1B801;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC27199BA
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903288; cv=none; b=MxQfnUGUbgJXTewyY+IpRzHUE168jTGOioUXIvyHtXY6wrSsIxLlPeDQaHSysLNjKEvMDcU8ac96xuQ4CuF/WRLhOpR2xKUIPzC2NyuAb9zkLtDNK9hsmjq2ZlydGMi8D1Cr4MMN2lr6jj7+9O1FU1ksTCd0bxoBoeWkjoaEzyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903288; c=relaxed/simple;
	bh=rVu267O0/lkv571rbv4WrTGGxtDyJpFNtrSoWSBP1Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WUlRmlPzzZGRGea4thAA5/kntvcNxGOYNW5vn+o5bvZB7iums3I4TQ6VS2uIfnDFzsqqlJBhj8FrQg1zFO2fAUGp92mv9nXJ6glToZ2j9CgWhBIxHTQEeW6C9ww9Ifl+HaM5nUw7kHWOsEigKBF5d5ThSVIuRESrPsUIcv2gJAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-00060X-5L; Wed, 14 Feb 2024 10:34:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-000fGy-9G; Wed, 14 Feb 2024 10:34:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-004Y8t-0g;
	Wed, 14 Feb 2024 10:34:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 133/164] pwm: tiecap: Change prototype of helpers to prepare further changes
Date: Wed, 14 Feb 2024 10:33:00 +0100
Message-ID:  <ed031f201ff52c6b298de2dc81b06aad3a0207f8.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3554; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=rVu267O0/lkv571rbv4WrTGGxtDyJpFNtrSoWSBP1Nk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjjj4j2yIz9xt55+G9kiAueuIQ07H9UpXR+s fSGTocyohuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI4wAKCRCPgPtYfRL+ TtL0B/498CG+2FSpmL727bjjmVORfWEhgxmBden9DZQpggPMqfOpzLj+Tm9zqRZYXweoWPrj+eT S6d33XDyMGu4vdXJkZlGVY94/utlKBb6poyPapt61uAR1lrWwm9+jvc4R1W2vDd8ABrPO7ZJI8H x+gCKbG8CkL0O8JOywYYsuihsESfiJ7OJMG4CgAQcICpM6uyU2VY6sIpdvJh11povmNEwJZN/EQ Yut4Wiwl/wQo6JiwtHUv/M5Gs4PBxm4SwxAnaCsW5zkMR696exVOXT9XE+90mwsHkTykg7keZO1 +Jqu2/d9zpfP9QS7EjOjzbnyrlLYEUtmpUqVcQOOVtTDQoet
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given ecap_pwm_chip. To just not have to
do that, rework ecap_pwm_save_context() and ecap_pwm_restore_context
take a pwm_chip. Also use the pwm_chip as driver data instead of the
ecap_pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index b93e3be318d5..0d10e8357731 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -218,6 +218,7 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ecap_pwm_chip *pc;
+	struct pwm_chip *chip;
 	struct clk *clk;
 	int ret;
 
@@ -244,21 +245,22 @@ static int ecap_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &ecap_pwm_ops;
-	pc->chip.npwm = 1;
+	chip = &pc->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &ecap_pwm_ops;
+	chip->npwm = 1;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
 		return PTR_ERR(pc->mmio_base);
 
-	ret = devm_pwmchip_add(&pdev->dev, &pc->chip);
+	ret = devm_pwmchip_add(&pdev->dev, chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
@@ -269,17 +271,21 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
+static void ecap_pwm_save_context(struct pwm_chip *chip)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
+
+	pm_runtime_get_sync(chip->dev);
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 }
 
-static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
+static void ecap_pwm_restore_context(struct pwm_chip *chip)
 {
+	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
+
 	writel(pc->ctx.cap3, pc->mmio_base + CAP3);
 	writel(pc->ctx.cap4, pc->mmio_base + CAP4);
 	writew(pc->ctx.ecctl2, pc->mmio_base + ECCTL2);
@@ -287,10 +293,10 @@ static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
 
 static int ecap_pwm_suspend(struct device *dev)
 {
-	struct ecap_pwm_chip *pc = dev_get_drvdata(dev);
-	struct pwm_device *pwm = pc->chip.pwms;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct pwm_device *pwm = chip->pwms;
 
-	ecap_pwm_save_context(pc);
+	ecap_pwm_save_context(chip);
 
 	/* Disable explicitly if PWM is running */
 	if (pwm_is_enabled(pwm))
@@ -301,14 +307,14 @@ static int ecap_pwm_suspend(struct device *dev)
 
 static int ecap_pwm_resume(struct device *dev)
 {
-	struct ecap_pwm_chip *pc = dev_get_drvdata(dev);
-	struct pwm_device *pwm = pc->chip.pwms;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct pwm_device *pwm = chip->pwms;
 
 	/* Enable explicitly if PWM was running */
 	if (pwm_is_enabled(pwm))
 		pm_runtime_get_sync(dev);
 
-	ecap_pwm_restore_context(pc);
+	ecap_pwm_restore_context(chip);
 	return 0;
 }
 
-- 
2.43.0


