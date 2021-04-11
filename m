Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65D635B606
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Apr 2021 18:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbhDKQFV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Apr 2021 12:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbhDKQFU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Apr 2021 12:05:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F1FC061574
        for <linux-pwm@vger.kernel.org>; Sun, 11 Apr 2021 09:05:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVca1-0005MZ-Ck; Sun, 11 Apr 2021 18:04:57 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lVca0-0003T0-7L; Sun, 11 Apr 2021 18:04:56 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Ensure for legacy drivers that pwm->state stays consistent
Date:   Sun, 11 Apr 2021 18:04:51 +0200
Message-Id: <20210411160451.1207799-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

Without this change it can happen that if changing the polarity succeeded
but changing duty_cycle and period failed pwm->state contains a mixture
between the old and the requested state.

So remember the initial state before starting to modify the configuration
and restore it when one of the required callback fails.

Compared to the previous implementation .disable() (if necessary) is called
earlier to prevent a glitch.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is my approach to address Thierry's review for my patch "pwm:
Prevent a glitch in compat code"
(https://lore.kernel.org/linux-pwm/20210308093600.25455-1-u.kleine-koenig@pengutronix.de).

The problem that Thierry pointed out already exists in the status quo
(but only if a callback failed) and with my patch it triggered more
often. So here is a patch that fixes both problems (partial update of
pwm->state and the glitch) in one go. Is it worth the effor to split
this patch further? (e.g. 1) move legacy handling in a separate
function, 2) address the partial update problem, 3) fix the glitch)

Best regards
Uwe

 drivers/pwm/core.c | 139 +++++++++++++++++++++++++--------------------
 1 file changed, 78 insertions(+), 61 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..3f216c59bb38 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -535,6 +535,71 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	}
 }
 
+static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int err;
+	struct pwm_state initial_state = pwm->state;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (!chip->ops->set_polarity) {
+			err = -EINVAL;
+			goto out_err;
+		}
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
+		err = chip->ops->set_polarity(chip, pwm,
+					      state->polarity);
+		if (err)
+			goto out_err;
+
+		pwm->state.polarity = state->polarity;
+	}
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			chip->ops->disable(chip, pwm);
+		return 0;
+	}
+
+	if (state->period != pwm->state.period ||
+	    state->duty_cycle != pwm->state.duty_cycle) {
+		err = chip->ops->config(pwm->chip, pwm,
+					state->duty_cycle,
+					state->period);
+		if (err)
+			goto out_err;
+
+		pwm->state.period = state->period;
+		pwm->state.duty_cycle = state->duty_cycle;
+	}
+
+	if (state->enabled && !pwm->state.enabled) {
+		err = chip->ops->enable(chip, pwm);
+		if (err)
+			goto out_err;
+	}
+
+	return 0;
+
+out_err:
+	pwm->state = initial_state;
+	return err;
+}
+
 /**
  * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
@@ -544,6 +609,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
 	int err;
+	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
+		     const struct pwm_state *state);
 
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
@@ -557,70 +624,20 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->enabled == pwm->state.enabled)
 		return 0;
 
-	if (chip->ops->apply) {
-		err = chip->ops->apply(chip, pwm, state);
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
+	apply = chip->ops->apply ?: pwm_apply_legacy;
+	err = apply(chip, pwm, state);
+	if (err)
+		return err;
 
-			err = chip->ops->set_polarity(chip, pwm,
-						      state->polarity);
-			if (err)
-				return err;
+	trace_pwm_apply(pwm, state);
 
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
+	pwm->state = *state;
 
-			pwm->state.duty_cycle = state->duty_cycle;
-			pwm->state.period = state->period;
-		}
-
-		if (state->enabled != pwm->state.enabled) {
-			if (state->enabled) {
-				err = chip->ops->enable(chip, pwm);
-				if (err)
-					return err;
-			} else {
-				chip->ops->disable(chip, pwm);
-			}
-
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

base-commit: 64d7d074acd52e1bdff621f2cb86c0aae9bcef80
-- 
2.30.2

