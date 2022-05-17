Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B9852A4C6
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbiEQO0s (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239516AbiEQO0r (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:47 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D9C742A27;
        Tue, 17 May 2022 07:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797605; x=1684333605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFECBIxcXYfz0pDlsSadifgxEhqSYOY8Lf0coZ96Zww=;
  b=nuKKGG6Fmckp0yg8UB/VO46qFQRtgNY/sQGxXsguvK1DDuxkv8HxiQGv
   5NXg1Cis597+ZmK5DCsFgmpCJD3PsfpkbaDO0QYNR8uqOvwpnVXTg1GLZ
   hUNjMzi36mVetAJYLD5UFhb4X1IKhvm5e/hW6xFjCDq+LUs3hmza6lHKw
   5LdUGlf8AEzmCwF6EMtPF5WOQYJazYTNVmQH8YHmPSq8Wt0q+56GHyyqN
   enaGJa0KHEZC1VfNlF7d6+S9U28SXKISztq/AShoQ5JWXKYdSpjNkAFwd
   7le8ie7YaXDVR8S6m6WvD8pyguRFLJsKLdRPucv9XHFaYWit/t1fvSLaN
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925932"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 17 May 2022 16:26:26 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Tue, 17 May 2022 16:26:26 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Tue, 17 May 2022 16:26:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797586; x=1684333586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rFECBIxcXYfz0pDlsSadifgxEhqSYOY8Lf0coZ96Zww=;
  b=e7Ga3th8KCe2NGmRvKbCy8sIXHlMKYT21CIY0oBhhM33hfKfpyo9jfIU
   fO8MgEPZwMSxMFIEh+OMtiHUi0vv0ARDdYIjkk/tSLIXdNt24XstlyMHK
   KMOMINxQOaWyJREVSidAWlo9BHWL8MGXAVS5dwef6zcZ4LUG95CeL9Ftd
   00kvUIb2bVwz5Yblpl2Y6erCSKoEgBuvQbp8Jz9T3/UrxcpKyYQo1RSDT
   epKT73NJdA6LdgDygNQm4t9pC+aevqm+TGAONuGmQr7wtYlsRaZyyIfhj
   N9OpAWqMf35mWvXvxXZC3886mfzmhjU/rMkRZi1bwIH9oDOhHAh3QFN/I
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925926"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:25 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 327AC280075;
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
Subject: [PATCH v3 1/6] hwmon: pwm-fan: Refactor fan power on/off
Date:   Tue, 17 May 2022 16:26:15 +0200
Message-Id: <20220517142620.1523143-2-alexander.stein@ew.tq-group.com>
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

In preparation for dynamically switching regulator, split the power on
and power off sequence into separate functions.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 36 ++++++++++++++++++++++++++++++------
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 6c08551d8d14..458914d01155 100644
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
+	struct pwm_state state;
+
+	state.enabled = false;
+	state.duty_cycle = 0;
+	pwm_apply_state(ctx->pwm, &state);
+
+	return 0;
+}
+
+static int  __set_pwm(struct pwm_fan_ctx *ctx, unsigned long pwm)
+{
 	int ret = 0;
-	struct pwm_state *state = &ctx->pwm_state;
 
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

