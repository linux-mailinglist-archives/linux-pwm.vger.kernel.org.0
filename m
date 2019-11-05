Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59EB1EFE27
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389071AbfKENPR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:17 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35373 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389042AbfKENPG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:06 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so13066323wmo.0;
        Tue, 05 Nov 2019 05:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xt6+YnHhbZbK7S4nwP8vGudUXXjwmJXOlHYfRvq7dDU=;
        b=b82PUhZdaCHspXDf476oBCr7LWRwa2nNrQGnyHJooYVLOdqhoJy2e9rnqbwZnWnXQ5
         u4SfbtZP8saEAUXq3Sr7xz4ElQvFJKrlJXOkRONQjW+dGM1covE4o/ZS2ObmjsxMfBxf
         mezsG2nmZXXMwWEbw28rdAlP5axhZCQnPbDDLW8useI38aBaQlFwIjjI7C3bil/xvV/V
         MBoX7x0JT+sQtGPXqRTMi5oPdCCfrDP1jwhgnE5tMMvP2hbzZpj2srlP2nS5Eia8aJPj
         Yf2oGNeJCVMCIN1BzsIMsTVDSc9+q+0S16LGcjkC+j2JssXhSguBQIR9vPSof6leQye+
         25qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xt6+YnHhbZbK7S4nwP8vGudUXXjwmJXOlHYfRvq7dDU=;
        b=TI5X1gfFpqyGImKQuatu58CzN26uPja5SCVJyFliWrS6B/1in/haYMpG0fTId28RnC
         KYEInFhsubt1zMvEo1VcQqVi1kWCQ8/DdaifKFxJa2WxU9xjVzzGe19MhnGV/hGDUhEq
         YCHr3gstA6A5FgUTIeUU81P4hAYwNbX7YtH2AvKpGGL3xMyRDDoTBaR3hmj9709xBVTZ
         8e+A8aZNlwQCcH/PooKPq2MwOaj/xI6xfgjWUMdpCHvKUaimhbZY+4PYxd+fm0lhJdn7
         cM6bxwmwplWru3Ty8ZjltSDzzMK5FfNqYtBXZ1Wyi3+LNk3XSLiu+U4DT2zYlLd9Kq/F
         0BXA==
X-Gm-Message-State: APjAAAVNL04L2ItEG8qFOoFSdrSJnnDGgYS5h3GMNTBV6mtlK42YgNxA
        uJYSzeLItllmZ84hUxvEnbg=
X-Google-Smtp-Source: APXvYqwmAQr34KTYKExdiiUMK+I3NRAd7G+ntwNMztShxd52M8uAfLlZrBw5n55jwsNDDz327arL0w==
X-Received: by 2002:a1c:a751:: with SMTP id q78mr4415744wme.129.1572959704075;
        Tue, 05 Nov 2019 05:15:04 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:03 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 4/7] pwm: sun4i: Add support to output source clock directly
Date:   Tue,  5 Nov 2019 14:14:53 +0100
Message-Id: <20191105131456.32400-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 54e19fa56a4e..810abf47c261 100644
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
@@ -218,6 +238,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
+	/*
+	 * Although it would make much more sense to check for bypass in
+	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
+	 */
+	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	bypass = state->enabled &&
+		 (state->period * clk_rate >= NSEC_PER_SEC) &&
+		 (state->duty_cycle * 2 == state->period);
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
@@ -265,6 +294,13 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
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

