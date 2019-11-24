Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D49A4108454
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfKXRaK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:10 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43334 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfKXRaK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:10 -0500
Received: by mail-wr1-f66.google.com with SMTP id n1so14657060wra.10;
        Sun, 24 Nov 2019 09:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kBIOZ347etSnW61gnUIaBM64Cedw0cl5jNO3eKEASaI=;
        b=BNXw7SGybu8K/BnOo/JmbYr3H+qeKULqXTZlFkPQeXtapTFXumcRzWWa5szX8gIRPp
         l7uDSFr5mU//Kl4U1JBwkwBjsK02e0mNwuLEk2pVhO40nb5ajspahtr7bqep6axQwhEi
         gzxBVD9Ec9ZOrVxntjnXGO7qAhgNPSeB/sxaiJrNudcMIFeRvMfLGrgl+Mu2kNQDOACB
         ArL/wo5SGjbWfA6sc7bDNvXpx20xYDg4U2ml/G8QWLADeK20UgsMFIgpjrtSRLj/J/oI
         yBW3k8s/2isjfXEOwqii/tWcnLSqOJBKgs2pQxGy6weYm6URBoVaUUFzdnry/7ToZdGL
         9vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kBIOZ347etSnW61gnUIaBM64Cedw0cl5jNO3eKEASaI=;
        b=gvgAT1mYA1o2Mf3R3fom18ReMKHpyb4nxHPg2q5eKm35lPIxYNmuMW/E1l0+53uBDf
         jpIm+qwpaedmQTkF/Ic7H8kEzpRDm9vEkIbMKf6Di0ryH6GxCluzPDKeC0zOIEbdDvOz
         yWq7PcJ77ORPGKE+7Rdr2fnqvj8ni22r/4XrqnI1AtrcS5mMLsEoDY694angJj7tSIaS
         IC1zk4ViFAKcpKvIWtWQfkRqlKic/L/7MB/8uoWITCXguqYGW+h/MMMqbcXVhGLbb+2f
         MmNInzg1/srDvfhkvcSkE1aPfyThGqTcee+4ntv5FZI36iFk90ofuCpkJ32EqojgTTJH
         MXtg==
X-Gm-Message-State: APjAAAXWt5LVJcuGSVysbHEG+8IzRl0ZAjWsoHoyMBLzkwgnfENpRhGF
        W1tB+gYLUXjphLOHIJTQFOw=
X-Google-Smtp-Source: APXvYqzn2w6E+vLemwZDNa1gBjr8f2SWkG2H6wnWdo2EcpqrquGJr5ycgzX0pUhtms7s/GZ6Vx7wGg==
X-Received: by 2002:a5d:55c5:: with SMTP id i5mr29179656wrw.385.1574616607934;
        Sun, 24 Nov 2019 09:30:07 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:30:07 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v9 4/6] pwm: sun4i: Always calculate params when applying new parameters
Date:   Sun, 24 Nov 2019 18:29:06 +0100
Message-Id: <20191124172908.10804-5-peron.clem@gmail.com>
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

Bypass mode will require to be re-calculated when the pwm state
is changed.

Remove the condition so pwm_sun4i_calculate is always called.

Reviewed-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 52 ++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index a6727dd89e28..e369b5a398f4 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -202,9 +202,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
-	u32 ctrl;
+	u32 ctrl, duty, period, val;
 	int ret;
-	unsigned int delay_us;
+	unsigned int delay_us, prescaler;
 	unsigned long now;
 
 	pwm_get_state(pwm, &cstate);
@@ -220,43 +220,37 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	spin_lock(&sun4i_pwm->ctrl_lock);
 	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
 
-	if ((cstate.period != state->period) ||
-	    (cstate.duty_cycle != state->duty_cycle)) {
-		u32 period, duty, val;
-		unsigned int prescaler;
-
-		ret = sun4i_pwm_calculate(sun4i_pwm, state,
-					  &duty, &period, &prescaler);
-		if (ret) {
-			dev_err(chip->dev, "period exceeds the maximum value\n");
-			spin_unlock(&sun4i_pwm->ctrl_lock);
-			if (!cstate.enabled)
-				clk_disable_unprepare(sun4i_pwm->clk);
-			return ret;
-		}
-
-		if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
-			/* Prescaler changed, the clock has to be gated */
-			ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler);
+	if (ret) {
+		dev_err(chip->dev, "period exceeds the maximum value\n");
+		spin_unlock(&sun4i_pwm->ctrl_lock);
+		if (!cstate.enabled)
+			clk_disable_unprepare(sun4i_pwm->clk);
+		return ret;
+	}
 
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
-- 
2.20.1

