Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AC1530F0C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234441AbiEWLFe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 07:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiEWLFa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 07:05:30 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604793122D;
        Mon, 23 May 2022 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303929; x=1684839929;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPXm7BZeX5DgNj1DNqvkm7tf4Ol3dCj610giwTyo8+I=;
  b=QWBAn0eRzUNmCegd4/rfSt/4AfcOTekxqhMbfimLoiySzTZFi0Nvvwvn
   IhaOp3gBS43PNmW0MvkdI7Me27dHhma+d+FtezOr2VzqUCe5X0grBNnI7
   d6tpv3mmWkJJZ+svhbqK1V/zle/LgpF7t93MDciS0T/4Ei9LNusWBgcqO
   wIq3mdhNXjQxHzsxcwvz11MeFSnYKYjELYjmwFBehto+DYwzAlXXtvZAz
   fMxR7P5nndpNui9ENdKpYCLbam/MOgSre/nUIDXR8yPxU0r9Oke8zl1UF
   tka+HlgpLH45F6DQc2pd9D+FXbT97tTFu89w0dlrbB1Z22WMNuXQDGK/L
   g==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031374"
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
  bh=GPXm7BZeX5DgNj1DNqvkm7tf4Ol3dCj610giwTyo8+I=;
  b=Kjd+CYlFtFLEq7NnzfyO7SNhQigyvyuRFWQ57vnxS20Jm8EtNTWF2xvT
   AqDI7izw/XvZHinnbloHaSqc8dkOixtjBZ02t314bODlDMMfXXVeOLKPU
   7AOyNQoDua+rKm+hvaQg6wi2OSmQIHBir28N7R8tEZ8ABIS96fZ8ygClz
   fKsT+8dTz80rWrDQBycqphOdXMLceAT3KgeDddVhF2p83TaJn1zIweRvR
   7JWdWwkYNhQnZmwQ5E90vmRWBtehXfpVrDiM4oED0wXrnT6ZzVRQWj1wo
   t5d6JwXNniNxSaCABySIEe1kSLsvACmLJ6v5GQkWJAXPcHBwt6kL5fnPa
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031373"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 13:05:19 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id CD4DB280075;
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
Subject: [PATCH v4 4/6] hwmon: pwm-fan: split __set_pwm into locked/unlocked functions
Date:   Mon, 23 May 2022 13:05:11 +0200
Message-Id: <20220523110513.407516-5-alexander.stein@ew.tq-group.com>
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

Regular calls to set_pwm don't hold the mutex, but the upcoming
update_enable support needs to call set_pwm with the mutex being held.
So provide the previous behavior in set_pwm (handling the lock), while
adding __set_pwm which assumes the lock being held.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 04af24268963..fcc1b7b55a65 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -152,14 +152,12 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	unsigned long period;
 	int ret = 0;
 
-	mutex_lock(&ctx->lock);
-
 	if (pwm > 0) {
 		period = state->period;
 		state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
 		ret = pwm_apply_state(ctx->pwm, state);
 		if (ret)
-			goto exit_set_pwm_err;
+			return ret;
 		ret = pwm_fan_power_on(ctx);
 	} else {
 		ret = pwm_fan_power_off(ctx);
@@ -167,8 +165,17 @@ static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
 	if (!ret)
 		ctx->pwm_value = pwm;
 
-exit_set_pwm_err:
+	return ret;
+}
+
+static int set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
+{
+	int ret;
+
+	mutex_lock(&ctx->lock);
+	ret = __set_pwm(ctx, pwm);
 	mutex_unlock(&ctx->lock);
+
 	return ret;
 }
 
@@ -192,7 +199,7 @@ static int pwm_fan_write(struct device *dev, enum hwmon_sensor_types type,
 	if (val < 0 || val > MAX_PWM)
 		return -EINVAL;
 
-	ret = __set_pwm(ctx, val);
+	ret = set_pwm(ctx, val);
 	if (ret)
 		return ret;
 
@@ -280,7 +287,7 @@ pwm_fan_set_cur_state(struct thermal_cooling_device *cdev, unsigned long state)
 	if (state == ctx->pwm_fan_state)
 		return 0;
 
-	ret = __set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
+	ret = set_pwm(ctx, ctx->pwm_fan_cooling_levels[state]);
 	if (ret) {
 		dev_err(&cdev->device, "Cannot set pwm!\n");
 		return ret;
@@ -400,7 +407,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	pwm_init_state(ctx->pwm, &ctx->pwm_state);
 
 	/*
-	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
+	 * set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
 	 * long. Check this here to prevent the fan running at a too low
 	 * frequency.
 	 */
@@ -410,7 +417,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	/* Set duty cycle to maximum allowed and enable PWM output */
-	ret = __set_pwm(ctx, MAX_PWM);
+	ret = set_pwm(ctx, MAX_PWM);
 	if (ret) {
 		dev_err(dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
-- 
2.25.1

