Return-Path: <linux-pwm+bounces-1453-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83FC854615
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33E181F2E09E
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE0E168D0;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8031B5AA
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903291; cv=none; b=M+oCj4W79IVE76BVh3mkW8QtRGmBahdk7d3v19I2Ta1VSoB1lotQvFhLTeXv+MBTCRK+Baejs5bSam8k0DV/pnGMVILphorgYMUhUYJkX4ODcukzYVkcpbidhvPC1t/mZqvUWnpT6VHjk8bWXj0/sGaieaqDNmE4AgeeJDC7hMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903291; c=relaxed/simple;
	bh=40Xo9fn01eQdlm2DNVi7Sc8sYzbB/3XoAwQupQBB1ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YVGe01paBXsftTYJZpM87Tdt7GJkAesK5YFNWbNTMdX5ihSzK3ZmaN5Rx8/M4aY5m573GDZQKqGRM7qn/EkAQiwkSL/XWfBCrv3UySenH1QIm5166O38IA1ll7pfwlH0zB7hqjJ8EqjqRvpELOS73WpjabZHz1vvGQKsUq1/e8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-00066c-G3; Wed, 14 Feb 2024 10:34:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-000fHY-L9; Wed, 14 Feb 2024 10:34:39 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-004Y9T-1s;
	Wed, 14 Feb 2024 10:34:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 142/164] pwm: twl-led: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:33:09 +0100
Message-ID:  <43c35b7116a637501b51ac93ec24c00ea92ee1af.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5771; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=40Xo9fn01eQdlm2DNVi7Sc8sYzbB/3XoAwQupQBB1ZU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjusuMtqtpjsiu/Eh9GauS5QL7iFwT3cWoRF GAooGXieFmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI7gAKCRCPgPtYfRL+ TkuAB/oC/C4qcg3egKJyY/EMXdKNE1DVjg+HSlLrO96AuJFPxAe9kUAwBbPk1rRZsdUpBKXAVCD T5kUceasLZ89t1TGi+lLgFBrsot1w5W2ZTgpJbqTlQgNc4kZrOJKygOKf2boSpiYnSds6FMNDq8 3h9c3eags2Mc790TKPjc0PnOwc6Hw+7gCZ1LNEYABluJQxoRJVM8h3pcuOXvZ0RxPYwXVPipqSV qaqooQUuRxlEMu/5IxdHl3a7Yj/AEMkJO3Fl+bgJHI0f8eZNN3bMGDPuGyw+zxAjRvq7EqaYgEn H4tf6DUaAX9lKKPW176IQzudYeWFdh6gxqPfOj8T7w+QYPhA
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


