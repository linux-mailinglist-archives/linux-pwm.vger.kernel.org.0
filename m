Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DA534D0B0
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Mar 2021 14:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhC2M67 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Mar 2021 08:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbhC2M6f (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Mar 2021 08:58:35 -0400
Received: from mail.pqgruber.com (mail.pqgruber.com [IPv6:2a05:d014:575:f70b:4f2c:8f1d:40c4:b13e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1280C061762;
        Mon, 29 Mar 2021 05:58:34 -0700 (PDT)
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id B37DAC72850;
        Mon, 29 Mar 2021 14:58:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1617022712;
        bh=4ELuNUPSMc13bRxSJqgUir+ULqspUkoZCvlmwEYQQrs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MK+x+Tm7lSQNA/Ggak/MG60kWPBhovEPtkCWQq3qM4ps8Ew4IeT1gKxnRFigIqudB
         vIvYfY00+iUumi6/3WCML8u5uoM0EVp1W5velOm9mTDZiYl7+NHqnBhtKU2RWNSXzf
         p1tFuhbo1A8fK3BK4P+GXfLmqDzDwwIAV1vGi1Ys=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v6 2/7] pwm: pca9685: Support hardware readout
Date:   Mon, 29 Mar 2021 14:57:02 +0200
Message-Id: <20210329125707.182732-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
References: <20210329125707.182732-1-clemens.gruber@pqgruber.com>
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
index 0ed1013737e3..fb026a25fb61 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -333,6 +333,46 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
@@ -355,6 +395,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static const struct pwm_ops pca9685_pwm_ops = {
 	.apply = pca9685_pwm_apply,
+	.get_state = pca9685_pwm_get_state,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
-- 
2.31.1

