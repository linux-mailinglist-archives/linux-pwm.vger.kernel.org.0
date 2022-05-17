Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAE52A4CB
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiEQO0w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348834AbiEQO0s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:48 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1342A39;
        Tue, 17 May 2022 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797607; x=1684333607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAQEobNYq5e7zqIN9kNTGCuqIpHhyYNp3YJZCqF6qww=;
  b=WHLWwAW+n+xUzP/VO06O+GQVFKgvqDm1Wt7ih1ZscQc+YhWa2g/L98Ub
   Ba9Nexqbk5JjgvRnr2tnJgMcmzo2YzSlBHCsU9Rulh62IrtNuys3I5ld3
   YDjJCNO61zDEdjjCvXeyXGCtmel2sZqKhoh79P+lJzyKw1+JDaHjG/4ze
   ILdODpVWLiiYxuDQeBt8lD/dZb8Rv9O0tqooKm9qaRQPyU9clQafwMRsq
   hH9YuFQUXrDtPeNSACUvc8uGymtMhZLKSkKyFygjnfnNXHX7WVj6afVTJ
   EyhZzSxe6Aj1rV0Rpx+jvr8m6hxb9OgfbEYJDuSqAAgIei5QtHHdmCYxi
   A==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925943"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 May 2022 16:26:35 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 17 May 2022 16:26:35 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 17 May 2022 16:26:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797595; x=1684333595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uAQEobNYq5e7zqIN9kNTGCuqIpHhyYNp3YJZCqF6qww=;
  b=I+LhpO8Ic2Glwm4qgLY7pLn9kUfYwU16261jfPlIWT1TlHtysBdDnOpH
   2to8AIxNAhAqtPBkFpuMmot+dAG9GCX/SK0AfkL1HCmA1jU3Fhye/jdkG
   /bVgGGZz4HAZy3kDFm05bz7VGThb0z1aUwyJ/nxrxYRJA9DAv3lbtoLVj
   aH6QJtJMZdWG2tSVGL4kpH2EUjluMQ1IvH/BG/ZWL8ouYUii70eWQxNk9
   M/FdTXZ7tBdyJzqC7LupZ4oD7Sk6ybyYt4DQlM184yxkSom82JxedmOlK
   IwKcY8Hopr9AKzz6irdjMvVkZnawCLyRxz2S/uDOr8FZZbftYjeSONtrI
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925935"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:26 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 5059C280078;
        Tue, 17 May 2022 16:26:26 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-hwmon@vger.kernel.org, linux-pwm@vger.kernel.org,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>
Subject: [PATCH v3 6/6] hwmon: pwm-fan: Add hwmon_pwm_enable attribute
Date:   Tue, 17 May 2022 16:26:20 +0200
Message-Id: <20220517142620.1523143-7-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
References: <20220517142620.1523143-1-alexander.stein@ew.tq-group.com>
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

This adds the enable attribute which is used to differentiate if PWM duty
means to switch off regulator and PWM or to keep them enabled but
at inactive PWM output level.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 Documentation/hwmon/pwm-fan.rst | 10 ++++
 drivers/hwmon/pwm-fan.c         | 95 +++++++++++++++++++++++++++++----
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/Documentation/hwmon/pwm-fan.rst b/Documentation/hwmon/pwm-fan.rst
index 82fe96742fee..0083480068d1 100644
--- a/Documentation/hwmon/pwm-fan.rst
+++ b/Documentation/hwmon/pwm-fan.rst
@@ -18,3 +18,13 @@ the hwmon's sysfs interface.
 
 The fan rotation speed returned via the optional 'fan1_input' is extrapolated
 from the sampled interrupts from the tachometer signal within 1 second.
+
+The driver provides the following sensor accesses in sysfs:
+
+=============== ======= =======================================================
+fan1_input	ro	fan tachometer speed in RPM
+pwm1_enable	rw	keep enable mode, defines behaviour when pwm1=0
+			0=switch off regulator and disable PWM
+			1=keep regulator enabled and set PWM to inactive level
+pwm1		rw	relative speed (0-255), 255=max. speed.
+=============== ======= =======================================================
diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 9ebe958cc908..cb29206ddcdc 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -35,6 +35,7 @@ struct pwm_fan_ctx {
 	struct pwm_device *pwm;
 	struct regulator *reg_en;
 	bool enabled;
+	bool keep_enabled;
 
 	int tach_count;
 	struct pwm_fan_tach *tachs;
@@ -129,7 +130,8 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 		return 0;
 
 	pwm_get_state(ctx->pwm, &state);
-	state.enabled = false;
+	if (!ctx->keep_enabled)
+		state.enabled = false;
 	state.duty_cycle = 0;
 	pwm_apply_state(ctx->pwm, &state);
 
@@ -178,20 +180,87 @@ static void pwm_fan_update_state(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	ctx->pwm_fan_state = i;
 }
 
+static int pwm_fan_update_enable(struct pwm_fan_ctx *ctx, long val)
+{
+	struct pwm_state old_state;
+	int ret;
+
+	pwm_get_state(ctx->pwm, &old_state);
+
+	if (val) {
+		/*
+		 * If PWM is already enabled, nothing will change
+		 * If PWM is disabled, it will enable with inactive level (duty == 0)
+		 */
+		ret = pwm_fan_enable_pwm(ctx);
+		if (ret) {
+			dev_err(ctx->dev, "failed to apply PWM state\n");
+			return ret;
+		}
+
+		/* Increase regulator reference counter to prevent switching off */
+		ret = regulator_enable(ctx->reg_en);
+		if (ret < 0) {
+			dev_err(ctx->dev, "failed to enable regulator\n");
+			/* Restore old state */
+			pwm_apply_state(ctx->pwm, &old_state);
+		}
+	} else {
+		/* Only disable PWM if currently on inactive state */
+		if (!ctx->pwm_value) {
+			struct pwm_state disable_state;
+
+			pwm_get_state(ctx->pwm, &disable_state);
+			disable_state.duty_cycle = 0;
+			disable_state.enabled = false;
+			ret = pwm_apply_state(ctx->pwm, &disable_state);
+			if (ret) {
+				dev_err(ctx->dev, "failed to apply PWM state\n");
+				return ret;
+			}
+		}
+		/* Decrease regulator reference counter */
+		ret = regulator_disable(ctx->reg_en);
+		if (ret < 0) {
+			dev_err(ctx->dev, "failed to decrease power supply usage\n");
+			/* Restore old state */
+			pwm_apply_state(ctx->pwm, &old_state);
+		}
+	}
+	if (ret == 0)
+		ctx->keep_enabled = val;
+
+	return ret;
+}
+
 static int pwm_fan_write(struct device *dev, enum hwmon_sensor_types type,
 			 u32 attr, int channel, long val)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 	int ret;
 
-	if (val < 0 || val > MAX_PWM)
-		return -EINVAL;
+	switch (attr) {
+	case hwmon_pwm_input:
+		if (val < 0 || val > MAX_PWM)
+			return -EINVAL;
+		ret = __set_pwm(ctx, val);
+		if (ret)
+			return ret;
+		pwm_fan_update_state(ctx, val);
+		break;
+	case hwmon_pwm_enable:
+		mutex_lock(&ctx->lock);
+		if (val < 0 || val > 1)
+			ret = -EINVAL;
+		else if (ctx->keep_enabled != val)
+			ret = pwm_fan_update_enable(ctx, val);
+		mutex_unlock(&ctx->lock);
 
-	ret = __set_pwm(ctx, val);
-	if (ret)
 		return ret;
+	default:
+		return -EOPNOTSUPP;
+	}
 
-	pwm_fan_update_state(ctx, val);
 	return 0;
 }
 
@@ -202,9 +271,15 @@ static int pwm_fan_read(struct device *dev, enum hwmon_sensor_types type,
 
 	switch (type) {
 	case hwmon_pwm:
-		*val = ctx->pwm_value;
-		return 0;
-
+		switch (attr) {
+		case hwmon_pwm_input:
+			*val = ctx->pwm_value;
+			return 0;
+		case hwmon_pwm_enable:
+			*val = ctx->keep_enabled;
+			return 0;
+		}
+		return -EOPNOTSUPP;
 	case hwmon_fan:
 		*val = ctx->tachs[channel].rpm;
 		return 0;
@@ -436,7 +511,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	if (!channels)
 		return -ENOMEM;
 
-	channels[0] = HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT);
+	channels[0] = HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_ENABLE);
 
 	for (i = 0; i < ctx->tach_count; i++) {
 		struct pwm_fan_tach *tach = &ctx->tachs[i];
-- 
2.25.1

