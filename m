Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC47B2DFE3C
	for <lists+linux-pwm@lfdr.de>; Mon, 21 Dec 2020 17:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgLUQ4E (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 21 Dec 2020 11:56:04 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:46711 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgLUQ4D (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 21 Dec 2020 11:56:03 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krOSr-0001tr-5O; Mon, 21 Dec 2020 17:55:17 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1krOSj-0001KI-Um; Mon, 21 Dec 2020 17:55:09 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>,
        Sean Young <sean@mess.org>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH] pwm: bcm2835: Improve period and duty cycle calculation
Date:   Mon, 21 Dec 2020 17:55:01 +0100
Message-Id: <20201221165501.717101-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

With an input clk rate bigger than 2000000000, scaler would have been
zero which then would have resulted in a division by zero.

Also the originally implemented algorithm divided by the result of a
division. This nearly always looses precision. Consider a requested period
of 1000000 ns. With an input clock frequency of 32786885 Hz the hardware
was configured with an actual period of 983869.007 ns (PERIOD = 32258)
while the hardware can provide 1000003.508 ns (PERIOD = 32787).
And note if the input clock frequency was 32786886 Hz instead, the hardware
was configured to 1016656.477 ns (PERIOD = 33333) while the optimal
setting results in 1000003.477 ns (PERIOD = 32787).

This patch implements proper range checking and only divides once for
the calculation of period (and similar for duty_cycle).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

during review of the bcm2835 driver I noticed this double division.

I think the practical relevance is low however because the clock rate is
fixed to 10 MHz on this platform which doesn't result in these
deviations. (Is this right, what is the actual rate?)

Having said that this patch is only compile tested.

Best regards
Uwe

 drivers/pwm/pwm-bcm2835.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index 6ff5f04b3e07..f937db32fa54 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -64,8 +64,9 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	struct bcm2835_pwm *pc = to_bcm2835_pwm(chip);
 	unsigned long rate = clk_get_rate(pc->clk);
-	unsigned long long period;
-	unsigned long scaler;
+	unsigned long long period_cycles;
+	u64 max_period, period, duty_cycle;
+
 	u32 val;
 
 	if (!rate) {
@@ -73,18 +74,34 @@ static int bcm2835_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return -EINVAL;
 	}
 
-	scaler = DIV_ROUND_CLOSEST(NSEC_PER_SEC, rate);
+	/*
+	 * period_cycles must be a 32 bit value, so period * rate / NSEC_PER_SEC
+	 * must be <= U32_MAX. As U32_MAX * NSEC_PER_SEC < U64_MAX the
+	 * multiplication period * rate doesn't overflow.
+	 */
+	max_period = DIV_ROUND_DOWN_ULL((u64)U32_MAX * NSEC_PER_SEC, rate);
+
+	if (state->period > max_period)
+		period = max_period;
+	else
+		period = state->period;
+
+	if (state->duty_cycle > period)
+		duty_cycle = period;
+	else
+		duty_cycle = state->duty_cycle;
+
 	/* set period */
-	period = DIV_ROUND_CLOSEST_ULL(state->period, scaler);
+	period_cycles = DIV_ROUND_CLOSEST_ULL(period * rate, NSEC_PER_SEC);
 
-	/* dont accept a period that is too small or has been truncated */
-	if ((period < PERIOD_MIN) || (period > U32_MAX))
+	/* don't accept a period that is too small */
+	if (period_cycles < PERIOD_MIN)
 		return -EINVAL;
 
-	writel(period, pc->base + PERIOD(pwm->hwpwm));
+	writel(period_cycles, pc->base + PERIOD(pwm->hwpwm));
 
 	/* set duty cycle */
-	val = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, scaler);
+	val = DIV_ROUND_CLOSEST_ULL(duty_cycle * rate, NSEC_PER_SEC);
 	writel(val, pc->base + DUTY(pwm->hwpwm));
 
 	/* set polarity */
-- 
2.29.2

