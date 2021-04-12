Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03B835C78C
	for <lists+linux-pwm@lfdr.de>; Mon, 12 Apr 2021 15:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239175AbhDLN3V (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 12 Apr 2021 09:29:21 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:59790 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237277AbhDLN3U (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 12 Apr 2021 09:29:20 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 571D3C725CF;
        Mon, 12 Apr 2021 15:29:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1618234140;
        bh=ZtZXR9Xo6D9jGVtq6dWiereAvHIsaPXkSy2ICiAWTiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kdGrCkLjji2lDl2QCGAPXiJ7sqEw/d9QcQ41mawFCMrU5Z+GtUG5eaUVWMx24rCFE
         ufugomTXtHVePJM8xGpHYEuaHaTaSiYlC0w8z7w8BEtgtqwfBH7DfNirOv2Yn2inaA
         sIjp1LqkIs6MThIUJufRSpeOPpLZXvJ3a1hOjefw=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH v8 2/8] pwm: pca9685: Support hardware readout
Date:   Mon, 12 Apr 2021 15:27:39 +0200
Message-Id: <20210412132745.76609-2-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
References: <20210412132745.76609-1-clemens.gruber@pqgruber.com>
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
Changes since v7:
- Always return enabled=true for channels except "all LEDs" channel
- Use DIV_ROUND_UP in .get_state

Changes since v6:
- Added a comment regarding the division (Suggested by Uwe)
- Rebased

 drivers/pwm/pwm-pca9685.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 827b57ced3c2..b39c0ba701ab 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -329,6 +329,41 @@ static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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
+	state->duty_cycle = DIV_ROUND_UP_ULL(duty * state->period, PCA9685_COUNTER_RANGE);
+}
+
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -351,6 +386,7 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 
 static const struct pwm_ops pca9685_pwm_ops = {
 	.apply = pca9685_pwm_apply,
+	.get_state = pca9685_pwm_get_state,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 	.owner = THIS_MODULE,
-- 
2.31.1

