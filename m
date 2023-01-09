Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9FB6631D3
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Jan 2023 21:48:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjAIUsi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Jan 2023 15:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjAIUsR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Jan 2023 15:48:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F18942E2B
        for <linux-pwm@vger.kernel.org>; Mon,  9 Jan 2023 12:48:16 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pEz3y-0000Nt-E6; Mon, 09 Jan 2023 21:48:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pEz3x-004vYT-JU; Mon, 09 Jan 2023 21:48:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pEz3w-00BVa6-MU; Mon, 09 Jan 2023 21:48:08 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] backlight: pwm_bl: configure pwm only once per backlight toggle
Date:   Mon,  9 Jan 2023 21:47:57 +0100
Message-Id: <20230109204758.610400-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3028; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tMZdMl/umVRDeT9rsYMGqAfkRDAo8yVZQfLxsndR6+E=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjvH13dvRtwRaDgz+Z46J6LBniAuKUN/DofOrLFmgK XkdthLeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCY7x9dwAKCRDB/BR4rcrsCb/FB/ 4iyFKEMW5MHQBK6gkxthBP3Bhb0W/n9q0TqmYFUJ0l822Axjn65LQFvhPivbRbz2C4Upgh9+s+QI7h RBXbWglWjQBJ4QBw1YypBPDTeWMIJS6rp0o7zjclyzi6f05SHrV9y27quTH8ysQfYebKp4hCT4CAhr qSFwNUM4c1q0m9T+nUZLYwsyLmjNOVUlgbNcaX44e8wlzFe5qbkp24o9v22CXxvq7rP1fAML2XdW0S CbCCWMIigDeBXHgpvJJ/4ADYn94E7eIL7bbcxQduP0wrCYqJMbM3QoIATwwI8TKECDLF3sKErUWHNV hR/A6Y2SyYhKAfgwHRbwrnGiUQpSl3
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When the function pwm_backlight_update_status() was called with
brightness > 0, pwm_get_state() was called twice (once directly and once
in compute_duty_cycle). Also pwm_apply_state() was called twice (once in
pwm_backlight_power_on() and once directly).

Optimize this to do both calls only once.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/video/backlight/pwm_bl.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index d0b22158cd70..0509fecd5715 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -40,10 +40,8 @@ struct pwm_bl_data {
 
 static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 {
-	struct pwm_state state;
 	int err;
 
-	pwm_get_state(pb->pwm, &state);
 	if (pb->enabled)
 		return;
 
@@ -51,9 +49,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 	if (err < 0)
 		dev_err(pb->dev, "failed to enable power supply\n");
 
-	state.enabled = true;
-	pwm_apply_state(pb->pwm, &state);
-
 	if (pb->post_pwm_on_delay)
 		msleep(pb->post_pwm_on_delay);
 
@@ -65,9 +60,6 @@ static void pwm_backlight_power_on(struct pwm_bl_data *pb)
 
 static void pwm_backlight_power_off(struct pwm_bl_data *pb)
 {
-	struct pwm_state state;
-
-	pwm_get_state(pb->pwm, &state);
 	if (!pb->enabled)
 		return;
 
@@ -77,28 +69,21 @@ static void pwm_backlight_power_off(struct pwm_bl_data *pb)
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
@@ -115,11 +100,18 @@ static int pwm_backlight_update_status(struct backlight_device *bl)
 
 	if (brightness > 0) {
 		pwm_get_state(pb->pwm, &state);
-		state.duty_cycle = compute_duty_cycle(pb, brightness);
+		state.duty_cycle = compute_duty_cycle(pb, brightness, &state);
+		state.enabled = true;
 		pwm_apply_state(pb->pwm, &state);
+
 		pwm_backlight_power_on(pb);
 	} else {
 		pwm_backlight_power_off(pb);
+
+		pwm_get_state(pb->pwm, &state);
+		state.enabled = false;
+		state.duty_cycle = 0;
+		pwm_apply_state(pb->pwm, &state);
 	}
 
 	if (pb->notify_after)

base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
prerequisite-patch-id: a0c7497a32092d284bc47eda60e4b3690338ba6e
-- 
2.39.0

