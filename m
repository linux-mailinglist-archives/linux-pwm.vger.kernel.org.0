Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0C752A4D0
	for <lists+linux-pwm@lfdr.de>; Tue, 17 May 2022 16:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348855AbiEQO0y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 May 2022 10:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348868AbiEQO0u (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 May 2022 10:26:50 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C800D42A3D;
        Tue, 17 May 2022 07:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1652797609; x=1684333609;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9Y16Fi0agI4kORhbSwpsI13j5cDz6fUFfAn4VgiYiQ=;
  b=pA0RU4nNtmkwCDVxaZfhxREJnmJoJHxBNNwt6kUAHS7DPRC7/jybMA24
   fI7igQ+Sr8mrKJmKWleC7J206CiM73eE200qA85W9oMd7NweYaij98zzk
   CUAN0Zp8FZo4zrvJvw8Wm13wVDIv0zvnVP+KqmxmcMSRi06SEB66MOzFv
   5UESbb8zAVW7b0cOEKmaPi4CcXIKWSLDunTZeDq+96MnUOeUv2Z5vPTIb
   rEAaGFIac17dp/CvQSxJ5Bl9o9JLU9wOoCsL+C4nmAO8t1BVJVtk31opG
   d9EsungJ+/fMuepFIoU213f++1SsRSDcqu3e8vR/cu+phnkeSgwoSUhUf
   g==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925941"
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
  bh=s9Y16Fi0agI4kORhbSwpsI13j5cDz6fUFfAn4VgiYiQ=;
  b=i4C8OLJpEuYalziNKXFZjd7WEAuHcOJO22cxfmvTT1YJoAHaLkqtG3Te
   aYlKaHCckYdZDoI8jHdDr/U5IdRY4AKdkLSJkii5BmFER6q026Yuduir2
   HqJZ3TePRosJgSftNp4BDV+M4MxtBOoFvTxIyV06HuAhnqfT1/I+nliwZ
   h+Qvp5PqGHOgp3AwO78vni9FYmdM+M4vi7skd5DRdO9D99APiwJFBnaql
   VRvrJMqzySw9TnED0u7es/FFPhhDXYCUm/rm+7t0HQbeYjVBxXjSxB3+D
   gaGt6kEOJ7kvnKw80ALeMKFs4AsKmt+gZ535ARlGhT/zwMHQZxMb/vm1q
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647298800"; 
   d="scan'208";a="23925934"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 17 May 2022 16:26:26 +0200
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 1EFAE280075;
        Tue, 17 May 2022 16:26:26 +0200 (CEST)
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
Subject: [PATCH v3 5/6] hwmon: pwm-fan: Move PWM enable into separate function
Date:   Tue, 17 May 2022 16:26:19 +0200
Message-Id: <20220517142620.1523143-6-alexander.stein@ew.tq-group.com>
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

This allows reusage in other code paths.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/hwmon/pwm-fan.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 21bfd0e931ba..9ebe958cc908 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -84,9 +84,17 @@ static void sample_timer(struct timer_list *t)
 	mod_timer(&ctx->rpm_timer, jiffies + HZ);
 }
 
-static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
+static int pwm_fan_enable_pwm(struct pwm_fan_ctx *ctx)
 {
 	struct pwm_state state;
+
+	pwm_get_state(ctx->pwm, &state);
+	state.enabled = true;
+	return pwm_apply_state(ctx->pwm, &state);
+}
+
+static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
+{
 	int ret;
 
 	if (ctx->enabled)
@@ -98,9 +106,7 @@ static int pwm_fan_power_on(struct pwm_fan_ctx *ctx)
 		return ret;
 	}
 
-	pwm_get_state(ctx->pwm, &state);
-	state.enabled = true;
-	ret = pwm_apply_state(ctx->pwm, &state);
+	ret = pwm_fan_enable_pwm(ctx);
 	if (ret) {
 		dev_err(ctx->dev, "failed to enable PWM\n");
 		goto disable_regulator;
-- 
2.25.1

