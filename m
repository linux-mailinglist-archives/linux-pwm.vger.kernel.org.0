Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08065B8BD6
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiINPbw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiINPbu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:31:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1048048CAB;
        Wed, 14 Sep 2022 08:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169509; x=1694705509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILty9AwYF/A0k9EWfznOPHbvgTNH+i70Ca8VVGwNl1M=;
  b=fgyG472QnAZFpy5OH66FDNrVNRB2CtF9p4qyVh2Aniwa4iDg8I8CJsbH
   3UsFz7GoxwigZ2va+3Be2De6jpH0t43ivQ0fFY+5HweEZMMHtdZPtkjKZ
   odey9N04q4EbtKPNk51A7indCa1avN1HmeyFyrRrbopgUzaUxJsEbKVKu
   0JL6Xm7RxY3/cWzVC1lYLQDpfepKxIDavkEtpZwrTQhylch5E4rH4kwM6
   o5KnFDTs6Amp+rU9aAWsJ5WtnjS8asGYZC/UmFNSztq79QIXByvTNwJdr
   gaMkGMgAsWn68wXHErDhUxVrbPjytQhMqeIIpIX1D+m2m7QHCIkO/usV4
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181306"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 14 Sep 2022 17:31:45 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 14 Sep 2022 17:31:45 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 14 Sep 2022 17:31:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169505; x=1694705505;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ILty9AwYF/A0k9EWfznOPHbvgTNH+i70Ca8VVGwNl1M=;
  b=ZZgw0xbXl5rKp7mbJgEPlyq2ifvcEsp7o6lL/AtuZtIA8sCRIPoKRA2C
   obVrEixQ8JydMCdZZ4dlhXNcUDylEfpXf1PqEoMD0+Z38xVHrU4EgEcpv
   8mHOBMz2gyNuQ7LqoITLHUvRjvKlm/OTDV8xxaF0C2GH0ZpgkMhd6qwYQ
   mzLpidypHBPxexP51LvQSNn2GYsIu9Q000x3immeAVVYRbmLLuqjkvkzQ
   30zMFmLqWEnKDLTnTJXpCITNa7kTR1yBrRVb1QqnSBjufs/7r7aEsYmYB
   45h7rnoIYXQA45thiHurvnqjDbh3UHt5IRPslSaxnWsiUX2nSly7sUhB0
   w==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181304"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 9BDF9280074;
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
Subject: [PATCH v5 4/5] hwmon: pwm-fan: split __set_pwm into locked/unlocked functions
Date:   Wed, 14 Sep 2022 17:31:36 +0200
Message-Id: <20220914153137.613982-5-alexander.stein@ew.tq-group.com>
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

Regular calls to set_pwm don't hold the mutex, but the upcoming
update_enable support needs to call set_pwm with the mutex being held.
So provide the previous behavior in set_pwm (handling the lock), while
adding __set_pwm which assumes the lock being held.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 92c5b7f5ddd6..12ef3b3dbe22 100644
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
@@ -398,7 +405,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	pwm_init_state(ctx->pwm, &ctx->pwm_state);
 
 	/*
-	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
+	 * set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
 	 * long. Check this here to prevent the fan running at a too low
 	 * frequency.
 	 */
@@ -408,7 +415,7 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	}
 
 	/* Set duty cycle to maximum allowed and enable PWM output */
-	ret = __set_pwm(ctx, MAX_PWM);
+	ret = set_pwm(ctx, MAX_PWM);
 	if (ret) {
 		dev_err(dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
-- 
2.25.1

