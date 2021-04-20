Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4523655C4
	for <lists+linux-pwm@lfdr.de>; Tue, 20 Apr 2021 11:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhDTJwO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 20 Apr 2021 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhDTJwN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 20 Apr 2021 05:52:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D696CC06174A
        for <linux-pwm@vger.kernel.org>; Tue, 20 Apr 2021 02:51:42 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYn2T-0001iF-SN; Tue, 20 Apr 2021 11:51:25 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lYn2R-0000PK-Pq; Tue, 20 Apr 2021 11:51:23 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: atmel: Improve duty cycle calculation in .apply()
Date:   Tue, 20 Apr 2021 11:51:18 +0200
Message-Id: <20210420095118.1571344-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
References: <20210420095118.1571344-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In the calculation of the register value determining the duty cycle the
requested period is used instead of the actually implemented period which
results in suboptimal settings.

The following example assumes an input clock of 133333333 Hz on one of
the SoCs with 16 bit period.

When the following state is to be applied:

        .period = 414727681
        .duty_cycle = 652806

the following register values used to be  calculated:

        PRES = 10
        CPRD = 54000
        CDTY = 53916

which yields an actual duty cycle of a bit more than 645120 ns.

The setting

        PRES = 10
        CPRD = 54000
        CDTY = 53915

however yields a duty of 652800 ns which is between the current result
and the requested value and so is a better approximation.

The reason for this error is that for the calculation of CDTY the
requested period was used instead of the actually implemented one.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index ebaeb50dcfde..29b5ad03f715 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -124,6 +124,7 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
 }
 
 static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
+					     unsigned long clkrate,
 					     const struct pwm_state *state,
 					     unsigned long *cprd, u32 *pres)
 {
@@ -132,7 +133,7 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 	int shift;
 
 	/* Calculate the period cycles and prescale value */
-	cycles *= clk_get_rate(atmel_pwm->clk);
+	cycles *= clkrate;
 	do_div(cycles, NSEC_PER_SEC);
 
 	/*
@@ -158,12 +159,14 @@ static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 }
 
 static void atmel_pwm_calculate_cdty(const struct pwm_state *state,
-				     unsigned long cprd, unsigned long *cdty)
+				     unsigned long clkrate, unsigned long cprd,
+				     u32 pres, unsigned long *cdty)
 {
 	unsigned long long cycles = state->duty_cycle;
 
-	cycles *= cprd;
-	do_div(cycles, state->period);
+	cycles *= clkrate;
+	do_div(cycles, NSEC_PER_SEC);
+	cycles >>= pres;
 	*cdty = cprd - cycles;
 }
 
@@ -244,17 +247,23 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	pwm_get_state(pwm, &cstate);
 
 	if (state->enabled) {
+		unsigned long clkrate = clk_get_rate(atmel_pwm->clk);
+
 		if (cstate.enabled &&
 		    cstate.polarity == state->polarity &&
 		    cstate.period == state->period) {
+			u32 cmr = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm, PWM_CMR);
+
 			cprd = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 						  atmel_pwm->data->regs.period);
-			atmel_pwm_calculate_cdty(state, cprd, &cdty);
+			pres = cmr & PWM_CMR_CPRE_MSK;
+
+			atmel_pwm_calculate_cdty(state, clkrate, cprd, pres, &cdty);
 			atmel_pwm_update_cdty(chip, pwm, cdty);
 			return 0;
 		}
 
-		ret = atmel_pwm_calculate_cprd_and_pres(chip, state, &cprd,
+		ret = atmel_pwm_calculate_cprd_and_pres(chip, clkrate, state, &cprd,
 							&pres);
 		if (ret) {
 			dev_err(chip->dev,
@@ -262,7 +271,7 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			return ret;
 		}
 
-		atmel_pwm_calculate_cdty(state, cprd, &cdty);
+		atmel_pwm_calculate_cdty(state, clkrate, cprd, pres, &cdty);
 
 		if (cstate.enabled) {
 			atmel_pwm_disable(chip, pwm, false);
-- 
2.30.2

