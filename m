Return-Path: <linux-pwm+bounces-1427-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A348545F6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD161F2D576
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684181B7F8;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1485619BCA
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903287; cv=none; b=P1m8PEMJV6SiK0+ZlY9abK2li/9hBIDBUebVTC5H89TuVlNPCnnkrBICViuRj8tMNFBGMFISIMqTeU0x329PTsBMHM5uZ0w1wPeihPoRgPoAKisSENDpEoWixHBv4d0Nl5wHvkh9Su0xujy0vt5XJAQMzx7ROv8YTC6RNep3WyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903287; c=relaxed/simple;
	bh=cPJzXrxLwHXkWiFEE4aAAFggyf8jdNMceE3IMNWt3kk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hroH8pzMexy1A6PHaAakN0YayYO6Y8UmOqYbU2+pkJ8wbd0HuBgsAjGr1eqElGE1+fLLLyXFXhKLIeVIMpbEQkNkbky1DOFcwUu3qT5Wt0w4BUDojycfYh6jkbfMUHOshIPnXWlvUIF+UuxMYNNZ/v4SO6eH8o08IkqQ9loLfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005qZ-A2; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fGG-MA; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-004Y81-1w;
	Wed, 14 Feb 2024 10:34:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 122/164] pwm: stmpe: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:49 +0100
Message-ID:  <2136fbdf9b1e6bac479b935b439e2be73a003b97.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3985; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=cPJzXrxLwHXkWiFEE4aAAFggyf8jdNMceE3IMNWt3kk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjXCJ9N00hJ5kHRel0KLZY2ALPZt/f5igpYs LtLH5gMjUqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI1wAKCRCPgPtYfRL+ TnyhB/wKHZSSeekGr0UMvENfpbAnautZgsAo1BwQTNoMwX5vhhZck7PmI5tqWRrAhAcNu2DFwfG SBVE7drsAZth4qfqroLyvLBDx2RJlKiXRRkrbHYo50ckqXLYvXUPosyYtbybLQd1jfF9PzGlYlW 3UEe9qYEkrNHXB8JRXZRmWAX/YLhdyzw9fH1JBWlNTmEyjjyc2XJzBi0CtSBD0tR4EGCeLP0Qp+ pakt74PsmDhIFwj4c6KzEtCxVy7BL/wGJ5bfKyrKYVe3IXfnpGCeUKyjQHx1tzhbVCvKJzUC8ot COPrrmYUldWV9LS50nSmXE3nF4XF2DBEAC9B4iITVr/fh7jB
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


