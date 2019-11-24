Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE428108458
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbfKXRaR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:17 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfKXRaN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:13 -0500
Received: by mail-wr1-f67.google.com with SMTP id z10so14635614wrs.12;
        Sun, 24 Nov 2019 09:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cYsxEdpSqsCpJgRGtsBvxG3DA2QGQ1mItmXFyJ8ZZGg=;
        b=kkUrmLRkmIfdWLL6w/h0QyoF7udOjF3phgyUsR+YWArdacOGLGdCniDOksWCVoZFSy
         z6yU7bDpx1uEdjUt8IvXO6g3OUdA2zdV4YEJzkLsuobQljI032YhhdHOl69Txf/OSjLY
         1FwOk7zQt1gV9mYfE5zUmTQfGnUWB0A8VgYrJfj6h7AzyRzbDg5B7Js4Ez8PCWZ1rZUp
         Bn1H8ZCv3x3q9TPisf87WZhjQUxsYJuwya7coKvvE3mMOPM/SptkOQOy9qFHYZEdOXcL
         XPjMc/f2tbWRGDCl9RTWr/7qmDal2bfHqZLCiV11/RzjwFAf9nr6hHuyNPc0FYb5joLa
         Oigg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cYsxEdpSqsCpJgRGtsBvxG3DA2QGQ1mItmXFyJ8ZZGg=;
        b=Cx9ulCK2ocL+USfJr98zUPh1RnzSvwJaDANLp1RfqblubQGrPPMoQj3WTfwt4Jnm+D
         sILfeOx/0VzCLeYfnbLLDnGlKzjcIrg0oPU+mNdDyGrwgKKXuD9Rq62+Hh486sIfId/C
         ZaC6dR0rb/z7eDePg4odT5jeXVSiclg/wUA2dVe/bPo6la+zzBzx4uezJin9Z8Y6ARW3
         KIu59TA3RxseN8wVp6+LWIN6EUXOM/9s5ge7zVTWpD6WzUK3SxKiZ7jSv007zBfqgu22
         j9IrQ9FSrCdFbWp1/lcInMIqg+D7vAaczChVwEJX/EQVQfGyEEd+ZrGlZTASjVqdTmsI
         EWyA==
X-Gm-Message-State: APjAAAWPjamPvH3JHVQn7Bg8Lqk8CJyG2hkVqUW8wz6U2BJoyfCsaGT/
        fp/SHmqDAywjSs8JepdpEL4=
X-Google-Smtp-Source: APXvYqwCZi9drjwqTATokBd8OlqQMDrv0PDPmqd39pwuNlCSVUPsD7CLPyfOCfi/vBeE0I29ZxUZTg==
X-Received: by 2002:adf:afc2:: with SMTP id y2mr9835759wrd.254.1574616609723;
        Sun, 24 Nov 2019 09:30:09 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:30:09 -0800 (PST)
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
Subject: [PATCH v9 5/6] pwm: sun4i: Add support to output source clock directly
Date:   Sun, 24 Nov 2019 18:29:07 +0100
Message-Id: <20191124172908.10804-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191124172908.10804-1-peron.clem@gmail.com>
References: <20191124172908.10804-1-peron.clem@gmail.com>
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
index e369b5a398f4..07bf7be6074b 100644
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

