Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20C60641C
	for <lists+linux-pwm@lfdr.de>; Thu, 20 Oct 2022 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiJTPQo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 20 Oct 2022 11:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiJTPQh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 20 Oct 2022 11:16:37 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F0814D8EE
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:16:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id bp11so35068796wrb.9
        for <linux-pwm@vger.kernel.org>; Thu, 20 Oct 2022 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuQJZUiYgsrv6ydPrE/ryH64TRoc2yWi4dM3ARWJNR4=;
        b=OpNhgpcgc+bvyMCS9w1f7Nn/hKXTVvUQ01wUJjJEGILMrVjMNMyPejXJxPZefBot12
         WngBSqCRmFckEm/rCYtFa4ofTEd+qAgHT8PHePBwmUFQN5RjqMdCSK25roKz3ipp5heI
         TXPc3AzeseMJJ9N+yQm2VV9QY7IQ2tEVnr3PauM0cGFBDIFOtSxGxvDNR8aYbq67j7uu
         yuUaSxPr5ybYFz33BzxFfviJ5ZowCJl7HBhINPRPfM7j4MKnar9nV6F4ZR9GXvChdobc
         r5WHUVSgsWsdB0eYDqASe5Aco2SNy7QLMv7gNwZUD4pr6HIm46AxJ5aOmSn+dRK8MWim
         PGMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuQJZUiYgsrv6ydPrE/ryH64TRoc2yWi4dM3ARWJNR4=;
        b=wPld2k+2vZRgjPU+JoDp0IknC7MhvpuFZrO0xLB+i6ximuC2uc06jnlUFl54eHNsoZ
         XvWgrx2Fi/iOz7CJDTKVYhf2y/HSBqNfK05Ew4i+Hch8dgcDe0QamZEsQGijqxS5I6Xl
         cC5hDFQ6XpuGgfp/Sq+Hnd4HAyj0hNltgGwNzYUtob8n8bJUK1dEKITfGoIdrA7INfNN
         q8sSNWTj4oe48ioiqar3iOj1/666h4l0gbckE1pAiKBPVtMOOyr87DUYzLW/5ao8boRQ
         eJhgUy2YHu6fNNb94MTsZ3glngiK9/AFZ4ek1k339P/YhVDohaPIXtdvvovgXYp5n2KV
         N01g==
X-Gm-Message-State: ACrzQf3Jn1YXKJ/7QpekyHctwww5/xk8d505lxVuqYCV6KAAXSCpEuVH
        Vcm5dr0jNyybtJJlcEz22HbA347TXTsWIw4ud+2OV+SIWY5yBjjGD4m5WsM5l7phjFCjCVXF8XY
        jT+zQ61V2I9ckTXRJ74nf5EqO0nvzz6BDZeMNjSM4srqGTc6xa8iogSU6gxgsmvtFXfFV28Ovpn
        g=
X-Google-Smtp-Source: AMsMyM46jl0F6OKvj0lpYAHCOdk2lOG0bWny8+1+IlJ4fSOSWTFQt+urAWWQviWKkMCti3yp9aVAxQ==
X-Received: by 2002:a05:6000:1689:b0:22e:2c03:36e7 with SMTP id y9-20020a056000168900b0022e2c0336e7mr9570319wrd.252.1666278985516;
        Thu, 20 Oct 2022 08:16:25 -0700 (PDT)
Received: from rainbowdash.guest.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id bg6-20020a05600c3c8600b003c6f3e5ba42sm41362wmb.46.2022.10.20.08.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 08:16:24 -0700 (PDT)
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
Subject: [PATCH v6 10/10] pwm: dwc: use clock rate in hz to avoid rounding issues
Date:   Thu, 20 Oct 2022 16:16:10 +0100
Message-Id: <20221020151610.59443-11-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020151610.59443-1-ben.dooks@sifive.com>
References: <20221020151610.59443-1-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As noted, the clock-rate when not a nice multiple of ns is probably
going to end up with inacurate caculations, as well as on a non pci
system the rate may change (although we've not put a clock rate
change notifier in this code yet) so we also add some quick checks
of the rate when we do any calculations with it.

Signed-off-by; Ben Dooks <ben.dooks@sifive.com>
Reported-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc-of.c |  2 +-
 drivers/pwm/pwm-dwc.c    | 29 ++++++++++++++++++++---------
 drivers/pwm/pwm-dwc.h    |  2 +-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-of.c b/drivers/pwm/pwm-dwc-of.c
index c5b4351cc7b0..5f7f066859d4 100644
--- a/drivers/pwm/pwm-dwc-of.c
+++ b/drivers/pwm/pwm-dwc-of.c
@@ -50,7 +50,7 @@ static int dwc_pwm_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(dwc->clk),
 				     "failed to get timer clock\n");
 
-	dwc->clk_ns = NSEC_PER_SEC / clk_get_rate(dwc->clk);
+	dwc->clk_rate = clk_get_rate(dwc->clk);
 	return devm_pwmchip_add(dev, &dwc->chip);
 }
 
diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 5ef0fe7ea3e9..f48a6245a3b5 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -43,18 +43,22 @@ static int __dwc_pwm_configure_timer(struct dwc_pwm *dwc,
 	u32 high;
 	u32 low;
 
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
 	/*
 	 * Calculate width of low and high period in terms of input clock
 	 * periods and check are the result within HW limits between 1 and
 	 * 2^32 periods.
 	 */
-	tmp = DIV_ROUND_CLOSEST_ULL(state->duty_cycle, dwc->clk_ns);
+	tmp = state->duty_cycle * dwc->clk_rate;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	low = tmp - 1;
 
-	tmp = DIV_ROUND_CLOSEST_ULL(state->period - state->duty_cycle,
-				    dwc->clk_ns);
+	tmp = (state->period - state->duty_cycle) * dwc->clk_rate;
+	tmp = DIV_ROUND_CLOSEST_ULL(tmp, NSEC_PER_SEC);
 	if (tmp < 1 || tmp > (1ULL << 32))
 		return -ERANGE;
 	high = tmp - 1;
@@ -120,6 +124,7 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			      struct pwm_state *state)
 {
 	struct dwc_pwm *dwc = to_dwc_pwm(chip);
+	unsigned long clk_rate;
 	u64 duty, period;
 	u32 ctrl, ld, ld2;
 
@@ -129,22 +134,28 @@ static void dwc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 	ld = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(pwm->hwpwm));
 	ld2 = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT2(pwm->hwpwm));
 
+	if (dwc->clk)
+		dwc->clk_rate = clk_get_rate(dwc->clk);
+
+	clk_rate = dwc->clk_rate;
 	state->enabled = !!(ctrl & DWC_TIM_CTRL_EN);
 
 	/* If we're not in PWM, technically the output is a 50-50
 	 * based on the timer load-count only.
 	 */
 	if (ctrl & DWC_TIM_CTRL_PWM) {
-		duty = (ld + 1) * dwc->clk_ns;
-		period = (ld2 + 1)  * dwc->clk_ns;
+		duty = ld + 1;
+		period = ld2 + 1;
 		period += duty;
 	} else {
-		duty = (ld + 1) * dwc->clk_ns;
+		duty = ld + 1;
 		period = duty * 2;
 	}
 
-	state->period = period;
-	state->duty_cycle = duty;
+	duty *= NSEC_PER_SEC;
+	period *= NSEC_PER_SEC;
+	state->period = DIV_ROUND_CLOSEST_ULL(period, clk_rate);
+	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(duty, clk_rate);
 	state->polarity = PWM_POLARITY_INVERSED;
 
 	pm_runtime_put_sync(chip->dev);
@@ -164,7 +175,7 @@ struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
 	if (!dwc)
 		return NULL;
 
-	dwc->clk_ns = 10;
+	dwc->clk_rate = NSEC_PER_SEC / 10;
 	dwc->chip.dev = dev;
 	dwc->chip.ops = &dwc_pwm_ops;
 	dwc->chip.npwm = DWC_TIMERS_TOTAL;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index dc451cb2eff5..19bdc2224690 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -41,7 +41,7 @@ struct dwc_pwm {
 	struct pwm_chip chip;
 	void __iomem *base;
 	struct clk *clk;
-	unsigned int clk_ns;
+	unsigned long clk_rate;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
 #define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
-- 
2.35.1

