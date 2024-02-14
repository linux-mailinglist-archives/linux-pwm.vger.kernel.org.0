Return-Path: <linux-pwm+bounces-1441-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 783A9854609
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE5B1C203F4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6681429C;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF881A28C
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903290; cv=none; b=u2wCt2CzuMi2enKBvXR6bCwEsuHUHH4oBzZKHvD/x4z4WiXjQ+4M9aXx0zOxuI+o2nIQ75I10W7RgHSdCoTznGQ/ilryByfPn+KaiVbSIcyzW/0Q51M0yMcO2g0J3Sk7/IAGCNRILHy25PIwkE3WEkwgubCsoQ9ajFX/D3DqrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903290; c=relaxed/simple;
	bh=5/yTk1XF3m/x+RiUeNlZR9xZGtgNzZcm4JJ6LWl3SkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRgxLHDsgcB9jygQmaLE8kDgyIvT4BfR4UgxBRMXleIruR7pv0f7UDLvk+jbfw4sTPPJcw0rENTmG6OW7q2vJ+ESTa1n6x5s0yA9nzFmp/U6FTMc7sjljSyPP78giPoIpaN7s+B1ZU0pXJST6n2j10ueldeyKrEcuF8000qd1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-00064k-Rj; Wed, 14 Feb 2024 10:34:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-000fHJ-0u; Wed, 14 Feb 2024 10:34:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-004Y9D-35;
	Wed, 14 Feb 2024 10:34:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 138/164] pwm: tiehrpwm: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:33:05 +0100
Message-ID:  <9badd116d0e26a5656b222c5b4adad7e111a53c7.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3880; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=5/yTk1XF3m/x+RiUeNlZR9xZGtgNzZcm4JJ6LWl3SkU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjpgsTtrvfgqya3uN0BJ+Dyy8uXS80wREI+d zNCuOxxwzGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI6QAKCRCPgPtYfRL+ Tt3sB/91l+quYZQfYlbIZdoku5QGEzrr07xSLsN7h3jbdg0sjBTJhXWt4vmRY5LWTAtv9yRE2vl CLHrBLZkEdBMoQNTsTzNDcqftYrHIWrFyaZaVYE/wn4nu/9FEViTGo1wgh9fcRa+YvNtBZBZhKY GzTEumJFHEjnOm9VESX+B3B3GsqK63wCcka1mNT00hbZJPf75vgawEqE2ivrVgCKLGozcrPf6Mx Q31wl2HSGdwhovIXuwuToX559F3fhGg3HXu0M/EgNDonD50+hCRFOp3nHbbwdkRP3I+t8VmejV/ KnfbPi4NPSYYo4H4C9L9pueD09GKd4b7kShs7ZfMmORZv5cB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 6d7babf6fdb0..9a7c72196173 100644
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
-			dev_name(chip->dev), ret);
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
@@ -528,7 +528,7 @@ static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 
-	pm_runtime_get_sync(chip->dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -539,7 +539,7 @@ static void ehrpwm_pwm_save_context(struct pwm_chip *chip)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(chip->dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static void ehrpwm_pwm_restore_context(struct pwm_chip *chip)
-- 
2.43.0


