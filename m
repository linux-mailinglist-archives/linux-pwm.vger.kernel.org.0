Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C665523B
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Dec 2022 16:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiLWPil (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Dec 2022 10:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236496AbiLWPib (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Dec 2022 10:38:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA8B379C7
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:30 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id o5so4917307wrm.1
        for <linux-pwm@vger.kernel.org>; Fri, 23 Dec 2022 07:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cm/TO7B0tyKmT8Jf6pVEyA9+xhdR/M2AnOj4sg8YaBc=;
        b=BeyF3cXONbLGRq0/yp7g0f3PxK8p6Rkwqx8YxgSW6wiUCdu/6TYmu65L2fvqK9x645
         kOl0MXlqtQeZ/3Hx3sKYrVQCoGSQhkO4M1d1Dnfk4LsbTDHU3PokMHhyrPHjPsMw6U2M
         gb1TDp3OrtI1Gdd+CMl+85lFMbqwXOOGpeLI/MIJ4kt1e3bnhLVMs0l02pj9LvB5OX1R
         42z5ZMcD1N907DPmoA6XNtrFTYKEMlznIeAxLOeRufsCmCP4SyiECn/8jgXNfy+n2pZC
         RvaYJ/QR2st6/G2mYrSvQbtOxTXjklFyQdezg+/eJZaIJlLAJP9uovlVCpPc71ZrZUP7
         oUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cm/TO7B0tyKmT8Jf6pVEyA9+xhdR/M2AnOj4sg8YaBc=;
        b=XEZjiisD/0osoDBnGqaeSQLOBSjTAf5gU4XnZdjB1/V4Elx/CSimoodQY3zbrUcIRY
         MafxPjsQFJLFr8LsecNLTWdkPzEeyFeUJ3pDTN/Spe44sgedQNM4+spLv8tEYY6mKjwS
         T9nJEOYoHsP0ydByLtCjqZp8pr/B9TVm1QfL0nSrN165Ub72YyocM3R1VhbTfp2kXS/A
         ClYowVojLP8BCkJGXeG42k5oBlSJ1QMrYLB1ze6hH/BaVRj8FZXv65Xm4huqTUclxbtt
         uARG9D+fPkK28F+I16XgTSx5I4Rmh2clgpxoAlp1yumvoc1uJ2HJhYCCJvJ2LXkYToEO
         IImQ==
X-Gm-Message-State: AFqh2koxvg+PfclCXo4oy6V5u8SfQdqx53l1rM+R3a3qeY6fBNVbTdhx
        ovufHNc2I2rKqKCFwdQ+GS28UVOVeIvCfbvGwDNH8WJl8jkZH10OZfP5qUFRIyj/uW9F1Beezs1
        5OnPYfjkN0TZTduWsrqq58rmqD4CYNYsVyNEfEqWsslNLSdtXj9bmM8zL6/zqC1tvyec9SsTSX6
        S+Zw==
X-Google-Smtp-Source: AMrXdXt/zUwIBuhy7eWqFGzS6sGXwZ8amyW98qtrL54h7fzThyLliEmzzvMoMDB+pU/7AxCoMU04BQ==
X-Received: by 2002:a5d:438e:0:b0:241:94bc:26d3 with SMTP id i14-20020a5d438e000000b0024194bc26d3mr6795708wrq.49.1671809909826;
        Fri, 23 Dec 2022 07:38:29 -0800 (PST)
Received: from rainbowdash.. (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id m5-20020adfc585000000b00236488f62d6sm3491610wrg.79.2022.12.23.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 07:38:29 -0800 (PST)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-pwm@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH v7 07/10] pwm: dwc: make timer clock configurable
Date:   Fri, 23 Dec 2022 15:38:17 +0000
Message-Id: <20221223153820.404565-8-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221223153820.404565-1-ben.dooks@sifive.com>
References: <20221223153820.404565-1-ben.dooks@sifive.com>
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

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v7:
 - remove the "struct clk *" clk field from dwc_pwm_ctx, not used here,
v6:
 - removed DWC_CLK_PERIOD_NS as it is now not needed
v4:
 - moved earlier before the of changes to make the of changes one patch
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc.c | 9 +++++----
 drivers/pwm/pwm-dwc.h | 2 +-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 90a8ae1252a1..0c6beafa8c41 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -47,13 +47,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, DWC_CLK_PERIOD_NS);
+	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
 	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    DWC_CLK_PERIOD_NS);
+				    dwc->clk_ns);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -128,12 +128,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	duty = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	duty += 1;
-	duty *= DWC_CLK_PERIOD_NS;
+	duty *= dwc->clk_ns;
 	state->duty_cycle = duty;
 
 	period = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 	period += 1;
-	period *= DWC_CLK_PERIOD_NS;
+	period *= dwc->clk_ns;
 	period += duty;
 	state->period = period;
 
@@ -156,6 +156,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 68f98eb76152..b29d8cd21208 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -22,7 +22,6 @@
 #define DWC_TIMERS_COMP_VERSION	0xac
 
 #define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
 
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
@@ -41,6 +40,7 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.35.1

