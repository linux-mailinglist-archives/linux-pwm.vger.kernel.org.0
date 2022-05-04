Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73388519FD5
	for <lists+linux-pwm@lfdr.de>; Wed,  4 May 2022 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbiEDMtg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 May 2022 08:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344100AbiEDMtf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 4 May 2022 08:49:35 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47308220C4;
        Wed,  4 May 2022 05:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651668358; x=1683204358;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9F6pufJQLceNeFS61+KLsP5LSDTp6NKXvgvBUSkYwJg=;
  b=KymhuHWF6vAa6CYtEHEPnToaFnTr9XtZlA1rfC/ZJQU+F6pthra1B+Ot
   C0DD4NP7F3bmGxX8JoE8mWHw1WschxP6oqs0iMzgI4JTkXiPgortJ94Bl
   Kn1s5ESS4LXIUHuEu5w/ZwYD9WBbjL6d/GRD93UJEcfm/5/qLnvmP27X0
   Wqo/5/LOOkoBtCnJydj6Arc1YSgr3Mp53qylf1HApWs8YBLZdmtqgaZNU
   v0b1BuRmlevs00Kcx92NWhbBVJB88AO88Waucd+yVjybDNzY5FsaeH4kX
   elBdSdnU8Fr69FPar1xxaTCIxOaH6U+8G6kLKEoQxZK/gXjifjPFPt2i9
   g==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647298800"; 
   d="scan'208";a="23668591"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 04 May 2022 14:45:56 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 04 May 2022 14:45:56 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 04 May 2022 14:45:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1651668356; x=1683204356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9F6pufJQLceNeFS61+KLsP5LSDTp6NKXvgvBUSkYwJg=;
  b=UekONrdWjEWCSQZ6P/hvzfNfKdgGTDpJvBuMyK8BHCqxCmVy5Y1P31Wj
   qdSvVxQSXRnYkbJz8ynl4Bnm27saKKfKyYqLR72TwZAisQMRW19fQYFxU
   jGgTz+isIklxQHVrLGyuz8PUjpXNKJTLxoXhl6XHX1y+KMojue1tsIk1L
   7zHb/vXJ0m4AN4w5tiG8BDZ8F1ubG40F/5IzOqqx8n5D0anX/ADW+M421
   QtA2qvuc9OwPVxvtFvbAwwnSWmLKhnlDXv51udRlrdOdJHn7i43lwdLc6
   PeV7fGpmEL/23HJ3fQiHxPjByg7Oegi+L95WLRO8fY+XWUk4NrKx5QgL+
   g==;
X-IronPort-AV: E=Sophos;i="5.91,198,1647298800"; 
   d="scan'208";a="23668590"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 04 May 2022 14:45:56 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 57FD3280070;
        Wed,  4 May 2022 14:45:56 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Alexander Stein <alexander.stein@ew.tq-group.com>
Subject: [PATCH v2 1/1] hwmon: pwm-fan: dynamically switch regulator
Date:   Wed,  4 May 2022 14:45:51 +0200
Message-Id: <20220504124551.1083383-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

A pwm value equal to zero is meant to switch off the pwm
hence also switching off the fan. Currently the optional
regulator is always on. When using this driver on boards
with an inverted pwm signal polarity this can cause running
the fan at maximum speed when setting pwm to zero.

The proposed changes switch the regulator off, when PWM is
currently enabled but pwm is requested to set to zero
and switch der regulator on, when PWM is currently disabled
but pwm shall be set to a no zero value.

Add __set_pwm_and_regulator and rewrite __set_pwm to
handle regulator switching for the following conditions:

- probe: pwm duty -> max, pwm state is unkwown: use __set_pwm
  and enable regulator separately to keep the devm action
- off: new pwm duty is zero, pwm currently enabled: disable
  regulator
- on: new pwm duty is non zero, pwm currently disabled: enable
  regulator

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Added my own missing S-o-b

 drivers/hwmon/pwm-fan.c | 144 ++++++++++++++++++++++++++--------------
 1 file changed, 93 insertions(+), 51 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index f12b9a28a232..b47d59fbe836 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -97,18 +97,50 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	unsigned long period;
 	int ret = 0;
 	struct pwm_state *state = &ctx->pwm_state;
+	/* track changes of reg_en for error handling */
+	enum regulator_change {
+		untouched,
+		enabled,
+		disabled,
+	} reg_change = untouched;
 
 	mutex_lock(&ctx->lock);
+
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
+	if (ctx->reg_en) {
+		if (pwm && !state->enabled) {
+			reg_change = enabled;
+			ret = regulator_enable(ctx->reg_en);
+		} else if (!pwm && state->enabled) {
+			reg_change = disabled;
+			ret = regulator_disable(ctx->reg_en);
+		}
+		if (ret)
+			goto exit_set_pwm_err;
+	}
+
 	period = state->period;
 	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
 	state->enabled = pwm ? true : false;
 
 	ret = pwm_apply_state(ctx->pwm, state);
-	if (!ret)
+	if (!ret) {
 		ctx->pwm_value = pwm;
+	} else if (reg_change != untouched) {
+		/*
+		 * revert regulator changes to keep consistency between
+		 * pwm and regulator
+		 */
+		int err;
+
+		if (reg_change == enabled)
+			err = regulator_disable(ctx->reg_en);
+		else if (reg_change == disabled)
+			err = regulator_enable(ctx->reg_en);
+	}
+
 exit_set_pwm_err:
 	mutex_unlock(&ctx->lock);
 	return ret;
@@ -280,18 +312,50 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	return 0;
 }
 
-static void pwm_fan_regulator_disable(void *data)
+/*
+ * disable fan and regulator
+ * if cleanup is true, disable pwm regardless of regulator disable result
+ * this makes the function dual use for unloading driver and suspend
+ */
+
+static int __pwm_fan_disable_or_cleanup(struct pwm_fan_ctx *ctx, bool cleanup)
 {
-	regulator_disable(data);
+	int ret;
+
+	if (ctx->pwm_value) {
+		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
+		struct pwm_state state = ctx->pwm_state;
+
+		/* regulator is only enabled if pwm_value is not zero */
+		if (ctx->pwm_value && ctx->reg_en) {
+			ret = regulator_disable(ctx->reg_en);
+			if (ret) {
+				pr_err("Failed to disable fan supply: %d\n", ret);
+				if (!cleanup)
+					return ret;
+			}
+		}
+
+		state.duty_cycle = 0;
+		state.enabled = false;
+		ret = pwm_apply_state(ctx->pwm, &state);
+	}
+
+	return ret;
 }
 
-static void pwm_fan_pwm_disable(void *__ctx)
+static void pwm_fan_cleanup(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
-
-	ctx->pwm_state.enabled = false;
-	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
 	del_timer_sync(&ctx->rpm_timer);
+	__pwm_fan_disable_or_cleanup(ctx, true);
+}
+
+static int pwm_fan_disable(void *__ctx)
+{
+	struct pwm_fan_ctx *ctx = __ctx;
+
+	return __pwm_fan_disable_or_cleanup(ctx, false);
 }
 
 static int pwm_fan_probe(struct platform_device *pdev)
@@ -324,19 +388,14 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->reg_en);
 
 		ctx->reg_en = NULL;
-	} else {
-		ret = regulator_enable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
-			return ret;
-		}
-		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
-					       ctx->reg_en);
-		if (ret)
-			return ret;
 	}
 
 	pwm_init_state(ctx->pwm, &ctx->pwm_state);
+	/*
+	 * Ensure the PWM is switched on (including the regulator),
+	 * independently from any previous PWM state
+	 */
+	ctx->pwm_state.enabled = false;
 
 	/*
 	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
@@ -348,14 +407,17 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Set duty cycle to maximum allowed and enable PWM output */
+	/*
+	 * Set duty cycle to maximum allowed and enable PWM output as well as
+	 * the regulator. In case of error nothing is changed
+	 */
 	ret = __set_pwm(ctx, MAX_PWM);
 	if (ret) {
 		dev_err(dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
 	}
 	timer_setup(&ctx->rpm_timer, sample_timer, 0);
-	ret = devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx);
+	ret = devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx);
 	if (ret)
 		return ret;
 
@@ -461,42 +523,22 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_fan_disable(struct device *dev)
-{
-	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	int ret;
-
-	if (ctx->pwm_value) {
-		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
-		struct pwm_state state = ctx->pwm_state;
-
-		state.duty_cycle = 0;
-		state.enabled = false;
-		ret = pwm_apply_state(ctx->pwm, &state);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (ctx->reg_en) {
-		ret = regulator_disable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static void pwm_fan_shutdown(struct platform_device *pdev)
 {
-	pwm_fan_disable(&pdev->dev);
+	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
+
+	pwm_fan_cleanup(ctx);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int pwm_fan_suspend(struct device *dev)
 {
-	return pwm_fan_disable(dev);
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pwm_fan_disable(ctx);
+
+	return ret;
 }
 
 static int pwm_fan_resume(struct device *dev)
@@ -504,6 +546,9 @@ static int pwm_fan_resume(struct device *dev)
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 	int ret;
 
+	if (ctx->pwm_value == 0)
+		return 0;
+
 	if (ctx->reg_en) {
 		ret = regulator_enable(ctx->reg_en);
 		if (ret) {
@@ -512,9 +557,6 @@ static int pwm_fan_resume(struct device *dev)
 		}
 	}
 
-	if (ctx->pwm_value == 0)
-		return 0;
-
 	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
 }
 #endif
-- 
2.25.1

