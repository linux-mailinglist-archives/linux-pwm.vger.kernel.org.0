Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E07A7C72BF
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379176AbjJLQbN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379535AbjJLQbA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:00 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4402D9
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-0004vz-3m; Thu, 12 Oct 2023 18:30:57 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-001C7B-NY; Thu, 12 Oct 2023 18:30:56 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaO-00F5O7-EF; Thu, 12 Oct 2023 18:30:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 030/109] pwm: stmpe: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:58 +0200
Message-ID: <20231012162827.1002444-141-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3973; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mp3SZMZIe1BVlm7AXDhMEr/586ii1475FtFyYgu5PSY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB7PYTn1MI7JGHGLwXoPx7lnAhxhLCnxk6M7O /MwO8SkBCWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgezwAKCRCPgPtYfRL+ TidgB/4vZvVi7g7l2JpnYFza+eZtE2GqwdSI/ingX4O4gMOo47B5a8f3VHZD4eFL4WEgyGGikF+ LUfVG3s3X0MBdRJQJLs5+R2mOl2k/+g6wwarHFIBJOQwG0On3fHOhKlC4CJkH4sF6HJ6UBWE3z7 bu7zr4aKY3ZYNfV4iUKSmzbDKaRsvIZlsGLli6HmsA0II9JrtEME3F8k8S0//hBiJKJOZz95niy +ADim41y9ksyzhXGcdpRST8SVzUmSKLLgKpw/2TwzWTtU8IcUNClgOxKQrfM+mLb5UnSICN8+sk 59yRfUeG1ZAhzX29rzNHGDomB5Iey2fWjsq9G/4joMfCG5BR
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
 drivers/pwm/pwm-stmpe.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index a46f5b4dd816..492494b73a87 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -44,7 +44,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
+		dev_err(pwmchip_parent(chip), "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -53,7 +53,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret) {
-		dev_err(chip->dev, "error writing PWM#%u control\n",
+		dev_err(pwmchip_parent(chip), "error writing PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -70,7 +70,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
+		dev_err(pwmchip_parent(chip), "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -79,7 +79,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret)
-		dev_err(chip->dev, "error writing PWM#%u control\n",
+		dev_err(pwmchip_parent(chip), "error writing PWM#%u control\n",
 			pwm->hwpwm);
 	return ret;
 }
@@ -125,7 +125,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = stmpe_set_altfunc(stmpe_pwm->stmpe, BIT(pin),
 					STMPE_BLOCK_PWM);
 		if (ret) {
-			dev_err(chip->dev, "unable to connect PWM#%u to pin\n",
+			dev_err(pwmchip_parent(chip), "unable to connect PWM#%u to pin\n",
 				pwm->hwpwm);
 			return ret;
 		}
@@ -150,7 +150,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -ENODEV;
 	}
 
-	dev_dbg(chip->dev, "PWM#%u: config duty %d ns, period %d ns\n",
+	dev_dbg(pwmchip_parent(chip), "PWM#%u: config duty %d ns, period %d ns\n",
 		pwm->hwpwm, duty_ns, period_ns);
 
 	if (duty_ns == 0) {
@@ -216,7 +216,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			program[1] = BRANCH;
 		}
 
-		dev_dbg(chip->dev,
+		dev_dbg(pwmchip_parent(chip),
 			"PWM#%u: value = %02x, last_duty = %02x, program=%04x,%04x,%04x\n",
 			pwm->hwpwm, value, last, program[0], program[1],
 			program[2]);
@@ -233,7 +233,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
+			dev_err(pwmchip_parent(chip), "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
@@ -242,7 +242,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
+			dev_err(pwmchip_parent(chip), "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
@@ -255,7 +255,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Sleep for 200ms so we're sure it will take effect */
 	msleep(200);
 
-	dev_dbg(chip->dev, "programmed PWM#%u, %u bytes\n", pwm->hwpwm, i);
+	dev_dbg(pwmchip_parent(chip), "programmed PWM#%u, %u bytes\n", pwm->hwpwm, i);
 
 	return 0;
 }
-- 
2.42.0

