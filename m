Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E9A672212
	for <lists+linux-pwm@lfdr.de>; Wed, 18 Jan 2023 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjARPuu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 18 Jan 2023 10:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjARPuF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 18 Jan 2023 10:50:05 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6F303FE
        for <linux-pwm@vger.kernel.org>; Wed, 18 Jan 2023 07:48:26 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfo-0000Am-3d; Wed, 18 Jan 2023 16:48:24 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfn-006wQ7-AP; Wed, 18 Jan 2023 16:48:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pIAfm-00Du2g-L8; Wed, 18 Jan 2023 16:48:22 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] pwm: ab8500: Fix calculation of duty and period
Date:   Wed, 18 Jan 2023 16:48:16 +0100
Message-Id: <20230118154817.97364-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
References: <20230118154817.97364-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5488; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=wAmmYtsQMXavDHDPs0wKjrTTxIKEX1qyDV5FrazEfyM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjyBS4D3fstm4acwkddDrCELSbWTUlzzNUIINXgIZF 2zC6WqGJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY8gUuAAKCRDB/BR4rcrsCRVxCA CGix0qR01lDwRGoOjraqMdMNYkrsGd8Gi+dgzJfIIO7+g0sATW33V55ZrjSkUVBJyUnyzl8Zqm5b3D ZwOemU/dN6C4eiir1vjMhImP44gPM2BTS2BHImRazPNxA7D+AmgmuNNqlfcbSeb0cfGC5r9p/gDlLW w4pExBtY4y16dArKLuiy2g/+GvlJfWgsrQt166eIprumSqIqWsAXfqv5P9b/yCXe6+YkAleRGiFTk4 qIAzkZRjoXYbwXhmSVP52s3KYAp41Q1S6oHg9V7VhOlP6V2VIX3OKm9/fLwx7czXApdov3xSU3SdvZ GAzD2/OIvwyk1zkvdy7EDZQV54ARKR
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

After a check of the manual it becomes obvious that the calculations in
.apply() are totally bogus:

FreqPWMOutx was always written as zero, so the period was fixed at
3413333.33 ns. However state->period wasn't checked at all.
The lower 10 bits of duty_cycle were just used as DutyPWMOutx. So if
a duty cycle of 512 ns (or 1536 ns) was requested, it actually
programmed 1710000 ns. Other values were wrong by the same factor.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 69 ++++++++++++++++++++++++++++++++++------
 1 file changed, 60 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index ad37bc46f272..c5239eef3b8f 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -3,6 +3,7 @@
  * Copyright (C) ST-Ericsson SA 2010
  *
  * Author: Arun R Murthy <arun.murthy@stericsson.com>
+ * Datasheet: https://web.archive.org/web/20130614115108/http://www.stericsson.com/developers/CD00291561_UM1031_AB8500_user_manual-rev5_CTDS_public.pdf
  */
 #include <linux/err.h>
 #include <linux/platform_device.h>
@@ -20,6 +21,8 @@
 #define AB8500_PWM_OUT_CTRL2_REG	0x61
 #define AB8500_PWM_OUT_CTRL7_REG	0x66
 
+#define AB8500_PWM_CLKRATE 9600000
+
 struct ab8500_pwm_chip {
 	struct pwm_chip chip;
 	unsigned int hwid;
@@ -35,13 +38,60 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	int ret;
 	u8 reg;
-	unsigned int higher_val, lower_val;
+	u8 higher_val, lower_val;
+	unsigned int duty_steps, div;
 	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	if (!state->enabled) {
+	if (state->enabled) {
+		/*
+		 * A time quantum is
+		 *   q = (32 - FreqPWMOutx[3:0]) / AB8500_PWM_CLKRATE
+		 * The period is always 1024 q, duty_cycle is between 1q and 1024q.
+		 *
+		 * FreqPWMOutx[3:0] | output frequency | output frequency | 1024q = period
+		 *                  | (from manual)    |   (1 / 1024q)    | = 1 / freq
+		 * -----------------+------------------+------------------+--------------
+		 *      b0000       |      293 Hz      |  292.968750 Hz   | 3413333.33 ns
+		 *      b0001       |      302 Hz      |  302.419355 Hz   | 3306666.66 ns
+		 *      b0010       |      312 Hz      |  312.500000 Hz   | 3200000    ns
+		 *      b0011       |      323 Hz      |  323.275862 Hz   | 3093333.33 ns
+		 *      b0100       |      334 Hz      |  334.821429 Hz   | 2986666.66 ns
+		 *      b0101       |      347 Hz      |  347.222222 Hz   | 2880000    ns
+		 *      b0110       |      360 Hz      |  360.576923 Hz   | 2773333.33 ns
+		 *      b0111       |      375 Hz      |  375.000000 Hz   | 2666666.66 ns
+		 *      b1000       |      390 Hz      |  390.625000 Hz   | 2560000    ns
+		 *      b1001       |      407 Hz      |  407.608696 Hz   | 2453333.33 ns
+		 *      b1010       |      426 Hz      |  426.136364 Hz   | 2346666.66 ns
+		 *      b1011       |      446 Hz      |  446.428571 Hz   | 2240000    ns
+		 *      b1100       |      468 Hz      |  468.750000 Hz   | 2133333.33 ns
+		 *      b1101       |      493 Hz      |  493.421053 Hz   | 2026666.66 ns
+		 *      b1110       |      520 Hz      |  520.833333 Hz   | 1920000    ns
+		 *      b1111       |      551 Hz      |  551.470588 Hz   | 1813333.33 ns
+		 *
+		 *
+		 * AB8500_PWM_CLKRATE is a multiple of 1024, so the division by
+		 * 1024 can be done in this factor without loss of precision.
+		 */
+		div = min_t(u64, mul_u64_u64_div_u64(state->period,
+						     AB8500_PWM_CLKRATE >> 10,
+						     NSEC_PER_SEC), 32); /* 32 - FreqPWMOutx[3:0] */
+		if (div <= 16)
+			/* requested period < 3413333.33 */
+			return -EINVAL;
+
+		duty_steps = max_t(u64, mul_u64_u64_div_u64(state->duty_cycle,
+							    AB8500_PWM_CLKRATE,
+							    (u64)NSEC_PER_SEC * div), 1024);
+	}
+
+	/*
+	 * The hardware doesn't support duty_steps = 0 explicitly, but emits low
+	 * when disabled.
+	 */
+	if (!state->enabled || duty_steps == 0) {
 		ret = abx500_mask_and_set_register_interruptible(chip->dev,
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 					1 << ab8500->hwid, 0);
@@ -53,28 +103,29 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	/*
-	 * get the first 8 bits that are be written to
+	 * The lower 8 bits of duty_steps is written to ...
 	 * AB8500_PWM_OUT_CTRL1_REG[0:7]
 	 */
-	lower_val = state->duty_cycle & 0x00FF;
+	lower_val = (duty_steps - 1) & 0x00ff;
 	/*
-	 * get bits [9:10] that are to be written to
-	 * AB8500_PWM_OUT_CTRL2_REG[0:1]
+	 * The two remaining high bits to
+	 * AB8500_PWM_OUT_CTRL2_REG[0:1]; together with FreqPWMOutx.
 	 */
-	higher_val = ((state->duty_cycle & 0x0300) >> 8);
+	higher_val = ((duty_steps - 1) & 0x0300) >> 8 | (32 - div) << 4;
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
 	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
-			reg, (u8)lower_val);
+			reg, lower_val);
 	if (ret < 0)
 		return ret;
 
 	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
-			(reg + 1), (u8)higher_val);
+			(reg + 1), higher_val);
 	if (ret < 0)
 		return ret;
 
+	/* enable */
 	ret = abx500_mask_and_set_register_interruptible(chip->dev,
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
 				1 << ab8500->hwid, 1 << ab8500->hwid);
-- 
2.39.0

