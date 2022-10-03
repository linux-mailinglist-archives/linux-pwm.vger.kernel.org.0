Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42C35F278C
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Oct 2022 03:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJCB4M (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 21:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiJCB4K (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 21:56:10 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99B72F3B0
        for <linux-pwm@vger.kernel.org>; Sun,  2 Oct 2022 18:56:09 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 2so2991673pgl.7
        for <linux-pwm@vger.kernel.org>; Sun, 02 Oct 2022 18:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tyRZJiGNGhZCYmFyedxmd9CLmdLq3Eb4RejqlovZlyY=;
        b=k8qS/UZ1+rsoS3ztDJLqwm17+yKdkR5+k7M09eiy0HBI5wmS+G6Sg+UINPKPdSqATZ
         ICxogbBKlFu8ZrSUuqBTeBJZo42n/cCBSBGM96Zz9mm1USJbJnlh9SzI8oLsSvRr1gyA
         jX6v65/LBzRi5wP/Za3gaohYQ92Hukti+Q18I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tyRZJiGNGhZCYmFyedxmd9CLmdLq3Eb4RejqlovZlyY=;
        b=DrmkHJn/4rmPZI4EzEhIKVxbv3SRtSI5aCwV5TU7Ql1qwKSmGO6XWatwoQ+O2nRxYH
         qKFTfB6bVtBrlIejZ8EE++nlcr5gvJ5CfnmQIZ4ilp/zNUFkmulFzGUjQueWUEwGQ/J/
         oTsmqzIQNXovDi05EikfHv7WALGIhCUFD/2TT18qFm9vti9yvZG41GST7vBOkbFK0LKm
         Kg38bMOmTgjOloYSEe+ObgghPLxxbgYBDg3XfBOOiOPOSQbPHpIKfztxd1gPaC6m8Bxf
         3IGlwCy8qMywKMlcOpsSjzTuTTKFEpgRS7YJaYZBYaonEhC2OKlFmkbGHaXgV24rzPBT
         DBlA==
X-Gm-Message-State: ACrzQf3KhiXwA3CegtRpXESTS6Hmm6BNihxIap3ldri6UevXWHyWKg9S
        jhO87MjIZA92RBPjpGX7W3H5tg==
X-Google-Smtp-Source: AMsMyM7N97opSj/bdIFuudsFEOEPr38aqXrKckRbhtRuOTZnqTO134PCK4rWfCrSciU5jxZQ2rjbVw==
X-Received: by 2002:a63:f057:0:b0:438:5c6c:de26 with SMTP id s23-20020a63f057000000b004385c6cde26mr16335902pgj.509.1664762169246;
        Sun, 02 Oct 2022 18:56:09 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id s9-20020a17090302c900b0017b69f99321sm5893786plk.219.2022.10.02.18.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 18:56:08 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH v2 1/5] pwm: pxa: Remove pxa_pwm_enable/disable
Date:   Sun,  2 Oct 2022 18:55:42 -0700
Message-Id: <20221003015546.202308-2-doug@schmorgal.com>
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

These functions are only acting as wrappers for clk_prepare_enable and
clk_disable_unprepare now, so remove them to simplify the driver.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Doug Brown <doug@schmorgal.com>
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

