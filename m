Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD43911C
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Jun 2019 17:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730759AbfFGP4y (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 Jun 2019 11:56:54 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:48090 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730114AbfFGPoW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 7 Jun 2019 11:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1559922259; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uKjYmWMGTPMWyT68pwkqTgx+FiVn9ZInyiEbS0sgpd8=;
        b=heZk/oQ9KnZtcfEMgGa9h5jz9LZyOlmXz8CxRJ4KshAT2D+HjqO1yZaJ+DrefNGhrrf0St
        PC8rEM2dkvtcaZupu57PYbzk6mEo7eOUgTh4Ag7gvMgmOkQ1yy9rq1iImozvP5pBhJxV8S
        vluR/Sx6JBHR7OwuA2KwlW0INfu+m+k=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/6] pwm: jz4740: Apply configuration atomically
Date:   Fri,  7 Jun 2019 17:44:07 +0200
Message-Id: <20190607154410.10633-4-paul@crapouillou.net>
In-Reply-To: <20190607154410.10633-1-paul@crapouillou.net>
References: <20190607154410.10633-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is cleaner, more future-proof, and incidentally it also fixes the
PWM resetting its config when stopped/started several times.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Rebase on v5.2-rc3

 drivers/pwm/pwm-jz4740.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 5c8bb6192201..75254360621c 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -74,17 +74,16 @@ static void jz4740_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	jz4740_timer_disable(pwm->hwpwm);
 }
 
-static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    struct pwm_state *state)
 {
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	unsigned long long tmp;
 	unsigned long period, duty;
 	unsigned int prescaler = 0;
 	uint16_t ctrl;
-	bool is_enabled;
 
-	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * period_ns;
+	tmp = (unsigned long long)clk_get_rate(jz4740->clk) * state->period;
 	do_div(tmp, 1000000000);
 	period = tmp;
 
@@ -96,16 +95,14 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (prescaler == 6)
 		return -EINVAL;
 
-	tmp = (unsigned long long)period * duty_ns;
-	do_div(tmp, period_ns);
+	tmp = (unsigned long long)period * state->duty_cycle;
+	do_div(tmp, state->period);
 	duty = period - tmp;
 
 	if (duty >= period)
 		duty = period - 1;
 
-	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
-	if (is_enabled)
-		jz4740_pwm_disable(chip, pwm);
+	jz4740_pwm_disable(chip, pwm);
 
 	jz4740_timer_set_count(pwm->hwpwm, 0);
 	jz4740_timer_set_duty(pwm->hwpwm, duty);
@@ -116,18 +113,7 @@ static int jz4740_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
 
-	if (is_enabled)
-		jz4740_pwm_enable(chip, pwm);
-
-	return 0;
-}
-
-static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
-		struct pwm_device *pwm, enum pwm_polarity polarity)
-{
-	uint32_t ctrl = jz4740_timer_get_ctrl(pwm->pwm);
-
-	switch (polarity) {
+	switch (state->polarity) {
 	case PWM_POLARITY_NORMAL:
 		ctrl &= ~JZ_TIMER_CTRL_PWM_ACTIVE_LOW;
 		break;
@@ -137,16 +123,17 @@ static int jz4740_pwm_set_polarity(struct pwm_chip *chip,
 	}
 
 	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
+
+	if (state->enabled)
+		jz4740_pwm_enable(chip, pwm);
+
 	return 0;
 }
 
 static const struct pwm_ops jz4740_pwm_ops = {
 	.request = jz4740_pwm_request,
 	.free = jz4740_pwm_free,
-	.config = jz4740_pwm_config,
-	.set_polarity = jz4740_pwm_set_polarity,
-	.enable = jz4740_pwm_enable,
-	.disable = jz4740_pwm_disable,
+	.apply = jz4740_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.21.0.593.g511ec345e18

