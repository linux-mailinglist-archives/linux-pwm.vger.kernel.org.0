Return-Path: <linux-pwm+bounces-24-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 009657F2F63
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7491C2168F
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D1E53812;
	Tue, 21 Nov 2023 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2722C10CF
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-0005Nw-IS; Tue, 21 Nov 2023 14:51:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-00AayQ-5h; Tue, 21 Nov 2023 14:51:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-004xck-T4; Tue, 21 Nov 2023 14:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 032/108] pwm: tiehrpwm: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:34 +0100
Message-ID: <20231121134901.208535-33-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3906; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RVXlxyqQbN8EiIIgF1ezGnwlxppGH5jOUnQlVaRVzn4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVwLFAXL4V+4Z7aPRhGzQsmrRR+8hms4r3Zj YG8/ikCJrOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1cAAKCRCPgPtYfRL+ TjxlB/4kWALE4VpELq+gK/OihDvMjDwBajp8QOxVV6zr759FWC4/Zq+DQxsRcKhZC6j9nabVa+b aKtjWNCQRBd6AfzhttAmJTLEwsFrD7ki6Yu7cGYeOaLVIxLcHr4TeNB7gzk/gLdFhQ5rGowtpGC L8eX6aZLuawMtkfGgsGEWldJ6GNuManaAHGJBD5OzHiTdtAennRwolq6nWzuht8tGKFpMIW9Mxl opqSBppAeXDmTo3q4n8V52QlnBugjNcyWfzanoeqUCmLif7u0qn0SGxLvxJfBnS+DvoVK2zpT1O +8BP6UEVzX89XVJ1P4zrUVeU8jiLkIe62X3Z2t8efQFUhxtX
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
2.42.0


