Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBFF1E0ED8
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2020 14:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbgEYM55 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 May 2020 08:57:57 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:47078 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388757AbgEYM55 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 May 2020 08:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590411462; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=o9eG/KlZQP44MIIRo7gEL1HDpg6czklGntJ8QGqQhPQ=;
        b=KT5CmLcX9D9LjB3Nptb3kDngnRI2RR5AH98rES8oVPcwZv1TmYKC1zBfMMWbGyLVRYdccW
        dJXOylyMVbEy66isQtqxy2nfWUF9vBHKUi7pkLwRPXYoYfB0Id/BoowkEkIfsEMIVb8xkn
        rF6tAoPIOtuaPqHJU6uEudGbE1m1Hg0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     od@zcrc.me, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/4] pwm: jz4740: Make PWM start with the active part
Date:   Mon, 25 May 2020 14:57:21 +0200
Message-Id: <20200525125722.36447-3-paul@crapouillou.net>
In-Reply-To: <20200525125722.36447-1-paul@crapouillou.net>
References: <20200525125722.36447-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The PWM in Ingenic SoCs starts in inactive state until the internal
timer reaches the duty value, then becomes active until the timer
reaches the period value. In theory, we should then use (period - duty)
as the real duty value, as a high duty value would otherwise result in
the PWM pin being inactive most of the time.

This is the reason why the duty value was inverted in the driver until
now, but it still had the problem that it would not start with the
active part.

To address this remaining issue, the common trick is to invert the
duty, and invert the polarity when the PWM is enabled.

Since the duty was already inverted, and we invert it again, we now
program the hardware for the requested duty, and simply invert the
polarity when the PWM is enabled.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v2: Add documentation about why we invert the polarity, and
    	improve commit message

 drivers/pwm/pwm-jz4740.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/pwm-jz4740.c b/drivers/pwm/pwm-jz4740.c
index 4fe9d99ac9a9..fe06ca8ce30f 100644
--- a/drivers/pwm/pwm-jz4740.c
+++ b/drivers/pwm/pwm-jz4740.c
@@ -6,7 +6,6 @@
  * Limitations:
  * - The .apply callback doesn't complete the currently running period before
  *   reconfiguring the hardware.
- * - Each period starts with the inactive part.
  */
 
 #include <linux/clk.h>
@@ -163,7 +162,7 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Calculate duty value */
 	tmp = (unsigned long long)rate * state->duty_cycle;
 	do_div(tmp, NSEC_PER_SEC);
-	duty = period - tmp;
+	duty = tmp;
 
 	if (duty >= period)
 		duty = period - 1;
@@ -189,18 +188,26 @@ static int jz4740_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 			   TCU_TCSR_PWM_SD, TCU_TCSR_PWM_SD);
 
-	/* Set polarity */
-	switch (state->polarity) {
-	case PWM_POLARITY_NORMAL:
+	/*
+	 * Set polarity.
+	 *
+	 * The PWM starts in inactive state until the internal timer reaches the
+	 * duty value, then becomes active until the timer reaches the period
+	 * value. In theory, we should then use (period - duty) as the real duty
+	 * value, as a high duty value would otherwise result in the PWM pin
+	 * being inactive most of the time.
+	 *
+	 * Here, we don't do that, and instead invert the polarity of the PWM
+	 * when it is active. This trick makes the PWM start with its active
+	 * state instead of its inactive state.
+	 */
+	if ((state->polarity == PWM_POLARITY_NORMAL) ^ state->enabled)
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH, 0);
-		break;
-	case PWM_POLARITY_INVERSED:
+	else
 		regmap_update_bits(jz4740->map, TCU_REG_TCSRc(pwm->hwpwm),
 				   TCU_TCSR_PWM_INITL_HIGH,
 				   TCU_TCSR_PWM_INITL_HIGH);
-		break;
-	}
 
 	if (state->enabled)
 		jz4740_pwm_enable(chip, pwm);
-- 
2.26.2

