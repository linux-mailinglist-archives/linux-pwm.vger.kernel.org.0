Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB75E2F10FA
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Jan 2021 12:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbhAKLS3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 11 Jan 2021 06:18:29 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:43340 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729549AbhAKLS3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 11 Jan 2021 06:18:29 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 23C644407ED;
        Mon, 11 Jan 2021 13:17:46 +0200 (IST)
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
Subject: [PATCH 4/5] gpio: mvebu: don't limit pwm period/duty_cycle to UINT_MAX
Date:   Mon, 11 Jan 2021 13:17:05 +0200
Message-Id: <97e5ed4dfc4385a99c585f7980210f9dd7c6ee3d.1610362661.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610362661.git.baruch@tkos.co.il>
References: <cover.1610362661.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

PWM on/off registers are limited to UINT_MAX. However the state period
and duty_cycle fields are ns values of type u64. There is no reason to
limit them to UINT_MAX.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 6fc64846eda3..eb7456fa6d86 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -669,9 +669,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	regmap_read(mvpwm->regs, mvebu_pwmreg_blink_on_duration(mvpwm), &u);
 	val = (unsigned long long) u * NSEC_PER_SEC;
 	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
-	if (val > UINT_MAX)
-		state->duty_cycle = UINT_MAX;
-	else if (val)
+	if (val)
 		state->duty_cycle = val;
 	else
 		state->duty_cycle = 1;
@@ -681,9 +679,7 @@ static void mvebu_pwm_get_state(struct pwm_chip *chip,
 	val += (unsigned long long) u; /* period = on + off duration */
 	val *= NSEC_PER_SEC;
 	val = DIV_ROUND_UP_ULL(val, mvpwm->clk_rate);
-	if (val > UINT_MAX)
-		state->period = UINT_MAX;
-	else if (val)
+	if (val)
 		state->period = val;
 	else
 		state->period = 1;
-- 
2.29.2

