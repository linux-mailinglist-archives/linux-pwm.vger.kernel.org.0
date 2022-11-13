Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A50627382
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Nov 2022 00:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiKMXgu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 13 Nov 2022 18:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiKMXgt (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 13 Nov 2022 18:36:49 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F2CCE2A
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id y13so9534845pfp.7
        for <linux-pwm@vger.kernel.org>; Sun, 13 Nov 2022 15:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA/+4JMPRi8hzrqhKnb+aNk6xu53Qw2sorxsmEi56VU=;
        b=Xf9X45awjbJNSpsDPfBC83agtjxVHdqLMoQfyEgGCoXXj+KeZ+g4OG4SK1JtHXQF90
         mkVV2rugqxlucXdjV+wc5BrM4YXHsmNtCG5twavjl9dTfwE+ItITVXCocJRc/PHOxrG3
         gHgRoKuhFIEOuYg4uKGk8FjMD79AmS+oEJm+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JA/+4JMPRi8hzrqhKnb+aNk6xu53Qw2sorxsmEi56VU=;
        b=41JOjcs1KaoPnRcmD3bgfBBtpxHc4q8GarQfMHeBrQGEKe3EXIDMbjnhAdM28+UE8N
         ztJm7ELvdZwsSH1P6EzXPFqvTEaikQEZWJwfofCQ4jjpWVsIjb/gh1pNhmEzQeITy4Ab
         ladXAn942j/DhIy81ZpmU2en7A7tSHA2gbb/xod5lhnK70xjZg5OI7w1fnCrrlZqua3F
         v8pJkeZu6f+DfPvaFjwB2uPEn4UIIn418ZKaiIwYbqR2+Qdq6HJdvKfqdF9YR9idF8jr
         2aibf9PUOX1yAi5ZZkq+DtXXPOB4nHrkzLV/M2Pd4MacATYmRC2aLCNB7kc/KC5ElpD8
         /7EA==
X-Gm-Message-State: ANoB5pm/hxiSN8ZAOsucvvcY811Guayv2lUGgP3EQclePeduhNq+ZT0u
        EjHuVaqPD92ttasDRm/bZyFwZg==
X-Google-Smtp-Source: AA0mqf5KvSQyeSjCTq81bEOOgNGz4J9swD5nmNFm00/d9u3Y2gVdEYY4JTETsDUjT2fy0FEcCVkWbQ==
X-Received: by 2002:a63:4509:0:b0:46f:b6df:3107 with SMTP id s9-20020a634509000000b0046fb6df3107mr9851086pga.454.1668382608577;
        Sun, 13 Nov 2022 15:36:48 -0800 (PST)
Received: from doug-ryzen-5700G.. ([192.183.212.197])
        by smtp.gmail.com with ESMTPSA id q14-20020a635c0e000000b004597e92f99dsm4641990pgb.66.2022.11.13.15.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 15:36:47 -0800 (PST)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v3 1/6] pwm: pxa: Remove pxa_pwm_enable/disable
Date:   Sun, 13 Nov 2022 15:36:34 -0800
Message-Id: <20221113233639.24244-2-doug@schmorgal.com>
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

These functions are only acting as wrappers for clk_prepare_enable and
clk_disable_unprepare now, so remove them to simplify the driver.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Doug Brown <doug@schmorgal.com>
Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-pxa.c | 19 +++----------------
 1 file changed, 3 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 0bcaa58c6a91..0ac052652c62 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -101,23 +101,10 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	return 0;
 }
 
-static int pxa_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
-
-	return clk_prepare_enable(pc->clk);
-}
-
-static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
-{
-	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
-
-	clk_disable_unprepare(pc->clk);
-}
-
 static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
+	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
 	int err;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -125,7 +112,7 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (!state->enabled) {
 		if (pwm->state.enabled)
-			pxa_pwm_disable(chip, pwm);
+			clk_disable_unprepare(pc->clk);
 
 		return 0;
 	}
@@ -135,7 +122,7 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return err;
 
 	if (!pwm->state.enabled)
-		return pxa_pwm_enable(chip, pwm);
+		return clk_prepare_enable(pc->clk);
 
 	return 0;
 }
-- 
2.34.1

