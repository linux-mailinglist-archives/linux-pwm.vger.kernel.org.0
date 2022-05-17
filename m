Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D496352A4CC
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348834AbiEQO0x (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348836AbiEQO0t (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:49 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AE942A3C;
        Tue, 17 May 2022 07:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797607; x=1684333607;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mDjd1Czri8IG4oOu2iAnNPTxvmKzQtBIO6FCC4N5SZc=;
  b=H9T5hbE1qbAxAPRczbjRqgrgl+0Hh3j6ezZasZ2oCiVMuwc1U7cJe35T
   0I3RKN7OJZTLNCIdINa62tXNzw5gohxQOXlc8FSkNPF9ig4eVCdiT9VVQ
   U2UM8fGix23uZjYtGoAkKbsExJK60rdXxMdzlMbHwjlPGdU7YKt1DW4cq
   ggK6LrXAOgIDRqg0mvxdl7rmp4P9Iv8eY+pBV2BOBrwbg55ZNtNYFRfOe
   umMsc/NQ/NTluPahFSwAIBWt8FHPpUvbUfq4GfaD+JKFU3twaXSAJgeR2
   6IxoCZ9Dav52JeZhKEhsw3sydrHoKtB9hvfFktQ9I+gvQrooQ2vg9umiJ
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925940"
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
  bh=mDjd1Czri8IG4oOu2iAnNPTxvmKzQtBIO6FCC4N5SZc=;
  b=l746PcLaj/s2K1yir+PBsTXlOfL1gOOSV9+AFEMJtOMlKSUVnuw15C9M
   QcWkGlw+opFjqOzXYT01oStp1mgwSa8yJZpDFUr1URups427wrDqXGmtJ
   oUhTIeo8lENTIn4ELoq6N1iXz4ApcvGXPBP+YWk92hiclRDtsJtujBujE
   Ar9WHAYQnHQdtUUuScmNvM/XYj27SRZ63SaRdepTbTTJSN9kMS+3h21QL
   scIWXWbrGtMtAKv1KZVorOHE6Suk+bo4R9v5QzJAncyDWSZ1ORuCbv2Z7
   eXQ7tjlV7xsZov+A3CRy6DoMSIwz42uHzTkBIsX7cf5QTGptFe4NchzIm
   g==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925931"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:25 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 997CC28007C;
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
Subject: [PATCH v3 3/6] hwmon: pwm-fan: Dynamically switch off regulator if PWM duty is 0
Date:   Tue, 17 May 2022 16:26:17 +0200
Message-Id: <20220517142620.1523143-4-alexander.stein@ew.tq-group.com>
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

Instead of powering the PWM fan all the time, turn off the regulator if
the PWM is disabled. This is especially important for fan using inverted
PWM signal polarity. Having regulator supplied and PWM disabled, some
PWM controllers provide the active, rather than inactive signal.
With this change the shutdown as well as suspend/resume paths require
modifcations as well.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 91 ++++++++++++-----------------------------
 1 file changed, 27 insertions(+), 64 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 2b7b26ab9b88..c757af514ede 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -93,16 +93,25 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 	if (ctx->enabled)
 		return 0;
 
+	ret = regulator_enable(ctx->reg_en);
+	if (ret < 0) {
+		dev_err(ctx->dev, "failed to enable power supply\n");
+		return ret;
+	}
+
 	state->enabled = true;
 	ret = pwm_apply_state(ctx->pwm, state);
 	if (ret) {
 		dev_err(ctx->dev, "failed to enable PWM\n");
-		goto err;
+		goto disable_regulator;
 	}
 
 	ctx->enabled = true;
 
-err:
+	return 0;
+
+disable_regulator:
+	regulator_disable(ctx->reg_en);
 	return ret;
 }
 
@@ -117,6 +126,8 @@ static int pwm_fan_power_off(struct pwm_fan_ctx *ctx)
 	state.duty_cycle = 0;
 	pwm_apply_state(ctx->pwm, &state);
 
+	regulator_disable(ctx->reg_en);
+
 	ctx->enabled = false;
 
 	return 0;
@@ -314,18 +325,12 @@ static int pwm_fan_of_get_cooling_data(struct device *dev,
 	return 0;
 }
 
-static void pwm_fan_regulator_disable(void *data)
-{
-	regulator_disable(data);
-}
-
-static void pwm_fan_pwm_disable(void *__ctx)
+static void pwm_fan_cleanup(void *__ctx)
 {
 	struct pwm_fan_ctx *ctx = __ctx;
 
-	ctx->pwm_state.enabled = false;
-	pwm_apply_state(ctx->pwm, &ctx->pwm_state);
 	del_timer_sync(&ctx->rpm_timer);
+	pwm_fan_power_off(ctx);
 }
 
 static int pwm_fan_probe(struct platform_device *pdev)
@@ -359,16 +364,6 @@ static int pwm_fan_probe(struct platform_device *pdev)
 			return PTR_ERR(ctx->reg_en);
 
 		ctx->reg_en = NULL;
-	} else {
-		ret = regulator_enable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
-			return ret;
-		}
-		ret = devm_add_action_or_reset(dev, pwm_fan_regulator_disable,
-					       ctx->reg_en);
-		if (ret)
-			return ret;
 	}
 
 	pwm_init_state(ctx->pwm, &ctx->pwm_state);
@@ -383,14 +378,17 @@ static int pwm_fan_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/* Set duty cycle to maximum allowed and enable PWM output */
+	/*
+	 * Set duty cycle to maximum allowed and enable PWM output as well as
+	 * the regulator. In case of error nothing is changed
+	 */
 	ret = __set_pwm(ctx, MAX_PWM);
 	if (ret) {
 		dev_err(dev, "Failed to configure PWM: %d\n", ret);
 		return ret;
 	}
 	timer_setup(&ctx->rpm_timer, sample_timer, 0);
-	ret = devm_add_action_or_reset(dev, pwm_fan_pwm_disable, ctx);
+	ret = devm_add_action_or_reset(dev, pwm_fan_cleanup, ctx);
 	if (ret)
 		return ret;
 
@@ -496,61 +494,26 @@ static int pwm_fan_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int pwm_fan_disable(struct device *dev)
-{
-	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	int ret;
-
-	if (ctx->pwm_value) {
-		/* keep ctx->pwm_state unmodified for pwm_fan_resume() */
-		struct pwm_state state = ctx->pwm_state;
-
-		state.duty_cycle = 0;
-		state.enabled = false;
-		ret = pwm_apply_state(ctx->pwm, &state);
-		if (ret < 0)
-			return ret;
-	}
-
-	if (ctx->reg_en) {
-		ret = regulator_disable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to disable fan supply: %d\n", ret);
-			return ret;
-		}
-	}
-
-	return 0;
-}
-
 static void pwm_fan_shutdown(struct platform_device *pdev)
 {
-	pwm_fan_disable(&pdev->dev);
+	struct pwm_fan_ctx *ctx = platform_get_drvdata(pdev);
+
+	pwm_fan_cleanup(ctx);
 }
 
 #ifdef CONFIG_PM_SLEEP
 static int pwm_fan_suspend(struct device *dev)
 {
-	return pwm_fan_disable(dev);
+	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
+
+	return pwm_fan_power_off(ctx);
 }
 
 static int pwm_fan_resume(struct device *dev)
 {
 	struct pwm_fan_ctx *ctx = dev_get_drvdata(dev);
-	int ret;
-
-	if (ctx->reg_en) {
-		ret = regulator_enable(ctx->reg_en);
-		if (ret) {
-			dev_err(dev, "Failed to enable fan supply: %d\n", ret);
-			return ret;
-		}
-	}
-
-	if (ctx->pwm_value == 0)
-		return 0;
 
-	return pwm_apply_state(ctx->pwm, &ctx->pwm_state);
+	return __set_pwm(ctx, ctx->pwm_value);
 }
 #endif
 
-- 
2.25.1

