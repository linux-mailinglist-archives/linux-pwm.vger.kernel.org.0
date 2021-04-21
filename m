Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D53667FA
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Apr 2021 11:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238119AbhDUJ15 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 21 Apr 2021 05:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDUJ14 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 21 Apr 2021 05:27:56 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0072C06174A
        for <linux-pwm@vger.kernel.org>; Wed, 21 Apr 2021 02:27:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZ98c-0000GP-Mo; Wed, 21 Apr 2021 11:27:14 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZ98b-0001zu-MR; Wed, 21 Apr 2021 11:27:13 +0200
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
Subject: [PATCH] pwm: atmel: rework tracking updates pending in hardware
Date:   Wed, 21 Apr 2021 11:26:08 +0200
Message-Id: <20210421092606.1634092-1-u.kleine-koenig@pengutronix.de>
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

This improves the driver's behavior in several ways:

 - The lock is held for shorter periods and so a channel that is currently
   waited for doesn't block disabling another channel.

 - It's easier to understand because the procedure is split into more
   semantic units and documentation is improved

 - A channel is only set to pending when such an event is actually
   scheduled in hardware (by writing the CUPD register).

 - Also wait in .get_state() to report the last configured state instead
   of (maybe) the previous one. This fixes the read back duty cycle and so
   prevents a warning being emitted when PWM_DEBUG is on.

Tested on an AriettaG25.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I tested this patch on top of the series I sent for this driver
yesterday. (I set In-Reply-To accordingly.)

With these three patches PWM_DEBUG is now happy. (At least I couldn't
trigger a warning any more. I think there are still a few problems with
integer overflows.)

Best regards
Uwe

 drivers/pwm/pwm-atmel.c | 101 +++++++++++++++++++++++++++++++---------
 1 file changed, 78 insertions(+), 23 deletions(-)

diff --git a/drivers/pwm/pwm-atmel.c b/drivers/pwm/pwm-atmel.c
index 29b5ad03f715..38d86340201c 100644
--- a/drivers/pwm/pwm-atmel.c
+++ b/drivers/pwm/pwm-atmel.c
@@ -84,9 +84,19 @@ struct atmel_pwm_chip {
 	void __iomem *base;
 	const struct atmel_pwm_data *data;
 
-	unsigned int updated_pwms;
-	/* ISR is cleared when read, ensure only one thread does that */
-	struct mutex isr_lock;
+	/*
+	 * The hardware supports a mechanism to update a channel's duty cycle at
+	 * the end of the currently running period. When such an update is
+	 * pending we delay disabling the PWM until the new configuration is
+	 * active because otherwise pmw_config(duty_cycle=0); pwm_disable();
+	 * might not result in an inactive output.
+	 * This bitmask tracks for which channels an update is pending in
+	 * hardware.
+	 */
+	u32 update_pending;
+
+	/* Protects .update_pending */
+	spinlock_t lock;
 };
 
 static inline struct atmel_pwm_chip *to_atmel_pwm_chip(struct pwm_chip *chip)
@@ -123,6 +133,63 @@ static inline void atmel_pwm_ch_writel(struct atmel_pwm_chip *chip,
 	atmel_pwm_writel(chip, base + offset, val);
 }
 
+static void atmel_pwm_update_pending(struct atmel_pwm_chip *chip)
+{
+	/*
+	 * Each channel that has its bit in ISR set started a new period since
+	 * ISR was cleared and so there is no more update pending.  Note that
+	 * reading ISR clears it, so this needs to handle all channels to not
+	 * loose information.
+	 */
+	u32 isr = atmel_pwm_readl(chip, PWM_ISR);
+	chip->update_pending &= ~isr;
+}
+
+static void atmel_pwm_set_pending(struct atmel_pwm_chip *chip, unsigned int ch)
+{
+	spin_lock(&chip->lock);
+
+	/*
+	 * Clear pending flags in hardware because otherwise there might still
+	 * be a stale flag in ISR.
+	 */
+	atmel_pwm_update_pending(chip);
+
+	chip->update_pending |= (1 << ch);
+
+	spin_unlock(&chip->lock);
+}
+
+static int atmel_pwm_test_pending(struct atmel_pwm_chip *chip, unsigned int ch)
+{
+	int ret = 0;
+
+	spin_lock(&chip->lock);
+
+	if (chip->update_pending & (1 << ch)) {
+		atmel_pwm_update_pending(chip);
+
+		if (chip->update_pending & (1 << ch))
+			ret = 1;
+	}
+
+	spin_unlock(&chip->lock);
+
+	return ret;
+}
+
+static int atmel_pwm_wait_nonpending(struct atmel_pwm_chip *chip, unsigned int ch)
+{
+	unsigned long timeout = jiffies + 2 * HZ;
+	int ret;
+
+	while ((ret = atmel_pwm_test_pending(chip, ch)) &&
+	       time_before(jiffies, timeout))
+		usleep_range(10, 100);
+
+	return ret ? -ETIMEDOUT : 0;
+}
+
 static int atmel_pwm_calculate_cprd_and_pres(struct pwm_chip *chip,
 					     unsigned long clkrate,
 					     const struct pwm_state *state,
@@ -185,6 +252,7 @@ static void atmel_pwm_update_cdty(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm,
 			    atmel_pwm->data->regs.duty_upd, cdty);
+	atmel_pwm_set_pending(atmel_pwm, pwm->hwpwm);
 }
 
 static void atmel_pwm_set_cprd_cdty(struct pwm_chip *chip,
@@ -205,20 +273,8 @@ static void atmel_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct atmel_pwm_chip *atmel_pwm = to_atmel_pwm_chip(chip);
 	unsigned long timeout = jiffies + 2 * HZ;
 
-	/*
-	 * Wait for at least a complete period to have passed before disabling a
-	 * channel to be sure that CDTY has been updated
-	 */
-	mutex_lock(&atmel_pwm->isr_lock);
-	atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
-
-	while (!(atmel_pwm->updated_pwms & (1 << pwm->hwpwm)) &&
-	       time_before(jiffies, timeout)) {
-		usleep_range(10, 100);
-		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
-	}
+	atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);
 
-	mutex_unlock(&atmel_pwm->isr_lock);
 	atmel_pwm_writel(atmel_pwm, PWM_DIS, 1 << pwm->hwpwm);
 
 	/*
@@ -292,10 +348,6 @@ static int atmel_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			val |= PWM_CMR_CPOL;
 		atmel_pwm_ch_writel(atmel_pwm, pwm->hwpwm, PWM_CMR, val);
 		atmel_pwm_set_cprd_cdty(chip, pwm, cprd, cdty);
-		mutex_lock(&atmel_pwm->isr_lock);
-		atmel_pwm->updated_pwms |= atmel_pwm_readl(atmel_pwm, PWM_ISR);
-		atmel_pwm->updated_pwms &= ~(1 << pwm->hwpwm);
-		mutex_unlock(&atmel_pwm->isr_lock);
 		atmel_pwm_writel(atmel_pwm, PWM_ENA, 1 << pwm->hwpwm);
 	} else if (cstate.enabled) {
 		atmel_pwm_disable(chip, pwm, true);
@@ -326,6 +378,9 @@ static void atmel_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		tmp <<= pres;
 		state->period = DIV64_U64_ROUND_UP(tmp, rate);
 
+		/* Wait for an updated duty_cycle queued in hardware */
+		atmel_pwm_wait_nonpending(atmel_pwm, pwm->hwpwm);
+
 		cdty = atmel_pwm_ch_readl(atmel_pwm, pwm->hwpwm,
 					  atmel_pwm->data->regs.duty);
 		tmp = (u64)(cprd - cdty) * NSEC_PER_SEC;
@@ -416,9 +471,10 @@ static int atmel_pwm_probe(struct platform_device *pdev)
 	if (!atmel_pwm)
 		return -ENOMEM;
 
-	mutex_init(&atmel_pwm->isr_lock);
 	atmel_pwm->data = of_device_get_match_data(&pdev->dev);
-	atmel_pwm->updated_pwms = 0;
+
+	atmel_pwm->update_pending = 0;
+	spin_lock_init(&atmel_pwm->lock);
 
 	atmel_pwm->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(atmel_pwm->base))
@@ -462,7 +518,6 @@ static int atmel_pwm_remove(struct platform_device *pdev)
 	pwmchip_remove(&atmel_pwm->chip);
 
 	clk_unprepare(atmel_pwm->clk);
-	mutex_destroy(&atmel_pwm->isr_lock);
 
 	return 0;
 }
-- 
2.30.2

