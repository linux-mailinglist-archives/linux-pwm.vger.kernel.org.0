Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18C3C37B13B
	for <lists+linux-pwm@lfdr.de>; Wed, 12 May 2021 00:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhEKWCd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 11 May 2021 18:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhEKWCc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 11 May 2021 18:02:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94708C06174A
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 15:01:25 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id k10so767073ejj.8
        for <linux-pwm@vger.kernel.org>; Tue, 11 May 2021 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=prusa3d-cz.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGJjejPNA5+HMTFCgCKvKscy9gIyFJ9LNB8FwA+a0eA=;
        b=lSYYG5TkeMPH6yJvWJfv6HkQ78/unirOq5GkK1zRHwqVqPDT1neDhZnEwhB3aIk1WN
         ccSD5cT+lC9MuEbKJvxyJSiZG0XGxdRr1Gk9sL0DPWPpiYYf/x21zwjtBCfvjyJWr5Uy
         0cPkthWelSPwkEFznsl4O4mgMAlAbS1dFm8l0Nq17xaK1ejlSu+fylpKJs8TqdaNv4kq
         wYlWN5Qd7DJRW1DC2Q/rKS3/HOZacFhbE1A6INPAZtVSQ8mxFlqS6JCJneNRFLnn7paO
         TTjIcbKt5Cmr6gYBNAU/4iY1bgJlSE1pieqQ5bxhZhHyqZoqJVWg/Thoe4dUD5LTqaDJ
         Ry4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aGJjejPNA5+HMTFCgCKvKscy9gIyFJ9LNB8FwA+a0eA=;
        b=gCKVOotxTUvpAnwQ6/yKJjKJS3jRcMQPNEm+j6ERPWcyQMRp8hIGzBht0EoS/GIeTX
         CWMn+5ni8+F9vsYC3TSG/eL53W2Z6nqtU+gcLfeE3QI2opRmAgNJJJK7C5ZROO9L+WZn
         wgQcJo+4zxtabrHNGJCkK4R3X3hcmU2F9llO6fRbgVcMaE+i+qRHSDBx3A/yNgNNM4/v
         i3wI+Hm/oppi19le2ucgtmSZGMqkNqPQVyLhf8nyiwwreR7Yfowttr9buPqxKbvZuCLy
         Bce71UIMkK0GHWb8emONXQ9FF+5dfecbgCQv/4wvIu3xy47DyRw+y6cb1iGc9bnr1fJQ
         nDDw==
X-Gm-Message-State: AOAM533SF8sA7nCRp0DXjWWjnoO5W5golK2E1WlD4wjiwNG8jHhh0Wlb
        8of3K+TO0B0Cnu/kCI+piBcDYw==
X-Google-Smtp-Source: ABdhPJwQDxOCJUSPBVJxUM2UQdm7il6zg5MtuKvXHXR16O7cx/bB48W1ka2HDs4n20LYkpslpNYh9g==
X-Received: by 2002:a17:906:564f:: with SMTP id v15mr33165529ejr.96.1620770484363;
        Tue, 11 May 2021 15:01:24 -0700 (PDT)
Received: from zen.local (ip-89-102-194-33.net.upcbroadband.cz. [89.102.194.33])
        by smtp.gmail.com with ESMTPSA id r17sm15583636edo.48.2021.05.11.15.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 15:01:23 -0700 (PDT)
From:   Roman Beranek <roman.beranek@prusa3d.cz>
X-Google-Original-From: Roman Beranek <roman.beranek@prusa3d.com>
To:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-sunxi@googlegroups.com,
        Roman Beranek <roman.beranek@prusa3d.com>
Subject: [PATCH] pwm: sun4i: Avoid waiting until the next period
Date:   Wed, 12 May 2021 00:00:14 +0200
Message-Id: <20210511220014.1945519-1-roman.beranek@prusa3d.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As disabling PWM by clearing the PWM_EN bit doesn't take an effect until
the last pulse cycle ends, gating the clock too soon may result in the
output signal getting stuck in an active state. Although the code gives
an appearance that it takes care of this particular problem by waiting
for the next period before finally clearing the CLK_GATING and EN bits,
unless the EN bit has already been cleared by the time the delay begins,
this measure doesn't achieve anything.

However, even if this detail were to be fixed, there would still remain
another issue to deal with: if the PWM were to be disabled shortly after
having its period shortened, the length of the delay might turn out
insufficient. So instead of waiting for the moment when it becomes safe
to gate the clock, let's not bother gating it in the first place.

Signed-off-by: Roman Beranek <roman.beranek@prusa3d.com>
Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 52 +++++++++++------------------------------
 1 file changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index e01becd10..809163186 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -89,7 +89,6 @@ struct sun4i_pwm_chip {
 	void __iomem *base;
 	spinlock_t ctrl_lock;
 	const struct sun4i_pwm_data *data;
-	unsigned long next_period[2];
 };
 
 static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
@@ -235,26 +234,15 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_state cstate;
 	u32 ctrl, duty = 0, period = 0, val;
 	int ret;
-	unsigned int delay_us, prescaler = 0;
-	unsigned long now;
+	unsigned int prescaler = 0;
 	bool bypass;
 
 	pwm_get_state(pwm, &cstate);
 
-	if (!cstate.enabled) {
-		ret = clk_prepare_enable(sun4i_pwm->clk);
-		if (ret) {
-			dev_err(chip->dev, "failed to enable PWM clock\n");
-			return ret;
-		}
-	}
-
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
 		dev_err(chip->dev, "period exceeds the maximum value\n");
-		if (!cstate.enabled)
-			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
 	}
 
@@ -284,8 +272,6 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
-	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		nsecs_to_jiffies(cstate.period + 1000);
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
@@ -296,34 +282,12 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	if (state->enabled)
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
+	else
+		ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
 
 	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-
-	spin_unlock(&sun4i_pwm->ctrl_lock);
-
-	if (state->enabled)
-		return 0;
-
-	/* We need a full period to elapse before disabling the channel. */
-	now = jiffies;
-	if (time_before(now, sun4i_pwm->next_period[pwm->hwpwm])) {
-		delay_us = jiffies_to_usecs(sun4i_pwm->next_period[pwm->hwpwm] -
-					   now);
-		if ((delay_us / 500) > MAX_UDELAY_MS)
-			msleep(delay_us / 1000 + 1);
-		else
-			usleep_range(delay_us, delay_us * 2);
-	}
-
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
-	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-	ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
 	spin_unlock(&sun4i_pwm->ctrl_lock);
 
-	clk_disable_unprepare(sun4i_pwm->clk);
-
 	return 0;
 }
 
@@ -457,6 +421,13 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		goto err_bus;
 	}
 
+	ret = clk_prepare_enable(pwm->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to prepare and enable PWM clock %pe\n",
+			ERR_PTR(ret));
+		goto err_clk;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.npwm = pwm->data->npwm;
@@ -476,6 +447,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->clk);
+err_clk:
 	clk_disable_unprepare(pwm->bus_clk);
 err_bus:
 	reset_control_assert(pwm->rst);
@@ -492,6 +465,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->clk);
 	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
-- 
2.31.1

