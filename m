Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2122FD55C
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 17:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391386AbhATQT2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 11:19:28 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55123 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391507AbhATQRk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 Jan 2021 11:17:40 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id DC4A2440DAA;
        Wed, 20 Jan 2021 18:16:41 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Russell King <linux@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 4/4] gpio: mvebu: improve handling of pwm zero on/off values
Date:   Wed, 20 Jan 2021 18:16:28 +0200
Message-Id: <fb61ffe7275237715af92015b2216b8355feb0d6.1611128398.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611128398.git.baruch@tkos.co.il>
References: <cover.1611128398.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hardware appears to treat zero value as 2^32. Take advantage of this
fact to support on/off values of up to UINT_MAX+1 == 2^32. Adjust both
.apply and .get_state to handle zero as a special case.

Rounded up division result in .get_state can't be zero, since the
dividend is now larger than 0. Remove check for this case.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Analyzed-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6b017854ce61..75e3c235bd3a 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -667,22 +667,21 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
-	val = (unsigned long long) u * NSEC_PER_SEC;
-	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
-	if (val)
-		state->duty_cycle = val;
+	/* Hardware treats zero as 2^32. See mvebu_pwm_apply(). */
+	if (u > 0)
+		val = u;
 	else
-		state->duty_cycle = 1;
+		val = UINT_MAX + 1ULL;
+	state->duty_cycle = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC,
+			mvpwm->clk_rate);
 
-	val = (unsigned long long) u; /* on duration */
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
-	val += (unsigned long long) u; /* period = on + off duration */
-	val *= NSEC_PER_SEC;
-	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
-	if (val)
-		state->period = val;
+	/* period = on + off duration */
+	if (u > 0)
+		val += u;
 	else
-		state->period = 1;
+		val += UINT_MAX + 1ULL;
+	state->period = DIV_ROUND_UP_ULL(val * NSEC_PER_SEC, mvpwm->clk_rate);
 
 	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
 	if (u)
@@ -704,9 +703,15 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
 	do_div(val, NSEC_PER_SEC);
-	if (val > UINT_MAX)
+	if (val > UINT_MAX + 1ULL)
 		return -EINVAL;
-	if (val)
+	/*
+	 * Zero on/off values don't work as expected. Experimentation shows
+	 * that zero value is treated as 2^32. This behavior is not documented.
+	 */
+	if (val == UINT_MAX + 1ULL)
+		on = 0;
+	else if (val)
 		on = val;
 	else
 		on = 1;
@@ -714,9 +719,11 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (unsigned long long) mvpwm->clk_rate * state->period;
 	do_div(val, NSEC_PER_SEC);
 	val -= on;
-	if (val > UINT_MAX)
+	if (val > UINT_MAX + 1ULL)
 		return -EINVAL;
-	if (val)
+	if (val == UINT_MAX + 1ULL)
+		off = 0;
+	else if (val)
 		off = val;
 	else
 		off = 1;
-- 
2.29.2

