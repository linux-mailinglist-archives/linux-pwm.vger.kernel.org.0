Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D93BC1D7
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Jul 2021 18:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbhGEQ6W (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Jul 2021 12:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbhGEQ6W (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Jul 2021 12:58:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49726C061574
        for <linux-pwm@vger.kernel.org>; Mon,  5 Jul 2021 09:55:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0Rsj-00046O-UP; Mon, 05 Jul 2021 18:55:41 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1m0Rsi-0007rW-TE; Mon, 05 Jul 2021 18:55:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Arun Murthy <arun.murthy@stericsson.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: ab8500: Fix register offset calculation to not depend on probe order
Date:   Mon,  5 Jul 2021 18:55:10 +0200
Message-Id: <20210705165510.443580-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

The assumption that lead to commit 5e5da1e9fbee ("pwm: ab8500:
Explicitly allocate pwm chip base dynamically") was wrong: The
pwm-ab8500 devices are not directly instantiated from device tree, but
from the ab8500 mfd driver. So the pdev->id isn't -1, but a number
between 1 and 3. Now that pwmchip ids are always allocated dynamically,
this cannot easily be reverted.

Introduce a new member in the driver data struct that tracks the
hardware id and use this to calculate the register offset.

Side-note: Using chip->base to calculate the offset was never robust
because if there was already a PWM with id 1 at the time ab8500-pwm.1
was probed, the associated pwmchip would get assigned chip->base = 2 (or
something bigger).

Fixes: 5e5da1e9fbee ("pwm: ab8500: Explicitly allocate pwm chip base dynamically")
Fixes: 6173f8f4ed9c ("pwm: Move AB8500 PWM driver to PWM framework")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ab8500.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-ab8500.c b/drivers/pwm/pwm-ab8500.c
index e2a26d9da25b..281f74a1c50b 100644
--- a/drivers/pwm/pwm-ab8500.c
+++ b/drivers/pwm/pwm-ab8500.c
@@ -22,14 +22,21 @@
 
 struct ab8500_pwm_chip {
 	struct pwm_chip chip;
+	unsigned int hwid;
 };
 
+static struct ab8500_pwm_chip *ab8500_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct ab8500_pwm_chip, chip);
+}
+
 static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	int ret;
 	u8 reg;
 	unsigned int higher_val, lower_val;
+	struct ab8500_pwm_chip *ab8500 = ab8500_pwm_from_chip(chip);
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
@@ -37,7 +44,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!state->enabled) {
 		ret = abx500_mask_and_set_register_interruptible(chip->dev,
 					AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
-					1 << (chip->base - 1), 0);
+					1 << ab8500->hwid, 0);
 
 		if (ret < 0)
 			dev_err(chip->dev, "%s: Failed to disable PWM, Error %d\n",
@@ -56,7 +63,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	higher_val = ((state->duty_cycle & 0x0300) >> 8);
 
-	reg = AB8500_PWM_OUT_CTRL1_REG + ((chip->base - 1) * 2);
+	reg = AB8500_PWM_OUT_CTRL1_REG + (ab8500->hwid * 2);
 
 	ret = abx500_set_register_interruptible(chip->dev, AB8500_MISC,
 			reg, (u8)lower_val);
@@ -70,7 +77,7 @@ static int ab8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = abx500_mask_and_set_register_interruptible(chip->dev,
 				AB8500_MISC, AB8500_PWM_OUT_CTRL7_REG,
-				1 << (chip->base - 1), 1 << (chip->base - 1));
+				1 << ab8500->hwid, 1 << ab8500->hwid);
 	if (ret < 0)
 		dev_err(chip->dev, "%s: Failed to enable PWM, Error %d\n",
 							pwm->label, ret);
@@ -88,6 +95,9 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	struct ab8500_pwm_chip *ab8500;
 	int err;
 
+	if (pdev->id < 1 || pdev->id > 31)
+		return dev_err_probe(&pdev->dev, EINVAL, "Invalid device id %d\n", pdev->id);
+
 	/*
 	 * Nothing to be done in probe, this is required to get the
 	 * device which is required for ab8500 read and write
@@ -99,6 +109,7 @@ static int ab8500_pwm_probe(struct platform_device *pdev)
 	ab8500->chip.dev = &pdev->dev;
 	ab8500->chip.ops = &ab8500_pwm_ops;
 	ab8500->chip.npwm = 1;
+	ab8500->hwid = pdev->id - 1;
 
 	err = pwmchip_add(&ab8500->chip);
 	if (err < 0)

base-commit: 96e45e5202377da39d086ec19f8934ebcc5b0fd6
-- 
2.30.2

