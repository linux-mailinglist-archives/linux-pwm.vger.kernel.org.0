Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 164F6531099
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234459AbiEWLFf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 07:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiEWLFc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 07:05:32 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718E418E0D;
        Mon, 23 May 2022 04:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303930; x=1684839930;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zkD9EPLd7PBjo+JjCvtRWIRLMDAYVEJ2yfUNmCB2e+k=;
  b=UDPh34UpF25bgBFcqPKwOE7nS/mGE7s4/gnCOq4DdZ8KeUW22hWb65B3
   AqNhHuynArzhl3toSkHh1kAXqa8QtZh7ZogVbmrIHmuU4WFeymOwOUKQ1
   h1hL8c600i2d5UhcKeJYBulk2LrdcJQOhgubaOFBeItCSm4VB+8XqgShl
   43TlEx9/plY+IfIki+pqtdlr3eqRRQh9Ff9Wv12yTti9UWCCZ175Tldj3
   rwNjkET81+aaveEsYGXIGa+pyDWduQjM9+jVYDI4VBP+cO8uB4mJz760s
   qu3Sj7WCJaFQdbaMUqmTgDDK7G/igFiTYeQx2TEutpR+Y4if2ka24VQK7
   g==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031378"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 May 2022 13:05:19 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 23 May 2022 13:05:19 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 23 May 2022 13:05:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303919; x=1684839919;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zkD9EPLd7PBjo+JjCvtRWIRLMDAYVEJ2yfUNmCB2e+k=;
  b=moatUu0y0++bXvH6gvlzD0IYzDUVN1q/qB8+ilzHyX5L7zfoU4lGoiO8
   xG9up6Ouju0TA3yL3MooxtemVr53ICuVwtV8itCEibXZ6WHtxx4bqVgul
   bTpCAMPlYGBWNc/X3h4Dh+97TuzbVQfJHuGjUb8IYSvjRhkg1txbdWHQA
   5fn0LkZ7AkgkmdL2U4CNShlumWFvosf853dx2AtaVelQBI+qpNqSWpJfq
   x0js9kAvG0CBRAh+DvNqLeMEClbhLKJ4yMVPCvg+WnoW0hL90bEQmkhAc
   xh/x7fzbYjY+YJcNRF8EK037pb77euCzoCT1KazofYqVzGEczM5pR+U69
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031377"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 13:05:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 35BC2280070;
        Mon, 23 May 2022 13:05:19 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v4 6/6] hwmon: pwm-fan: Remove internal duplicated pwm_state
Date:   Mon, 23 May 2022 13:05:13 +0200
Message-Id: <20220523110513.407516-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
References: <20220523110513.407516-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_CSS_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Each pwm device has already a pwm_state. Use this one instead of
managing an own copy of it.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 49 +++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index e5d4b3b1cc49..e0ce81cdf5e0 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -40,7 +40,6 @@ struct pwm_fan_ctx {
 
 	struct mutex lock;
 	struct pwm_device *pwm;
-	struct pwm_state pwm_state;
 	struct regulator *reg_en;
 	enum pwm_fan_enable_mode enable_mode;
 	bool regulator_enabled;
@@ -142,7 +141,7 @@ static int pwm_fan_switch_power(struct pwm_fan_ctx *ctx, bool on)
 
 static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 {
-	struct pwm_state *state = &ctx->pwm_state;
+	struct pwm_state state;
 	int ret;
 
 	if (ctx->enabled)
@@ -154,8 +153,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 		return ret;
 	}
 
-	state->enabled = true;
-	ret = pwm_apply_state(ctx->pwm, state);
+	pwm_get_state(ctx->pwm, &state);
+	state.enabled = true;
+	ret = pwm_apply_state(ctx->pwm, &state);
 	if (ret) {
 		dev_err(ctx->dev, "failed to enable PWM\n");
 		goto disable_regulator;
@@ -172,19 +172,20 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 
 static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 {
-	struct pwm_state *state = &ctx->pwm_state;
 	bool enable_regulator = false;
+	struct pwm_state state;
 
 	if (!ctx->enabled)
 		return 0;
 
 	pwm_fan_enable_mode_2_state(ctx->enable_mode,
-				    state,
+				    &state,
 				    &enable_regulator);
 
-	state->enabled = false;
-	state->duty_cycle = 0;
-	pwm_apply_state(ctx->pwm, state);
+	pwm_get_state(ctx->pwm, &state);
+	state.enabled = false;
+	state.duty_cycle = 0;
+	pwm_apply_state(ctx->pwm, &state);
 
 	pwm_fan_switch_power(ctx, enable_regulator);
 
@@ -195,7 +196,7 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
-	struct pwm_state *state = &ctx->pwm_state;
+	struct pwm_state state;
 	unsigned long period;
 	int ret = 0;
 
@@ -204,9 +205,10 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 			/* pwm-fan hard disabled */
 			return 0;
 
-		period = state->period;
-		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
-		ret = pwm_apply_state(ctx->pwm, state);
+		pwm_get_state(ctx->pwm, &state);
+		period = state.period;
+		state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
+		ret = pwm_apply_state(ctx->pwm, &state);
 		if (ret)
 			return ret;
 		ret = pwm_fan_power_on(ctx);
@@ -266,15 +268,16 @@ static int pwm_fan_update_enable(struct pwm_fan_ctx *ctx, long val)
 		 * Nothing to do if currently enabled
 		 */
 		if (!ctx->enabled) {
-			struct pwm_state *state = &ctx->pwm_state;
 			bool enable_regulator = false;
+			struct pwm_state state;
 
-			state->duty_cycle = 0;
+			pwm_get_state(ctx->pwm, &state);
+			state.duty_cycle = 0;
 			pwm_fan_enable_mode_2_state(val,
-						    state,
+						    &state,
 						    &enable_regulator);
 
-			pwm_apply_state(ctx->pwm, state);
+			pwm_apply_state(ctx->pwm, &state);
 			pwm_fan_switch_power(ctx, enable_regulator);
 			pwm_fan_update_state(ctx, 0);
 		}
@@ -473,6 +476,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	struct thermal_cooling_device *cdev;
 	struct device *dev = &pdev->dev;
 	struct pwm_fan_ctx *ctx;
+	struct pwm_state state;
 	struct device *hwmon;
 	int ret;
 	const struct hwmon_channel_info **channels;
@@ -501,18 +505,25 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		ctx->reg_en = NULL;
 	}
 
-	pwm_init_state(ctx->pwm, &ctx->pwm_state);
+	pwm_init_state(ctx->pwm, &state);
 
 	/*
 	 * set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
 	 * long. Check this here to prevent the fan running at a too low
 	 * frequency.
 	 */
-	if (ctx->pwm_state.period > ULONG_MAX / MAX_PWM + 1) {
+	if (state.period > ULONG_MAX / MAX_PWM + 1) {
 		dev_err(dev, "Configured period too big\n");
 		return -EINVAL;
 	}
 
+	/* Apply modified PWM default state */
+	ret = pwm_apply_state(ctx->pwm, &state);
+	if (ret) {
+		dev_err(dev, "failed to apply initial PWM state: %d\n", ret);
+		return -EINVAL;
+	}
+
 	ctx->enable_mode = pwm_disable_reg_enable;
 
 	/*
-- 
2.25.1

