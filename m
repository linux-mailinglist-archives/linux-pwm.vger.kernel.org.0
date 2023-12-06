Return-Path: <linux-pwm+bounces-335-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B4806E73
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CB481F21563
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257FE358AD;
	Wed,  6 Dec 2023 11:48:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14602D64
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOB-0006OF-GU; Wed, 06 Dec 2023 12:48:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOB-00Dwtq-3R; Wed, 06 Dec 2023 12:48:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-00FQz2-Ql; Wed, 06 Dec 2023 12:48:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 039/115] pwm: twl: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:53 +0100
Message-ID:  <9bb5babe112c15b0781ca6ce7a002b887b5c1634.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5949; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=UtPXctsPF5xPCIk8dswOWb4Z0qoHqT/eJJudj3K5iuo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6Og3jmTfdsyYWFVMKFwP+vl8cCHLMHJMAAU UvBg/rhn2SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBejgAKCRCPgPtYfRL+ TkcrB/4nuhwD4FHh9EYZYmUlczPN99T1cTmdsWCAS9FIKqVpEKG4AsNAOwTAQYqxMH0J5oK3PIa 5fLbQNeTlF9z+3HmFK5fh++qsN08wSyqKLNzamEQ9HKCeaQOMA/89nOwCm8qS78zS+hSLf/w+VN a22h0ImFLJVhS0OBy5cpUg3wtTnSRa9m0y5gXYsg5/4gT39gMb8R/C0iib4JtDxbOVBdMhs/Af6 LDwWDZ4g5wNArYgx6QUdHzDzlNchDK8srteSGZxzeOa1GJdtO9NHoNbDLX3ssHsrpla2sg9hhR2 HK3yF+uI+Ef0tqa21XpjsTPfQUihZU4DMNcHrDcZdRhcmY6E
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
2.42.0


