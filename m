Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889EB278D3E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Sep 2020 17:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgIYPxn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 25 Sep 2020 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgIYPxn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 25 Sep 2020 11:53:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C7FC0613CE
        for <linux-pwm@vger.kernel.org>; Fri, 25 Sep 2020 08:53:43 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kLq2S-0000oQ-Ki; Fri, 25 Sep 2020 17:53:36 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kLq2Q-0008QC-Sy; Fri, 25 Sep 2020 17:53:34 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] pwm: imx27: enable clock unconditional for register access
Date:   Fri, 25 Sep 2020 17:53:26 +0200
Message-Id: <20200925155330.32301-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925155330.32301-1-m.felsch@pengutronix.de>
References: <20200925155330.32301-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The current implementation enables the clock if the current PWM state
is '!enabled' to ensure the register access and left the clock on if the
new state is 'enabled'. Further apply calls don't enable the clock since
they relying on the fact the the clock is already running. Change this
behaviour since it is not very intuitive.

This commit changes this behaviour. Now the clocks are unconditional
enabled/disabled before/after the register access. If the PWM should be
turned on (state.enabled) we enable the clock again and vice versa if
the PWM should be turned off (!state.enabled).

Therefore I added the enable member to the driver state struct since
the usage of cstate and pwm_get_state() is a layer violation. I removed
this violation while on it.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
v2:
- use enable var which can be shared later on
- remove cstate and pwm_get_state() layer violation
- explicite enable/disable the clock twice if the pwm should be
  enabled/disabled rather than tracking the clock usage within the
  pwm_imx27_clk_prepare_enable() state.
- rename commit message

 drivers/pwm/pwm-imx27.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index c50d453552bd..7edac4ac6395 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -91,6 +91,7 @@ struct pwm_imx27_chip {
 	 * value to return in that case.
 	 */
 	unsigned int duty_cycle;
+	bool enabled;
 };
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
@@ -217,13 +218,14 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	unsigned long period_cycles, duty_cycles, prescale;
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
-	struct pwm_state cstate;
 	unsigned long long c;
 	unsigned long long clkrate;
 	int ret;
 	u32 cr;
 
-	pwm_get_state(pwm, &cstate);
+	ret = pwm_imx27_clk_prepare_enable(imx);
+	if (ret)
+		return ret;
 
 	clkrate = clk_get_rate(imx->clk_per);
 	c = clkrate * state->period;
@@ -251,15 +253,10 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
 	 * the FIFO if the PWM was disabled and is about to be enabled.
 	 */
-	if (cstate.enabled) {
+	if (imx->enabled)
 		pwm_imx27_wait_fifo_slot(chip, pwm);
-	} else {
-		ret = pwm_imx27_clk_prepare_enable(imx);
-		if (ret)
-			return ret;
-
+	else
 		pwm_imx27_sw_reset(chip);
-	}
 
 	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
@@ -284,10 +281,21 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writel(cr, imx->mmio_base + MX3_PWMCR);
 
-	if (!state->enabled)
-		pwm_imx27_clk_disable_unprepare(imx);
+	if (imx->enabled != state->enabled) {
+		if (state->enabled) {
+			ret = pwm_imx27_clk_prepare_enable(imx);
+			if (ret)
+				goto out;
+		} else {
+			pwm_imx27_clk_disable_unprepare(imx);
+		}
+		imx->enabled = state->enabled;
+	}
 
-	return 0;
+out:
+	pwm_imx27_clk_disable_unprepare(imx);
+
+	return ret;
 }
 
 static const struct pwm_ops pwm_imx27_ops = {
-- 
2.20.1

