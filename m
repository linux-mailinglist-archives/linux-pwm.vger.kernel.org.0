Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F123B8E29
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhGAHcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhGAHcE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 03:32:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF892C061756
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 00:29:32 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8c-00038y-Ou; Thu, 01 Jul 2021 09:29:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8b-0006y1-OU; Thu, 01 Jul 2021 09:29:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] pwm: Move legacy driver handling into a dedicated function
Date:   Thu,  1 Jul 2021 09:29:25 +0200
Message-Id: <20210701072927.328254-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=VLywSRiHGKnQZ+sS60XRoAG+wlQ7ZanrKLCkgOrOEtI=; m=QQPqrse405A0JmOj99AyliymNJHPDcGyWK2Z6TGu7H8=; p=UfM8u/A5kO1ZoEeAdooxrxFd7zYtC0Qf5wAU/XvdwmU=; g=66d12b77bcf010abc5b380ec6f11cccdd7875858
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdbsoACgkQwfwUeK3K7AnDUwf9Gd/ R/7bk0u93wRx4bEYcaWnLy+qtDgUX816nORB4cJZtdclCrw4a5zQmXgMXLskoUmJ8j2OPnJ8AM1n8 2wnDX8J7Rs8ZFq7Og9+1BmB5CRBb4wmi9GAf9AJJmbk4xE8pmKFENVcLEYyiAk1KWX3VCsXAnk+/P eKnR69iqUO8ND1TDEOrBOvZ73TnlyKYxWH2Cz7aMtpqBFs2cLdmlBIhyFZhJyy0tmC9IVuuYG1Voj O6i2HfDUuRCJ7n0qzVqaoTTv4JVPX0dxDP1a/ZMMTNoLk7zwKp6pshezy5dyYwapb1ZfSNcyvkjIU AQmJ18qWJHwevSgyU2EbgS4aiWwD27g==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is no change in behaviour, only some code is moved from
pwm_apply_state to a separate function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 130 ++++++++++++++++++++++++---------------------
 1 file changed, 70 insertions(+), 60 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..3c72f8963073 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -535,6 +535,64 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	}
 }
 
+static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int err;
+
+	/*
+	 * FIXME: restore the initial state in case of error.
+	 */
+	if (state->polarity != pwm->state.polarity) {
+		if (!chip->ops->set_polarity)
+			return -EINVAL;
+
+		/*
+		 * Changing the polarity of a running PWM is only allowed when
+		 * the PWM driver implements ->apply().
+		 */
+		if (pwm->state.enabled) {
+			chip->ops->disable(chip, pwm);
+
+			/*
+			 * Update pwm->state already here in case
+			 * .set_polarity() or another callback depend on that.
+			 */
+			pwm->state.enabled = false;
+		}
+
+		err = chip->ops->set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+
+		pwm->state.polarity = state->polarity;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		err = chip->ops->config(pwm->chip, pwm,
+					state->duty_cycle,
+					state->period);
+		if (err)
+			return err;
+
+		pwm->state.period = state->period;
+		pwm->state.duty_cycle = state->duty_cycle;
+	}
+
+	if (state->enabled != pwm->state.enabled) {
+		if (!pwm->state.enabled) {
+			err = chip->ops->enable(chip, pwm);
+			if (err)
+				return err;
+		} else {
+			chip->ops->disable(chip, pwm);
+		}
+	}
+
+	return 0;
+}
+
 /**
  * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
@@ -557,70 +615,22 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->enabled == pwm->state.enabled)
 		return 0;
 
-	if (chip->ops->apply) {
+	if (chip->ops->apply)
 		err = chip->ops->apply(chip, pwm, state);
-		if (err)
-			return err;
-
-		trace_pwm_apply(pwm, state);
-
-		pwm->state = *state;
-
-		/*
-		 * only do this after pwm->state was applied as some
-		 * implementations of .get_state depend on this
-		 */
-		pwm_apply_state_debug(pwm, state);
-	} else {
-		/*
-		 * FIXME: restore the initial state in case of error.
-		 */
-		if (state->polarity != pwm->state.polarity) {
-			if (!chip->ops->set_polarity)
-				return -EINVAL;
-
-			/*
-			 * Changing the polarity of a running PWM is
-			 * only allowed when the PWM driver implements
-			 * ->apply().
-			 */
-			if (pwm->state.enabled) {
-				chip->ops->disable(chip, pwm);
-				pwm->state.enabled = false;
-			}
-
-			err = chip->ops->set_polarity(chip, pwm,
-						      state->polarity);
-			if (err)
-				return err;
-
-			pwm->state.polarity = state->polarity;
-		}
-
-		if (state->period != pwm->state.period ||
-		    state->duty_cycle != pwm->state.duty_cycle) {
-			err = chip->ops->config(pwm->chip, pwm,
-						state->duty_cycle,
-						state->period);
-			if (err)
-				return err;
+	else
+		err = pwm_apply_legacy(chip, pwm, state);
+	if (err)
+		return err;
 
-			pwm->state.duty_cycle = state->duty_cycle;
-			pwm->state.period = state->period;
-		}
+	trace_pwm_apply(pwm, state);
 
-		if (state->enabled != pwm->state.enabled) {
-			if (state->enabled) {
-				err = chip->ops->enable(chip, pwm);
-				if (err)
-					return err;
-			} else {
-				chip->ops->disable(chip, pwm);
-			}
+	pwm->state = *state;
 
-			pwm->state.enabled = state->enabled;
-		}
-	}
+	/*
+	 * only do this after pwm->state was applied as some
+	 * implementations of .get_state depend on this
+	 */
+	pwm_apply_state_debug(pwm, state);
 
 	return 0;
 }
-- 
2.30.2

