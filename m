Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F792F9279
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 14:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbhAQNS5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 08:18:57 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52072 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728967AbhAQNSx (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 Jan 2021 08:18:53 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 606B8440856;
        Sun, 17 Jan 2021 15:17:32 +0200 (IST)
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
Subject: [PATCH v4 5/5] gpio: mvebu: improve handling of pwm zero on/off values
Date:   Sun, 17 Jan 2021 15:17:06 +0200
Message-Id: <065aa239ba7e10b64f1c563aba08626f5de790ba.1610882271.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610882271.git.baruch@tkos.co.il>
References: <cover.1610882271.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hardware appears to treat zero value as 2^32. Take advantage of this
fact to support on/off values of up to UINT_MAX+1 == 2^32. Adjust both
.apply and .get_sate to handle zero as a special case.

Rounded up division result in .get_state can't be zero, since the
dividend is now larger than 0. Remove check for this case.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Analyzed-by: Russell King <linux@armlinux.org.uk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6b017854ce61..37f5bd65062f 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -667,22 +667,20 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	spin_lock_irqsave(&mvpwm->lock, flags);
 
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
-	val = (unsigned long long) u * NSEC_PER_SEC;
-	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
-	if (val)
-		state->duty_cycle = val;
+	/* Hardware treats zero as 2^32. See mvebu_pwm_apply(). */
+	if (u > 0)
+		val = (unsigned long long) u * NSEC_PER_SEC;
 	else
-		state->duty_cycle = 1;
+		val = ((unsigned long long) UINT_MAX+1) * NSEC_PER_SEC;
+	state->duty_cycle = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
 
-	val = (unsigned long long) u; /* on duration */
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
-	val += (unsigned long long) u; /* period = on + off duration */
-	val *= NSEC_PER_SEC;
-	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
-	if (val)
-		state->period = val;
+	/* period = on + off duration */
+	if (u > 0)
+		val += (unsigned long long) u * NSEC_PER_SEC;
 	else
-		state->period = 1;
+		val += ((unsigned long long) UINT_MAX+1) * NSEC_PER_SEC;
+	state->period = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
 
 	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
 	if (u)
@@ -704,9 +702,15 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
 	do_div(val, NSEC_PER_SEC);
-	if (val > UINT_MAX)
+	if (val > (unsigned long long) UINT_MAX+1)
 		return -EINVAL;
-	if (val)
+	/*
+	 * Zero on/off values don't work as expected. Experimentation shows
+	 * that zero value is treated as 2^32. This behavior is not documented.
+	 */
+	if (val == (unsigned long long) UINT_MAX+1)
+		on = 0;
+	else if (val)
 		on = val;
 	else
 		on = 1;
@@ -714,9 +718,11 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (unsigned long long) mvpwm->clk_rate * state->period;
 	do_div(val, NSEC_PER_SEC);
 	val -= on;
-	if (val > UINT_MAX)
+	if (val > (unsigned long long) UINT_MAX+1)
 		return -EINVAL;
-	if (val)
+	if (val == (unsigned long long) UINT_MAX+1)
+		off = 0;
+	else if (val)
 		off = val;
 	else
 		off = 1;
-- 
2.29.2

