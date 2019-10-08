Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5FABCF78C
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2019 12:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbfJHKy1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Oct 2019 06:54:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44762 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbfJHKy1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Oct 2019 06:54:27 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 7DDAD28FBC6
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Cc:     heiko@sntech.de, dianders@chromium.org, mka@chromium.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        groeck@chromium.org, kernel@collabora.com, bleung@chromium.org,
        linux-pwm@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: cros-ec: Let cros_ec_pwm_get_state() return the last applied state
Date:   Tue,  8 Oct 2019 12:54:17 +0200
Message-Id: <20191008105417.16132-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For the cros-ec-pwm, "disabled" is the same as "duty cycle == 0", and is
not possible to program a duty cycle while the device is disabled. However,
the PWM API allows us to configure the "duty cycle" while the device is
"disabled". But now, pwm_get_state() is returning the real hardware state
instead of the last applied state, and this change of behavior, broke
the display on my rk3399-gru-kevin and doesn't turn on anymore.

Commit 01ccf903edd6 ("pwm: Let pwm_get_state() return the last implemented
state") introduced this change of behavior. And, assuming that this is
the right to do, workaround this problem for the cros-ec-pwm driver by
reverting the mentioned commit at the lowlevel driver.

With that patch applied pwm_get_state() will return only the programmed
hardware duty cycle value if the PWM is enabled. When is disabled, will
return the last applied duty_cycle value instead. That's not ideal, but
definetely is better than don't implement .get_state().

Fixes: 01ccf903edd6 ("pwm: Let pwm_get_state() return the last implemented state")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/pwm/pwm-cros-ec.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d217..f750a3cf0c6c 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -18,11 +18,13 @@
  * @dev: Device node
  * @ec: Pointer to EC device
  * @chip: PWM controller chip
+ * @state: Holds the last state applied
  */
 struct cros_ec_pwm_device {
 	struct device *dev;
 	struct cros_ec_device *ec;
 	struct pwm_chip chip;
+	struct pwm_state state;
 };
 
 static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
@@ -102,6 +104,9 @@ static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != EC_PWM_MAX_DUTY)
 		return -EINVAL;
 
+	/* Store the new state */
+	ec_pwm->state = *state;
+
 	/*
 	 * EC doesn't separate the concept of duty cycle and enabled, but
 	 * kernel does. Translate.
@@ -117,17 +122,28 @@ static void cros_ec_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct cros_ec_pwm_device *ec_pwm = pwm_to_cros_ec_pwm(chip);
 	int ret;
 
-	ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
-	if (ret < 0) {
-		dev_err(chip->dev, "error getting initial duty: %d\n", ret);
-		return;
+	/*
+	 * As there is no way for this hardware to separate the concept of
+	 * duty cycle and enabled, but the PWM API does, let return the last
+	 * applied state when the PWM is disabled and only return the real
+	 * hardware value when the PWM is enabled. Otherwise, a user of this
+	 * driver, can get confused because won't be able to program a duty
+	 * cycle while the PWM is disabled.
+	 */
+	state->enabled = ec_pwm->state.enabled;
+	if (state->enabled) {
+		ret = cros_ec_pwm_get_duty(ec_pwm->ec, pwm->hwpwm);
+		if (ret < 0) {
+			dev_err(chip->dev, "error getting initial duty: %d\n",
+				ret);
+			return;
+		}
+		state->duty_cycle = ret;
+	} else {
+		state->duty_cycle = ec_pwm->state.duty_cycle;
 	}
 
-	state->enabled = (ret > 0);
 	state->period = EC_PWM_MAX_DUTY;
-
-	/* Note that "disabled" and "duty cycle == 0" are treated the same */
-	state->duty_cycle = ret;
 }
 
 static struct pwm_device *
-- 
2.20.1

