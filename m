Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE76A58AE76
	for <lists+linux-pwm@lfdr.de>; Fri,  5 Aug 2022 18:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiHEQux (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 5 Aug 2022 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiHEQuu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 5 Aug 2022 12:50:50 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4B01BEB6
        for <linux-pwm@vger.kernel.org>; Fri,  5 Aug 2022 09:50:48 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b6so1653581wmq.5
        for <linux-pwm@vger.kernel.org>; Fri, 05 Aug 2022 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=xtgPxFLwZi/ozmv/dKYJFl8mhw/7WaaIbNbRSLG6I4E=;
        b=P7qv2wQrbujU2+Ct2z5eGGgnDRDKYBtYxyKk/LhObJLXBCxZpQ8PVxTvsLL2OciOnw
         PjM4AZZf0umyZueaHTX0UwY+OAOXg9VYwiPlNvDHPbijtykL2f+scdlH1RkBiQwgl1DB
         ycKUbNDcAM1Q6iGKkOV6BAqF4nh3zaR2FoDzWqWSNgMdRhpGZDtpcpc9f5WCx8C+dWKt
         0tFPU13DOSInoQiKqrfCoNqUTL2r1FOLdY3AitJdocgumVn/gpT91ljJOq1dCvtMJmTN
         Tzt+Z4C7IDSRMPLptBcx8BNr39tB/8JCmFRvzC1KBE0do2hHPf4fiLUlaaq0uni5BEqB
         n3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=xtgPxFLwZi/ozmv/dKYJFl8mhw/7WaaIbNbRSLG6I4E=;
        b=GBXt5tZZrlG5XeGgQTUYVDfznh1uYcfAIzmsSwTwyPwLwF7YOGvXJtGFCWlY9WKT7f
         Pq+JOtzqpVpeaf7vioeQiJ4ghbYSPU6KmYNk/0moFX3Ps7/8RXCMmQJPsSc1QWB6t4J3
         OHHwC1sktvu0itqnjoxnYBDdNsoVICXux8DV9L6NeBm58lSV4mlYx9mjSkM4Ql28o+rw
         SqiSuESD+dVSZs0TwC8Y3yJv2ZIGhR8rYDebyvIwGaGIqEOcUD0l3lX8rSWniFulHKdj
         ebQ25PP/l8PdAZ5RjL3GxBnydc+m44yHwv2nXsqWPyVylTrRRjD+eGUVdVveI2u3Apav
         ApgA==
X-Gm-Message-State: ACgBeo2Grb7buhUm2W/aDEHOFF8QBv5mtvA4g+xgA+rRN5DT94nCE7s6
        RU2h73ZgS3JgeIAMS55ZFHcdovU41AX2LEEa
X-Google-Smtp-Source: AA6agR7ARuXIJSEwDQX/+7fSmp2PM7Ulf7L2hECWM0MxrfrcAEn/nH3j6wZb0OVTkKTZzU3gdyCzHg==
X-Received: by 2002:a05:600c:1f13:b0:3a3:3f0d:d9d4 with SMTP id bd19-20020a05600c1f1300b003a33f0dd9d4mr10369535wmb.4.1659718248235;
        Fri, 05 Aug 2022 09:50:48 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id h28-20020a05600c2cbc00b003a4f08495b7sm11325374wmc.34.2022.08.05.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 09:50:47 -0700 (PDT)
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
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH 6/8] pwm: dwc: add timer clock
Date:   Fri,  5 Aug 2022 17:50:31 +0100
Message-Id: <20220805165033.140958-7-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220805165033.140958-1-ben.dooks@sifive.com>
References: <20220805165033.140958-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add a configurable clock base rate for the pwm as when being built
for non-PCI the block may be sourced from an internal clock.

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
v2:
  - removed the ifdef and merged the other clock patch in here
---
 drivers/pwm/pwm-dwc.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index d5f2df6fee62..5c319d0e3d52 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/pwm.h>
@@ -35,7 +36,6 @@
 #define DWC_TIMERS_COMP_VERSION	0xac
 
 #define DWC_TIMERS_TOTAL	8
-#define DWC_CLK_PERIOD_NS	10
 
 /* Timer Control Register */
 #define DWC_TIM_CTRL_EN		BIT(0)
@@ -54,6 +54,8 @@ struct dwc_pwm_ctx {
 struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
+	struct clk *clk;
+	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
@@ -96,13 +98,13 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
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
@@ -177,12 +179,12 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
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
 
@@ -205,6 +207,7 @@ static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
+	dwc->clk_ns = 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
@@ -336,6 +339,14 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(dwc->base),
 				     "failed to map IO\n");
 
+	dwc->clk = devm_clk_get(dev, "timer");
+	if (IS_ERR(dwc->clk))
+		return dev_err_probe(dev, PTR_ERR(dwc->clk),
+				     "failed to get timer clock\n");
+
+	clk_prepare_enable(dwc->clk);
+	dwc->clk_ns = 1000000000 / clk_get_rate(dwc->clk);
+
 	ret = pwmchip_add(&dwc->chip);
 	if (ret)
 		return ret;
@@ -347,6 +358,7 @@ static int dwc_pwm_plat_remove(struct platform_device *pdev)
 {
 	struct dwc_pwm *dwc = platform_get_drvdata(pdev);
 
+	clk_disable_unprepare(dwc->clk);
 	pwmchip_remove(&dwc->chip);
 	return 0;
 }
-- 
2.35.1

