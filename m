Return-Path: <linux-pwm+bounces-975-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF8E83C1CA
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2FFE290C7F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83A34439F;
	Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7084502A
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184652; cv=none; b=Y372eRSnKEzOpRXmm9rAbfSE89gFqJWAn3f2IxjJpVWB/9i38KpPits5ysstlsowQ9dG6Qlbo/rJtkDycSvuO4D/nNC0e8jXCJ7OrHNCQTkTNcbCRjJZzRpZMkxHOx/TiBx1jVRAYKYAPs+DrDIkknnqEd4IYqF5qDdsjty9LIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184652; c=relaxed/simple;
	bh=VtRkOXadk7PhuJR6plzr6JlXTjGn2qEhYa+ucY8hwas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LDZVHgggRp401+jb0tw4ePh31ZhQB3frBK1YaKnqkkpyMMM9czOeAqv5I/F6vezA7mkZWsenfMnZNpvt2uB/pgn4YmvmCdyt5HsGdzhw9dOmeI1UsxQdFXCqXaPYiGBTO/ar/D522fOjqb9p0HPnwM2gD/HDoXFo/LjUpSwc+so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZD-0003ul-8c; Thu, 25 Jan 2024 13:10:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-002HQb-Re; Thu, 25 Jan 2024 13:10:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-007n05-2V;
	Thu, 25 Jan 2024 13:10:45 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v5 030/111] pwm: stmpe: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:52 +0100
Message-ID:  <4429d56b2b4452687bbd34fcd7129ef1b8b215cd.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3973; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=VtRkOXadk7PhuJR6plzr6JlXTjGn2qEhYa+ucY8hwas=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9ckt6biCk699tUOev2DxKkJzNUlodamAnyZ kxKeQYSZleJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPXAAKCRCPgPtYfRL+ Th/DB/4z/0rMH//RkTf+FSP2aenm4/eapOxa/9SLJi8ipYxWgrNFPGMJU8fy8UjG8iEyvbND+oc S2d6ICSvHXUz17y0He6YSslmx0e5i+YtqfwB/5TLYZdF0ed167ebRKLK2H6mQjiTIYypUxmxOza w/Hd2MCFGhePZ/Ok/F9ZThYFTAcgBNOIz5TLIKynzZerEGTwPmR8eWKus/KAQoOkkHN6Lk6T7Ue DMNthTKUthQyEDLShlseLTkXNHrkC0M++61juVWb5LVEB3uOlrEIvt4LvkoGdMZe4qAMtCklXoE H+s/5aZ13UNf1oKnpZoFt5rvFHIjQjY7QwOWPi+RXCKlUEZ+
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
index 19c0c0f39675..05f3f38031ee 100644
--- a/drivers/pwm/pwm-stmpe.c
+++ b/drivers/pwm/pwm-stmpe.c
@@ -44,7 +44,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_dbg(chip->dev, "error reading PWM#%u control\n",
+		dev_dbg(pwmchip_parent(chip), "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -53,7 +53,7 @@ static int stmpe_24xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret) {
-		dev_dbg(chip->dev, "error writing PWM#%u control\n",
+		dev_dbg(pwmchip_parent(chip), "error writing PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -70,7 +70,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_read(stmpe_pwm->stmpe, STMPE24XX_PWMCS);
 	if (ret < 0) {
-		dev_dbg(chip->dev, "error reading PWM#%u control\n",
+		dev_dbg(pwmchip_parent(chip), "error reading PWM#%u control\n",
 			pwm->hwpwm);
 		return ret;
 	}
@@ -79,7 +79,7 @@ static int stmpe_24xx_pwm_disable(struct pwm_chip *chip,
 
 	ret = stmpe_reg_write(stmpe_pwm->stmpe, STMPE24XX_PWMCS, value);
 	if (ret)
-		dev_dbg(chip->dev, "error writing PWM#%u control\n",
+		dev_dbg(pwmchip_parent(chip), "error writing PWM#%u control\n",
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
-			dev_dbg(chip->dev, "error writing register %02x: %d\n",
+			dev_dbg(pwmchip_parent(chip), "error writing register %02x: %d\n",
 				offset, ret);
 			return ret;
 		}
@@ -242,7 +242,7 @@ static int stmpe_24xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		ret = stmpe_reg_write(stmpe_pwm->stmpe, offset, value);
 		if (ret) {
-			dev_dbg(chip->dev, "error writing register %02x: %d\n",
+			dev_dbg(pwmchip_parent(chip), "error writing register %02x: %d\n",
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
2.43.0


