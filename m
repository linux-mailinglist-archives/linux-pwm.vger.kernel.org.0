Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5151ABAC1
	for <lists+linux-pwm@lfdr.de>; Thu, 16 Apr 2020 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439837AbgDPIDF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 16 Apr 2020 04:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2439759AbgDPIC6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 16 Apr 2020 04:02:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98CB3C061A0C
        for <linux-pwm@vger.kernel.org>; Thu, 16 Apr 2020 01:02:58 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOzU6-0005Pu-Ox; Thu, 16 Apr 2020 10:02:54 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOzU5-0005D8-Ge; Thu, 16 Apr 2020 10:02:53 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: imx27: Fix rounding behavior
Date:   Thu, 16 Apr 2020 10:02:45 +0200
Message-Id: <20200416080245.3203-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To not trigger the warnings provided by CONFIG_PWM_DEBUG

 - use up-rounding in .get_state()
 - don't divide by the result of a division
 - don't use the rounded counter value for the period length to calculate
   the counter value for the duty cycle

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index a6e40d4c485f..732a6f3701e8 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -150,13 +150,12 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 
 	prescaler = MX3_PWMCR_PRESCALER_GET(val);
 	pwm_clk = clk_get_rate(imx->clk_per);
-	pwm_clk = DIV_ROUND_CLOSEST_ULL(pwm_clk, prescaler);
 	val = readl(imx->mmio_base + MX3_PWMPR);
 	period = val >= MX3_PWMPR_MAX ? MX3_PWMPR_MAX : val;
 
 	/* PWMOUT (Hz) = PWMCLK / (PWMPR + 2) */
-	tmp = NSEC_PER_SEC * (u64)(period + 2);
-	state->period = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
+	tmp = NSEC_PER_SEC * (u64)(period + 2) * prescaler;
+	state->period = DIV_ROUND_UP_ULL(tmp, pwm_clk);
 
 	/*
 	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
@@ -167,8 +166,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	else
 		val = imx->duty_cycle;
 
-	tmp = NSEC_PER_SEC * (u64)(val);
-	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, pwm_clk);
+	tmp = NSEC_PER_SEC * (u64)(val) * prescaler;
+	state->duty_cycle = DIV_ROUND_UP_ULL(tmp, pwm_clk);
 
 	pwm_imx27_clk_disable_unprepare(imx);
 }
@@ -220,22 +219,23 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	struct pwm_state cstate;
 	unsigned long long c;
+	unsigned long long clkrate;
 	int ret;
 	u32 cr;
 
 	pwm_get_state(pwm, &cstate);
 
-	c = clk_get_rate(imx->clk_per);
-	c *= state->period;
+	clkrate = clk_get_rate(imx->clk_per);
+	c = clkrate * state->period;
 
-	do_div(c, 1000000000);
+	do_div(c, NSEC_PER_SEC);
 	period_cycles = c;
 
 	prescale = period_cycles / 0x10000 + 1;
 
 	period_cycles /= prescale;
-	c = (unsigned long long)period_cycles * state->duty_cycle;
-	do_div(c, state->period);
+	c = clkrate * state->duty_cycle;
+	do_div(c, NSEC_PER_SEC * prescale);
 	duty_cycles = c;
 
 	/*
-- 
2.26.0.rc2

