Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64A052A4C8
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbiEQO0w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiEQO0s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:48 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BB742A31;
        Tue, 17 May 2022 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797607; x=1684333607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RHY+Uqy+B8OW1co9+ZEM3AZ7L4FCao6DaFnGqdfR86A=;
  b=mQd+rkZebzMbWIOQQYcdi+AWYK4XPD79LPq2hZeM9ClC5XgNjJ9Sa5pR
   3Rcz4GvKQZYUr2MxZktM1Eg3h5BjP1SI+aMYWTYR6BTe21HKqmNjZa3Ka
   dosYB9/Px/fV9Xz/5FyXtHotTI4dVar3zsOJDsHZg6QhSAP8ppXBxIvAK
   p185KaT7nQQI6w2geZKKa1fYvQKAzFMARFyjcwxyEmAB1H460MWP5b+4I
   SZY+wkKIwuSzTdmi8xq2Otvq+1MhwAa/Gp86TrnNWivYJvciBrAqsTMtA
   U9xzCmgLDSUkWawbRG5k32b5twNsjZHlBTiTv8eelvMHpcI76gMPSB66+
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925938"
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
  bh=RHY+Uqy+B8OW1co9+ZEM3AZ7L4FCao6DaFnGqdfR86A=;
  b=qXgFBIDR3R7e/MpZ3qn1frxZWSFXS8hGSgppNcJC6CAjSyD6Ravt3v5t
   FC9p+H7ull8G+5gwMouePzxrVIBsLFJuNUSRahRjbv8Fn+W4pkDdZeySC
   1sVSak2LbVvPIX39H0xx0Dnjxm3A5InBh9cDvmKRQU3YnbSsDOQr4gxVm
   QSmIloHen9bXkPEAceU0jpA5Gc18h5NbGr2cEoNNSkKIFxC+D7b0Zwbqo
   AbsidZYxlCFUB1hhH4mYsdAYmsmvu70B6fAeTMzXsNTSTHHVSmtkDKzDm
   ZQoJ2si8+3yu1Ad4lR51n0WyF7GAvCdBRDVk/E7+j3qIOv2nkXjhlKy50
   w==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925929"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:25 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 648A0280078;
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
Subject: [PATCH v3 2/6] hwmon: pwm-fan: Simplify enable/disable check
Date:   Tue, 17 May 2022 16:26:16 +0200
Message-Id: <20220517142620.1523143-3-alexander.stein@ew.tq-group.com>
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

Instead of comparing the current to the new pwm duty to decide whether to
enable the PWM, use a dedicated flag. Also apply the new PWM duty in any
case. This is a preparation to enable/disable the regulator dynamically.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 458914d01155..2b7b26ab9b88 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -29,10 +29,13 @@ struct pwm_fan_tach {
 };
 
 struct pwm_fan_ctx {
+	struct device *dev;
+
 	struct mutex lock;
 	struct pwm_device *pwm;
 	struct pwm_state pwm_state;
 	struct regulator *reg_en;
+	bool enabled;
 
 	int tach_count;
 	struct pwm_fan_tach *tachs;
@@ -85,14 +88,21 @@ static void sample_timer(struct timer_list *t)
 static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 {
 	struct pwm_state *state = &ctx->pwm_state;
-	unsigned long period;
 	int ret;
 
-	period = state->period;
-	state->duty_cycle = DIV_ROUND_UP(ctx->pwm_value * (period - 1), MAX_PWM);
+	if (ctx->enabled)
+		return 0;
+
 	state->enabled = true;
 	ret = pwm_apply_state(ctx->pwm, state);
+	if (ret) {
+		dev_err(ctx->dev, "failed to enable PWM\n");
+		goto err;
+	}
 
+	ctx->enabled = true;
+
+err:
 	return ret;
 }
 
@@ -100,26 +110,36 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 {
 	struct pwm_state state;
 
+	if (!ctx->enabled)
+		return 0;
+
 	state.enabled = false;
 	state.duty_cycle = 0;
 	pwm_apply_state(ctx->pwm, &state);
 
+	ctx->enabled = false;
+
 	return 0;
 }
 
 static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 {
+	struct pwm_state *state = &ctx->pwm_state;
+	unsigned long period;
 	int ret = 0;
 
 	mutex_lock(&ctx->lock);
-	if (ctx->pwm_value == pwm)
-		goto exit_set_pwm_err;
 
-	if (pwm > 0)
+	if (pwm > 0) {
+		period = state->period;
+		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
+		ret = pwm_apply_state(ctx->pwm, state);
+		if (ret)
+			goto exit_set_pwm_err;
 		ret = pwm_fan_power_on(ctx);
-	else
+	} else {
 		ret = pwm_fan_power_off(ctx);
-
+	}
 	if (!ret)
 		ctx->pwm_value = pwm;
 
@@ -326,6 +346,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	mutex_init(&ctx->lock);
 
+	ctx->dev = &pdev->dev;
 	ctx->pwm = devm_of_pwm_get(dev, dev->of_node, NULL);
 	if (IS_ERR(ctx->pwm))
 		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
-- 
2.25.1

