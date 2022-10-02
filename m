Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02BAC5F2187
	for <lists+linux-pwm@lfdr.de>; Sun,  2 Oct 2022 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiJBGSl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 2 Oct 2022 02:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBGSi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 2 Oct 2022 02:18:38 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD574F18E
        for <linux-pwm@vger.kernel.org>; Sat,  1 Oct 2022 23:18:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id q7so78646pfl.9
        for <linux-pwm@vger.kernel.org>; Sat, 01 Oct 2022 23:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=schmorgal.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=258c6ilUlPgoCnjGUHRElR4sfuv4hNJ78FrbPm5zqZs=;
        b=UjAu+3OQeNTVLdeOmdTl5Ao6tdR6hRGlLPDqOTLL6XqCEc9ATl0Ek1KpmdqIhcUu5b
         EvejfpZmIL2rkB1EX4f+yLjwceYW8yilyAydxays6tmEqZUzJzYbDAdZXxNVPrRUMZzX
         i29q6WNLamJMeDhf5dGAhOvokdyy4W1hwC6t0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=258c6ilUlPgoCnjGUHRElR4sfuv4hNJ78FrbPm5zqZs=;
        b=Ate/eOSu467/q9xOO1QidlR0JZwpMmPGNvaTBZ/1IulkHa0dVnmmL6RO0iufRWK5qY
         z7boL+PrR26Ece12TAslerOcRAQVvcDN1AEpeh9camjo+AV4Vdz+7OLcbjMnc+HMCzRC
         pG/O7BCRHowvpnH4bLdwDmDF8TtrtYBxhLOt/GSUxBTjXzasUhME5m9dbdwOxv1WB+8W
         HUYMaudjqIsTYEFgkTxcld87qwwoUuBz6SqbMMNwd2CcwW11YOQa2cGcc3W3V3rN9JX7
         Ypp7RylVZKnWOGK0if0rIwR3jpJ/q+YYb8wnsJFgbK3F7WmpFlDmdFHjq+bWTjIMF358
         SBNA==
X-Gm-Message-State: ACrzQf3+omv9WchCkCRup0pMcDzD7D9FvsqB7UYzSsIt+JgR0k+i+WBb
        /m9PeiRLytun+TlGBj+TShYPbwuEqSt4l/G3TmQ=
X-Google-Smtp-Source: AMsMyM5tam0ndfZfj6CG3wABrXIbM5f16Aixq5no+frBnYe5ybMpuawFAs8i70j9y90yYvSb7a6cYg==
X-Received: by 2002:a05:6a00:198d:b0:548:bd77:69b1 with SMTP id d13-20020a056a00198d00b00548bd7769b1mr16752825pfl.20.1664691517115;
        Sat, 01 Oct 2022 23:18:37 -0700 (PDT)
Received: from doug-ryzen-5700G.. ([50.45.132.124])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a4bc100b00202aa2b5295sm6276242pjl.36.2022.10.01.23.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 23:18:36 -0700 (PDT)
From:   Doug Brown <doug@schmorgal.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, Doug Brown <doug@schmorgal.com>
Subject: [PATCH 1/2] pwm: pxa: Enable clock before applying config
Date:   Sat,  1 Oct 2022 23:15:51 -0700
Message-Id: <20221002061552.45479-2-doug@schmorgal.com>
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

The clock has to be on before we can apply the config anyway, so there
is no need to turn the clock on, off, and back on again.

This fixes an issue discovered on the PXA168 where sometimes the PWM
output doesn't activate properly if the clock is turned off and back on
too quickly. Removing the on/off/on sequence eliminates the problem.

Signed-off-by: Doug Brown <doug@schmorgal.com>
---
 drivers/pwm/pwm-pxa.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 0bcaa58c6a91..208c32c79453 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -64,7 +64,6 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long c;
 	unsigned long period_cycles, prescale, pv, dc;
 	unsigned long offset;
-	int rc;
 
 	offset = pwm->hwpwm ? 0x10 : 0;
 
@@ -86,18 +85,11 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		dc = mul_u64_u64_div_u64(pv + 1, duty_ns, period_ns);
 
-	/* NOTE: the clock to PWM has to be enabled first
-	 * before writing to the registers
-	 */
-	rc = clk_prepare_enable(pc->clk);
-	if (rc < 0)
-		return rc;
-
+	/* Clock is required here. We can assume it's already on. */
 	writel(prescale, pc->mmio_base + offset + PWMCR);
 	writel(dc, pc->mmio_base + offset + PWMDCR);
 	writel(pv, pc->mmio_base + offset + PWMPCR);
 
-	clk_disable_unprepare(pc->clk);
 	return 0;
 }
 
@@ -130,12 +122,17 @@ static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
+	if (!pwm->state.enabled) {
+		err = pxa_pwm_enable(chip, pwm);
+		if (err)
+			return err;
+	}
+
 	err = pxa_pwm_config(chip, pwm, state->duty_cycle, state->period);
-	if (err)
+	if (err) {
+		pxa_pwm_disable(chip, pwm);
 		return err;
-
-	if (!pwm->state.enabled)
-		return pxa_pwm_enable(chip, pwm);
+	}
 
 	return 0;
 }
-- 
2.34.1

