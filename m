Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 886442DA9F8
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgLOJVg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 04:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbgLOJVc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Dec 2020 04:21:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55CCC0617A7
        for <linux-pwm@vger.kernel.org>; Tue, 15 Dec 2020 01:20:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kp6Ve-0007Fq-F8; Tue, 15 Dec 2020 10:20:42 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kp6Ve-00020J-4a; Tue, 15 Dec 2020 10:20:42 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] hwmon: pwm-fan: stop using legacy PWM functions and some cleanups
Date:   Tue, 15 Dec 2020 10:20:31 +0100
Message-Id: <20201215092031.152243-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
References: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
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

pwm_apply_state() does what the legacy functions pwm_config() and
pwm_{en,dis}able() do in a single function call. This simplifies error
handling and is more efficient for new-style PWM hardware drivers.

Instead of repeatedly querying the PWM framework about the initial PWM
configuration, cache the settings in driver data.

Also use __set_pwm() in .probe() to have the algorithm calculating the PWM
state in a single place.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/pwm-fan.c | 47 +++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index ec171f2b684a..4ccad5a87019 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -25,6 +25,7 @@
 struct pwm_fan_ctx {
 	struct mutex lock;
 	struct pwm_device *pwm;
+	struct pwm_state pwm_state;
 	struct regulator *reg_en;
 
 	int irq;
@@ -73,18 +74,17 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
 	unsigned long period;
 	int ret = 0;
-	struct pwm_state state = { };
+	struct pwm_state *state = &ctx->pwm_state;
 
 	mutex_lock(&ctx->lock);
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	pwm_init_state(ctx->pwm, &state);
-	period = ctx->pwm->args.period;
-	state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
-	state.enabled = pwm ? true : false;
+	period = state->period;
+	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
+	state->enabled = pwm ? true : false;
 
-	ret = pwm_apply_state(ctx->pwm, &state);
+	ret = pwm_apply_state(ctx->pwm, state);
 	if (!ret)
 		ctx->pwm_value = pwm;
 exit_set_pwm_err:
@@ -274,7 +274,9 @@ static void pwm_fan_regulator_disable(void *data)
 static void pwm_fan_pwm_disable(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
-	pwm_disable(ctx->pwm);
+
+	ctx->pwm_state.enabled = false;
+	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
 	del_timer_sync(&ctx->rpm_timer);
 }
 
@@ -285,7 +287,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	struct pwm_fan_ctx *ctx;
 	struct device *hwmon;
 	int ret;
-	struct pwm_state state = { };
 	u32 ppr = 2;
 
 	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
@@ -324,22 +325,20 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ctx->pwm_value = MAX_PWM;
 
-	pwm_init_state(ctx->pwm, &state);
+	pwm_init_state(ctx->pwm, &ctx->pwm_state);
+
 	/*
 	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
 	 * long. Check this here to prevent the fan running at a too low
 	 * frequency.
 	 */
-	if (state.period > ULONG_MAX / MAX_PWM + 1) {
+	if (ctx->pwm_state.period > ULONG_MAX / MAX_PWM + 1) {
 		dev_err(dev, "Configured period too big\n");
 		return -EINVAL;
 	}
 
 	/* Set duty cycle to maximum allowed and enable PWM output */
-	state.duty_cycle = ctx->pwm->args.period - 1;
-	state.enabled = true;
-
-	ret = pwm_apply_state(ctx->pwm, &state);
+	ret = __set_pwm(ctx, MAX_PWM);
 	if (ret) {
 		dev_err(dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
@@ -399,17 +398,16 @@ static int pwm_fan_probe(struct platform_device *pdev)
 static int pwm_fan_disable(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	struct pwm_args args;
 	int ret;
 
-	pwm_get_args(ctx->pwm, &args);
-
 	if (ctx->pwm_value) {
-		ret = pwm_config(ctx->pwm, 0, args.period);
+		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
+		struct pwm_state state = ctx->pwm_state;
+		state.duty_cycle = 0;
+		state.enabled = false;
+		ret = pwm_apply_state(ctx->pwm, &state);
 		if (ret < 0)
 			return ret;
-
-		pwm_disable(ctx->pwm);
 	}
 
 	if (ctx->reg_en) {
@@ -437,8 +435,6 @@ static int pwm_fan_suspend(struct device *dev)
 static int pwm_fan_resume(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	struct pwm_args pargs;
-	unsigned long duty;
 	int ret;
 
 	if (ctx->reg_en) {
@@ -452,12 +448,7 @@ static int pwm_fan_resume(struct device *dev)
 	if (ctx->pwm_value == 0)
 		return 0;
 
-	pwm_get_args(ctx->pwm, &pargs);
-	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
-	ret = pwm_config(ctx->pwm, duty, pargs.period);
-	if (ret)
-		return ret;
-	return pwm_enable(ctx->pwm);
+	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
 }
 #endif
 
-- 
2.29.2

