Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3AB2FD561
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Jan 2021 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbhATQTa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Jan 2021 11:19:30 -0500
Received: from guitar.tcltek.co.il ([192.115.133.116]:55095 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391454AbhATQR3 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 20 Jan 2021 11:17:29 -0500
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 4B3714407FA;
        Wed, 20 Jan 2021 18:16:39 +0200 (IST)
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
Subject: [PATCH v5 2/4] gpio: mvebu: make pwm .get_state closer to idempotent
Date:   Wed, 20 Jan 2021 18:16:26 +0200
Message-Id: <27439c93b155e3e298a03ebc69ec4e2f7ce7cdc4.1611128398.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611128398.git.baruch@tkos.co.il>
References: <cover.1611128398.git.baruch@tkos.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Round up the divisions in .get_state() to make applying the read out
configuration idempotent in most cases as .apply rounds down.

Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/gpio/gpio-mvebu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index c424d88e9e2b..8673ba77af5a 100644
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
-- 
2.29.2

