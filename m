Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAEC5B8BCF
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Sep 2022 17:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiINPbt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 14 Sep 2022 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiINPbs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 14 Sep 2022 11:31:48 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B9750700;
        Wed, 14 Sep 2022 08:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1663169507; x=1694705507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WM+xIdPpk5wsGwY+EBkuixZH3uS2Jyz3uzB0NBE5Q3k=;
  b=E04LbOy8t4tccSnSG00tuUe7kxj1oMBa1w+Nh+RH8pVEO8T02/Bz6ge4
   CErxje0B/G+4VvSSr6/BYPzpFCn1D0w6SY1Ri/2vS4qz212P5DogZonb4
   RipUt4UvMeKFP0x5/K8n5YScGSb2wFS8LwwyzesTvcFyr2vsIW1evZNn7
   naxzJSJjAMXoAKJCH4/knYLz4b3/vJNagz4iyki1vZMM8YBbnItO3VScn
   EhCwFzZkzrsY9YXA+vtFmscjvt+cBl/4Aymewevwv/XcHpFhQeuTMM4X8
   O7WeaRcs4VsLJAO6u+os2J7IYEGD1MThvClSilNA6081cN9qbA6HXMPRp
   A==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181299"
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
  bh=WM+xIdPpk5wsGwY+EBkuixZH3uS2Jyz3uzB0NBE5Q3k=;
  b=e1l8ZBIQ36TVBcdaZU1MXuzLIw3pzc6lrcKToWJDn9jYcHUd7t7S10t5
   HpOSnK/9Z4+GTqrmKUzyJ7DGFKJ8fBkFnzQ72pWk7/MXRa4BRaX3PtjZm
   N6kGGA8Kl97s/q4phzyuu+hYmi/nWOKlA0GczZTnpo7RaMrxNasQ9Sl80
   LKznogmhpCBIiRjEzQpakkeASHsuj4SVxOFhG3yNysKtYxFzhCfk1UENX
   4pFxQWKdEDPZGAdRahxmDyqmEuDP6JKvrHo76OepNIBioFh+wlk7Dy/NU
   CdelbAOUTDBxTDkPvRXBXa36YfXT4xNe47ASAtEN6XfQiwEOi2ifJ/BLr
   g==;
X-IronPort-AV: E=Sophos;i="5.93,315,1654552800"; 
   d="scan'208";a="26181298"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 14 Sep 2022 17:31:44 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.11])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 0C2D3280072;
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
Subject: [PATCH v5 1/5] hwmon: pwm-fan: Refactor fan power on/off
Date:   Wed, 14 Sep 2022 17:31:33 +0200
Message-Id: <20220914153137.613982-2-alexander.stein@ew.tq-group.com>
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

In preparation for dynamically switching regulator, split the power on
and power off sequence into separate functions.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 06fd1d75101d..c8a7926d39e7 100644
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

