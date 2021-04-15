Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7457F36090B
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Apr 2021 14:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbhDOMPm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Apr 2021 08:15:42 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:34760 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231590AbhDOMPl (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 15 Apr 2021 08:15:41 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id A46EDC725D8;
        Thu, 15 Apr 2021 14:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618488916;
        bh=06ZRhpbZxpxadONy0rq3gW+vmEz9TQ24K/L4VxJp+H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qaALg2Q1xoIuc8ukGjU9iwMA4OVX01EGXckf1uyZ4frUa6uAwkHgVu4IBDjuZOmFV
         Dq/TfmycpYnu0rxwQ9v7frA1Ayncve67HMfHoNiy6FRllB3+fhwqpNCwO6VwJzGFOG
         hO3kI2mlmULtTnL7wRXFDoukIs72oKjFzBFxWL4s=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v9 2/8] pwm: pca9685: Support hardware readout
Date:   Thu, 15 Apr 2021 14:14:49 +0200
Message-Id: <20210415121455.39536-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
References: <20210415121455.39536-1-clemens.gruber@pqgruber.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Implement .get_state to read-out the current hardware state.

The hardware readout may return slightly different values than those
that were set in apply due to the limited range of possible prescale and
counter register values.

Also note that although the datasheet mentions 200 Hz as default
frequency when using the internal 25 MHz oscillator, the calculated
period from the default prescaler register setting of 30 is 5079040ns.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
Changes since v8:
- As we left the math in apply as-is, use DIV_ROUND_DOWN in get_state

Changes since v7:
- Always return enabled=true for channels except "all LEDs" channel
- Use DIV_ROUND_UP in .get_state

Changes since v6:
- Added a comment regarding the division (Suggested by Uwe)
- Rebased

 drivers/pwm/pwm-pca9685.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index ea19d72e5c34..aa48c45bd294 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -331,6 +331,41 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
+static void pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
+				  struct pwm_state *state)
+{
+	struct pca9685 *pca = to_pca(chip);
+	unsigned long long duty;
+	unsigned int val = 0;
+
+	/* Calculate (chip-wide) period from prescale value */
+	regmap_read(pca->regmap, PCA9685_PRESCALE, &val);
+	/*
+	 * PCA9685_OSC_CLOCK_MHZ is 25, i.e. an integer divider of 1000.
+	 * The following calculation is therefore only a multiplication
+	 * and we are not losing precision.
+	 */
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
+	state->enabled = true;
+	duty = pca9685_pwm_get_duty(pca, pwm->hwpwm);
+	state->duty_cycle = DIV_ROUND_DOWN_ULL(duty * state->period, PCA9685_COUNTER_RANGE);
+}
+
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -353,6 +388,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static const struct pwm_ops pca9685_pwm_ops = {
 	.apply = pca9685_pwm_apply,
+	.get_state = pca9685_pwm_get_state,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
-- 
2.31.1

