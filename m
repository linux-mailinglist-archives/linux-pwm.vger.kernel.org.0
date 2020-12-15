Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C532DB5D5
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 22:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgLOVZ5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 16:25:57 -0500
Received: from mail.pqgruber.com ([52.59.78.55]:54728 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgLOVZh (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 15 Dec 2020 16:25:37 -0500
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 4E628C727E5;
        Tue, 15 Dec 2020 22:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1608067494;
        bh=kHby63bueNno6SajQC6qRDHclc/CI0IKw4C1GFWWmvg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B+r124iIe7HGprQKt/BK0Z2gwejiFPdn1lzj+3Tbi2T9vRUtzwSi9pgEZgQp+JK7g
         wDb4oYXIM0JAEZd6HYX4y46FouXEJnJlJrflAlKaA/EvnDdsnhl830a0WLYDMbZNat
         a9MatMMJHaSGwiADfQJtubeYbCVGlgooB+Ry9KnY=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        u.kleine-koenig@pengutronix.de,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        David Jander <david@protonic.nl>,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v5 2/7] pwm: pca9685: Support hardware readout
Date:   Tue, 15 Dec 2020 22:22:23 +0100
Message-Id: <20201215212228.185517-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
References: <20201215212228.185517-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implements .get_state to read-out the current hardware state.

The hardware readout may return slightly different values than those
that were set in apply due to the limited range of possible prescale and
counter register values.

Also note that although the datasheet mentions 200 Hz as default
frequency when using the internal 25 MHz oscillator, the calculated
period from the default prescaler register setting of 30 is 5079040ns.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 drivers/pwm/pwm-pca9685.c | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 1b5b5fb93b43..b3398963c0ff 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -331,6 +331,46 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pca9685 *pca = to_pca(chip);
+	unsigned long long duty;
+	unsigned int val;
+
+	/* Calculate (chip-wide) period from prescale value */
+	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
+			(val + 1);
+
+	/* The (per-channel) polarity is fixed */
+	state->polarity = PWM_POLARITY_NORMAL;
+
+	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
+		/*
+		 * The "all LEDs" channel does not support HW readout
+		 * Return 0 and disabled for backwards compatibility
+		 */
+		state->duty_cycle = 0;
+		state->enabled = false;
+		return;
+	}
+
+	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
+
+	state->enabled = !!duty;
+	if (!state->enabled) {
+		state->duty_cycle = 0;
+		return;
+	} else if (duty == PCA9685_COUNTER_RANGE) {
+		state->duty_cycle = state->period;
+		return;
+	}
+
+	duty *= state->period;
+	state->duty_cycle = duty / PCA9685_COUNTER_RANGE;
+}
+
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -353,6 +393,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static const struct pwm_ops pca9685_pwm_ops = {
 	.apply = pca9685_pwm_apply,
+	.get_state = pca9685_pwm_get_state,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
-- 
2.29.2

