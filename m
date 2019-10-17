Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A302DA6FB
	for <lists+linux-pwm@lfdr.de>; Thu, 17 Oct 2019 10:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408162AbfJQILM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 17 Oct 2019 04:11:12 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:40121 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392882AbfJQILL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 17 Oct 2019 04:11:11 -0400
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iL0sH-0005ka-6T; Thu, 17 Oct 2019 10:11:09 +0200
Received: from ukl by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iL0sG-0002A7-6d; Thu, 17 Oct 2019 10:11:08 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Adam Ford <aford173@gmail.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] backlight: pwm_bl: configure pwm only once per backlight toggle
Date:   Thu, 17 Oct 2019 10:10:59 +0200
Message-Id: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A previous change in the pwm core (namely 01ccf903edd6 ("pwm: Let
pwm_get_state() return the last implemented state")) changed the
semantic of pwm_get_state() and disclosed an (as it seems) common
problem in lowlevel PWM drivers. By not relying on the period and duty
cycle being retrievable from a disabled PWM this type of problem is
worked around.

Apart from this issue only calling the pwm_get_state/pwm_apply_state
combo once is also more effective.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

There are now two reports about 01ccf903edd6 breaking a backlight. As
far as I understand the problem this is a combination of the backend pwm
driver yielding surprising results and the pwm-bl driver doing things
more complicated than necessary.

So I guess this patch works around these problems. Still it would be
interesting to find out the details in the imx driver that triggers the
problem. So Adam, can you please instrument the pwm-imx27 driver to
print *state at the beginning of pwm_imx27_apply() and the end of
pwm_imx27_get_state() and provide the results?

Note I only compile tested this change.

Best regards
Uwe

 drivers/video/backlight/pwm_bl.c | 34 +++++++++++---------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..ddebd62b3978 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -42,10 +42,8 @@ struct pwm_bl_data {
 
 static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 {
-	struct pwm_state state;
 	int err;
 
-	pwm_get_state(pb->pwm, &state);
 	if (pb->enabled)
 		return;
 
@@ -53,9 +51,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
-	state.enabled = true;
-	pwm_apply_state(pb->pwm, &state);
-
 	if (pb->post_pwm_on_delay)
 		msleep(pb->post_pwm_on_delay);
 
@@ -67,40 +62,27 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
-	struct pwm_state state;
-
-	pwm_get_state(pb->pwm, &state);
-	if (!pb->enabled)
-		return;
-
 	if (pb->enable_gpio)
 		gpiod_set_value_cansleep(pb->enable_gpio, 0);
 
 	if (pb->pwm_off_delay)
 		msleep(pb->pwm_off_delay);
 
-	state.enabled = false;
-	state.duty_cycle = 0;
-	pwm_apply_state(pb->pwm, &state);
-
 	regulator_disable(pb->power_supply);
 	pb->enabled = false;
 }
 
-static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness)
+static int compute_duty_cycle(struct pwm_bl_data *pb, int brightness, struct pwm_state *state)
 {
 	unsigned int lth = pb->lth_brightness;
-	struct pwm_state state;
 	u64 duty_cycle;
 
-	pwm_get_state(pb->pwm, &state);
-
 	if (pb->levels)
 		duty_cycle = pb->levels[brightness];
 	else
 		duty_cycle = brightness;
 
-	duty_cycle *= state.period - lth;
+	duty_cycle *= state->period - lth;
 	do_div(duty_cycle, pb->scale);
 
 	return duty_cycle + lth;
@@ -122,12 +104,20 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 
 	if (brightness > 0) {
 		pwm_get_state(pb->pwm, &state);
-		state.duty_cycle = compute_duty_cycle(pb, brightness);
+		state.duty_cycle = compute_duty_cycle(pb, brightness, &state);
+		state.enabled = true;
 		pwm_apply_state(pb->pwm, &state);
+
 		pwm_backlight_power_on(pb);
-	} else
+	} else {
 		pwm_backlight_power_off(pb);
 
+		pwm_get_state(pb->pwm, &state);
+		state.enabled = false;
+		state.duty_cycle = 0;
+		pwm_apply_state(pb->pwm, &state);
+	}
+
 	if (pb->notify_after)
 		pb->notify_after(pb->dev, brightness);
 
-- 
2.23.0

