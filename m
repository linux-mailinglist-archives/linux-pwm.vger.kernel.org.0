Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1E94105AC1
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfKUT7a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51193 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfKUT7S (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id l17so5126708wmh.0;
        Thu, 21 Nov 2019 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dU0M2wH1Fq0Elrc60MLP4chXO/aXp+1AHKdZUUUJPtM=;
        b=IdESNjVeRmiunPsFcAugnrxh20+dxe5lv7kRSV64Wr2vGmZ0je2ZM/TJrM+tFfGKMF
         mDCvmkj42vs0Xiyq/1y2cPiuR4a1Ziz38eQlYiI/20+W6OmeOw6NhlulJef6CdauIdeh
         aG73Q+3g1xxbuY/91JcQYVIBdA9jPaz5p9IjcQjxsBqfzxFxJNAXbgcI0fUdOLkVjNE+
         TGQnhYdmtcNkluGaVawvSgO0UYUndTBhz0jBJqsuox5KWL0lyh58hxaHfsJK318BYNb4
         UAPqDfFB3sxKgOPo/BLrh0hAmIbaALLEyV3g8mmSP90cy9PEF/YPDgQ3ExopBThSDT16
         WouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dU0M2wH1Fq0Elrc60MLP4chXO/aXp+1AHKdZUUUJPtM=;
        b=ahgLBV0TpiH9iipOYXeyOHqz7k2tLgLEE3XRlmcmfuTFbLjyccrKlC1RNeCebiL2Dn
         qXupGs7qwo6DIJSPfbhY8aCOSJgAIovYITCyhEZ7OoihlSyIwy93BpguAGfT/q/gdQb+
         pdjdelTUQzvF/oiTLwmdJuNQ1QNljRyTRuuBs0q/Kxh+BhzUcOwySv1y1ypL4q6CbPSb
         84PLufKiZje6sY5J5rU9RPoopzpqFofz/HHN38e9ocoosr6rSh4cSlmtIttpGOvcNON3
         4yrs0KQGu5vaHgjlJYau3lmNHw0KY0T+luNJE+H+btxs88IM9TJURttPy8Lq06+fTEQN
         aacA==
X-Gm-Message-State: APjAAAUY+pDgB1u+q6X338kSV0RJsRJBkydY5DwYVRHd12aLb1faYJgh
        R17FddwCzCk/IP8KEpuumnYjnkVtcpk=
X-Google-Smtp-Source: APXvYqwSaWX6MHEm+ebVVhdIFdmPfawuvHcc0h5bDCG8msobgwlDpoOWMdWS0YAVdAGdSBe6r5t9lA==
X-Received: by 2002:a1c:410a:: with SMTP id o10mr12354084wma.117.1574366355519;
        Thu, 21 Nov 2019 11:59:15 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:15 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v8 5/6] pwm: sun4i: Add support to output source clock directly
Date:   Thu, 21 Nov 2019 20:59:01 +0100
Message-Id: <20191121195902.6906-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191121195902.6906-1-peron.clem@gmail.com>
References: <20191121195902.6906-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

PWM core has an option to bypass whole logic and output unchanged source
clock as PWM output. This is achieved by enabling bypass bit.

Note that when bypass is enabled, no other setting has any meaning, not
even enable bit.

This mode of operation is needed to achieve high enough frequency to
serve as clock source for AC200 chip which is integrated into same
package as H6 SoC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1fa2057419fb..0fe9c680d6d0 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -3,6 +3,10 @@
  * Driver for Allwinner sun4i Pulse Width Modulation Controller
  *
  * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * Limitations:
+ * - When outputing the source clock directly, the PWM logic will be bypassed
+ *   and the currently running period is not guaranteed to be completed
  */
 
 #include <linux/bitops.h>
@@ -73,6 +77,7 @@ static const u32 prescaler_table[] = {
 
 struct sun4i_pwm_data {
 	bool has_prescaler_bypass;
+	bool has_direct_mod_clk_output;
 	unsigned int npwm;
 };
 
@@ -118,6 +123,20 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
+	/*
+	 * PWM chapter in H6 manual has a diagram which explains that if bypass
+	 * bit is set, no other setting has any meaning. Even more, experiment
+	 * proved that also enable bit is ignored in this case.
+	 */
+	if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
+	    sun4i_pwm->data->has_direct_mod_clk_output) {
+		state->period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
+		state->duty_cycle = DIV_ROUND_UP_ULL(state->period, 2);
+		state->polarity = PWM_POLARITY_NORMAL;
+		state->enabled = true;
+		return;
+	}
+
 	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
 	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler = 1;
@@ -149,13 +168,24 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 			       const struct pwm_state *state,
-			       u32 *dty, u32 *prd, unsigned int *prsclr)
+			       u32 *dty, u32 *prd, unsigned int *prsclr,
+			       bool *bypass)
 {
 	u64 clk_rate, div = 0;
 	unsigned int pval, prescaler = 0;
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
+	*bypass = sun4i_pwm->data->has_direct_mod_clk_output &&
+		  state->enabled &&
+		  (state->period * clk_rate >= NSEC_PER_SEC) &&
+		  (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
+		  (state->duty_cycle * clk_rate * 2 >= NSEC_PER_SEC);
+
+	/* Skip calculation of other parameters if we bypass them */
+	if (*bypass)
+		return 0;
+
 	if (sun4i_pwm->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
@@ -206,6 +236,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret;
 	unsigned int delay_us, prescaler;
 	unsigned long now;
+	bool bypass;
 
 	pwm_get_state(pwm, &cstate);
 
@@ -220,7 +251,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler);
+	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
+				  &bypass);
 	if (ret) {
 		dev_err(chip->dev, "period exceeds the maximum value\n");
 		spin_unlock(&sun4i_pwm->ctrl_lock);
@@ -229,6 +261,18 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 	}
 
+	if (sun4i_pwm->data->has_direct_mod_clk_output) {
+		if (bypass) {
+			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
+			/* We can skip other parameter */
+			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+			spin_unlock(&sun4i_pwm->ctrl_lock);
+			return 0;
+		} else {
+			ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
+		}
+	}
+
 	if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
 		/* Prescaler changed, the clock has to be gated */
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-- 
2.20.1

