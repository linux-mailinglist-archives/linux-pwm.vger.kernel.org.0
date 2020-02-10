Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17D1D1584D8
	for <lists+linux-pwm@lfdr.de>; Mon, 10 Feb 2020 22:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgBJVfd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 10 Feb 2020 16:35:33 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:49475 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgBJVfd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 10 Feb 2020 16:35:33 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GiJ-0002PW-NE; Mon, 10 Feb 2020 22:35:31 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1j1GiI-0004QO-7v; Mon, 10 Feb 2020 22:35:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH v2] pwm: Implement some checks for lowlevel drivers
Date:   Mon, 10 Feb 2020 22:35:18 +0100
Message-Id: <20200210213518.25906-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are some expectations which the callbacks provided by lowlevel
drivers should fulfill. Implement checks that help driver authors to get
these semantics right. As these have some overhead the checks can be
disabled using a Kconfig setting.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/Kconfig |   9 +++
 drivers/pwm/core.c  | 133 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/pwm.h |   4 +-
 3 files changed, 138 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 30190beeb6e9..e21834f44a29 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -33,6 +33,15 @@ config PWM_SYSFS
 	bool
 	default y if SYSFS
 
+config PWM_DEBUG
+	bool "PWM lowlevel drivers additional checks and debug messages"
+	depends on DEBUG_KERNEL
+	help
+	  This option enables some additional checks to help lowlevel driver
+	  authors to get their callbacks implemented correctly.
+	  It is expected to introduce some runtime overhead and diagnostic
+	  output to the kernel log, so only enable while working on a driver.
+
 config PWM_AB8500
 	tristate "AB8500 PWM support"
 	depends on AB8500_CORE && ARCH_U8500
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 5a7f6598c05f..1e7bb1ef1a08 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -120,6 +120,9 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	if (pwm->chip->ops->get_state) {
 		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
 		trace_pwm_get(pwm, &pwm->state);
+
+		if (IS_ENABLED(PWM_DEBUG))
+			pwm->implemented_state = pwm->state;
 	}
 
 	set_bit(PWMF_REQUESTED, &pwm->flags);
@@ -232,17 +235,28 @@ void *pwm_get_chip_data(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_get_chip_data);
 
-static bool pwm_ops_check(const struct pwm_ops *ops)
+static bool pwm_ops_check(const struct pwm_chip *chip)
 {
+
+	const struct pwm_ops *ops = chip->ops;
+
 	/* driver supports legacy, non-atomic operation */
-	if (ops->config && ops->enable && ops->disable)
-		return true;
+	if (ops->config && ops->enable && ops->disable) {
+		if (IS_ENABLED(CONFIG_PWM_DEBUG))
+			dev_warn(chip->dev,
+				 "Driver needs updating to atomic API\n");
 
-	/* driver supports atomic operation */
-	if (ops->apply)
 		return true;
+	}
+
+	if (!ops->apply)
+		return false;
 
-	return false;
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
+		dev_warn(chip->dev,
+			 "Please implement the .get_state() callback\n");
+
+	return true;
 }
 
 /**
@@ -266,7 +280,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
-	if (!pwm_ops_check(chip->ops))
+	if (!pwm_ops_check(chip))
 		return -EINVAL;
 
 	mutex_lock(&pwm_lock);
@@ -450,6 +464,105 @@ void pwm_free(struct pwm_device *pwm)
 }
 EXPORT_SYMBOL_GPL(pwm_free);
 
+void pwm_apply_state_debug(struct pwm_device *pwm,
+			   const struct pwm_state *state)
+{
+	struct pwm_state s1, s2;
+	struct pwm_chip *chip = pwm->chip;
+	struct pwm_state *impstate = &pwm->implemented_state;
+	int err;
+
+	if (!IS_ENABLED(CONFIG_PWM_DEBUG))
+		return;
+
+	/* No reasonable diagnosis possible without .get_state() */
+	if (!chip->ops->get_state)
+		return;
+
+	/*
+	 * *state was just applied. Read out the hardware state and do some
+	 * checks.
+	 */
+
+	chip->ops->get_state(chip, pwm, &s1);
+	trace_pwm_get(pwm, &s1);
+
+	/*
+	 * The lowlevel driver either ignored .polarity (which is a bug) or as
+	 * best effort inverted .polarity and fixed .duty_cycle respectively.
+	 * Undo this inversion and fixup for further tests.
+	 */
+	if (s1.enabled && s1.polarity != state->polarity) {
+		s2.polarity = state->polarity;
+		s2.duty_cycle = s1.period - s1.duty_cycle;
+		s2.period = s1.period;
+		s2.enabled = s1.enabled;
+	} else {
+		s2 = s1;
+	}
+
+	if (s2.polarity != state->polarity &&
+	    state->duty_cycle < state->period)
+		dev_warn(chip->dev, ".apply ignored .polarity\n");
+
+	if (state->enabled &&
+	    impstate->polarity == state->polarity &&
+	    impstate->period > s2.period &&
+	    impstate->period <= state->period)
+		dev_warn(chip->dev,
+			 ".apply didn't pick the best available period (requested: %u, applied: %u, possible: %u)\n",
+			 state->period, s2.period, impstate->period);
+
+	if (state->enabled && state->period < s2.period)
+		dev_warn(chip->dev,
+			 ".apply is supposed to round down period (requested: %u, applied: %u)\n",
+			 state->period, s2.period);
+
+	if (state->enabled &&
+	    impstate->polarity == state->polarity &&
+	    impstate->period == s2.period &&
+	    impstate->duty_cycle > s2.duty_cycle &&
+	    impstate->duty_cycle <= state->duty_cycle)
+		dev_warn(chip->dev,
+			 ".apply didn't pick the best available duty cycle (requested: %u/%u, applied: %u/%u, possible: %u/%u)\n",
+			 state->duty_cycle, state->period,
+			 s2.duty_cycle, s2.period,
+			 impstate->duty_cycle, impstate->period);
+
+	if (state->enabled && state->duty_cycle < s2.duty_cycle)
+		dev_warn(chip->dev,
+			 ".apply is supposed to round down duty_cycle (requested: %u/%u, applied: %u/%u)\n",
+			 state->duty_cycle, state->period,
+			 s2.duty_cycle, s2.period);
+
+	if (!state->enabled && s2.enabled && s2.duty_cycle > 0)
+		dev_warn(chip->dev,
+			 "requested disabled, but yielded enabled with duty > 0");
+
+	/* reapply the state that the driver reported being configured. */
+	err = chip->ops->apply(chip, pwm, &s1);
+	if (err) {
+		*impstate = s1;
+		dev_err(chip->dev, "failed to reapply current setting\n");
+		return;
+	}
+	trace_pwm_apply(pwm, &s1);
+
+	chip->ops->get_state(chip, pwm, impstate);
+	trace_pwm_get(pwm, impstate);
+
+	/* reapplication of the current state should give an exact match */
+	if (s1.enabled != impstate->enabled ||
+	    s1.polarity != impstate->polarity ||
+	    (s1.enabled && s1.period != impstate->period) ||
+	    (s1.enabled && s1.duty_cycle != impstate->duty_cycle)) {
+		dev_err(chip->dev,
+			".apply is not idempotent (ena=%d pol=%d %u/%u) -> (ena=%d pol=%d %u/%u)\n",
+			s1.enabled, s1.polarity, s1.duty_cycle, s1.period,
+			impstate->enabled, impstate->polarity, impstate->duty_cycle, impstate->period);
+	}
+}
+
 /**
  * pwm_apply_state() - atomically apply a new state to a PWM device
  * @pwm: PWM device
@@ -480,6 +593,12 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		trace_pwm_apply(pwm, state);
 
 		pwm->state = *state;
+
+		/*
+		 * only do this after pwm->state was applied as some
+		 * implementations of .get_state depend on this
+		 */
+		pwm_apply_state_debug(pwm, state);
 	} else {
 		/*
 		 * FIXME: restore the initial state in case of error.
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 0ef808d925bb..27700ce492a1 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -71,7 +71,8 @@ struct pwm_state {
  * @chip: PWM chip providing this PWM device
  * @chip_data: chip-private data associated with the PWM device
  * @args: PWM arguments
- * @state: curent PWM channel state
+ * @state: last applied state
+ * @implemented_state: last implemented state (for PWM_DEBUG)
  */
 struct pwm_device {
 	const char *label;
@@ -83,6 +84,7 @@ struct pwm_device {
 
 	struct pwm_args args;
 	struct pwm_state state;
+	struct pwm_state implemented_state;
 };
 
 /**
-- 
2.24.0

