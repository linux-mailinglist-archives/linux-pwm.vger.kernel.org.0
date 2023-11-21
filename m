Return-Path: <linux-pwm+bounces-28-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A48947F2F6D
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46104B20FAB
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5353807;
	Tue, 21 Nov 2023 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4575410E4
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:53 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-0005N2-4r; Tue, 21 Nov 2023 14:51:51 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-00AayD-MK; Tue, 21 Nov 2023 14:51:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAM-004xcY-D6; Tue, 21 Nov 2023 14:51:50 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v3 029/108] pwm: stmpe: Make use of pwmchip_parent() macro
Date: Tue, 21 Nov 2023 14:49:31 +0100
Message-ID: <20231121134901.208535-30-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3973; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=mp3SZMZIe1BVlm7AXDhMEr/586ii1475FtFyYgu5PSY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVtYTn1MI7JGHGLwXoPx7lnAhxhLCnxk6M7O /MwO8SkBCWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1bQAKCRCPgPtYfRL+ Tla4B/9heKoRuVqdFKkLxv5wGVy3ZI4YM1CL04RbhW7lj0ZEgWV6j8SeyI7uamIexcEyt3KZ2xi 7SxSXEjr0wwW2qZb4Ftmsp424uPCgc1czuVwh0zCSTGoCvTf2yvq17lMjHQ5xnjcfV73MheCO4X 2o5SkWtPNSHnfzXuyEaHV/wwD1L53z92o8V/+Jk8/2/HJ8pbKabSA1XPNfUF334flGarjCp8odl SPO+GkjY8fuenjW5ELsq+9e/Kgmvabyyxvi5smpg/L9cIgp+1EogIlCZiHVteEmPfhr5Zf1g+aa g0Vk9fHXgGPCCvbN/q1iazkYSX118WZCYBw9K74anLBzMR5U
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


