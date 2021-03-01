Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B348E328C58
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Mar 2021 19:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236432AbhCASt7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Mar 2021 13:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240395AbhCASqX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Mar 2021 13:46:23 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48646C061756
        for <linux-pwm@vger.kernel.org>; Mon,  1 Mar 2021 10:45:42 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGnY4-0002ff-QW; Mon, 01 Mar 2021 19:45:40 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lGnY3-0006zi-Rd; Mon, 01 Mar 2021 19:45:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>, kernel@pengutronix.de
Subject: [PATCH] pwm: ab8500: Implement .apply instead of .config, .enable and .disable
Date:   Mon,  1 Mar 2021 19:45:37 +0100
Message-Id: <20210301184537.1687926-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 53 +++++++++++++++++++---------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index 58c6c0f5b0ec..5b0a71243d0f 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -24,23 +24,37 @@ struct ab8500_pwm_chip {
 	struct pwm_chip chip;
 };
 
-static int ab8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
 {
-	int ret = 0;
-	unsigned int higher_val, lower_val;
+	int ret;
 	u8 reg;
+	unsigned int higher_val, lower_val;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		ret = abx500_mask_and_set_register_interruptible(chip->dev,
+					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
+					1 << (chip->base - 1), 0);
+
+		if (ret < 0)
+			dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
+								pwm->label, ret);
+		return ret;
+	}
 
 	/*
 	 * get the first 8 bits that are be written to
 	 * AB8500_PWM_OUT_CTRL1_REG[0:7]
 	 */
-	lower_val = duty_ns & 0x00FF;
+	lower_val = state->duty_cycle & 0x00FF;
 	/*
 	 * get bits [9:10] that are to be written to
 	 * AB8500_PWM_OUT_CTRL2_REG[0:1]
 	 */
-	higher_val = ((duty_ns & 0x0300) >> 8);
+	higher_val = ((state->duty_cycle & 0x0300) >> 8);
 
 	reg = AB8500_PWM_OUT_CTRL1_REG + ((chip->base - 1) * 2);
 
@@ -48,15 +62,11 @@ static int ab8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			reg, (u8)lower_val);
 	if (ret < 0)
 		return ret;
+
 	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
 			(reg + 1), (u8)higher_val);
-
-	return ret;
-}
-
-static int ab8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	int ret;
+	if (ret < 0)
+		return ret;
 
 	ret = abx500_mask_and_set_register_interruptible(chip->dev,
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
@@ -64,25 +74,12 @@ static int ab8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (ret < 0)
 		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
-	return ret;
-}
 
-static void ab8500_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	int ret;
-
-	ret = abx500_mask_and_set_register_interruptible(chip->dev,
-				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
-				1 << (chip->base - 1), 0);
-	if (ret < 0)
-		dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
-							pwm->label, ret);
+	return ret;
 }
 
 static const struct pwm_ops ab8500_pwm_ops = {
-	.config = ab8500_pwm_config,
-	.enable = ab8500_pwm_enable,
-	.disable = ab8500_pwm_disable,
+	.apply = ab8500_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.0

