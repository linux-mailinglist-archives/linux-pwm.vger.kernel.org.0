Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259E6530F61
	for <lists+linux-pwm@lfdr.de>; Mon, 23 May 2022 15:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbiEWLFa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 23 May 2022 07:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbiEWLF3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 23 May 2022 07:05:29 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4995217E33;
        Mon, 23 May 2022 04:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1653303927; x=1684839927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/cAEHkHWSmpF0ROyxA/wCo1gDxMoa4uQunb5Hpc/roU=;
  b=aLHq3dswWyM2jqucryPHXOPJUXYg0KogzKcYWrGgIvm+TxaZrCQnBB8L
   GuSxo+0BbagNE7mm6UoJu3Rl1qsODb5Xsq3VqZY3DPyrPp8/oEYpwvcnr
   AZAVH6zJ+DhjfOAxL7F2z80BV2R7MyAZ6BKegGCa64wEiasmiVxwMLQtH
   vEJo0tJnYVNw5fToJaicnMTRRbhXepIcGeQP1cscrxGSjSTsYVtTH1nwp
   IlXHT7/bVQMNsaaeoQg9M3AFZ24MvAugl2qf/2vJ969jYVPY4YRvcUOpQ
   sn5S2Oh+qItnwhHOassH3xQ1DSiGeH7FfBHuxLC0w0aEQHOo7axMEhFsI
   w==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031368"
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
  bh=/cAEHkHWSmpF0ROyxA/wCo1gDxMoa4uQunb5Hpc/roU=;
  b=Bd+nrmORCCQsc6qMJS7ZDy5bTSAyV+Ih3ABkKPjTGz293Y9+TzLHkTMf
   Rbpk+gFXH7OlCeyDrJrqUW0HkA/+yR4a6MmT4pO5/qFH/nP1yFXngNJ8B
   qKLfLyK0eb4jhMVmJVSjL8WbQNnZzAURrI0QRbZj4DodHof1+aVmFCQzw
   YebDQWbz1McGUX1IRLmvurdtaHG+PkZ6xgKoUvRimwrUdROu2rRN4zErl
   s/77D28LV/ZePeRBCVn/PPMGbPZiZeXvZh3bWGJZgA/iELH84y8BR6qeZ
   k5X0/au+5txYswUfqO3NO7lpMTItGdmvxltjZwZRjIc2YAeScRrJL1YNa
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647298800"; 
   d="scan'208";a="24031367"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 23 May 2022 13:05:18 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 65080280078;
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
Subject: [PATCH v4 2/6] hwmon: pwm-fan: Simplify enable/disable check
Date:   Mon, 23 May 2022 13:05:09 +0200
Message-Id: <20220523110513.407516-3-alexander.stein@ew.tq-group.com>
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

Instead of comparing the current to the new pwm duty to decide whether to
enable the PWM, use a dedicated flag. Also apply the new PWM duty in any
case. This is a preparation to enable/disable the regulator dynamically.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 831878daffe6..96b10d422828 100644
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
 	struct pwm_state *state = &ctx->pwm_state;
 
+	if (!ctx->enabled)
+		return 0;
+
 	state->enabled = false;
 	state->duty_cycle = 0;
 	pwm_apply_state(ctx->pwm, state);
 
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

