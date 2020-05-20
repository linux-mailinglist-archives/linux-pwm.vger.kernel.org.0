Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8C1DC26E
	for <lists+linux-pwm@lfdr.de>; Thu, 21 May 2020 00:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbgETW4T (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 May 2020 18:56:19 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18672 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728677AbgETW4J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 May 2020 18:56:09 -0400
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 May 2020 15:56:07 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg05-sd.qualcomm.com with ESMTP; 20 May 2020 15:56:06 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id A04134DD3; Wed, 20 May 2020 15:56:06 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [RESEND PATCH v14 06/11] pwm: imx27: Use 64-bit division macro and function
Date:   Wed, 20 May 2020 15:55:59 -0700
Message-Id: <de0bebdbfffd28c87f50bb6ef1751d352fb960a2.1589330178.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1589330178.git.gurus@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
In-Reply-To: <cover.1589330178.git.gurus@codeaurora.org>
References: <cover.1589330178.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_state.period's
datatype to u64, prepare for this transition by using
DIV_ROUND_UP_ULL to handle a 64-bit dividend, and div64_u64 to handle a
64-bit divisor.

Also handle a possible overflow in the calculation of period_cycles when
both clk_rate and period are large numbers. This logic was unit-tested
out by calculating period_cycles using both the existing logic and the
proposed one, and the results are as below.

----------------------------------------------------------------------------
 clk_rate            period           existing            proposed
----------------------------------------------------------------------------
1000000000   18446744073709551615    18446744072    18446744073000000000
                   (U64_MAX)
----------------------------------------------------------------------------
1000000000        4294967291         4294967291         4294967291
----------------------------------------------------------------------------

Overflow occurs in the first case with the existing logic, whereas the
proposed logic handles it better, sacrificing some precision in a best-effort
attempt to handle overflow. As for the second case where there are
more typical values of period, the proposed logic handles that correctly
too.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-imx27.c | 53 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index a6e40d4..164cb65 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -203,7 +203,7 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 	sr = readl(imx->mmio_base + MX3_PWMSR);
 	fifoav = FIELD_GET(MX3_PWMSR_FIFOAV, sr);
 	if (fifoav == MX3_PWMSR_FIFOAV_4WORDS) {
-		period_ms = DIV_ROUND_UP(pwm_get_period(pwm),
+		period_ms = DIV_ROUND_UP_ULL(pwm_get_period(pwm),
 					 NSEC_PER_MSEC);
 		msleep(period_ms);
 
@@ -213,6 +213,45 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 	}
 }
 
+static int pwm_imx27_calc_period_cycles(const struct pwm_state *state,
+					unsigned long clk_rate,
+					unsigned long *period_cycles)
+{
+	u64 c = 0, c1, c2;
+
+	c1 = clk_rate;
+	c2 = state->period;
+	if (c2 > c1) {
+		c2 = c1;
+		c1 = state->period;
+	}
+
+	if (!c1 || !c2) {
+		pr_err("clk rate and period should be nonzero\n");
+		return -EINVAL;
+	}
+
+	if (c2 <= div64_u64(U64_MAX, c1)) {
+		c = c1 * c2;
+		do_div(c, 1000000000);
+	} else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000))) {
+		do_div(c1, 1000);
+		c = c1 * c2;
+		do_div(c, 1000000);
+	} else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000))) {
+		do_div(c1, 1000000);
+		c = c1 * c2;
+		do_div(c, 1000);
+	} else if (c2 <= div64_u64(U64_MAX, div64_u64(c1, 1000000000))) {
+		do_div(c1, 1000000000);
+		c = c1 * c2;
+	}
+
+	*period_cycles = c;
+
+	return 0;
+}
+
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			   const struct pwm_state *state)
 {
@@ -225,18 +264,16 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	pwm_get_state(pwm, &cstate);
 
-	c = clk_get_rate(imx->clk_per);
-	c *= state->period;
-
-	do_div(c, 1000000000);
-	period_cycles = c;
+	ret = pwm_imx27_calc_period_cycles(state, clk_get_rate(imx->clk_per),
+					   &period_cycles);
+	if (ret)
+		return ret;
 
 	prescale = period_cycles / 0x10000 + 1;
 
 	period_cycles /= prescale;
 	c = (unsigned long long)period_cycles * state->duty_cycle;
-	do_div(c, state->period);
-	duty_cycles = c;
+	duty_cycles = div64_u64(c, state->period);
 
 	/*
 	 * according to imx pwm RM, the real period value should be PERIOD
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

