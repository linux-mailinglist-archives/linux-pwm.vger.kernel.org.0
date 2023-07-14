Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA8D754467
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 23:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjGNVph (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 17:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjGNVpg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 17:45:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA5235A7
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 14:45:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKQbT-0004K1-36; Fri, 14 Jul 2023 23:45:31 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKQbS-00ER0c-DR; Fri, 14 Jul 2023 23:45:30 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKQbR-004ugH-8a; Fri, 14 Jul 2023 23:45:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: stmpe: Don't issue error messages for problems in .apply_state()
Date:   Fri, 14 Jul 2023 23:45:19 +0200
Message-Id: <20230714214519.2503468-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
References: <20230714214519.2503468-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2652; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=EDmD91sjWnCFgWsPh20j8mnlhmGqcCydxE/nXHu6EDQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkscHulkxsmIfUAq2oACNEu2mBf4pYSihPeL7DC QWmHFzanYqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLHB7gAKCRCPgPtYfRL+ TsSCCACqH0TGE8lm/P/kgKhzeTvJ7qkTUxJSTpNJLWty1GXePG7nMi7rx18Yiu023PKv2TAxsyA hSl3J1FRMsluqDHWNrrc0THITbaM+uqhCHFjYXZ5XZJZguoeds44Tkz+QAzYqRZjJOXiMP45R6x VdefOBtJJfA9xKPyGuogienbEq+Fxu/Bod/y74AgFDdRnPla6oGXt26R3dMxdjP2NDBp0I0r/hK NJwr81VPEpcY4vKed/VlN4F6xaWSb0x04NH+Jy7+R67mfOrQ6tkAsAXaG/07G17HNlxGdeswmCw rx9AVmGRs59AHrLbxJBLqjVzk4kSbh2KYq8I2DE8EnL3ymw8
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm drivers are supposed to be silent for failures in .apply_state()
because a problem is likely to be persistent and so it can easily flood
the kernel log. So remove all error messages from .apply_state() and the
functions that are (only) called by that callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stmpe.c | 35 ++++++-----------------------------
 1 file changed, 6 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-stmpe.c b/drivers/pwm/pwm-stmpe.c
index e205405c4828..4a8d0d9b9cfc 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -43,22 +43,12 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	int ret;
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
-	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
-			pwm->hwpwm);
+	if (ret < 0)
 		return ret;
-	}
 
 	value = ret | BIT(pwm->hwpwm);
 
-	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
-	if (ret) {
-		dev_err(chip->dev, "error writing PWM#%u control\n",
-			pwm->hwpwm);
-		return ret;
-	}
-
-	return 0;
+	return stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 }
 
 static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
@@ -69,19 +59,12 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 	int ret;
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
-	if (ret < 0) {
-		dev_err(chip->dev, "error reading PWM#%u control\n",
-			pwm->hwpwm);
+	if (ret < 0)
 		return ret;
-	}
 
 	value = ret & ~BIT(pwm->hwpwm);
 
-	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
-	if (ret)
-		dev_err(chip->dev, "error writing PWM#%u control\n",
-			pwm->hwpwm);
-	return ret;
+	return stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 }
 
 /* STMPE 24xx PWM instructions */
@@ -124,11 +107,8 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_set_altfunc(stmpe_pwm->stmpe, BIT(pin),
 					STMPE_BLOCK_PWM);
-		if (ret) {
-			dev_err(chip->dev, "unable to connect PWM#%u to pin\n",
-				pwm->hwpwm);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/* STMPE24XX */
@@ -241,11 +221,8 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		value = program[i] & 0xff;
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
-		if (ret) {
-			dev_err(chip->dev, "error writing register %02x: %d\n",
-				offset, ret);
+		if (ret)
 			return ret;
-		}
 	}
 
 	/* If we were enabled, re-enable this PWM */
-- 
2.39.2

