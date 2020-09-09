Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD82262F07
	for <lists+linux-pwm@lfdr.de>; Wed,  9 Sep 2020 15:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIINRp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 9 Sep 2020 09:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730373AbgIINRe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 9 Sep 2020 09:17:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45FBC06179B
        for <linux-pwm@vger.kernel.org>; Wed,  9 Sep 2020 06:07:58 -0700 (PDT)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzpB-0002t5-5r; Wed, 09 Sep 2020 15:07:45 +0200
Received: from mfe by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1kFzp9-0004WX-LR; Wed, 09 Sep 2020 15:07:43 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        michal.vokac@ysoft.com, l.majewski@majess.pl
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: imx27: fix disable state for inverted PWMs
Date:   Wed,  9 Sep 2020 15:07:39 +0200
Message-Id: <20200909130739.26717-4-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909130739.26717-1-m.felsch@pengutronix.de>
References: <20200909130739.26717-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Up to now disabling the PWM is done using the PWMCR.EN register bit.
Setting this bit to zero results in the output pin driving a low value
independent of the polarity setting (PWMCR.POUTC).

There is only little documentation about expectations and requirements
in the PWM framework but the usual expectation seems to be that
disabling a PWM or setting .duty_cycle = 0 results in the output driving
the inactive level. The pwm-bl driver for example uses this setting to
disable the backlight and with the pwm-imx27 driver this results in an
enabled backlight if the pwm signal is inverted.

Keep the PWMCR.EN bit always enabled and simulate a disabled PWM using
duty_cycle = 0 to fix this. Furthermore we have to drop the sw-reset
from apply() else the PWMCR.EN is cleared too. Therefore the
pwm_imx27_wait_fifo_slot() is extended to guarantee a free FIFO slot.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 drivers/pwm/pwm-imx27.c | 69 ++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 29 deletions(-)

diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
index 30388a9ece04..d98e8df14eb9 100644
--- a/drivers/pwm/pwm-imx27.c
+++ b/drivers/pwm/pwm-imx27.c
@@ -92,6 +92,7 @@ struct pwm_imx27_chip {
 	 */
 	unsigned int duty_cycle;
 	bool clk_on;
+	bool enabled;
 };
 
 #define to_pwm_imx27_chip(chip)	container_of(chip, struct pwm_imx27_chip, chip)
@@ -151,12 +152,9 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	if (ret < 0)
 		return;
 
-	val = readl(imx->mmio_base + MX3_PWMCR);
+	state->enabled = imx->enabled;
 
-	if (val & MX3_PWMCR_EN)
-		state->enabled = true;
-	else
-		state->enabled = false;
+	val = readl(imx->mmio_base + MX3_PWMCR);
 
 	switch (FIELD_GET(MX3_PWMCR_POUTC, val)) {
 	case MX3_PWMCR_POUTC_NORMAL:
@@ -179,8 +177,8 @@ static void pwm_imx27_get_state(struct pwm_chip *chip,
 	state->period = DIV_ROUND_UP_ULL(tmp, pwm_clk);
 
 	/*
-	 * PWMSAR can be read only if PWM is enabled. If the PWM is disabled,
-	 * use the cached value.
+	 * Use the cached value if the PWM is disabled since we are using the
+	 * PWMSAR to disable the PWM (see the notes in pwm_imx27_apply())
 	 */
 	if (state->enabled)
 		val = readl(imx->mmio_base + MX3_PWMSAR);
@@ -209,8 +207,8 @@ static void pwm_imx27_sw_reset(struct pwm_imx27_chip *imx, struct device *dev)
 		dev_warn(dev, "software reset timeout\n");
 }
 
-static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
-				     struct pwm_device *pwm)
+static int pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
+				    struct pwm_device *pwm)
 {
 	struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
 	struct device *dev = chip->dev;
@@ -226,9 +224,13 @@ static void pwm_imx27_wait_fifo_slot(struct pwm_chip *chip,
 		msleep(period_ms);
 
 		sr = readl(imx->mmio_base + MX3_PWMSR);
-		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr))
+		if (fifoav == FIELD_GET(MX3_PWMSR_FIFOAV, sr)) {
 			dev_warn(dev, "there is no free FIFO slot\n");
+			return -EBUSY;
+		}
 	}
+
+	return 0;
 }
 
 static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -270,17 +272,25 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	else
 		period_cycles = 0;
 
+	/* Wait for a free FIFO slot */
+	ret = pwm_imx27_wait_fifo_slot(chip, pwm);
+	if (ret)
+		goto out;
+
 	/*
-	 * Wait for a free FIFO slot if the PWM is already enabled, and flush
-	 * the FIFO if the PWM was disabled and is about to be enabled.
+	 * We can't use the enable bit to control the en-/disable squence
+	 * correctly because the output pin is pulled low if setting this bit
+	 * to '0' regardless of the poutc value. Instead we have to use the
+	 * sample register. According the RM:
+	 * A value of zero in the sample register will result in the PWMO output
+	 * signal always being low/high (POUTC = 00 it will be low and
+	 * POUTC = 01 it will be high), and no output waveform will be produced.
+	 * If the value in this register is higher than the PERIOD
 	 */
-	if (cstate.enabled) {
-		pwm_imx27_wait_fifo_slot(chip, pwm);
-	} else {
-		pwm_imx27_sw_reset(imx, chip->dev);
-	}
-
-	writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	if (state->enabled)
+		writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
+	else
+		writel(0, imx->mmio_base + MX3_PWMSAR);
 	writel(period_cycles, imx->mmio_base + MX3_PWMPR);
 
 	/*
@@ -288,24 +298,21 @@ static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * MX3_PWMSAR register can't be read (i.e. when the PWM is disabled).
 	 */
 	imx->duty_cycle = duty_cycles;
+	imx->enabled = state->enabled;
 
 	cr = MX3_PWMCR_PRESCALER_SET(prescale);
-
 	if (state->polarity == PWM_POLARITY_INVERSED)
-		cr |= FIELD_PREP(MX3_PWMCR_POUTC,
-				MX3_PWMCR_POUTC_INVERTED);
+		cr |= FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_INVERTED);
 
-	if (state->enabled)
-		cr |= MX3_PWMCR_EN;
-
-	mask = MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
+	mask = MX3_PWMCR_PRESCALER | MX3_PWMCR_POUTC;
 
 	pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, cr);
 
+out:
 	if (!state->enabled)
 		pwm_imx27_clk_disable_unprepare(imx);
 
-	return 0;
+	return ret;
 }
 
 static const struct pwm_ops pwm_imx27_ops = {
@@ -378,12 +385,16 @@ static int pwm_imx27_probe(struct platform_device *pdev)
 
 		pwm_imx27_sw_reset(imx, &pdev->dev);
 		mask = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
-			MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC;
+			MX3_PWMCR_DBGEN | MX3_PWMCR_CLKSRC | MX3_PWMCR_POUTC | MX3_PWMCR_EN;
 		pwmcr = MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
 			MX3_PWMCR_DBGEN |
-			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH);
+			FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
+			FIELD_PREP(MX3_PWMCR_POUTC, MX3_PWMCR_POUTC_OFF) |
+			MX3_PWMCR_EN;
 		pwm_imx27_update_bits(imx->mmio_base + MX3_PWMCR, mask, pwmcr);
 		pwm_imx27_clk_disable_unprepare(imx);
+	} else {
+		imx->enabled = true;
 	}
 
 	return pwmchip_add(&imx->chip);
-- 
2.20.1

