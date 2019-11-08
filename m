Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67DC3F4261
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfKHIpc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:32 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53306 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725975AbfKHIpc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:32 -0500
Received: by mail-wm1-f65.google.com with SMTP id x4so5260697wmi.3;
        Fri, 08 Nov 2019 00:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o1BbTTGdSFKY2gKlnZB56hqOxy66kjY0LgiclhRJDv0=;
        b=C1dyS/W0NAlPRWhXtx8M04st3Ji81RU6NVq5t+9WHq97OdhgLePwxDGl3Cruq/vZPd
         DhMB3BDpQ9jyil8oXeLUcnBbpOhWwv0qM4eJ9r1DWxSVAXweAgSmuhTKrKoIW/UjqRB8
         3iIe5/qXLUa7pNPl83YENVRzssGRhi4YaVcGmiVRgz7IBMqSAZAhijS+2p7GRQfbwuFk
         cl38aPIvbDXot2aNqlghO7DJoyJx3cor3VtsLCISWwWyl1arlRUPR4VUcxBxW+kfmzmf
         EV+V1LpkKB8obh/ddgEvSJ9UeBITSOTJAlg23+Lw9qzcOjOi6UY2ZlMHWRXoO0xS1W5/
         t7Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o1BbTTGdSFKY2gKlnZB56hqOxy66kjY0LgiclhRJDv0=;
        b=HCj9SDME4t+LmbfunJ+8jstJeJ4CttmhLoQSSMNAe/mUPo15hDgWP/NFiIZL74Afof
         5wEm9rZyTWwUvmTxWliRNhywn4kpJZRz0erPs8jyVmjFIHojeZzskITW3cPqIJAT36SC
         2u5ZNtYZUBC39umTcwuzKsgZWOiaz4Q9abK4ayrEfyhxZn4JeaoysC/DhFDdWIxDSrSq
         GsP7cnels99It1bG+zz/2u7D9a7YArfAGfU9KrkZ3/o2ClN3pZqXp1RP+lkip199AhzH
         wS9BYWxLk/IXF+xINLx3c/XHzs/0lQ6Gh4DqOmz3QsJtYlCZu2iYCZ9y1O9ugKouRR23
         hb0A==
X-Gm-Message-State: APjAAAVCWb+89vaEGpk51cZXa6qYH6YlPGk69OSucfBX1A+VOsABrwZq
        JvBTyezuDKGcrvnlMiOcml0=
X-Google-Smtp-Source: APXvYqxwBaxdGVAxdGG5OfhwPgDnJ/JZT/ybNdD4d2t31vpqkvY3E2BRG4vS88zywqSF6FNS60xWrQ==
X-Received: by 2002:a1c:740a:: with SMTP id p10mr7053319wmc.121.1573202729584;
        Fri, 08 Nov 2019 00:45:29 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:29 -0800 (PST)
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
Subject: [PATCH v4 4/7] pwm: sun4i: Add support to output source clock directly
Date:   Fri,  8 Nov 2019 09:45:14 +0100
Message-Id: <20191108084517.21617-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108084517.21617-1-peron.clem@gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 44 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a10022d6c0fd..9cc928ab47bc 100644
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
@@ -204,6 +223,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
 	u32 ctrl;
+	bool bypass = false;
 	int ret;
 	unsigned int delay_us;
 	unsigned long now;
@@ -218,9 +238,24 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
+	/*
+	 * Although it would make much more sense to check for bypass in
+	 * sun4i_pwm_calculate(), value of bypass bit also depends on "enabled".
+	 */
+	if (state->enabled) {
+		u32 clk_rate = clk_get_rate(sun4i_pwm->clk);
+		bypass = (state->period * clk_rate >= NSEC_PER_SEC) &&
+			 (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
+			 (state->duty_cycle * clk_rate * 2 >= NSEC_PER_SEC);
+	}
+
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
+	/* We can skip calculation and apply parameters */
+	if (bypass && sun4i_pwm->data->has_direct_mod_clk_output)
+		goto bypass_mode;
+
 	if ((cstate.period != state->period) ||
 	    (cstate.duty_cycle != state->duty_cycle)) {
 		u32 period, duty, val;
@@ -258,6 +293,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ctrl |= BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
 
 	ctrl |= BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
+
 	if (state->enabled) {
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
 	} else if (!sun4i_pwm->needs_delay[pwm->hwpwm]) {
@@ -265,6 +301,14 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	}
 
+bypass_mode:
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

