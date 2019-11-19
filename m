Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D13C3102B23
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfKSRxs (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:48 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35486 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbfKSRxb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id s5so24972733wrw.2;
        Tue, 19 Nov 2019 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ftjDb5WxJHIC5enFSHC7KF6MbGREBXU1Fw5+H0zCqjU=;
        b=KU6LloSbgJbhjYz8glUYl+Sy4m+gnNNcLyWGIcxK70P9GMiRFSBG8ekzID6NeIA/zq
         BPEyrJnMqsuHoJvReby6/m6gUR2AH6GVpJoeY1R7ZSfGxZKHaqwEgVFnUqjv1RMm/Ki0
         nk2hE+4JO6vtQIjkKECkPC8dHsxlqKp+rjfgxJX4fA0XPmR/xrBlgi67Hc3X8xap4Vyz
         ZYyEXCa2UifXtDSvSIvvMqarH9tK0/T+Vc9ZWJUVAGjjY2r8UDLhDahH9Bc9BhSWVcEI
         o3i2u0zIBMx4C+W27D/hU/TJnCTHl9ONEEp+GEwJzYgmm5cCCifpiL+Hnx9mmDstu29e
         36Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ftjDb5WxJHIC5enFSHC7KF6MbGREBXU1Fw5+H0zCqjU=;
        b=NI459muNzshju6EXOrMZmIQJzBwZX7BV3yLVkDHDxOzDGb8nH8qWl//xhoskXCPiSu
         SPC6W/fC93+A8sofdD25t2+pf+d+CFE7MeLEJAxSfGsVm2qhELnhbRaoYOv7pOZl03cS
         iSp6XFm4DwweXcaQiKGYwd94KmryRhuIsNhbynNNJINWsKFRf3PHdKkewXZ7Dq7iHkh2
         lvQSQBdPGpEZaWARgAEHxnXos0/3wREmugSxikJzGCJnS4P5oLIxbB4qRJ1ifWzSjn7G
         Dx/SlKM6hLXvCeJwquzvjoPmN6PimD62zKLX5MYxRyDrYnjNn7RGeOScCuVNUId9xdcA
         A5wQ==
X-Gm-Message-State: APjAAAXGJPA9iG4RDeS9Tchy0rn8rXbqjkojL/TKva3mEtACW5mXmubP
        Ch8lyVG+/VtFR/txgjUEK404xCXM66Pe6Q==
X-Google-Smtp-Source: APXvYqz5E/Oxsl405HgiJg967Yp2OBUbbajWimUnFeUuLd8q6rxo8ERPQ3nx320aCcWVxgS0R2dCmQ==
X-Received: by 2002:a5d:4381:: with SMTP id i1mr3842117wrq.292.1574186007899;
        Tue, 19 Nov 2019 09:53:27 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:27 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v7 5/8] pwm: sun4i: Add support to output source clock directly
Date:   Tue, 19 Nov 2019 18:53:16 +0100
Message-Id: <20191119175319.16561-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
References: <20191119175319.16561-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 92 ++++++++++++++++++++++++++++-------------
 1 file changed, 64 insertions(+), 28 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index ce83d479ba0e..a1d8851b18f0 100644
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
@@ -149,13 +168,23 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 			       const struct pwm_state *state,
-			       u32 *dty, u32 *prd, unsigned int *prsclr)
+			       u32 *dty, u32 *prd, unsigned int *prsclr,
+			       bool *bypass)
 {
 	u64 clk_rate, div = 0;
 	unsigned int pval, prescaler = 0;
 
 	clk_rate = clk_get_rate(sun4i_pwm->clk);
 
+	*bypass = state->enabled &&
+		  (state->period * clk_rate >= NSEC_PER_SEC) &&
+		  (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
+		  (state->duty_cycle * clk_rate * 2 >= NSEC_PER_SEC);
+
+	/* Skip calculation of other parameters if we bypass them */
+	if (*bypass && sun4i_pwm->data->has_direct_mod_clk_output)
+		return 0;
+
 	if (sun4i_pwm->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
@@ -202,10 +231,11 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
-	u32 ctrl;
+	u32 ctrl, period, duty, val;
 	int ret;
-	unsigned int delay_us;
+	unsigned int delay_us, prescaler;
 	unsigned long now;
+	bool bypass;
 
 	pwm_get_state(pwm, &cstate);
 
@@ -220,43 +250,48 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if ((cstate.period != state->period) ||
-	    (cstate.duty_cycle != state->duty_cycle)) {
-		u32 period, duty, val;
-		unsigned int prescaler;
+	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
+				  &bypass);
+	if (ret) {
+		dev_err(chip->dev, "period exceeds the maximum value\n");
+		spin_unlock(&sun4i_pwm->ctrl_lock);
+		if (!cstate.enabled)
+			clk_disable_unprepare(sun4i_pwm->clk);
+		return ret;
+	}
 
-		ret = sun4i_pwm_calculate(sun4i_pwm, state,
-					  &duty, &period, &prescaler);
-		if (ret) {
-			dev_err(chip->dev, "period exceeds the maximum value\n");
-			spin_unlock(&sun4i_pwm->ctrl_lock);
-			if (!cstate.enabled)
-				clk_disable_unprepare(sun4i_pwm->clk);
-			return ret;
+	if (sun4i_pwm->data->has_direct_mod_clk_output) {
+		if (bypass) {
+			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
+			/* We can skip apply of other parameters */
+			goto bypass_mode;
+		} else {
+			ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
 		}
+	}
 
-		if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
-			/* Prescaler changed, the clock has to be gated */
-			ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-
-			ctrl &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
-			ctrl |= BIT_CH(prescaler, pwm->hwpwm);
-		}
+	if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
+		/* Prescaler changed, the clock has to be gated */
+		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+		sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
-		val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
-		sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-		sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-			usecs_to_jiffies(cstate.period / 1000 + 1);
-		sun4i_pwm->needs_delay[pwm->hwpwm] = true;
+		ctrl &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
+		ctrl |= BIT_CH(prescaler, pwm->hwpwm);
 	}
 
+	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
+	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
+	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
+		usecs_to_jiffies(cstate.period / 1000 + 1);
+	sun4i_pwm->needs_delay[pwm->hwpwm] = true;
+
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 	else
 		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 
 	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+
 	if (state->enabled) {
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
 	} else if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
@@ -264,6 +299,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
 
+bypass_mode:
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
 	spin_unlock(&sun4i_pwm->ctrl_lock);
-- 
2.20.1

