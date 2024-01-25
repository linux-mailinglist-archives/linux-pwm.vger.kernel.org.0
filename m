Return-Path: <linux-pwm+bounces-971-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE6683C1CB
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332A01C227E7
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D799B3F8CA;
	Thu, 25 Jan 2024 12:10:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2CC4502C
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184651; cv=none; b=Z8hLX3AmRpT0kG8QcjreAU5d6gqWfSj+0ggv93aTk7c36om7PUKDA2wpptLaPyoYkHkKWQXxue4NKJ5bf5Hf4loh3QwTqg+1hCNT3GwT1PmZtEnttFnypiX+X0mYf0RtbCJfykpOR0nALAC7qrCS/lF0cXw+YngeI1UNLxlNoMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184651; c=relaxed/simple;
	bh=pENp6Fzt17e/dX+Jfp4xUxSF7mCQqw25Xy3zSvEU+Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fVrpHatAri+ry6ZMl5+7b50Y7cfU2qpmnf0vofT25T0LZHw0+EfR1lxjspskkAI9UpuVmR42D2naAFj2e2mMoYHbZq+RrexwVvkJ2C3Pg6kTIkZV9RqYd16dXQuyObgPDb6R2rZMXN4DkIi5zc6GbS5zaQRORaDuEKeaTNXsaDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZD-0003zt-Ux; Thu, 25 Jan 2024 13:10:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-002HQm-G0; Thu, 25 Jan 2024 13:10:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-007n0H-17;
	Thu, 25 Jan 2024 13:10:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 033/111] pwm: tiehrpwm: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:55 +0100
Message-ID:  <4d53f2ef951a0def23270a527f53f0d70fa1cb37.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3906; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pENp6Fzt17e/dX+Jfp4xUxSF7mCQqw25Xy3zSvEU+Pg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9gnbLYYrnLXsqCXIdTAJ6x4zDjzhG+AexsZ iXe4f/49tWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPYAAKCRCPgPtYfRL+ Tt4tB/9wMfi6xdkS9/uPPygRjLAKBRATrhKJOxY478JRosH0/hqzXP0fgr3g4IlR+LHPlm60VLo bVo9Tma1/9IaC3gVxRW8IknaCpKtaQiAgNYqHgUm57EcdxRVDkpz4d/NjgQBao8Fh/AfHxAOKEL HqQJo88jPyq/fV0hCubNkiDditVy6Tml40w1ZGnltH3cnMS0dw3lD/51UtK+7agYf3isGHo7lIv LzmCNErLU16WI+NNLeaim7YNIttbNBju7xhw1vjjmwzmATKVK5niVaPj4j7G01rAMhAfE6iuGpy yT4r5PFQmyUF0xq3eVvGir4lDz47qrgCQyUYmZlJjt/Ionft
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index af231fa74fa9..80e22e373bc5 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -256,7 +256,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			if (i == pwm->hwpwm)
 				continue;
 
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"period value conflicts with channel %u\n",
 				i);
 			return -EINVAL;
@@ -268,11 +268,11 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Configure clock prescaler to support Low frequency PWM wave */
 	if (set_prescale_div(period_cycles/PERIOD_MAX, &ps_divval,
 			     &tb_divval)) {
-		dev_err(chip->dev, "Unsupported values\n");
+		dev_err(pwmchip_parent(chip), "Unsupported values\n");
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Update clock prescaler values */
 	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_CLKDIV_MASK, tb_divval);
@@ -299,7 +299,7 @@ static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ehrpwm_write(pc->mmio_base, cmp_reg, duty_cycles);
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -323,7 +323,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	int ret;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/* Disabling Action Qualifier on PWM output */
 	if (pwm->hwpwm) {
@@ -346,8 +346,8 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
-		dev_err(chip->dev, "Failed to enable TBCLK for %s: %d\n",
-			dev_name(pc->chip.dev), ret);
+		dev_err(pwmchip_parent(chip), "Failed to enable TBCLK for %s: %d\n",
+			dev_name(pwmchip_parent(chip)), ret);
 		return ret;
 	}
 
@@ -385,7 +385,7 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable(pc->tbclk);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -393,8 +393,8 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
 	if (pwm_is_enabled(pwm)) {
-		dev_warn(chip->dev, "Removing PWM device without disabling\n");
-		pm_runtime_put_sync(chip->dev);
+		dev_warn(pwmchip_parent(chip), "Removing PWM device without disabling\n");
+		pm_runtime_put_sync(pwmchip_parent(chip));
 	}
 
 	/* set period value to zero on free */
@@ -523,7 +523,7 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 
 static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -534,7 +534,7 @@ static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
 }
 
 static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
-- 
2.43.0


