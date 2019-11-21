Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E07A105ABC
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Nov 2019 20:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfKUT7S (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Nov 2019 14:59:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36480 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfKUT7R (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Nov 2019 14:59:17 -0500
Received: by mail-wm1-f66.google.com with SMTP id n188so3212321wme.1;
        Thu, 21 Nov 2019 11:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+B/OIVjrG1dlH6HSUpfUfOtGFBjbxI16EIo0y2GEAU=;
        b=MfIKbSxz1ViKv1FClZ1Y7HO8tDP27iqEfRdOQn7Z+H2SZ+3vBlAnSCT5KzzC+Rst/L
         79LbaZbN7hOK2FGlTYrI0WGeufKMf2xjcUIXSu/RR8k+ZoeM/e6ApOfmfjvRmyRipHQ2
         0xq+FiUkUvodQ+PpptjFzwNzNkmQCel34fwSO99VxjQQ50SGQ7PGw+Q0cLzHYMhTEOQp
         yVXOoOzShn0yUtcbHPkTgZg+JTpR9HKJ3i83CSSNTtJzXv3Nem5cnhOd2a4Tyw4xjY+N
         HQdNFktej6DSE5D9fX8a39EwfQWd7nESK5zzqzH3hMFoTYBcxgP4w7kray8peKiix5Gx
         GPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+B/OIVjrG1dlH6HSUpfUfOtGFBjbxI16EIo0y2GEAU=;
        b=K0Gx+b252FsFcyyBdw3d/xcvhnCQVBKF8QAPDy8pbbUmnJ0YVWlw8ZsEgOCAhtWz8P
         s+qYvzkfMikYiFgWhtF6A6wHzQV40G7IdnR9jUadFwsi4qpRRHHCVMgWGyMcuK//wUp5
         ewESjVxufRrcURtayK7rZPNCktnrHp+oYpDfUlplRetdG7eGVQZ9JUleCHAXWGH0ByBd
         WV0KpSa9yhqRzf2OQPK5TKkuIalW2p08rdBc495BnHgowIQTJDGe6ehPFoQFsRRykAkk
         pHcCltyYHNdxMo0nRel9JPYzVFqUaLyRTQSffPDgrn9WV8yAhdeTpACc5U35wMvwVz3R
         mWGw==
X-Gm-Message-State: APjAAAUnnbwpBx9nylN8ImiHzrQ/KUqTb+bpP31F22m2IoStn4f/Ufal
        boFlA/+lmeXgBTuVbiMtipc=
X-Google-Smtp-Source: APXvYqyPDEXLEsfGsvqz9l3KdOkpAXePb3VTVy0wMdLDHlo6Ya6Kzeu0XRM4i9iNcMC3qKaYHJ4WsA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr1000354wmb.40.1574366354830;
        Thu, 21 Nov 2019 11:59:14 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id l4sm747124wme.4.2019.11.21.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2019 11:59:14 -0800 (PST)
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
Subject: [PATCH v8 4/6] pwm: sun4i: Always calculate params when applying new parameters
Date:   Thu, 21 Nov 2019 20:59:00 +0100
Message-Id: <20191121195902.6906-5-peron.clem@gmail.com>
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

Bypass mode will require to be re-calculated when the pwm state
is changed.

Remove the condition so pwm_sun4i_calculate is always called.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 52 ++++++++++++++++++-----------------------
 1 file changed, 23 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 66befd8d6f9c..1fa2057419fb 100644
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

