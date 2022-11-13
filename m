Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269DD627383
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiKMXgx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbiKMXgw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:36:52 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C07D2D3
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id i3so9513197pfc.11
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=leQgJ9bcx3VfAns6DS1hNL1QDESZmnuXmuLithED7DY=;
        b=SHRsqkbshmSG2494oxRUFMXSx65xC5XzbK/JHle0LwA0lyrHP5Tz9i7gBq38skSD4X
         UEx5z3LGoxjBmSC2PnTKFbY/bu5riOY34rdddUb6CBHPB4mkReXstb1cY7coKwwwPMQI
         Sbu1PQZ7ihHNo1K1doI7E/86CQrXQeD6N1dnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=leQgJ9bcx3VfAns6DS1hNL1QDESZmnuXmuLithED7DY=;
        b=D2FpcD4CB21VesE9ANtxiS0Q3Sv09Qo+VvnvNkcNwXUcKAiGi0fzeN2Er4TVU8sgIQ
         VE+f2McK8R+UD4GyezzmA2xacIPKK2IgGhPtH1DgLyKE+uRCaNdHCOAuCsVOK+FCL8a9
         8g9cEbCn3yQ3O1lgXjUlkqTTbGsVVaqCSYXX89Hq6ZIv25+s9pe85YJF6i0en0AMwBkt
         8RUNotUzcF8RYipprSnVOQmX+dMW/iQJtMZbn1xSK35uPym/I/KRmlTwh/rg8e2EKgg/
         kxp62FjsRZjcrL4nImXWYuhmgi5lArHhFsrMt4HFatqmz31vP5IarHqSeDkR3zfDFXzK
         rOWQ==
X-Gm-Message-State: ANoB5pmaJlS7AI2DH576sCt5a6C2GggvrwCmE+aoYRyRKbBxWFdnV21N
        9n9JYuHPrchEXtAj+2Z78J/1eQ==
X-Google-Smtp-Source: AA0mqf79kAsx9d36/aG9XzlGtOaCIYe1HvUi2sziXMZf4oN7uCneSMKtA4bnbB02JgMqalQXIq/DYA==
X-Received: by 2002:a63:1d49:0:b0:476:898c:ded5 with SMTP id d9-20020a631d49000000b00476898cded5mr1668226pgm.299.1668382611024;
        Sun, 13 Nov 2022 15:36:51 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:36:50 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 2/6] pwm: pxa: Set duty cycle to 0 when disabling PWM
Date:   Sun, 13 Nov 2022 15:36:35 -0800
Message-Id: <20221113233639.24244-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113233639.24244-1-doug@schmorgal.com>
References: <20221113233639.24244-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When disabling PWM, the duty cycle needs to be set to 0. This prevents
the previous duty cycle from showing up momentarily when the clock is
re-enabled next time.

Because the clock has to be running in order to configure the duty
cycle, unconditionally enable it early in pxa_pwm_apply and account for
the correct enable count at the end.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 0ac052652c62..9ee9b41d62b8 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -105,24 +105,31 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+	u64 duty_cycle;
 	int err;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		return -EINVAL;
 
-	if (!state->enabled) {
-		if (pwm->state.enabled)
-			clk_disable_unprepare(pc->clk);
+	err = clk_prepare_enable(pc->clk);
+	if (err)
+		return err;
 
-		return 0;
-	}
+	duty_cycle = state->enabled ? state->duty_cycle : 0;
 
-	err = pxa_pwm_config(chip, pwm, state->duty_cycle, state->period);
-	if (err)
+	err = pxa_pwm_config(chip, pwm, duty_cycle, state->period);
+	if (err) {
+		clk_disable_unprepare(pc->clk);
 		return err;
+	}
+
+	if (state->enabled && !pwm->state.enabled)
+		return 0;
+
+	clk_disable_unprepare(pc->clk);
 
-	if (!pwm->state.enabled)
-		return clk_prepare_enable(pc->clk);
+	if (!state->enabled && pwm->state.enabled)
+		clk_disable_unprepare(pc->clk);
 
 	return 0;
 }
-- 
2.34.1

