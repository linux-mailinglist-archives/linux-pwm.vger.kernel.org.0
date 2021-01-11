Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646B72F10F9
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbhAKLS1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 06:18:27 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:43328 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728569AbhAKLS1 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Jan 2021 06:18:27 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 45B8A4405AD;
        Mon, 11 Jan 2021 13:17:44 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        linux-pwm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/5] gpio: mvebu: make pwm apply/get_state closer to idempotent
Date:   Mon, 11 Jan 2021 13:17:04 +0200
Message-Id: <1c8864722e4c74d1d8d5d4a213998a1672be9992.1610362661.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610362661.git.baruch@tkos.co.il>
References: <cover.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Round up the result of division in period/duty_cycle calculation to make
the result closer to idempotent.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index c424d88e9e2b..6fc64846eda3 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -668,7 +668,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
 	val = (unsigned long long) u * NSEC_PER_SEC;
-	do_div(val, mvpwm->clk_rate);
+	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
 	if (val > UINT_MAX)
 		state->duty_cycle = UINT_MAX;
 	else if (val)
@@ -680,7 +680,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_off_duration(mvpwm), &u);
 	val += (unsigned long long) u; /* period = on + off duration */
 	val *= NSEC_PER_SEC;
-	do_div(val, mvpwm->clk_rate);
+	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
 	if (val > UINT_MAX)
 		state->period = UINT_MAX;
 	else if (val)
@@ -707,7 +707,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned int on, off;
 
 	val = (unsigned long long) mvpwm->clk_rate * state->duty_cycle;
-	do_div(val, NSEC_PER_SEC);
+	val = DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);
 	if (val > UINT_MAX)
 		return -EINVAL;
 	if (val)
@@ -716,7 +716,7 @@ static int mvebu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		on = 1;
 
 	val = (unsigned long long) mvpwm->clk_rate * state->period;
-	do_div(val, NSEC_PER_SEC);
+	val = DIV_ROUND_UP_ULL(val, NSEC_PER_SEC);
 	val -= on;
 	if (val > UINT_MAX)
 		return -EINVAL;
-- 
2.29.2

