Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84FE7C72C1
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379640AbjJLQbO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379605AbjJLQbA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570BBDC
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-0004wj-Nr; Thu, 12 Oct 2023 18:30:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-001C7N-BF; Thu, 12 Oct 2023 18:30:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-00F5OJ-2G; Thu, 12 Oct 2023 18:30:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 033/109] pwm: tiehrpwm: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:29:01 +0200
Message-ID: <20231012162827.1002444-144-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3928; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=D+1CyYIey9yHukWYli4cnyec/orwhBcQhM7GBl28P8I=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7TyEYK27rlOcs5Yw8456AykNy4ZrX62a/bk 9oKHTCh58qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSge0wAKCRCPgPtYfRL+ ThU3B/4uq3An/UbgHcMIwYuvT5IvAnhOzS+1dYiWRKSvkzE+CQlxn3C/Z3fISzlEJvuufTvllxe J2ZVp5Xf76j8B0oMBgQYBewAfsadhMTFdE47GcRogesm6cH2qly2yFMd2/PcuFtfAa/k4ZzLkFQ OiVelg0SRXiql5Vky8YwxifAI6KnbEkpbkpX9P4IHfRumLxCsL8G+PNRzmsyxix0y9iwiS4m+eo ceQCLK0ANlTwaK8Y8yXymzwrfSVUzyEvapiDEFkMLvp3YkAzbG1+FTB2pnmyIr4A0Np8lDotIZL D44reT7YubEW4sk9n9GLMc5Wn7w4+zhjPmCHVrmwn0XrMbKa
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 66ac2655845f..b7021e05bc72 100644
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
@@ -524,7 +524,7 @@ static void ehrpwm_pwm_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
 
 	pc->ctx.tbctl = ehrpwm_read(pc->mmio_base, TBCTL);
 	pc->ctx.tbprd = ehrpwm_read(pc->mmio_base, TBPRD);
@@ -535,7 +535,7 @@ static void ehrpwm_pwm_save_context(struct ehrpwm_pwm_chip *pc)
 	pc->ctx.aqsfrc = ehrpwm_read(pc->mmio_base, AQSFRC);
 	pc->ctx.aqcsfrc = ehrpwm_read(pc->mmio_base, AQCSFRC);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
 }
 
 static void ehrpwm_pwm_restore_context(struct ehrpwm_pwm_chip *pc)
-- 
2.42.0

