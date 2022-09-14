Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC1F5B8BD1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiINPbu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiINPbs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:31:48 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3A852E68;
        Wed, 14 Sep 2022 08:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169507; x=1694705507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W5vAyTiInp3pwLtLIS4sxMRlr7rQja3WJIBXzAKb0BI=;
  b=UVf1hz7NUcaQxBtKmain85sdswtK555bgTPAumRRQZ2mdfmqRrPR0Ht3
   iyYkYo6mRGLLmeHjO7Q4Y/uaaBtTQOfsjAjWG7NgDE6kFCkRGqa2x1WIC
   tbNDGJQdvWj1ty4McPhkEh2hnIW0LqXofE+lCdqKxCn5Ie3IkkInnxdEx
   Y5brWhmtbWClIj7MFc+4EblnUtXkzQ6XaPhpXAAZ8Lybfs9NMo88bmVE9
   hZNC+LlsnyZzFIPT8+9FflKGszkxezODopBcPFOvAvV7DUa7VBiGAkPKf
   SGSUAJ7WxMU5aQM0dwFNSgqiOJa1SKWgKF5LfhSYe2ia5Ct2TLLPCCIfk
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181301"
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
  bh=W5vAyTiInp3pwLtLIS4sxMRlr7rQja3WJIBXzAKb0BI=;
  b=oYGfkcbIe81V3a67qeZfEFbMmxRXugAAdSgfUbhPpmlg8sBYVkkfSdFU
   Xuk/XEgojOeuPkDwDXVNbpRiE1aOd7aO2CbBlQm5siKIHt9Tf1zYIoq1X
   yu9fLZ0jMoNVVHuVY+zs/H7s1BC8tUtx+GYuqRd0ktjgaNEtgZrnzySrI
   P8W2PnoHv09rS/luAmWoIlL4f4CHTxuCZdQ+0gwe7grVYcrwW/sYBpPNw
   4KS80IA38xYjKWImDd6FNlNo53EAqLTuvfKtOxvjUD8/HZAs2i7Ktm5Xw
   AzZdNk8hkH27gyUCHMRKjwfM8rOivJBYGxbVtYmlyBLQSpByXSuhblQHV
   g==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181300"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 3ABED280056;
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
Subject: [PATCH v5 2/5] hwmon: pwm-fan: Simplify enable/disable check
Date:   Wed, 14 Sep 2022 17:31:34 +0200
Message-Id: <20220914153137.613982-3-alexander.stein@ew.tq-group.com>
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

Instead of comparing the current to the new pwm duty to decide whether to
enable the PWM, use a dedicated flag. Also apply the new PWM duty in any
case. This is a preparation to enable/disable the regulator dynamically.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 43 ++++++++++++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index c8a7926d39e7..01412c71deb3 100644
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
@@ -85,13 +88,19 @@ static void sample_timer(struct timer_list *t)
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
+		return ret;
+	}
+
+	ctx->enabled = true;
 
 	return ret;
 }
@@ -99,27 +108,42 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 {
 	struct pwm_state *state = &ctx->pwm_state;
+	int ret;
+
+	if (!ctx->enabled)
+		return 0;
 
 	state->enabled = false;
 	state->duty_cycle = 0;
-	pwm_apply_state(ctx->pwm, state);
+	ret = pwm_apply_state(ctx->pwm, state);
+	if (ret) {
+		dev_err(ctx->dev, "failed to disable PWM\n");
+		return ret;
+	}
+
+	ctx->enabled = false;
 
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
 
@@ -326,6 +350,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	mutex_init(&ctx->lock);
 
+	ctx->dev = &pdev->dev;
 	ctx->pwm = devm_pwm_get(dev, NULL);
 	if (IS_ERR(ctx->pwm))
 		return dev_err_probe(dev, PTR_ERR(ctx->pwm), "Could not get PWM\n");
-- 
2.25.1

