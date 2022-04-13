Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38A4FF2BB
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Apr 2022 10:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiDMIyX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Apr 2022 04:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbiDMIxc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2022 04:53:32 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F11645521
        for <linux-pwm@vger.kernel.org>; Wed, 13 Apr 2022 01:51:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiO-0006XC-8U; Wed, 13 Apr 2022 10:51:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiM-002kHC-AH; Wed, 13 Apr 2022 10:51:00 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiK-002yxM-4Y; Wed, 13 Apr 2022 10:51:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 4/6] pwm: renesas-tpu: Rename variables to match the usual naming
Date:   Wed, 13 Apr 2022 10:50:48 +0200
Message-Id: <20220413085050.61144-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11426; h=from:subject; bh=RAN+Sgmd0OlLs64H2z+B6ZCNu3MmR6N1zXMaR2oWcW8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiVo7fcuPXFIO472fD1KEeWIlaW3S7/eMgdnXQEllU os2SIDCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlaO3wAKCRDB/BR4rcrsCXzwB/ wMuS1Uf5XBebMV8f0oSvknTSSFhBNxw/DnoKK7HkOFFRVMHh8c6jsp5+xk9DCSxO/HMeEHDhUfKLhl H5i4aDKTZqMYBe59/uueIfkcOo88PqMkrDBExutcJU9GO/3PJsJpB0dRiDJckovMizl8037ALVoPMK F3+85f8hcJtxL2VXi5N1LUdqUN7qMU6wFkiNGU7RXAV24zMBStRBwI4XvKvCAXFAGDHqql5yzclEGC GVaCF/rK/Uy8rIb4EfXxSNUZ/UlkgqVYQQe9tfiqaIg7Lex6hWbopRh/5/Pkh45QpZpsaVi16B5IfA sGithOdCh300615XtqcNlZWRVmZda/
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver used "pwm" for struct tpu_pwm_device pointers. This name is
usually only used for struct pwm_device pointers which this driver calls
"_pwm". So rename to the driver data pointers to "tpd" which then allows
to drop the underscore from "_pwm".

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 172 +++++++++++++++++-----------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 100c21e27648..671f1f824da8 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -89,71 +89,71 @@ struct tpu_device {
 
 #define to_tpu_device(c)	container_of(c, struct tpu_device, chip)
 
-static void tpu_pwm_write(struct tpu_pwm_device *pwm, int reg_nr, u16 value)
+static void tpu_pwm_write(struct tpu_pwm_device *tpd, int reg_nr, u16 value)
 {
-	void __iomem *base = pwm->tpu->base + TPU_CHANNEL_OFFSET
-			   + pwm->channel * TPU_CHANNEL_SIZE;
+	void __iomem *base = tpd->tpu->base + TPU_CHANNEL_OFFSET
+			   + tpd->channel * TPU_CHANNEL_SIZE;
 
 	iowrite16(value, base + reg_nr);
 }
 
-static void tpu_pwm_set_pin(struct tpu_pwm_device *pwm,
+static void tpu_pwm_set_pin(struct tpu_pwm_device *tpd,
 			    enum tpu_pin_state state)
 {
 	static const char * const states[] = { "inactive", "PWM", "active" };
 
-	dev_dbg(&pwm->tpu->pdev->dev, "%u: configuring pin as %s\n",
-		pwm->channel, states[state]);
+	dev_dbg(&tpd->tpu->pdev->dev, "%u: configuring pin as %s\n",
+		tpd->channel, states[state]);
 
 	switch (state) {
 	case TPU_PIN_INACTIVE:
-		tpu_pwm_write(pwm, TPU_TIORn,
-			      pwm->polarity == PWM_POLARITY_INVERSED ?
+		tpu_pwm_write(tpd, TPU_TIORn,
+			      tpd->polarity == PWM_POLARITY_INVERSED ?
 			      TPU_TIOR_IOA_1 : TPU_TIOR_IOA_0);
 		break;
 	case TPU_PIN_PWM:
-		tpu_pwm_write(pwm, TPU_TIORn,
-			      pwm->polarity == PWM_POLARITY_INVERSED ?
+		tpu_pwm_write(tpd, TPU_TIORn,
+			      tpd->polarity == PWM_POLARITY_INVERSED ?
 			      TPU_TIOR_IOA_0_SET : TPU_TIOR_IOA_1_CLR);
 		break;
 	case TPU_PIN_ACTIVE:
-		tpu_pwm_write(pwm, TPU_TIORn,
-			      pwm->polarity == PWM_POLARITY_INVERSED ?
+		tpu_pwm_write(tpd, TPU_TIORn,
+			      tpd->polarity == PWM_POLARITY_INVERSED ?
 			      TPU_TIOR_IOA_0 : TPU_TIOR_IOA_1);
 		break;
 	}
 }
 
-static void tpu_pwm_start_stop(struct tpu_pwm_device *pwm, int start)
+static void tpu_pwm_start_stop(struct tpu_pwm_device *tpd, int start)
 {
 	unsigned long flags;
 	u16 value;
 
-	spin_lock_irqsave(&pwm->tpu->lock, flags);
-	value = ioread16(pwm->tpu->base + TPU_TSTR);
+	spin_lock_irqsave(&tpd->tpu->lock, flags);
+	value = ioread16(tpd->tpu->base + TPU_TSTR);
 
 	if (start)
-		value |= 1 << pwm->channel;
+		value |= 1 << tpd->channel;
 	else
-		value &= ~(1 << pwm->channel);
+		value &= ~(1 << tpd->channel);
 
-	iowrite16(value, pwm->tpu->base + TPU_TSTR);
-	spin_unlock_irqrestore(&pwm->tpu->lock, flags);
+	iowrite16(value, tpd->tpu->base + TPU_TSTR);
+	spin_unlock_irqrestore(&tpd->tpu->lock, flags);
 }
 
-static int tpu_pwm_timer_start(struct tpu_pwm_device *pwm)
+static int tpu_pwm_timer_start(struct tpu_pwm_device *tpd)
 {
 	int ret;
 
-	if (!pwm->timer_on) {
+	if (!tpd->timer_on) {
 		/* Wake up device and enable clock. */
-		pm_runtime_get_sync(&pwm->tpu->pdev->dev);
-		ret = clk_prepare_enable(pwm->tpu->clk);
+		pm_runtime_get_sync(&tpd->tpu->pdev->dev);
+		ret = clk_prepare_enable(tpd->tpu->clk);
 		if (ret) {
-			dev_err(&pwm->tpu->pdev->dev, "cannot enable clock\n");
+			dev_err(&tpd->tpu->pdev->dev, "cannot enable clock\n");
 			return ret;
 		}
-		pwm->timer_on = true;
+		tpd->timer_on = true;
 	}
 
 	/*
@@ -161,8 +161,8 @@ static int tpu_pwm_timer_start(struct tpu_pwm_device *pwm)
 	 * completely. First drive the pin to the inactive state to avoid
 	 * glitches.
 	 */
-	tpu_pwm_set_pin(pwm, TPU_PIN_INACTIVE);
-	tpu_pwm_start_stop(pwm, false);
+	tpu_pwm_set_pin(tpd, TPU_PIN_INACTIVE);
+	tpu_pwm_start_stop(tpd, false);
 
 	/*
 	 * - Clear TCNT on TGRB match
@@ -172,80 +172,80 @@ static int tpu_pwm_timer_start(struct tpu_pwm_device *pwm)
 	 * - Output 1 until TGRA, output 0 until TGRB (active high polarity
 	 * - PWM mode
 	 */
-	tpu_pwm_write(pwm, TPU_TCRn, TPU_TCR_CCLR_TGRB | TPU_TCR_CKEG_RISING |
-		      pwm->prescaler);
-	tpu_pwm_write(pwm, TPU_TMDRn, TPU_TMDR_MD_PWM);
-	tpu_pwm_set_pin(pwm, TPU_PIN_PWM);
-	tpu_pwm_write(pwm, TPU_TGRAn, pwm->duty);
-	tpu_pwm_write(pwm, TPU_TGRBn, pwm->period);
+	tpu_pwm_write(tpd, TPU_TCRn, TPU_TCR_CCLR_TGRB | TPU_TCR_CKEG_RISING |
+		      tpd->prescaler);
+	tpu_pwm_write(tpd, TPU_TMDRn, TPU_TMDR_MD_PWM);
+	tpu_pwm_set_pin(tpd, TPU_PIN_PWM);
+	tpu_pwm_write(tpd, TPU_TGRAn, tpd->duty);
+	tpu_pwm_write(tpd, TPU_TGRBn, tpd->period);
 
-	dev_dbg(&pwm->tpu->pdev->dev, "%u: TGRA 0x%04x TGRB 0x%04x\n",
-		pwm->channel, pwm->duty, pwm->period);
+	dev_dbg(&tpd->tpu->pdev->dev, "%u: TGRA 0x%04x TGRB 0x%04x\n",
+		tpd->channel, tpd->duty, tpd->period);
 
 	/* Start the channel. */
-	tpu_pwm_start_stop(pwm, true);
+	tpu_pwm_start_stop(tpd, true);
 
 	return 0;
 }
 
-static void tpu_pwm_timer_stop(struct tpu_pwm_device *pwm)
+static void tpu_pwm_timer_stop(struct tpu_pwm_device *tpd)
 {
-	if (!pwm->timer_on)
+	if (!tpd->timer_on)
 		return;
 
 	/* Disable channel. */
-	tpu_pwm_start_stop(pwm, false);
+	tpu_pwm_start_stop(tpd, false);
 
 	/* Stop clock and mark device as idle. */
-	clk_disable_unprepare(pwm->tpu->clk);
-	pm_runtime_put(&pwm->tpu->pdev->dev);
+	clk_disable_unprepare(tpd->tpu->clk);
+	pm_runtime_put(&tpd->tpu->pdev->dev);
 
-	pwm->timer_on = false;
+	tpd->timer_on = false;
 }
 
 /* -----------------------------------------------------------------------------
  * PWM API
  */
 
-static int tpu_pwm_request(struct pwm_chip *chip, struct pwm_device *_pwm)
+static int tpu_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct tpu_device *tpu = to_tpu_device(chip);
-	struct tpu_pwm_device *pwm;
+	struct tpu_pwm_device *tpd;
 
-	if (_pwm->hwpwm >= TPU_CHANNEL_MAX)
+	if (pwm->hwpwm >= TPU_CHANNEL_MAX)
 		return -EINVAL;
 
-	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
-	if (pwm == NULL)
+	tpd = kzalloc(sizeof(*tpd), GFP_KERNEL);
+	if (tpd == NULL)
 		return -ENOMEM;
 
-	pwm->tpu = tpu;
-	pwm->channel = _pwm->hwpwm;
-	pwm->polarity = PWM_POLARITY_NORMAL;
-	pwm->prescaler = 0;
-	pwm->period = 0;
-	pwm->duty = 0;
+	tpd->tpu = tpu;
+	tpd->channel = pwm->hwpwm;
+	tpd->polarity = PWM_POLARITY_NORMAL;
+	tpd->prescaler = 0;
+	tpd->period = 0;
+	tpd->duty = 0;
 
-	pwm->timer_on = false;
+	tpd->timer_on = false;
 
-	pwm_set_chip_data(_pwm, pwm);
+	pwm_set_chip_data(pwm, tpd);
 
 	return 0;
 }
 
-static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *_pwm)
+static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
+	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 
-	tpu_pwm_timer_stop(pwm);
-	kfree(pwm);
+	tpu_pwm_timer_stop(tpd);
+	kfree(tpd);
 }
 
-static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
+static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns, bool enabled)
 {
 	static const unsigned int prescalers[] = { 1, 4, 16, 64 };
-	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
+	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 	struct tpu_device *tpu = to_tpu_device(chip);
 	unsigned int prescaler;
 	bool duty_only = false;
@@ -285,29 +285,29 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 		"rate %u, prescaler %u, period %u, duty %u\n",
 		clk_rate, prescalers[prescaler], period, duty);
 
-	if (pwm->prescaler == prescaler && pwm->period == period)
+	if (tpd->prescaler == prescaler && tpd->period == period)
 		duty_only = true;
 
-	pwm->prescaler = prescaler;
-	pwm->period = period;
-	pwm->duty = duty;
+	tpd->prescaler = prescaler;
+	tpd->period = period;
+	tpd->duty = duty;
 
 	/* If the channel is disabled we're done. */
 	if (!enabled)
 		return 0;
 
-	if (duty_only && pwm->timer_on) {
+	if (duty_only && tpd->timer_on) {
 		/*
 		 * If only the duty cycle changed and the timer is already
 		 * running, there's no need to reconfigure it completely, Just
 		 * modify the duty cycle.
 		 */
-		tpu_pwm_write(pwm, TPU_TGRAn, pwm->duty);
-		dev_dbg(&tpu->pdev->dev, "%u: TGRA 0x%04x\n", pwm->channel,
-			pwm->duty);
+		tpu_pwm_write(tpd, TPU_TGRAn, tpd->duty);
+		dev_dbg(&tpu->pdev->dev, "%u: TGRA 0x%04x\n", tpd->channel,
+			tpd->duty);
 	} else {
 		/* Otherwise perform a full reconfiguration. */
-		ret = tpu_pwm_timer_start(pwm);
+		ret = tpu_pwm_timer_start(tpd);
 		if (ret < 0)
 			return ret;
 	}
@@ -317,29 +317,29 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *_pwm,
 		 * To avoid running the timer when not strictly required, handle
 		 * 0% and 100% duty cycles as fixed levels and stop the timer.
 		 */
-		tpu_pwm_set_pin(pwm, duty ? TPU_PIN_ACTIVE : TPU_PIN_INACTIVE);
-		tpu_pwm_timer_stop(pwm);
+		tpu_pwm_set_pin(tpd, duty ? TPU_PIN_ACTIVE : TPU_PIN_INACTIVE);
+		tpu_pwm_timer_stop(tpd);
 	}
 
 	return 0;
 }
 
-static int tpu_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *_pwm,
+static int tpu_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 				enum pwm_polarity polarity)
 {
-	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
+	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 
-	pwm->polarity = polarity;
+	tpd->polarity = polarity;
 
 	return 0;
 }
 
-static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *_pwm)
+static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
+	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 	int ret;
 
-	ret = tpu_pwm_timer_start(pwm);
+	ret = tpu_pwm_timer_start(tpd);
 	if (ret < 0)
 		return ret;
 
@@ -347,23 +347,23 @@ static int tpu_pwm_enable(struct pwm_chip *chip, struct pwm_device *_pwm)
 	 * To avoid running the timer when not strictly required, handle 0% and
 	 * 100% duty cycles as fixed levels and stop the timer.
 	 */
-	if (pwm->duty == 0 || pwm->duty == pwm->period) {
-		tpu_pwm_set_pin(pwm, pwm->duty ?
+	if (tpd->duty == 0 || tpd->duty == tpd->period) {
+		tpu_pwm_set_pin(tpd, tpd->duty ?
 				TPU_PIN_ACTIVE : TPU_PIN_INACTIVE);
-		tpu_pwm_timer_stop(pwm);
+		tpu_pwm_timer_stop(tpd);
 	}
 
 	return 0;
 }
 
-static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *_pwm)
+static void tpu_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tpu_pwm_device *pwm = pwm_get_chip_data(_pwm);
+	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 
 	/* The timer must be running to modify the pin output configuration. */
-	tpu_pwm_timer_start(pwm);
-	tpu_pwm_set_pin(pwm, TPU_PIN_INACTIVE);
-	tpu_pwm_timer_stop(pwm);
+	tpu_pwm_timer_start(tpd);
+	tpu_pwm_set_pin(tpd, TPU_PIN_INACTIVE);
+	tpu_pwm_timer_stop(tpd);
 }
 
 static int tpu_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.35.1

