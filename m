Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDCF5F2188
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Oct 2022 08:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiJBGSp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBGSo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 02:18:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F7E4F18E
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 23:18:42 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id w2so7689705pfb.0
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JygOsF2A3C/k9yqqeU23bDjFlU/HrMWA2w+1Wjpfh0Q=;
        b=QsSekMB6e/FrjTg6TkilMsOZzk77Izam2mGaBFhHTqYD4q8VassOqt5wd0e4bV5Wby
         bb505OtjNypGGtABacgXmVpN5Ba1Qklbwb6uNf33RlHWLrS2iLhF+tQsIJOdswDH8kIM
         tccwyp/Ylh9iL1edZGvgSACgC7/u5+RVeplGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JygOsF2A3C/k9yqqeU23bDjFlU/HrMWA2w+1Wjpfh0Q=;
        b=MCYGZHv1gDnUchoUuVtSOMriKZV0zT6Lm/KD4HZBalr6CNuXWiizjlWzBP6DetHe2n
         BV77c22BedviePxc6UCHlP38FRJL167eEPZfXCnulhPdSSP5gU263idmnQ0O7f+SCzZh
         2KVDZuQhsJEDb0IGFz7fFCMo1obEv4jLlNwHcA0y7eN3HJcRP/w+dA4mYOlbxoDPg7kh
         WttrwvF2UZi6mWXx5mcbmQ6O5V0cKRNh4QwTv0dNPrASMuqzT7EvFA4lcy/xO1zJxGyB
         th38AyHLTTjJ1ED87yNUAW85OTbyjavzL1nVnd96HPvihX2VvZ1WVHQsxlRVEnSPar5w
         d0gA==
X-Gm-Message-State: ACrzQf1mrd6KIac+ug/BOLebXzL9P043ZcSabkHC1lPs/tNMu5ywvsWd
        lo84MKk8VqyATigtobtain9asw==
X-Google-Smtp-Source: AMsMyM5pTPC9sghUzT5s+SZlqPGQ+MP/FjvhL+w095ZxymOXEX8GvufeRlUTd3mYVKCzTN6Y+dMAUQ==
X-Received: by 2002:a63:d40b:0:b0:43b:e86f:d384 with SMTP id a11-20020a63d40b000000b0043be86fd384mr13830414pgh.167.1664691522232;
        Sat, 01 Oct 2022 23:18:42 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a4bc100b00202aa2b5295sm6276242pjl.36.2022.10.01.23.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:18:41 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH 2/2] pwm: pxa: Set duty cycle to 0 before disabling
Date:   Sat,  1 Oct 2022 23:15:52 -0700
Message-Id: <20221002061552.45479-3-doug@schmorgal.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002061552.45479-1-doug@schmorgal.com>
References: <20221002061552.45479-1-doug@schmorgal.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Turning off the clock doesn't guarantee that the pin will be left in a
low state. Set the duty cycle to 0 first to force it to turn off.

Without this fix, the PWM peripheral on a PXA168 was observed to
randomly leave the PWM pin high after attempting to turn it off,
especially when the duty cycle was set to 100%.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 208c32c79453..d426e4f17241 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -103,6 +103,12 @@ static int pxa_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
+	unsigned long offset = pwm->hwpwm ? 0x10 : 0;
+
+	/* Ensure the duty cycle is set to 0 before turning off the clock.
+	 * Otherwise, the PWM pin might stay high.
+	 */
+	writel(0, pc->mmio_base + offset + PWMDCR);
 
 	clk_disable_unprepare(pc->clk);
 }
-- 
2.34.1

