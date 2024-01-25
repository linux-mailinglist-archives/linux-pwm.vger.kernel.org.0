Return-Path: <linux-pwm+bounces-973-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8CA83C1FE
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96B0CB23B0F
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FCC33CC9;
	Thu, 25 Jan 2024 12:10:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536B4502E
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184651; cv=none; b=kRMFpTXp27UQ3v/+Jg3bvSTEIn7D3XN0rMhn6F1q78EzftvCpJwxNqGzkqUZcdgbkr+y8MkSrVyTcqwmrHs7IGQ1YkQaNJgo6cCrwgKJFUrBw2zz3Ft823LGCULu7PqfIPtPUC30z5Aacv7yEv9Gh+BC8hci/fB6pmRbKcU1fqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184651; c=relaxed/simple;
	bh=X14x+DY306nHG5hEMQxX1u8V65fC+fZjXfuMgUb+HjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3q5JWRbqYiRG0HokrIBlzLeLWqgjTLDXQeQUaP7nDlJLEhr4d8b0N8TohoCzM0fcoOjlAYCl3dv/22ALnh9dXYJD8NC9YZGFSYgcQXe/VOSvV+QV42C8D4MGT41aPXgPjzABpnrQBowIL/M6bB3WyiOWkLoawXucvdNpgDnNsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZE-00041A-3e; Thu, 25 Jan 2024 13:10:48 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-002HQr-Mo; Thu, 25 Jan 2024 13:10:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-007n0L-22;
	Thu, 25 Jan 2024 13:10:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 034/111] pwm: twl-led: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:56 +0100
Message-ID:  <310ab25192d777892b842949721cf855575f4e00.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5759; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=X14x+DY306nHG5hEMQxX1u8V65fC+fZjXfuMgUb+HjY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9hzHDFMzye1+II6c/mPDI7uFrPYgKaDtFjz e3Dr/C2OTqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPYQAKCRCPgPtYfRL+ TocOB/4njJqRZk9TnMdM27IbPvxrXNbZsXhaqZalsiBYn3nb7QqrK5GSLrQKfJJ0vwv3OI/4bYk 3jYSuD9avDQu3LJpQnmM1WbA4EnhAuPrsDq843UyVBDT0+sNxfu7CsJUjWgRK6yzsgFA+Qb69YI f2AOJtXDfuewuIdJ8Y2eWheimDeNdk8vHWPg+MI8aaWNZgT7roB7tFsdMpvq4KSk/T5RVh4JWZJ J30dvbJH590CfJ9bWbfnv5eiAjs1K3PpFiUFXcG/qOF3EXKOQMjq81+1pC8R4CbbVCpgjVEb895 nWJzS9Oovioo4/eW9a9clB/PTN5CetE0UqYxOTmZRizWqOtX
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
 drivers/pwm/pwm-twl-led.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-twl-led.c b/drivers/pwm/pwm-twl-led.c
index c670ccb81653..00ef798dae52 100644
--- a/drivers/pwm/pwm-twl-led.c
+++ b/drivers/pwm/pwm-twl-led.c
@@ -100,7 +100,7 @@ static int twl4030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = twl_i2c_write(TWL4030_MODULE_LED, pwm_config, base, 2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -114,7 +114,7 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read LEDEN\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read LEDEN\n", pwm->label);
 		goto out;
 	}
 
@@ -122,7 +122,7 @@ static int twl4030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -139,7 +139,7 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_LED, &val, TWL4030_LEDEN_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read LEDEN\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read LEDEN\n", pwm->label);
 		goto out;
 	}
 
@@ -147,7 +147,7 @@ static void twl4030_pwmled_disable(struct pwm_chip *chip,
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_LED, val, TWL4030_LEDEN_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -203,7 +203,7 @@ static int twl6030_pwmled_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, on_time,
 			       TWL6030_LED_PWM_CTRL1);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -217,7 +217,7 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -227,7 +227,7 @@ static int twl6030_pwmled_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -244,7 +244,7 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -254,7 +254,7 @@ static void twl6030_pwmled_disable(struct pwm_chip *chip,
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -295,7 +295,7 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -305,7 +305,7 @@ static int twl6030_pwmled_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to request PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to request PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -321,7 +321,7 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL6030_MODULE_ID1, &val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PWM_CTRL2\n",
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PWM_CTRL2\n",
 			pwm->label);
 		goto out;
 	}
@@ -331,7 +331,7 @@ static void twl6030_pwmled_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_LED_PWM_CTRL2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to free PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to free PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
-- 
2.43.0


