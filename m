Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5412E5B8BD3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiINPbu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiINPbt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:31:49 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540A4455F;
        Wed, 14 Sep 2022 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169508; x=1694705508;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85aJxQmKurDkYSP1FJQw3TqELhxhuad70Kc3ZbTLiDU=;
  b=JCopAZ3UxZkFbmCtdPYkBFq77fhwhJtRvfwHCSWYBpTGpcVyetXtWY/h
   PlHH/I5MsqPU3Tu5hBLnCp+8G7KjC6StkOfQ/QdqKfX6XfAaAvI/3wLhT
   cm90SRv+1YGC6CE/52WFCodc5yC8OIp2PfVOUG1SAO3SJZZeStzofMgLy
   X5P2v/LAFO+ZpnIciowt3n/41xWUxRWs9S4BzdaRw4f3bgNg4csm9Qn1a
   BBcfL+Xp6S10k0PAKWhEEcckD4bA1T8qYT1ifz/r3t2xkwFurxiMlGf9N
   NYKqn3q0jd40u/5qtg9TZnR6cl3ieSgUW0YyaM0ctLKUcAiL5/Tb+6GLD
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181305"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 14 Sep 2022 17:31:44 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 14 Sep 2022 17:31:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169504; x=1694705504;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=85aJxQmKurDkYSP1FJQw3TqELhxhuad70Kc3ZbTLiDU=;
  b=TNx2rb7vlJsNyykDsNrCbfi9QNtwXpZQnzbXLYUPn8tOni0IXiL98Nez
   It7mhgv561AVkLJZk2jSIZSUIeW/ZaehH+/xGNWXAU8SYrpQO181+kDfU
   HSrLCbeHBCymHll4QXIUMFrPjl+A7tJ2G+026WtdpjsHdeZwPChtkYOzV
   qLczwEHa2FdycrZKUESbXz+tUxauRv3qH0+T4jgYJyfIZ/9qFBW4Re2No
   Hr6Xzo8H9DwKGi7gUzwiNR0HKSqeLskNmizpRFxhKuQp20+M2e0UlaCku
   LRiR8Lh2kJKbn8fWu7DNWfozjsGhsTq34GZfAdvTx4AwGBioHAGERjd8f
   A==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181303"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 6D3BD280073;
        Wed, 14 Sep 2022 17:31:44 +0200 (CEST)
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
Subject: [PATCH v5 3/5] hwmon: pwm-fan: Add dedicated power switch function
Date:   Wed, 14 Sep 2022 17:31:35 +0200
Message-Id: <20220914153137.613982-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
References: <20220914153137.613982-1-alexander.stein@ew.tq-group.com>
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

This handles enabling/disabling the regulator in a single function, while
keeping the enables/disabled balanced. This is a preparation when
regulator is switched from different code paths.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 46 +++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 01412c71deb3..92c5b7f5ddd6 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -35,6 +35,7 @@ struct pwm_fan_ctx {
 	struct pwm_device *pwm;
 	struct pwm_state pwm_state;
 	struct regulator *reg_en;
+	bool regulator_enabled;
 	bool enabled;
 
 	int tach_count;
@@ -85,6 +86,25 @@ static void sample_timer(struct timer_list *t)
 	mod_timer(&ctx->rpm_timer, jiffies + HZ);
 }
 
+static int pwm_fan_switch_power(struct pwm_fan_ctx *ctx, bool on)
+{
+	int ret = 0;
+
+	if (!ctx->reg_en)
+		return ret;
+
+	if (!ctx->regulator_enabled && on) {
+		ret = regulator_enable(ctx->reg_en);
+		if (ret == 0)
+			ctx->regulator_enabled = true;
+	} else if (ctx->regulator_enabled && !on) {
+		ret = regulator_disable(ctx->reg_en);
+		if (ret == 0)
+			ctx->regulator_enabled = false;
+	}
+	return ret;
+}
+
 static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 {
 	struct pwm_state *state = &ctx->pwm_state;
@@ -320,7 +340,7 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 
 static void pwm_fan_regulator_disable(void *data)
 {
-	regulator_disable(data);
+	pwm_fan_switch_power(data, false);
 }
 
 static void pwm_fan_pwm_disable(void *__ctx)
@@ -364,13 +384,13 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
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
@@ -516,12 +536,10 @@ static int pwm_fan_disable(struct device *dev)
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
@@ -543,12 +561,10 @@ static int pwm_fan_resume(struct device *dev)
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

