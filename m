Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0645310D6
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbiEWLF2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 07:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiEWLF1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 07:05:27 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F53101D0;
        Mon, 23 May 2022 04:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303926; x=1684839926;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N4fNOLo/O2++wVgHbraL4AIatNPwANhDsXLsREGO28k=;
  b=FBHKZCKXI0GhQ5bWoahwcBRGOMbNGwtC/SKbmCvZm0qA4Y00l0nLc9DN
   oJi3oDhxHhVuGZ3APXe2yFSqQbhsNIg8lJPhf+i2G4/l0po0sX2keBxWt
   HM7Qmt3n5+1F4Jhh7gx6/SOf0oEhGuQgLFPWlZdCeAXQkNpgnIqdnJR4j
   j2oKSvUFg7fDwQeUGLh2Szjpaun7CamCMERA5U3gUWUvZbNzkYKW8wjik
   5QK5gFGnUYwWluS8X1YIHKJ44D5I44ef505PQJZfWDf2uzzbsXf6mNr8r
   55N5U0w4krr2TBV8xTUKB0mkNUZvH/FDEcU9ZwzFkZFslFz6cZ1/B+Y5e
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031366"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 23 May 2022 13:05:18 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 23 May 2022 13:05:18 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 23 May 2022 13:05:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303918; x=1684839918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N4fNOLo/O2++wVgHbraL4AIatNPwANhDsXLsREGO28k=;
  b=Dfb10s2uvl8lOhQsuxFCPb18Yx3MZuayLzNQJJ3ZIGB/gZbFdBCPae2m
   Vvlm795eDMN3f7/53LAZRGcDiTSw4nHTYSqXwWCntgCJMePryrMAvqZsY
   1d+CFLVHPyot1cxLga48CDTKvSQPxSA+ikZF7dBGQYZwhimi3aDuK9nDU
   441ZKaoguu5m4hYl9zfx89t/orcycVAjJ7e+ZsiFcR2Llo0Z6YXsS3CQw
   e6cphxmB0grqVA7ONRnYc4sL1FpNI0+o47R5tpRnZ5EOP5XD0dnr34BFs
   rHc7qtN1gw03Gp0iZcHbYO50U0l51m4UAl9A+UGyj9CI17HMQUouBXk4q
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031365"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 13:05:18 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 33939280075;
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
Subject: [PATCH v4 1/6] hwmon: pwm-fan: Refactor fan power on/off
Date:   Mon, 23 May 2022 13:05:08 +0200
Message-Id: <20220523110513.407516-2-alexander.stein@ew.tq-group.com>
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

In preparation for dynamically switching regulator, split the power on
and power off sequence into separate functions.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 6c08551d8d14..831878daffe6 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -82,23 +82,47 @@ static void sample_timer(struct timer_list *t)
 	mod_timer(&ctx->rpm_timer, jiffies + HZ);
 }
 
-static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
+static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 {
+	struct pwm_state *state = &ctx->pwm_state;
 	unsigned long period;
-	int ret = 0;
+	int ret;
+
+	period = state->period;
+	state->duty_cycle = DIV_ROUND_UP(ctx->pwm_value * (period - 1), MAX_PWM);
+	state->enabled = true;
+	ret = pwm_apply_state(ctx->pwm, state);
+
+	return ret;
+}
+
+static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
+{
 	struct pwm_state *state = &ctx->pwm_state;
 
+	state->enabled = false;
+	state->duty_cycle = 0;
+	pwm_apply_state(ctx->pwm, state);
+
+	return 0;
+}
+
+static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
+{
+	int ret = 0;
+
 	mutex_lock(&ctx->lock);
 	if (ctx->pwm_value == pwm)
 		goto exit_set_pwm_err;
 
-	period = state->period;
-	state->duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);
-	state->enabled = pwm ? true : false;
+	if (pwm > 0)
+		ret = pwm_fan_power_on(ctx);
+	else
+		ret = pwm_fan_power_off(ctx);
 
-	ret = pwm_apply_state(ctx->pwm, state);
 	if (!ret)
 		ctx->pwm_value = pwm;
+
 exit_set_pwm_err:
 	mutex_unlock(&ctx->lock);
 	return ret;
-- 
2.25.1

