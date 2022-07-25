Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07262580667
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Jul 2022 23:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiGYVW0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Jul 2022 17:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237235AbiGYVWU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Jul 2022 17:22:20 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D032409A
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:22:13 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso7092139wmq.3
        for <linux-pwm@vger.kernel.org>; Mon, 25 Jul 2022 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1Xv9gQUnkJbk4F0OgYMl9FyP7zMBpFHCpf4m5lSD++Y=;
        b=ivbkCy0wsckrV/txZ+aJp6OOzD/sPW9WjPS6qiSWEb2SIXh8+j6qesfb3L7a1wzyft
         r2WHGfpvGpoVRgfL5Hvf9sddCVsXcWQO0/EBJJFuzw4EveXx9oH3DAcyv5apuOfJWMEM
         io7F870QmdYxTa8KEvnPFasNVVpKM0KSqFxjqVpAPIXkLs3mXGBPq8Qdt9+9EMb/Ug/V
         6U7mMQ1lJOmX8R7LWAeffugpwdKpC1Fj/d12wrtwclxjxQtSntZPXYELTH1pREAeDxXp
         qElCj0UJbtTQLtjLaIhd7GJ1v0ulKvdUSD09Wok2TeFaNXU9AM+ap7Sbp96QjeFoBfoO
         E1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1Xv9gQUnkJbk4F0OgYMl9FyP7zMBpFHCpf4m5lSD++Y=;
        b=FvjayirGbNGW0UxoGunFtkqqYA51aRzzF/W7j+g1zZp7pS/m9h6n4E6B6ElbULFilY
         7iLfC85eSYjd1cWOy3VSfpq2N1LbeGVZx8s3/3j09o8jlv2O5IcWOYgzQGsSzWDHTWQo
         Ax+6oDjMkXVfCAOS6nhtUCnsLi3hF1IbYO+DWeh+ves/rFBnTSJJN9plzZeFyP2WkqaX
         1/fy4pJYiYT0/t+/xAXr6iUYMKfHX6PlUNHB04gNZki/VUXycEEeg5FMKfr710MCxD2z
         nxUN2MsQ7WIM3IL/nti5QSJTJs7ILhb0FhKp3umaHFhxaLxsuU269dRV9RZdVxbqV82k
         97yw==
X-Gm-Message-State: AJIora+3xtY8tPdp9cac/KKvx9CAKMxyUC+lhdlRFS0NgxUjeGsG0CzO
        tD44XUl5c5PYFRY96AQGzrdWpgqqaSmtWg==
X-Google-Smtp-Source: AGRyM1uLuV02EtjkgpPz+Fd0i4C4ji98axhqBws+TSbQOnuMNuWRKknmpRfWjZ1y7wRdU+uE9fCsLQ==
X-Received: by 2002:a05:600c:284a:b0:3a2:ffb7:b56f with SMTP id r10-20020a05600c284a00b003a2ffb7b56fmr22459114wmb.134.1658784131994;
        Mon, 25 Jul 2022 14:22:11 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id i13-20020a05600011cd00b0021d6924b777sm12656348wrx.115.2022.07.25.14.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 14:22:11 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [[PATCH v2] 9/9] pwm: dwc: add PWM bit unset in get_state call
Date:   Mon, 25 Jul 2022 22:21:40 +0100
Message-Id: <20220725212140.741644-9-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220725212140.741644-1-ben.dooks@sifive.com>
References: <20220725212140.741644-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If we are not in PWM mode, then the output is technically a 50%
output based on a single timer instead of the high-low based on
the two counters. Add a check for the PWM mode in dwc_pwm_get_state()
and if DWC_TIM_CTRL_PWM is not set, then return a 50% cycle.

This may only be an issue on initialisation, as the rest of the
code currently assumes we're always going to have the extended
PWM mode using two counters.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 drivers/pwm/pwm-dwc.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index da325133d297..f3723c4d1e59 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -171,23 +171,35 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	u64 duty, period;
+	u32 ctrl, ld, ld2;
 
 	pm_runtime_get_sync(chip->dev);
 
-	state->enabled = !!(dwc_pwm_readl(dwc,
-				DWC_TIM_CTRL(pwm->hwpwm)) & DWC_TIM_CTRL_EN);
+	ctrl = dwc_pwm_readl(dwc, DWC_TIM_CTRL(pwm->hwpwm));
+	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
+	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
-	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
-	duty += 1;
-	duty *= dwc->clk_ns;
-	state->duty_cycle = duty;
+	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
-	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
-	period += 1;
-	period *= dwc->clk_ns;
-	period += duty;
-	state->period = period;
+	/* If we're not in PWM, technically the output is a 50-50
+	 * based on the timer load-count only.
+	 */
+	if (ctrl & DWC_TIM_CTRL_PWM) {
+		duty = ld;
+		duty += 1;
+		duty *= dwc->clk_ns;
+
+		period = ld2;
+		period += 1;
+		period *= dwc->clk_ns;
+		period += duty;
+	} else {
+		duty = (ld + 1) * dwc->clk_ns;
+		period = duty * 2;
+	}
 
+	state->period = period;
+	state->duty_cycle = duty;
 	state->polarity = PWM_POLARITY_INVERSED;
 
 	pm_runtime_put_sync(chip->dev);
-- 
2.35.1

