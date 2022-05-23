Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A43C530F6E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiEWLFc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 07:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbiEWLFa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 07:05:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4DE18346;
        Mon, 23 May 2022 04:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303928; x=1684839928;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RZSNcjfq2xPUXOnuE4OSU5ARSJIozOw0E0Ak4xm71EM=;
  b=dSt1H88Zap0Z9nhwfadAcU7ExOMmVxkuuHA6LjDW2F0XZLSxJSz789nd
   RusHil9QkSj+TrpuXX4gOTvBOIPKJirn54p45uRNn68m622naBK1VV1Vb
   6TJHIX4LDuPEUM+T4ABjU4EdtY4UR/5Jkzf8nO4DBgQdHde1l1zVRC6MT
   aLtfrrrJsCxFClQdaqjAwDhmm6D2cXhp20LpIs9K7/v6k0jsaZ7J3H5l7
   Ruu1O/mWbEeX+fCm5LD1ojtkWxMHFhLiaBpTKRHumSizszu/6E21aqrTC
   6xJov5Rr6X+8is38a+2sxdjEi34wySibxWTlIC7q8vxFmqiFbyeulLkvF
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031372"
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
  bh=RZSNcjfq2xPUXOnuE4OSU5ARSJIozOw0E0Ak4xm71EM=;
  b=eHL8kAIkeUFJtSGbCT3nN4KFGYO9d3g/J1yv/hOA83n+MqCzG1g174bO
   zZr76mRupkeRixx5Zo84kbHSeF+96Bf+azCJIkYZFJmLsjGgz9kq1yMp2
   fCkWna2zniynDOi8VrXRo65oiNSKnY7wvjwB5jbnAaECZIQskjemgl6rS
   xMtPOqu7RU08PlvtEdDWiGh+qo1ifLrwW8cNI5sJQlEi8svmSV+624TkP
   MrG8F57l132k1Uo6RYwjtoPwvtVLOS9W3Hgw8lVYx2NnHoieLUFe9hSPf
   7wpzVDZCMHG5kdORd+Y6Cqn9I3/cxJPO9U2RXdw2+x5RaXme3H43FFCLv
   g==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031371"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 13:05:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9BEB3280070;
        Mon, 23 May 2022 13:05:18 +0200 (CEST)
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
Subject: [PATCH v4 3/6] hwmon: pwm-fan: Add dedicated power switch function
Date:   Mon, 23 May 2022 13:05:10 +0200
Message-Id: <20220523110513.407516-4-alexander.stein@ew.tq-group.com>
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

This handles enabling/disabling the regulator in a single function, while
keeping the enables/disabled balanced. This is a preparation when
regulator is switched from different code paths.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 52 +++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 96b10d422828..04af24268963 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -35,6 +35,7 @@ struct pwm_fan_ctx {
 	struct pwm_device *pwm;
 	struct pwm_state pwm_state;
 	struct regulator *reg_en;
+	bool regulator_enabled;
 	bool enabled;
 
 	int tach_count;
@@ -85,6 +86,29 @@ static void sample_timer(struct timer_list *t)
 	mod_timer(&ctx->rpm_timer, jiffies + HZ);
 }
 
+static int pwm_fan_switch_power(struct pwm_fan_ctx *ctx, bool on)
+{
+	int ret = 0;
+
+	if (!ctx->reg_en)
+		return ret;
+
+	if (ctx->regulator_enabled && on) {
+		ret = 0;
+	} else if (!ctx->regulator_enabled && on) {
+		ret = regulator_enable(ctx->reg_en);
+		if (ret == 0)
+			ctx->regulator_enabled = true;
+	} else if (ctx->regulator_enabled && !on) {
+		ret = regulator_disable(ctx->reg_en);
+		if (ret == 0)
+			ctx->regulator_enabled = false;
+	} else if (!ctx->regulator_enabled && !on) {
+		ret = 0;
+	}
+	return ret;
+}
+
 static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 {
 	struct pwm_state *state = &ctx->pwm_state;
@@ -316,7 +340,9 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 
 static void pwm_fan_regulator_disable(void *data)
 {
-	regulator_disable(data);
+	struct pwm_fan_ctx *ctx = data;
+
+	pwm_fan_switch_power(ctx, false);
 }
 
 static void pwm_fan_pwm_disable(void *__ctx)
@@ -360,13 +386,13 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 		ctx->reg_en = NULL;
 	} else {
-		ret = regulator_enable(ctx->reg_en);
+		ret = pwm_fan_switch_power(ctx, true);
 		if (ret) {
 			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
 			return ret;
 		}
 		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
-					       ctx->reg_en);
+					       ctx);
 		if (ret)
 			return ret;
 	}
@@ -512,12 +538,10 @@ static int pwm_fan_disable(struct device *dev)
 			return ret;
 	}
 
-	if (ctx->reg_en) {
-		ret = regulator_disable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
-			return ret;
-		}
+	ret = pwm_fan_switch_power(ctx, false);
+	if (ret) {
+		dev_err(dev, "Failed to disable fan supply: %d\n", ret);
+		return ret;
 	}
 
 	return 0;
@@ -539,12 +563,10 @@ static int pwm_fan_resume(struct device *dev)
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
 	int ret;
 
-	if (ctx->reg_en) {
-		ret = regulator_enable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
-			return ret;
-		}
+	ret = pwm_fan_switch_power(ctx, true);
+	if (ret) {
+		dev_err(dev, "Failed to enable fan supply: %d\n", ret);
+		return ret;
 	}
 
 	if (ctx->pwm_value == 0)
-- 
2.25.1

