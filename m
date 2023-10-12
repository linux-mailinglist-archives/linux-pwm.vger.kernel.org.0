Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7D47C72C3
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379601AbjJLQbP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379609AbjJLQbB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:01 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD89DCA
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:59 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaQ-0004xE-6n; Thu, 12 Oct 2023 18:30:58 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-001C7V-OW; Thu, 12 Oct 2023 18:30:57 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaP-00F5OR-FU; Thu, 12 Oct 2023 18:30:57 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 035/109] pwm: twl: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:29:03 +0200
Message-ID: <20231012162827.1002444-146-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5949; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+KwJ4o5AIHPowTaP4FP0eNm+9RFGL4Xevpq4Eo/3wWc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhlQNuauHFcMfiTU+EXsfvqR0X4eBlJfyocdMpXdPN024s nrCvMYnnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBMpJGXg2HR84SJ+x3eZKYx zHAO11JV4lWoEm27M6ny5V1jlWYTE++k1ZVTmq9P5m1V5M7plrt66dSK3P1Trt5+OJUzXln78al nUodybtx+8upb0QeniRa3N/bJT+SdxpOX7MnNdl2+/JnqPDWtuGj7OKfa5rkntmqxzDraVbJKet adNg13J/uNU9PbIo58utWz+oy6bdrrI9J/q+Zs6si1WZvKv6jodO4vznczL5xwfh+88GTwBd4g8 44LnXIFitw8nAyMPcnbuzVsdy75dmQh77KK4lRZz4r/bmc1jRWLnll48Apc+MnhYOrSo5Y7YULZ Hs3cdFu2PcGWYauLU1L01HNkdRyPJT6MjPt4q3nixNWxAA==
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
 drivers/pwm/pwm-twl.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 603d31f27470..073c107964f6 100644
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

