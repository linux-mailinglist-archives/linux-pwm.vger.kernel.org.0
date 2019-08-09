Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B12879F7
	for <lists+linux-pwm@lfdr.de>; Fri,  9 Aug 2019 14:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406676AbfHIMbR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 9 Aug 2019 08:31:17 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:55616 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHIMbR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 9 Aug 2019 08:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1565353850; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/v3/BAVtZKNue7NyDFb+jY+xt8Nkkuc47WZZP4QpfNk=;
        b=JPbfun6S2OJfE2xqfYQWl1jnD/Ozp5dKiDu/llBTvLQ05O3NBIMb8Sqj5lAoVom7AloJ17
        X3p60uEuk+ek/JNHCeR43zIQ9nIAfVptGFmw4PWYNu5CTweg0Qm+hlYxBeYCh5wH4CRd1H
        Qpi3ru3npbC+YSbixgD5w07JFoEBQVo=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, od@zcrc.me,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
Subject: [PATCH 4/7] pwm: jz4740: Improve algorithm of clock calculation
Date:   Fri,  9 Aug 2019 14:30:28 +0200
Message-Id: <20190809123031.24219-5-paul@crapouillou.net>
In-Reply-To: <20190809123031.24219-1-paul@crapouillou.net>
References: <20190809123031.24219-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The previous algorithm hardcoded details about how the TCU clocks work.
The new algorithm will use clk_round_rate to find the perfect clock rate
for the PWM channel.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Tested-by: Mathieu Malaterre <malat@debian.org>
Tested-by: Artur Rojek <contact@artur-rojek.eu>
---
 drivers/pwm/pwm-jz4740.c | 60 +++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 6ec8794d3b99..f20dc2e19240 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -110,24 +110,56 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct jz4740_pwm_chip *jz4740 = to_jz4740(pwm->chip);
 	struct clk *clk = pwm_get_chip_data(pwm),
 		   *parent_clk = clk_get_parent(clk);
-	unsigned long rate, period, duty;
+	unsigned long rate, parent_rate, period, duty;
 	unsigned long long tmp;
-	unsigned int prescaler = 0;
+	int ret;
 
-	rate = clk_get_rate(parent_clk);
-	tmp = (unsigned long long)rate * state->period;
-	do_div(tmp, 1000000000);
-	period = tmp;
+	parent_rate = clk_get_rate(parent_clk);
+
+	jz4740_pwm_disable(chip, pwm);
 
-	while (period > 0xffff && prescaler < 6) {
-		period >>= 2;
-		rate >>= 2;
-		++prescaler;
+	/* Reset the clock to the maximum rate, and we'll reduce it if needed */
+	ret = clk_set_max_rate(clk, parent_rate);
+	if (ret) {
+		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
+		return ret;
 	}
 
-	if (prescaler == 6)
-		return -EINVAL;
+	ret = clk_set_rate(clk, parent_rate);
+	if (ret) {
+		dev_err(chip->dev, "Unable to reset to parent rate (%lu Hz)",
+			parent_rate);
+		return ret;
+	}
+
+	/*
+	 * Limit the clock to a maximum rate that still gives us a period value
+	 * which fits in 16 bits.
+	 */
+	tmp = 0xffffull * NSEC_PER_SEC;
+	do_div(tmp, state->period);
 
+	ret = clk_set_max_rate(clk, tmp);
+	if (ret) {
+		dev_err(chip->dev, "Unable to set max rate: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Read back the clock rate, as it may have been modified by
+	 * clk_set_max_rate()
+	 */
+	rate = clk_get_rate(clk);
+
+	if (rate != parent_rate)
+		dev_dbg(chip->dev, "PWM clock updated to %lu Hz\n", rate);
+
+	/* Calculate period value */
+	tmp = (unsigned long long)rate * state->period;
+	do_div(tmp, NSEC_PER_SEC);
+	period = (unsigned long)tmp;
+
+	/* Calculate duty value */
 	tmp = (unsigned long long)period * state->duty_cycle;
 	do_div(tmp, state->period);
 	duty = period - tmp;
@@ -135,14 +167,10 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty >= period)
 		duty = period - 1;
 
-	jz4740_pwm_disable(chip, pwm);
-
 	/* Set abrupt shutdown */
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	clk_set_rate(clk, rate);
-
 	/* Reset counter to 0 */
 	regmap_write(jz4740->map, TCU_REG_TCNTc(pwm->hwpwm), 0);
 
-- 
2.21.0.593.g511ec345e18

