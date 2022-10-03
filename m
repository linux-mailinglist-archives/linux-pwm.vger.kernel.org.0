Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61A95F278D
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 03:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJCB4N (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 21:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCB4M (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 21:56:12 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F8E2F3B0
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 18:56:11 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so8758090pjk.2
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 18:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=hOfsB7F9RZhnEfTfyOIwklg+MTCgwEM3l5X+V4LN3vM=;
        b=XVHP93bWWDdjD+o4D+UPOoR1kiNtIjBFUVFAC9bwViyd5NG+fbMYnIKqA+0S3q9Z86
         nEFhdCBDkIrT6z+S3GUI3IE2tCfMDvOl6EKcxRLR9q2o/kvuLnvkZLJF4RZWsxRI7r4D
         d01H+nsei7QI4wUtSJJgV8TbwbtVaDG7gUl6o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=hOfsB7F9RZhnEfTfyOIwklg+MTCgwEM3l5X+V4LN3vM=;
        b=tWB9WW4/GWCp6DPcxLcN2kz0zC2ZpDdtGMbnjtJLzO6UCwpJFBZPXmLACo9tDCcpBB
         06+BqlltM46lk3PMlDqbapq5/XsiM/9u7nKl9WU6x/TczwThEmmI3CJrzMeRGTGGZzfU
         02C+2tWtdo+atTY4xak5eTGI6LHgM1MdvTrQbv0uImI7mvcyvUpV5iDaOl23zC9DzKY3
         qp5T3OCliusznjMbwTHBA4OvanlBrsbqkqcIZuHNFGP8TrYfm6naLCfFw2FthNIAjkr2
         kE8vOOykytUxgESOnKwZoN2L0ZINFv2jwQIlO0/vea2owNkxjg9/dXFZLafwPafW8Ke+
         bYoQ==
X-Gm-Message-State: ACrzQf1c0E3L9DSN4U7MJi2TvTbuOPlk9Gg04pREGlC5+igMPePFEG6V
        ohnft8rFUXcv9Wjk1Q4AjDVp1A==
X-Google-Smtp-Source: AMsMyM4D5Cds7GBl8+AFUfKQgnpeAncPfaytOhkG/sYstKfcJ0vY6+n46ASI7xyiNOMDH3bdixG8Nw==
X-Received: by 2002:a17:903:20d3:b0:17c:8197:c4db with SMTP id i19-20020a17090320d300b0017c8197c4dbmr13517340plb.43.1664762171322;
        Sun, 02 Oct 2022 18:56:11 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090302c900b0017b69f99321sm5893786plk.219.2022.10.02.18.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 18:56:10 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 2/5] pwm: pxa: Set duty cycle to 0 when disabling PWM
Date:   Sun,  2 Oct 2022 18:55:43 -0700
Message-Id: <20221003015546.202308-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221003015546.202308-1-doug@schmorgal.com>
References: <20221003015546.202308-1-doug@schmorgal.com>
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
re-enabled next time, and also prevents the output pin from being stuck
high when the clock is disabled.

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

