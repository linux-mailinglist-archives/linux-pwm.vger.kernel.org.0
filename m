Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582D977440C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjHHSOu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235445AbjHHSOX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7EE7587F
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:25 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0007ic-6t; Tue, 08 Aug 2023 19:20:02 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-0022A7-GV; Tue, 08 Aug 2023 19:20:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-00BTG5-OW; Tue, 08 Aug 2023 19:20:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 092/101] pwm: stmpe: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:22 +0200
Message-Id: <20230808171931.944154-93-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4352; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mKsDHlR1ryNYcGpy4/fFxkU/QUskhN6B3Jdy5iBEIHI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkYA1fkG34FYE+GkMYCqzeLhiL1ZiINN4pzK E/99dm/hraJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5GAAKCRCPgPtYfRL+ TqcfB/oCSFyhcQU9yq3A/5FS5tltdWE5/OSLqjNqS1lL8vCIbOA/Zg2ytSvvLJWnHOdPtinACd3 FL1ln50BWXEvkbc9p9oO6QN9BK7GaSOdake2kNmU1lC6KB3LXKIsvweqGLSH8XZ9K7bzFBBJLQM 3TAqoDIRlHkzfCr57rUZULEO5VpIH8NOw9YFHG+xHEd9l7TYQ28b+wPpET4BlgVF2iiEjLgkGna 8305F49IYBtwrP/XpCXBlQ7XvMfrndwq+07uOFXvWow7iVy465Io3MkSJsIL9YeUVivOz18+T8U M4YjB+2EmItftl9KVe/rsoIHIV4yDqCwnFe9V0K9YbjrBBOF
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index 9c0f96b77c42..3efa28a5a9a3 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -26,6 +26,7 @@
 #define STMPE_PWM_24XX_PINBASE	21
 
 struct stmpe_pwm {
+	struct device *parent;
 	struct stmpe *stmpe;
 	u8 last_duty;
 };
@@ -43,7 +44,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
+		dev_err(stmpe_pwm->parent, "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -52,7 +53,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret) {
-		dev_err(chip->dev, "error writing PWM#%u control\n",
+		dev_err(stmpe_pwm->parent, "error writing PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -69,7 +70,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
+		dev_err(stmpe_pwm->parent, "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -78,7 +79,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret)
-		dev_err(chip->dev, "error writing PWM#%u control\n",
+		dev_err(stmpe_pwm->parent, "error writing PWM#%u control\n",
 			pwm->hwpwm);
 	return ret;
 }
@@ -124,7 +125,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = stmpe_set_altfunc(stmpe_pwm->stmpe, BIT(pin),
 					STMPE_BLOCK_PWM);
 		if (ret) {
-			dev_err(chip->dev, "unable to connect PWM#%u to pin\n",
+			dev_err(stmpe_pwm->parent, "unable to connect PWM#%u to pin\n",
 				pwm->hwpwm);
 			return ret;
 		}
@@ -149,7 +150,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -ENODEV;
 	}
 
-	dev_dbg(chip->dev, "PWM#%u: config duty %d ns, period %d ns\n",
+	dev_dbg(stmpe_pwm->parent, "PWM#%u: config duty %d ns, period %d ns\n",
 		pwm->hwpwm, duty_ns, period_ns);
 
 	if (duty_ns == 0) {
@@ -215,7 +216,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			program[1] = BRANCH;
 		}
 
-		dev_dbg(chip->dev,
+		dev_dbg(stmpe_pwm->parent,
 			"PWM#%u: value = %02x, last_duty = %02x, program=%04x,%04x,%04x\n",
 			pwm->hwpwm, value, last, program[0], program[1],
 			program[2]);
@@ -232,7 +233,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
+			dev_err(stmpe_pwm->parent, "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
@@ -241,7 +242,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
+			dev_err(stmpe_pwm->parent, "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
@@ -254,7 +255,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Sleep for 200ms so we're sure it will take effect */
 	msleep(200);
 
-	dev_dbg(chip->dev, "programmed PWM#%u, %u bytes\n", pwm->hwpwm, i);
+	dev_dbg(stmpe_pwm->parent, "programmed PWM#%u, %u bytes\n", pwm->hwpwm, i);
 
 	return 0;
 }
@@ -312,6 +313,7 @@ static int __init stmpe_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(chip);
 	stmpe_pwm = to_stmpe_pwm(chip);
 
+	stmpe_pwm->parent = &pdev->dev;
 	stmpe_pwm->stmpe = stmpe;
 
 	chip->ops = &stmpe_24xx_pwm_ops;
-- 
2.40.1

