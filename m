Return-Path: <linux-pwm+bounces-1462-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5802F854622
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1EF11F2E031
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA7B3171AC;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D941B962
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=kUWNzl9FW7Rplt+k6hNYDVvmXB5ewavW6H72eenVr8psaBxxDpfPnUbz+AsDNiRbRYXy344y0xarFCzUkpIuZzEWVdQAXFPfNfJOsZJ5e+F/D5K37dlAqZzn9L5vKH3ykz/Lu6dKn1V5qf0PaE+c9JH5rpxnr5DQfpaGwJOqRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=pYqhxukqqxjxaP+7jWY0dwzmWc6tQ3fdQHkzU6wvKgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFkkj4qhvAp5RtclMBNeVsH7g6rGxjmjWh898+KQZ+9vYMIeDheuNF3DiIKK3XXvbbfyjhueKzwTMYbkthiyauTn+FZN3Q8j77VuqkU+0I7Z/mgy5xudekDW60eJBdy3XIUynJKT7LIbC+a0elUvAO1OTjbdyMhpE7Lfqxoi7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf7-0005u1-Dd; Wed, 14 Feb 2024 10:34:41 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-000fGY-92; Wed, 14 Feb 2024 10:34:37 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf3-004Y8H-0d;
	Wed, 14 Feb 2024 10:34:37 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 126/164] pwm: sun4i: Consistently name driver data sun4ichip
Date: Wed, 14 Feb 2024 10:32:53 +0100
Message-ID:  <705f54a13b59fff50eaa345d8b1e0c691345b996.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=8725; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pYqhxukqqxjxaP+7jWY0dwzmWc6tQ3fdQHkzU6wvKgc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjcFJDeGkGJiCtO/kFkd4CLnokzccSXKgqPX LlvGrwWM6qJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI3AAKCRCPgPtYfRL+ TqzCB/wO/LFmseKA69poXqCjxMiqvBOa7Xea8Y6B8KAQ/NRqLuEYt/ztn4WfSQABtY/wmbqha5C f38ihhHgQUVnW0vpHG1UJ5SzYP8zsWHUnLfncnN4rmAzxTccWP1+6ITqW345W3V5DGc36nCQkWc PegrIy9paz81m1oXjxchHqhXdp1k/gOFjf1dGb7hzYlxT4d8bCsksvepchLi8SovZcmeMzt/em2 oo0EkrcAWE5F8nsMYJTv2S5OAScfpp9twB3ucFPiiidbuIZqTwSgg0j1+PDLcnc3V2+djcHe+cT X4ZHx36LgIwt//2cCHSwAfK0Ppn8t51x52Ojw52il/Wu2W5T
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The driver uses three different names for variables of type
sun4i_pwm_chip:

	$ git grep 'struct sun4i_pwm_chip \*' v6.8-rc1 -- drivers/pwm/pwm-sun4i.c
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:       struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:       struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:       struct sun4i_pwm_chip *sun4ichip;
	v6.8-rc1:drivers/pwm/pwm-sun4i.c:       struct sun4i_pwm_chip *sun4ichip = platform_get_drvdata(pdev);

"chip" is usually reserved for variables of type struct pwm_chip. So
pick sun4ichip as common name which better matches the type name than
sun4i_pwm.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 64 ++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index c2f579043915..2437e5961f5e 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -95,32 +95,32 @@ static inline struct sun4i_pwm_chip *to_sun4i_pwm_chip(struct pwm_chip *chip)
 	return container_of(chip, struct sun4i_pwm_chip, chip);
 }
 
-static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *chip,
+static inline u32 sun4i_pwm_readl(struct sun4i_pwm_chip *sun4ichip,
 				  unsigned long offset)
 {
-	return readl(chip->base + offset);
+	return readl(sun4ichip->base + offset);
 }
 
-static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *chip,
+static inline void sun4i_pwm_writel(struct sun4i_pwm_chip *sun4ichip,
 				    u32 val, unsigned long offset)
 {
-	writel(val, chip->base + offset);
+	writel(val, sun4ichip->base + offset);
 }
 
 static int sun4i_pwm_get_state(struct pwm_chip *chip,
 			       struct pwm_device *pwm,
 			       struct pwm_state *state)
 {
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct sun4i_pwm_chip *sun4ichip = to_sun4i_pwm_chip(chip);
 	u64 clk_rate, tmp;
 	u32 val;
 	unsigned int prescaler;
 
-	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	clk_rate = clk_get_rate(sun4ichip->clk);
 	if (!clk_rate)
 		return -EINVAL;
 
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	val = sun4i_pwm_readl(sun4ichip, PWM_CTRL_REG);
 
 	/*
 	 * PWM chapter in H6 manual has a diagram which explains that if bypass
@@ -128,7 +128,7 @@ static int sun4i_pwm_get_state(struct pwm_chip *chip,
 	 * proved that also enable bit is ignored in this case.
 	 */
 	if ((val & BIT_CH(PWM_BYPASS, pwm->hwpwm)) &&
-	    sun4i_pwm->data->has_direct_mod_clk_output) {
+	    sun4ichip->data->has_direct_mod_clk_output) {
 		state->period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, clk_rate);
 		state->duty_cycle = DIV_ROUND_UP_ULL(state->period, 2);
 		state->polarity = PWM_POLARITY_NORMAL;
@@ -137,7 +137,7 @@ static int sun4i_pwm_get_state(struct pwm_chip *chip,
 	}
 
 	if ((PWM_REG_PRESCAL(val, pwm->hwpwm) == PWM_PRESCAL_MASK) &&
-	    sun4i_pwm->data->has_prescaler_bypass)
+	    sun4ichip->data->has_prescaler_bypass)
 		prescaler = 1;
 	else
 		prescaler = prescaler_table[PWM_REG_PRESCAL(val, pwm->hwpwm)];
@@ -156,7 +156,7 @@ static int sun4i_pwm_get_state(struct pwm_chip *chip,
 	else
 		state->enabled = false;
 
-	val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
+	val = sun4i_pwm_readl(sun4ichip, PWM_CH_PRD(pwm->hwpwm));
 
 	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
@@ -167,7 +167,7 @@ static int sun4i_pwm_get_state(struct pwm_chip *chip,
 	return 0;
 }
 
-static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
+static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4ichip,
 			       const struct pwm_state *state,
 			       u32 *dty, u32 *prd, unsigned int *prsclr,
 			       bool *bypass)
@@ -175,9 +175,9 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	u64 clk_rate, div = 0;
 	unsigned int prescaler = 0;
 
-	clk_rate = clk_get_rate(sun4i_pwm->clk);
+	clk_rate = clk_get_rate(sun4ichip->clk);
 
-	*bypass = sun4i_pwm->data->has_direct_mod_clk_output &&
+	*bypass = sun4ichip->data->has_direct_mod_clk_output &&
 		  state->enabled &&
 		  (state->period * clk_rate >= NSEC_PER_SEC) &&
 		  (state->period * clk_rate < 2 * NSEC_PER_SEC) &&
@@ -187,7 +187,7 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 	if (*bypass)
 		return 0;
 
-	if (sun4i_pwm->data->has_prescaler_bypass) {
+	if (sun4ichip->data->has_prescaler_bypass) {
 		/* First, test without any prescaler when available */
 		prescaler = PWM_PRESCAL_MASK;
 		/*
@@ -233,7 +233,7 @@ static int sun4i_pwm_calculate(struct sun4i_pwm_chip *sun4i_pwm,
 static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
-	struct sun4i_pwm_chip *sun4i_pwm = to_sun4i_pwm_chip(chip);
+	struct sun4i_pwm_chip *sun4ichip = to_sun4i_pwm_chip(chip);
 	struct pwm_state cstate;
 	u32 ctrl, duty = 0, period = 0, val;
 	int ret;
@@ -243,31 +243,31 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_get_state(pwm, &cstate);
 
 	if (!cstate.enabled) {
-		ret = clk_prepare_enable(sun4i_pwm->clk);
+		ret = clk_prepare_enable(sun4ichip->clk);
 		if (ret) {
 			dev_err(pwmchip_parent(chip), "failed to enable PWM clock\n");
 			return ret;
 		}
 	}
 
-	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
+	ret = sun4i_pwm_calculate(sun4ichip, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
 		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
 		if (!cstate.enabled)
-			clk_disable_unprepare(sun4i_pwm->clk);
+			clk_disable_unprepare(sun4ichip->clk);
 		return ret;
 	}
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	spin_lock(&sun4ichip->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4ichip, PWM_CTRL_REG);
 
-	if (sun4i_pwm->data->has_direct_mod_clk_output) {
+	if (sun4ichip->data->has_direct_mod_clk_output) {
 		if (bypass) {
 			ctrl |= BIT_CH(PWM_BYPASS, pwm->hwpwm);
 			/* We can skip other parameter */
-			sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-			spin_unlock(&sun4i_pwm->ctrl_lock);
+			sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
+			spin_unlock(&sun4ichip->ctrl_lock);
 			return 0;
 		}
 
@@ -277,14 +277,14 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (PWM_REG_PRESCAL(ctrl, pwm->hwpwm) != prescaler) {
 		/* Prescaler changed, the clock has to be gated */
 		ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
-		sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+		sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
 
 		ctrl &= ~BIT_CH(PWM_PRESCAL_MASK, pwm->hwpwm);
 		ctrl |= BIT_CH(prescaler, pwm->hwpwm);
 	}
 
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
-	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
+	sun4i_pwm_writel(sun4ichip, val, PWM_CH_PRD(pwm->hwpwm));
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
 		ctrl &= ~BIT_CH(PWM_ACT_STATE, pwm->hwpwm);
@@ -296,9 +296,9 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->enabled)
 		ctrl |= BIT_CH(PWM_EN, pwm->hwpwm);
 
-	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
+	sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
 
-	spin_unlock(&sun4i_pwm->ctrl_lock);
+	spin_unlock(&sun4ichip->ctrl_lock);
 
 	if (state->enabled)
 		return 0;
@@ -310,14 +310,14 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		usleep_range(delay_us, delay_us * 2);
 
-	spin_lock(&sun4i_pwm->ctrl_lock);
-	ctrl = sun4i_pwm_readl(sun4i_pwm, PWM_CTRL_REG);
+	spin_lock(&sun4ichip->ctrl_lock);
+	ctrl = sun4i_pwm_readl(sun4ichip, PWM_CTRL_REG);
 	ctrl &= ~BIT_CH(PWM_CLK_GATING, pwm->hwpwm);
 	ctrl &= ~BIT_CH(PWM_EN, pwm->hwpwm);
-	sun4i_pwm_writel(sun4i_pwm, ctrl, PWM_CTRL_REG);
-	spin_unlock(&sun4i_pwm->ctrl_lock);
+	sun4i_pwm_writel(sun4ichip, ctrl, PWM_CTRL_REG);
+	spin_unlock(&sun4ichip->ctrl_lock);
 
-	clk_disable_unprepare(sun4i_pwm->clk);
+	clk_disable_unprepare(sun4ichip->clk);
 
 	return 0;
 }
-- 
2.43.0


