Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49D323B8ECF
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234709AbhGAIab (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 04:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbhGAIaa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 04:30:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9378C0617AE
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 01:28:00 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3D-0000np-12; Thu, 01 Jul 2021 10:27:59 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lys3C-000296-NV; Thu, 01 Jul 2021 10:27:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: [PATCH 5/5] pwm: ep93xx: Ensure configuring period and duty_cycle isn't wrongly skipped
Date:   Thu,  1 Jul 2021 10:27:55 +0200
Message-Id: <20210701082755.332593-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
References: <20210701082755.332593-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=KDTIsKX/ukFzUeVZ2owWNz8SkUld4P3ixAUYW2SYa/0=; m=M57jX7oxilR22LgptO/pFlNs1gPGHBQfC586QQJYsHk=; p=9QAwHjWsIWr75rMsom4kKSvUFcyNuwnfeLPTLWGp8Dg=; g=ef94ed0c9b570be7fa8a3cc00f3980aa9e4afaa9
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdfGMACgkQwfwUeK3K7Am7rwf/TmR CoAgR57IicHek1h4uqBLA5g4cu1nyUVbOotzgfi3H+Kg4IZpGuXOyCaUyqPYuTyDj4Y9DtD/9R1pF k0CD55qHgb4aEbC36+LdbMMrbJsqR7vuPdITqUQ6vDCkBb2TjEWYCRcKOs56pysNtSixQdiwjVspM tru4DzWxKeIoJeqbRtnZv/6DlT5TeJUeCcGflAgX7EoA3Qy6RKGs95LllvCRsnvWhIqR0arf0N3NE pjp47qIKu92xXkdQd20AHEPbVhF4832bYCT6xKoIttFiNQxXhtMGl+fhWyTgRm9drWZzCu8vt+6zj HXa0MK8cNwFCJB+K+mfgGSM0Veosw5g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As the last call to ep93xx_pwm_apply() might have exited early if
state->enabled was false, the values for period and duty_cycle stored in
pwm->state might not have been written to hardware and it must be
ensured that they are configured before enabling the PWM.

Fixes: 6d45374af539 ("pwm: ep93xx: Implement .apply callback")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-ep93xx.c | 85 +++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/pwm/pwm-ep93xx.c b/drivers/pwm/pwm-ep93xx.c
index 8a3d781e6514..fc3cb7d669c6 100644
--- a/drivers/pwm/pwm-ep93xx.c
+++ b/drivers/pwm/pwm-ep93xx.c
@@ -64,6 +64,11 @@ static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	int ret;
 	struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
 	bool enabled = state->enabled;
+	void __iomem *base = ep93xx_pwm->base;
+	unsigned long long c;
+	unsigned long period_cycles;
+	unsigned long duty_cycles;
+	unsigned long term;
 
 	if (state->polarity != pwm->state.polarity) {
 		if (enabled) {
@@ -97,57 +102,47 @@ static int ep93xx_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		return 0;
 	}
 
-	if (state->period != pwm->state.period ||
-	    state->duty_cycle != pwm->state.duty_cycle) {
-		struct ep93xx_pwm *ep93xx_pwm = to_ep93xx_pwm(chip);
-		void __iomem *base = ep93xx_pwm->base;
-		unsigned long long c;
-		unsigned long period_cycles;
-		unsigned long duty_cycles;
-		unsigned long term;
+	/*
+	 * The clock needs to be enabled to access the PWM registers.
+	 * Configuration can be changed at any time.
+	 */
+	if (!pwm_is_enabled(pwm)) {
+		ret = clk_prepare_enable(ep93xx_pwm->clk);
+		if (ret)
+			return ret;
+	}
 
-		/*
-		 * The clock needs to be enabled to access the PWM registers.
-		 * Configuration can be changed at any time.
-		 */
-		if (!pwm_is_enabled(pwm)) {
-			ret = clk_prepare_enable(ep93xx_pwm->clk);
-			if (ret)
-				return ret;
-		}
+	c = clk_get_rate(ep93xx_pwm->clk);
+	c *= state->period;
+	do_div(c, 1000000000);
+	period_cycles = c;
+
+	c = period_cycles;
+	c *= state->duty_cycle;
+	do_div(c, state->period);
+	duty_cycles = c;
 
-		c = clk_get_rate(ep93xx_pwm->clk);
-		c *= state->period;
-		do_div(c, 1000000000);
-		period_cycles = c;
-
-		c = period_cycles;
-		c *= state->duty_cycle;
-		do_div(c, state->period);
-		duty_cycles = c;
-
-		if (period_cycles < 0x10000 && duty_cycles < 0x10000) {
-			term = readw(base + EP93XX_PWMx_TERM_COUNT);
-
-			/* Order is important if PWM is running */
-			if (period_cycles > term) {
-				writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
-				writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
-			} else {
-				writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
-				writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
-			}
-			ret = 0;
+	if (period_cycles < 0x10000 && duty_cycles < 0x10000) {
+		term = readw(base + EP93XX_PWMx_TERM_COUNT);
+
+		/* Order is important if PWM is running */
+		if (period_cycles > term) {
+			writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
+			writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
 		} else {
-			ret = -EINVAL;
+			writew(duty_cycles, base + EP93XX_PWMx_DUTY_CYCLE);
+			writew(period_cycles, base + EP93XX_PWMx_TERM_COUNT);
 		}
+		ret = 0;
+	} else {
+		ret = -EINVAL;
+	}
 
-		if (!pwm_is_enabled(pwm))
-			clk_disable_unprepare(ep93xx_pwm->clk);
+	if (!pwm_is_enabled(pwm))
+		clk_disable_unprepare(ep93xx_pwm->clk);
 
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		return ret;
 
 	if (!enabled) {
 		ret = clk_prepare_enable(ep93xx_pwm->clk);
-- 
2.30.2

