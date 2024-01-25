Return-Path: <linux-pwm+bounces-970-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7845F83C1CC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55E31F2245E
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C794136B0E;
	Thu, 25 Jan 2024 12:10:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868A45023
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184651; cv=none; b=l7AIWigvRcP90BIb0naZKUIUwC7zw2sl02QKqjlNFJGSvuHY7MVbll9injMYPS1S2+JPsglK6+qvgC5EdCA0S8XW6NRIeYykNYvdLB6FBUhzpnXNsBDKk1DhwrRdklX/PyYIndFnMjFGgUvF4lMbQE3XYSzHCr56ttgVqTRn06Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184651; c=relaxed/simple;
	bh=uZu7ncU3PZl05paVsjapk1h8ZA+56KzF86t148POQ6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbvmHgVPegUIntW4O/cv+SfDJgUPAvHTdp3mXOVTw9XDLqkELL6RuHCIkKVVOuq3hZP6V1FfEj0KeoUmsGb82kx5jKyGJVFwMjfAjfOI0eZwI0fsvjiSlQQ+Um+HzkdF0F8susykeCWsRKh/0FLNbvI8Ldxq1UOGz0YQDSaat7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZD-00042O-Oh; Thu, 25 Jan 2024 13:10:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-002HQu-T2; Thu, 25 Jan 2024 13:10:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-007n0U-2f;
	Thu, 25 Jan 2024 13:10:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 035/111] pwm: twl: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:57 +0100
Message-ID:  <56e853aab4ab8db0ea9a831ed4530f31afcd0341.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5949; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=uZu7ncU3PZl05paVsjapk1h8ZA+56KzF86t148POQ6c=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9isUmADg7oBykd7xzGebGj1691fPnbjht8M tADeoDwp4WJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPYgAKCRCPgPtYfRL+ TqLMB/4ma1oq1E9N9moCm00bhtL4ZyCzLdb/ofAn1B07zzX0KzbkY6NEs12lNx/EA148RXjirg0 PH/ZmkobzBacrSFh1Reir04MZFNJQwR08lJ2g5S3d4fYXHI7bP3fYsGMv2tZpaCTJHehxA3f3Pl EA15YQ0kel2IOByRfldRQLqVow3vZJeDJBSWQfUnDectGBLyYDXvcW++Tsnlz6t6H/kpk6aTA9+ K2b7GsDRUCRz00jPaHQ1YeIsUgq7OgYG3q446UBCgcauS9zPZOLXZZsLtRW/1zMo7aGwQvaJ+6Z XzMcZx/v7pPeGlQvDm+MiYgwVR/s/03I1SXhmzCwcyTMVQXs
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
 drivers/pwm/pwm-twl.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 68e02c9a6bf9..7233ae039bdb 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -86,7 +86,7 @@ static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = twl_i2c_write(TWL_MODULE_PWM, pwm_config, base, 2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -100,7 +100,7 @@ static int twl4030_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_GPBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read GPBR1\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read GPBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -108,13 +108,13 @@ static int twl4030_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
 	val |= TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMX_ENABLE);
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -130,7 +130,7 @@ static void twl4030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_GPBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read GPBR1\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read GPBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -138,13 +138,13 @@ static void twl4030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 
 	val &= ~TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMXCLK_ENABLE);
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -167,7 +167,7 @@ static int twl4030_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_PMBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PMBR1\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PMBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -181,7 +181,7 @@ static int twl4030_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_PMBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to request PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to request PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -202,7 +202,7 @@ static void twl4030_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_PMBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PMBR1\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to read PMBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -212,7 +212,7 @@ static void twl4030_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_PMBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to free PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to free PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -231,7 +231,7 @@ static int twl6030_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to enable PWM\n", pwm->label);
 		goto out;
 	}
 
@@ -254,7 +254,7 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
 
@@ -262,7 +262,7 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
 
@@ -270,7 +270,7 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(pwmchip_parent(chip), "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
 
-- 
2.43.0


