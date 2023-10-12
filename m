Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305ED7C72A4
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379601AbjJLQa7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379525AbjJLQa5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:30:57 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB5CF
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:30:53 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaK-0004gF-8e; Thu, 12 Oct 2023 18:30:52 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-001C5U-SM; Thu, 12 Oct 2023 18:30:51 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaJ-00F5ML-JN; Thu, 12 Oct 2023 18:30:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 004/109] pwm: atmel: Make use of pwmchip_parent() macro
Date:   Thu, 12 Oct 2023 18:28:32 +0200
Message-ID: <20231012162827.1002444-115-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=kchnmBeM6dTUrRyczIW+qjV7tOiXzRrzwU7RLUUbwus=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB6whUyTKcE9gN6+Zc5xJTgAKfQ/XAJNfqJCV azqwn2Ia5yJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgesAAKCRCPgPtYfRL+ TslUCACtgSbZn9GzTz1xpEsO/Q8CxBzatGaeZ/q/UXygIKrfv+Ei647jNhr1sX4XKiFXKQuGEPG e9GenS2XO5JVDEdfGyWVirCRQoUctsIDu5cAPEf2XPW/h9mTIxYNE4XpRaZz1nYajIaKcLUTUMj oX1Kr1i4mAI1JkUuKYDZyc4emFo3VaFpKC4KufvkqnCUTnUO25xnf83Lujs2M4u/n5AwGP8ZLiN kZmaYoz5oBNWBQD6OU/YwQfe34xqmiDN35Nm+Gaa1rVDgOp6XYxyumOSGma/a/wfPPlsWZ7daUC as7qCqev0J3/nxTCCY6u5APNMNOQzy3nEZJX2W2umIR3qHnX
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
 drivers/pwm/pwm-atmel.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 47bcc8a3bf9d..4ef91fe6f147 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -210,7 +210,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	shift = fls(cycles) - atmel_pwm->data->cfg.period_bits;
 
 	if (shift > PWM_MAX_PRES) {
-		dev_err(chip->dev, "pres exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "pres exceeds the maximum value\n");
 		return -EINVAL;
 	} else if (shift > 0) {
 		*pres = shift;
@@ -321,7 +321,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ret = atmel_pwm_calculate_cprd_and_pres(chip, clkrate, state, &cprd,
 							&pres);
 		if (ret) {
-			dev_err(chip->dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to calculate cprd and prescaler\n");
 			return ret;
 		}
@@ -333,7 +333,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		} else {
 			ret = clk_enable(atmel_pwm->clk);
 			if (ret) {
-				dev_err(chip->dev, "failed to enable clock\n");
+				dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 				return ret;
 			}
 		}
@@ -462,8 +462,9 @@ static const struct of_device_id atmel_pwm_dt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, atmel_pwm_dt_ids);
 
-static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
+static int atmel_pwm_enable_clk_if_on(struct pwm_chip *chip, bool on)
 {
+	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned int i, cnt = 0;
 	unsigned long sr;
 	int ret = 0;
@@ -480,7 +481,7 @@ static int atmel_pwm_enable_clk_if_on(struct atmel_pwm_chip *atmel_pwm, bool on)
 	for (i = 0; i < cnt; i++) {
 		ret = clk_enable(atmel_pwm->clk);
 		if (ret) {
-			dev_err(atmel_pwm->chip.dev,
+			dev_err(pwmchip_parent(chip),
 				"failed to enable clock for pwm %pe\n",
 				ERR_PTR(ret));
 
@@ -525,7 +526,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	atmel_pwm->chip.ops = &atmel_pwm_ops;
 	atmel_pwm->chip.npwm = 4;
 
-	ret = atmel_pwm_enable_clk_if_on(atmel_pwm, true);
+	ret = atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, true);
 	if (ret < 0)
 		return ret;
 
@@ -538,7 +539,7 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 disable_clk:
-	atmel_pwm_enable_clk_if_on(atmel_pwm, false);
+	atmel_pwm_enable_clk_if_on(&atmel_pwm->chip, false);
 
 	return ret;
 }
-- 
2.42.0

