Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE42F9276
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Jan 2021 14:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbhAQNSM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 Jan 2021 08:18:12 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:52023 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbhAQNSJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Sun, 17 Jan 2021 08:18:09 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 2C38E440281;
        Sun, 17 Jan 2021 15:17:17 +0200 (IST)
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
Subject: [PATCH v4 1/5] gpio: mvebu: fix pwm .get_state period calculation
Date:   Sun, 17 Jan 2021 15:17:02 +0200
Message-Id: <588373a200d20da0fa6c2a6c7f1928b4818097e9.1610882271.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610882271.git.baruch@tkos.co.il>
References: <cover.1610882271.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The period is the sum of on and off values. That is, calculate period as

  ($on + $off) / clkrate

instead of

  $off / clkrate - $on / clkrate

that makes no sense.

Reported-by: Russell King <linux@armlinux.org.uk>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: 757642f9a584e ("gpio: mvebu: Add limited PWM support")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 672681a976f5..a912a8fed197 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -676,20 +676,17 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->duty_cycle = 1;
 
+	val = (unsigned long long) u; /* on duration */
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
-	val = (unsigned long long) u * NSEC_PER_SEC;
+	val += (unsigned long long) u; /* period = on + off duration */
+	val *= NSEC_PER_SEC;
 	do_div(val, mvpwm->clk_rate);
-	if (val < state->duty_cycle) {
+	if (val > UINT_MAX)
+		state->period = UINT_MAX;
+	else if (val)
+		state->period = val;
+	else
 		state->period = 1;
-	} else {
-		val -= state->duty_cycle;
-		if (val > UINT_MAX)
-			state->period = UINT_MAX;
-		else if (val)
-			state->period = val;
-		else
-			state->period = 1;
-	}
 
 	regmap_read(mvchip->regs, GPIO_BLINK_EN_OFF + mvchip->offset, &u);
 	if (u)
-- 
2.29.2

