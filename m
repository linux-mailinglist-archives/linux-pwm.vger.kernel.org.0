Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDD52A4CF
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348836AbiEQO0x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348855AbiEQO0u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B98F42A27;
        Tue, 17 May 2022 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797608; x=1684333608;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uoe6C6uZ9UgWU6o7KK3hz1/ZIrJ6jOKQYwm+FlWuZ14=;
  b=HaAPxOpIuPJqCyWHCQm+yvQYrF9iRmVOlJucSLJnMUilynP7+xUrEbEE
   K07zJwwlKtVPftkGNZejh3nWNv5VvfGrvaMFxvI3jHBSW0MPi+9/gQ5/S
   zo842V8vZQxYilRKJH1Qo84jzp0B2y2Ic3P3U7z2/W7V4w80457ByAIPA
   5oy7zFQGM7vCdByjI6a81qN9sPafTDCii5hWkp+FGq9bLzTNOEZOLK0so
   mzjGxigjlqXRIDeUQ8kt1vUFAyYORvBffScqHwOm6/8OXIoW3OQjVAeLA
   DkKTRlpf6oTMFeODo05dDe2g9/Cpc6ixahD2L0kbT9zpbZhDX+2/qASe1
   g==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925939"
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
  bh=Uoe6C6uZ9UgWU6o7KK3hz1/ZIrJ6jOKQYwm+FlWuZ14=;
  b=E/swFrcXJOcRTgUEGG+1Ax8YTwFN7aH4yrlawsDK/S0f7bLCh6HKBY86
   vxkEQ2Vtt7rjjPQnzW+3ptBNvKZi1gF4n6zwJP5FEXRt/YBfV2OOrOJQy
   GMi6f06DUGNVyc6WVAYlCBChq3y4Q9sAJi1BqEeHxMgSzTSZ/ToPeNGh1
   Uy5ojz8VM60Jk73e1St0CaJzjNViznKI1qHPjjvdQF67q6muPJ+f6MAQG
   9umkJEcMdHR7mVTVb2WVkdeE5jumLAnYfIIiVJ5WzUrZW7th3mQkHtPcH
   jFlaYejPUpi+lJ+ClhvPVUuTnSUsEnYhbC2OZg/1t+ngJ8Vfum8KvH8yO
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925933"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:26 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id CAC23280070;
        Tue, 17 May 2022 16:26:25 +0200 (CEST)
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
Subject: [PATCH v3 4/6] hwmon: pwm-fan: Remove internal duplicated pwm_state
Date:   Tue, 17 May 2022 16:26:18 +0200
Message-Id: <20220517142620.1523143-5-alexander.stein@ew.tq-group.com>
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

Each pwm device has already a pwm_state. Use this one instead of
managing an own copy of it.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index c757af514ede..21bfd0e931ba 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -33,7 +33,6 @@ struct pwm_fan_ctx {
 
 	struct mutex lock;
 	struct pwm_device *pwm;
-	struct pwm_state pwm_state;
 	struct regulator *reg_en;
 	bool enabled;
 
@@ -87,7 +86,7 @@ static void sample_timer(struct timer_list *t)
 
 static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 {
-	struct pwm_state *state = &ctx->pwm_state;
+	struct pwm_state state;
 	int ret;
 
 	if (ctx->enabled)
@@ -99,8 +98,9 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
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
@@ -122,6 +122,7 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 	if (!ctx->enabled)
 		return 0;
 
+	pwm_get_state(ctx->pwm, &state);
 	state.enabled = false;
 	state.duty_cycle = 0;
 	pwm_apply_state(ctx->pwm, &state);
@@ -135,16 +136,17 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
-	struct pwm_state *state = &ctx->pwm_state;
+	struct pwm_state state;
 	unsigned long period;
 	int ret = 0;
 
 	mutex_lock(&ctx->lock);
 
 	if (pwm > 0) {
-		period = state->period;
-		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
-		ret = pwm_apply_state(ctx->pwm, state);
+		pwm_get_state(ctx->pwm, &state);
+		period = state.period;
+		state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
+		ret = pwm_apply_state(ctx->pwm, &state);
 		if (ret)
 			goto exit_set_pwm_err;
 		ret = pwm_fan_power_on(ctx);
@@ -338,6 +340,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	struct thermal_cooling_device *cdev;
 	struct device *dev = &pdev->dev;
 	struct pwm_fan_ctx *ctx;
+	struct pwm_state state;
 	struct device *hwmon;
 	int ret;
 	const struct hwmon_channel_info **channels;
@@ -366,18 +369,25 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		ctx->reg_en = NULL;
 	}
 
-	pwm_init_state(ctx->pwm, &ctx->pwm_state);
+	pwm_init_state(ctx->pwm, &state);
 
 	/*
 	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
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
 	/*
 	 * Set duty cycle to maximum allowed and enable PWM output as well as
 	 * the regulator. In case of error nothing is changed
-- 
2.25.1

