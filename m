Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30163330A5F
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Mar 2021 10:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCHJia (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Mar 2021 04:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhCHJiK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Mar 2021 04:38:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F873C06174A
        for <linux-pwm@vger.kernel.org>; Mon,  8 Mar 2021 01:38:10 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJCKx-0000Xx-Tx; Mon, 08 Mar 2021 10:38:03 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJCKx-0001F2-8D; Mon, 08 Mar 2021 10:38:03 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: atmel-tcp: Implement .apply callback
Date:   Mon,  8 Mar 2021 10:37:55 +0100
Message-Id: <20210308093755.25580-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is just pushing down the core's compat code down into the driver using
the legacy callback nearly unchanged. The call to .enable() was just
dropped from .config() because .apply() calls it unconditionally.
---
 drivers/pwm/pwm-atmel-tcb.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-tcb.c b/drivers/pwm/pwm-atmel-tcb.c
index 251c9f205ca0..8451d3e846be 100644
--- a/drivers/pwm/pwm-atmel-tcb.c
+++ b/drivers/pwm/pwm-atmel-tcb.c
@@ -362,20 +362,37 @@ static int atmel_tcb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	tcbpwm->div = i;
 	tcbpwm->duty = duty;
 
-	/* If the PWM is enabled, call enable to apply the new conf */
-	if (pwm_is_enabled(pwm))
-		atmel_tcb_pwm_enable(chip, pwm);
-
 	return 0;
 }
 
+static int atmel_tcb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			       const struct pwm_state *state)
+{
+	int duty_cycle, period;
+	int ret;
+
+	/* This function only sets a flag in driver data */
+	atmel_tcb_pwm_set_polarity(chip, pwm, state->polarity);
+
+	if (!state->enabled) {
+		atmel_tcb_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	period = state->period < INT_MAX ? state->period : INT_MAX;
+	duty_cycle = state->duty_cycle < INT_MAX ? state->duty_cycle : INT_MAX;
+
+	ret = atmel_tcb_pwm_config(chip, pwm, duty_cycle, period);
+	if (ret)
+		return ret;
+
+	return atmel_tcb_pwm_enable(chip, pwm);
+}
+
 static const struct pwm_ops atmel_tcb_pwm_ops = {
 	.request = atmel_tcb_pwm_request,
 	.free = atmel_tcb_pwm_free,
-	.config = atmel_tcb_pwm_config,
-	.set_polarity = atmel_tcb_pwm_set_polarity,
-	.enable = atmel_tcb_pwm_enable,
-	.disable = atmel_tcb_pwm_disable,
+	.apply = atmel_tcb_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.1

