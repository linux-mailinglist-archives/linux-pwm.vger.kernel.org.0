Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB895ED4A2
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfKCUdy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:33:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36310 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbfKCUdx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:53 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so13985479wmd.1;
        Sun, 03 Nov 2019 12:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3v88dggHcBZfZorIEJteI6G3MHHzRcAhgG+sL5blC4=;
        b=K7kfdeNHzvQ40s6dcM9hHjArKts5wA8WUiKHKpUWwDoPJBJhex1hsOvcQ0ZAmJOW8R
         4r55bIj1j3IJT/LDEUuqbOlTVx3+Ies1MjK3Ww3J/Fs9jYPrWVfL71znvG7qW0UMu44S
         xAGy2mkKurbJDZCBMAGabvomD/5tdtZHWwkvVGssSR1LQUl84QQd08RI1IyBRkrdgP7z
         VT2SJMwQE1zRdaIPsTUv7Uv2mcjIqG9/pgQHpI8Pb8g6zcb5zv3uGbnwlONJAOQfb8jK
         1cpBsyMzKutPMbfndQJS9gLyHl4bMNNI3pe2lNx7262yiCW69nUZfY7pekQKYG8wKj6e
         531A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3v88dggHcBZfZorIEJteI6G3MHHzRcAhgG+sL5blC4=;
        b=gExMnK9UAaqDbkiUSQC74A24gYVjQsmq/80XnDgY3qYp7+B+bNLSfybojbcb9nul7i
         3ZmUas6Hp+/Nq3EpAKg6eA0rUuXwxOvlpC6dThS2wxReuM2LkWH3iXcKxN/SPAdHTQeG
         f9KmVf18K2ViisUL2IHxJiSQjTcCVcRQpLrQXpNn8C8RuDg+uBRv3Ncz61pV4hCAOqrC
         kK4cJpG/uB2z1Gl6s8VwHQoY6VRqTnymukyFqX79lyu4wkqufJGz0sk89jZJwT5FEzW2
         kM9Jis4S4n72Hq3Leva03Uj0ICwFLL5RJDH3fXzPhe0P4xUUbYnXY82EcuFd6eLdynoz
         wYjw==
X-Gm-Message-State: APjAAAUxmsnujqwu/lSgN1YgmhdUFsgOP3zrpsHo7DgOlAb2+x+u/Inp
        J7lrwQ4rlZA1lHLbFN2rNNs=
X-Google-Smtp-Source: APXvYqxxRy+dDdp1/OTkUzEr3GeLcZ8EdB08MeKikBoxu1k9woxDDCw5VwhiwFzmSR9s41YYf+0zHA==
X-Received: by 2002:a1c:39c1:: with SMTP id g184mr19877719wma.75.1572813229504;
        Sun, 03 Nov 2019 12:33:49 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:48 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 4/7] pwm: sun4i: Add support to output source clock directly
Date:   Sun,  3 Nov 2019 21:33:31 +0100
Message-Id: <20191103203334.10539-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
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
serve as clock source for AC200 chip, which is integrated into same
package as H6 SoC.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index b5e7ac364f59..2441574674d9 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -3,6 +3,10 @@
  * Driver for Allwinner sun4i Pulse Width Modulation Controller
  *
  * Copyright (C) 2014 Alexandre Belloni <alexandre.belloni@free-electrons.com>
+ *
+ * Limitations:
+ * - When outputing the source clock directly, the PWM logic will be bypassed
+ *   and the currently running period is not guaranted to be completed
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
+	    data->has_direct_mod_clk_output) {
+		state->period = DIV_ROUND_CLOSEST_ULL(NSEC_PER_SEC, clk_rate);
+		state->duty_cycle = state->period / 2;
+		state->polarity = PWM_POLARITY_NORMAL;
+		state->enabled = true;
+		return;
+	}
+
 	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
 	    sun4i_pwm->data->has_prescaler_bypass)
 		prescaler = 1;
@@ -203,7 +222,8 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
-	u32 ctrl;
+	u32 ctrl, clk_rate;
+	bool bypass;
 	int ret;
 	unsigned int delay_us;
 	unsigned long now;
@@ -218,6 +238,16 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
+	/*
+	 * Although it would make much more sense to check for bypass in
+	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
+	 * Period is allowed to be rounded up or down.
+	 */
+	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	bypass = ((state->period * clk_rate >= NSEC_PER_SEC &&
+		   state->period * clk_rate < NSEC_PER_SEC + clk_rate) &&
+		  state->enabled);
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
@@ -265,6 +295,13 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
 
+	if (sun4i_pwm->data->has_direct_mod_clk_output) {
+		if (bypass)
+			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
+		else
+			ctrl &= ~BIT_CH(PWM_BYPASS, pwm->hwpwm);
+	}
+
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 
 	spin_unlock(&sun4i_pwm->ctrl_lock);
-- 
2.20.1

