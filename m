Return-Path: <linux-pwm+bounces-1433-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CFD8545FA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 890FA28A7B7
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E60A1B96E;
	Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE741A702
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903288; cv=none; b=g4QJGIH5/wzSL4+rJqLEFFsKxY2pv4BMNpictsHLLOufdIDpuuNAaRM7QMuYMgwAAisNBIEFbPaAB8o7sOo1Ksn2x9pRsZbYdxQaMEAVuzkiM4Ui9sAwn4/AqyaZrrJ0/OxjyhOj8gchw01/YdPBd/lu5B684uIoBFlIgBDS03Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903288; c=relaxed/simple;
	bh=usIskIVUdl4EP/qITT6EmD55KwWXVoyXRVoSXpcFV4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fLCHq2U5kJENv++5o4vj+2Q3HlzQJZOrCvipaxcRAyfPEiCzfhWZTpijq8c9Du/9TbbJRYan0QU73hvVpycHpPg24gBaCzFSXJUqfwpLspvMW56ddXo0MJrZOeQm2IA2rbiYTQtrPCKQI0FANvNRRYSm/iHdTDh85P6d05fKhuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-00063o-0K; Wed, 14 Feb 2024 10:34:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-000fHG-Sq; Wed, 14 Feb 2024 10:34:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-004Y99-2e;
	Wed, 14 Feb 2024 10:34:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 137/164] pwm: tiehrpwm: Change prototype of helpers to prepare further changes
Date: Wed, 14 Feb 2024 10:33:04 +0100
Message-ID:  <79052207cdf71f0882ae13fe1a192ef6f6dba35b.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4457; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=usIskIVUdl4EP/qITT6EmD55KwWXVoyXRVoSXpcFV4g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjoAnMbZuaxZ+YfcsWlJy1ln1tOSpQtjqL3m I7hl9Mhd7mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI6AAKCRCPgPtYfRL+ To69CACmsZiethXYA2z3aw2FAy+1wa3qzqVOz9Q6TgJvZWo9XZpbZo5CpZPq5Drypk09L+tId3u G0Mt0swWgweNVf0yX5Lo2HwMXP5vyG6pdp/H2ESIzmM59kPcQh7jPf54QExps1v/H5oyzf/u0rj uMqffVctKLGjHwdJ0JpgZA3jHMJgmMxoeHUZKZnSPSngQkuq5XTgokk7Q9TcWU2ozwDC2eN6Qyz FHV3xnEJU9o1VSFqZzmuY0C/bg5I6CsrMs0/+kWrYder9kJ3OPy2O7L4rVd5OeMNOelLA8Mo4MT trZXRVn71ln7UIb3Ax/NbprpFu36poW5FgX6RZkrDC32Iwpf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the driver for further changes that will make it harder to
determine the pwm_chip from a given ehrpwm_pwm_chip. To just not have to
do that, rework ehrpwm_pwm_save_context() and
ehrpwm_pwm_restore_context() take a pwm_chip. Also use the pwm_chip as
driver data instead of the ehrpwm_pwm_chip.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 45 ++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 9848493dee97..6d7babf6fdb0 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -450,6 +450,7 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
 	struct ehrpwm_pwm_chip *pc;
+	struct pwm_chip *chip;
 	struct clk *clk;
 	int ret;
 
@@ -474,9 +475,10 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	pc->chip.dev = &pdev->dev;
-	pc->chip.ops = &ehrpwm_pwm_ops;
-	pc->chip.npwm = NUM_PWM_CHANNEL;
+	chip = &pc->chip;
+	chip->dev = &pdev->dev;
+	chip->ops = &ehrpwm_pwm_ops;
+	chip->npwm = NUM_PWM_CHANNEL;
 
 	pc->mmio_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(pc->mmio_base))
@@ -493,13 +495,13 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = pwmchip_add(&pc->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
 		goto err_clk_unprepare;
 	}
 
-	platform_set_drvdata(pdev, pc);
+	platform_set_drvdata(pdev, chip);
 	pm_runtime_enable(&pdev->dev);
 
 	return 0;
@@ -512,18 +514,21 @@ static int ehrpwm_pwm_probe(struct platform_device *pdev)
 
 static void ehrpwm_pwm_remove(struct platform_device *pdev)
 {
-	struct ehrpwm_pwm_chip *pc = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	pwmchip_remove(&pc->chip);
+	pwmchip_remove(chip);
 
 	clk_unprepare(pc->tbclk);
 
 	pm_runtime_disable(&pdev->dev);
 }
 
-static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
+	pm_runtime_get_sync(chip->dev);
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -534,11 +539,13 @@ static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(chip->dev);
 }
 
-static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
+static void ehrpwm_pwm_restore_context(struct pwm_chip *chip)
 {
+	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
+
 	ehrpwm_write(pc->mmio_base, TBPRD, pc->ctx.tbprd);
 	ehrpwm_write(pc->mmio_base, CMPA, pc->ctx.cmpa);
 	ehrpwm_write(pc->mmio_base, CMPB, pc->ctx.cmpb);
@@ -551,13 +558,13 @@ static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
 
 static int ehrpwm_pwm_suspend(struct device *dev)
 {
-	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	unsigned int i;
 
-	ehrpwm_pwm_save_context(pc);
+	ehrpwm_pwm_save_context(chip);
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -571,11 +578,11 @@ static int ehrpwm_pwm_suspend(struct device *dev)
 
 static int ehrpwm_pwm_resume(struct device *dev)
 {
-	struct ehrpwm_pwm_chip *pc = dev_get_drvdata(dev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
 	unsigned int i;
 
-	for (i = 0; i < pc->chip.npwm; i++) {
-		struct pwm_device *pwm = &pc->chip.pwms[i];
+	for (i = 0; i < chip->npwm; i++) {
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		if (!pwm_is_enabled(pwm))
 			continue;
@@ -584,7 +591,7 @@ static int ehrpwm_pwm_resume(struct device *dev)
 		pm_runtime_get_sync(dev);
 	}
 
-	ehrpwm_pwm_restore_context(pc);
+	ehrpwm_pwm_restore_context(chip);
 
 	return 0;
 }
-- 
2.43.0


