Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B41774414
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbjHHSPB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbjHHSOe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46D81DD2E
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:28 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNH-0007lX-Gp; Tue, 08 Aug 2023 19:20:03 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNG-0022Ab-Ta; Tue, 08 Aug 2023 19:20:02 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNF-00BTGO-Iz; Tue, 08 Aug 2023 19:20:01 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 096/101] pwm: twl: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:26 +0200
Message-Id: <20230808171931.944154-97-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6386; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=5xSqRYI/c2Q3Fvx1mQ0+nkQDGN+P98BjGaKCnhC55R4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkcK7u3szMxFpnMY0dhD7jrlasHKq+eYqo70 a68idhj5buJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5HAAKCRCPgPtYfRL+ Tsb9B/9Nl7VMNbTZB8Ci4kBwhrYwbDueNmlHR9TKacWnZaXBCEa21Dgbp3jtPFTD9et5jCPEPh4 P+T9cYFSwz6WGy+LKC9jNqlQnxNWGZkoO0cg0HadKKb8D2iXm2NQK4TUhIkRfoK1R4g6tAQtSdK EcOek2wfChm9YDpoT0eDAvtmtM9gfsurMdtQ4nyHLmviIZaKNT45z7hW8OP2hPmm563qXosle5h WTkglyV29JuPCCCIAlMsHyNWSfOuYF1pZFN0snvyWUWO6TSFPN6oqwpfE5FEQYgoN6OTpQYiq3t zSw1rLOncv+nn02V+Km7+3+0JDMLc0/tEc9qhT/HS27n4sw4
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
 drivers/pwm/pwm-twl.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index d66596c8597d..f7aa9b34f67e 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -46,6 +46,7 @@
 #define TWL6030_PWM_TOGGLE(pwm, x)	((x) << (pwm * 3))
 
 struct twl_pwm_chip {
+	struct device *parent;
 	struct mutex mutex;
 	u8 twl6030_toggle3;
 	u8 twl4030_pwm_mux;
@@ -59,6 +60,7 @@ static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
 static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  u64 duty_ns, u64 period_ns)
 {
+	struct twl_pwm_chip *twl = to_twl(chip);
 	int duty_cycle = DIV64_U64_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns) + 1;
 	u8 pwm_config[2] = { 1, 0 };
 	int base, ret;
@@ -85,7 +87,7 @@ static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = twl_i2c_write(TWL_MODULE_PWM, pwm_config, base, 2);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to configure PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to configure PWM\n", pwm->label);
 
 	return ret;
 }
@@ -99,7 +101,7 @@ static int twl4030_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_GPBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read GPBR1\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to read GPBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -107,13 +109,13 @@ static int twl4030_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to enable PWM\n", pwm->label);
 
 	val |= TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMX_ENABLE);
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to enable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -129,7 +131,7 @@ static void twl4030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_GPBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read GPBR1\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to read GPBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -137,13 +139,13 @@ static void twl4030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 
 	val &= ~TWL4030_PWM_TOGGLE(pwm->hwpwm, TWL4030_PWMXCLK_ENABLE);
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_GPBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -166,7 +168,7 @@ static int twl4030_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_PMBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PMBR1\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to read PMBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -180,7 +182,7 @@ static int twl4030_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_PMBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to request PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to request PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -201,7 +203,7 @@ static void twl4030_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_lock(&twl->mutex);
 	ret = twl_i2c_read_u8(TWL4030_MODULE_INTBR, &val, TWL4030_PMBR1_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to read PMBR1\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to read PMBR1\n", pwm->label);
 		goto out;
 	}
 
@@ -211,7 +213,7 @@ static void twl4030_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL4030_MODULE_INTBR, val, TWL4030_PMBR1_REG);
 	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to free PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to free PWM\n", pwm->label);
 
 out:
 	mutex_unlock(&twl->mutex);
@@ -230,7 +232,7 @@ static int twl6030_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to enable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to enable PWM\n", pwm->label);
 		goto out;
 	}
 
@@ -253,7 +255,7 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
 
@@ -261,7 +263,7 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
 
@@ -269,7 +271,7 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID1, val, TWL6030_TOGGLE3_REG);
 	if (ret < 0) {
-		dev_err(chip->dev, "%s: Failed to disable PWM\n", pwm->label);
+		dev_err(twl->parent, "%s: Failed to disable PWM\n", pwm->label);
 		goto out;
 	}
 
-- 
2.40.1

