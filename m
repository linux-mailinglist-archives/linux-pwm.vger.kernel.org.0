Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8346801E
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Dec 2021 23:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240817AbhLCXCr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Dec 2021 18:02:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233523AbhLCXCp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Dec 2021 18:02:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F0DC061751
        for <linux-pwm@vger.kernel.org>; Fri,  3 Dec 2021 14:59:20 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mtHWO-0002i1-8G; Fri, 03 Dec 2021 23:59:16 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mtHWL-002YZE-RY; Fri, 03 Dec 2021 23:59:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mtHWK-0004o7-Kr; Fri, 03 Dec 2021 23:59:12 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: bcm-kona: Implement .apply() callback
Date:   Fri,  3 Dec 2021 23:58:59 +0100
Message-Id: <20211203225859.1148940-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=sicxnB7sI9F1KLJCot2X4rPyHNg29OnBNjOYdFMGiMw=; m=wZfxozxba0q2U0bId2fqec9Z+OKS2FM9s3CYdlcJEhY=; p=dzJrpatLdFzXCsqobkY7x0EBti/D9VIdV/7EHxrsRNA=; g=371721f29b2f6104e26aab7005ca4be684c12fa7
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGqoS4ACgkQwfwUeK3K7AlLEggAlBt 72P8O+elYUoiyd8dcWRzXj8hNK+LZ5KNIXSB7vetSwmL2PgbEo/o95rJpDM5MkcLriNHjH5Sf6CgS +1HFpuZZozjMdsX3DROI1incv7AT2Ho3zpZc/DGJmo0tMZ90ukLUx0RrA2Ry5EG16S92NfbemusUd byHqw48ov8fcG8h32ey4pIZnqGn6tC6qQO7BLFgsd6OZwmX47TsMdKiNyLOpY6BOKx4yEYQvHpgIr eVTk3uhooa1LfUJKHi1jrw5nvvNg+JltjUKRpia2mCp+f7ekD2btweIJ9WbWn++gM6zvl2mRaMeSv a4WzbAoYlxsovl04upE2Pi+kX2hoaVA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().

The conversion wasn't quite straight forward because .config() and
.enable() were special to effectively swap their usual order. This resulted
in calculating the required values twice in some cases when
pwm_apply_state() was called. This is optimized en passant, and the order
of the callbacks is preserved without special jumping through hoops.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 90 ++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 64148f5f81d0..f171169c1c1f 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -109,10 +109,10 @@ static void kona_pwmc_apply_settings(struct kona_pwmc *kp, unsigned int chan)
 }
 
 static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			    int duty_ns, int period_ns)
+			    u64 duty_ns, u64 period_ns)
 {
 	struct kona_pwmc *kp = to_kona_pwmc(chip);
-	u64 val, div, rate;
+	u64 div, rate;
 	unsigned long prescale = PRESCALE_MIN, pc, dc;
 	unsigned int value, chan = pwm->hwpwm;
 
@@ -132,10 +132,8 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	while (1) {
 		div = 1000000000;
 		div *= 1 + prescale;
-		val = rate * period_ns;
-		pc = div64_u64(val, div);
-		val = rate * duty_ns;
-		dc = div64_u64(val, div);
+		pc = mul_u64_u64_div_u64(rate, period_ns, div);
+		dc = mul_u64_u64_div_u64(rate, duty_ns, div);
 
 		/* If duty_ns or period_ns are not achievable then return */
 		if (pc < PERIOD_COUNT_MIN)
@@ -150,25 +148,18 @@ static int kona_pwmc_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			return -EINVAL;
 	}
 
-	/*
-	 * Don't apply settings if disabled. The period and duty cycle are
-	 * always calculated above to ensure the new values are
-	 * validated immediately instead of on enable.
-	 */
-	if (pwm_is_enabled(pwm)) {
-		kona_pwmc_prepare_for_settings(kp, chan);
+	kona_pwmc_prepare_for_settings(kp, chan);
 
-		value = readl(kp->base + PRESCALE_OFFSET);
-		value &= ~PRESCALE_MASK(chan);
-		value |= prescale << PRESCALE_SHIFT(chan);
-		writel(value, kp->base + PRESCALE_OFFSET);
+	value = readl(kp->base + PRESCALE_OFFSET);
+	value &= ~PRESCALE_MASK(chan);
+	value |= prescale << PRESCALE_SHIFT(chan);
+	writel(value, kp->base + PRESCALE_OFFSET);
 
-		writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
+	writel(pc, kp->base + PERIOD_COUNT_OFFSET(chan));
 
-		writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
+	writel(dc, kp->base + DUTY_CYCLE_HIGH_OFFSET(chan));
 
-		kona_pwmc_apply_settings(kp, chan);
-	}
+	kona_pwmc_apply_settings(kp, chan);
 
 	return 0;
 }
@@ -216,13 +207,6 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	ret = kona_pwmc_config(chip, pwm, pwm_get_duty_cycle(pwm),
-			       pwm_get_period(pwm));
-	if (ret < 0) {
-		clk_disable_unprepare(kp->clk);
-		return ret;
-	}
-
 	return 0;
 }
 
@@ -248,11 +232,53 @@ static void kona_pwmc_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(kp->clk);
 }
 
+static int kona_pwmc_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	int err;
+	struct kona_pwmc *kp = to_kona_pwmc(chip);
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			kona_pwmc_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = kona_pwmc_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+
+		pwm->state.polarity = state->polarity;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			kona_pwmc_disable(chip, pwm);
+		return 0;
+	} else if (!enabled) {
+		/*
+		 * This is a bit special here, usually the PWM should only be
+		 * enabled when duty and period are setup. But before this
+		 * driver was converted to .apply it was done the other way
+		 * around and so this behaviour was kept even though this might
+		 * result in a glitch. This might be improvable by someone with
+		 * hardware and/or documentation.
+		 */
+		err = kona_pwmc_enable(chip, pwm);
+		if (err)
+			return err;
+	}
+
+	err = kona_pwmc_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err && !pwm->state.enabled)
+		clk_disable_unprepare(kp->clk);
+
+	return err;
+}
+
 static const struct pwm_ops kona_pwm_ops = {
-	.config = kona_pwmc_config,
-	.set_polarity = kona_pwmc_set_polarity,
-	.enable = kona_pwmc_enable,
-	.disable = kona_pwmc_disable,
+	.apply = kona_pwmc_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: b6ce2af8766c39a5b09afa466ed4d0ef2d8b5a65
-- 
2.30.2

