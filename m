Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452348E86E
	for <lists+linux-pwm@lfdr.de>; Thu, 15 Aug 2019 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731280AbfHOJim (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 15 Aug 2019 05:38:42 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55477 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfHOJim (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 15 Aug 2019 05:38:42 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyCDR-0006Ew-7r; Thu, 15 Aug 2019 11:38:41 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hyCDQ-0003a2-Jo; Thu, 15 Aug 2019 11:38:40 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Baolin Wang <baolin.wang@linaro.org>,
        =?UTF-8?q?Michal=20Vok=C3=A1=C4=8D?= <michal.vokac@ysoft.com>
Subject: [PATCH RFC] pwm: add debug knob to help driver authors
Date:   Thu, 15 Aug 2019 11:38:39 +0200
Message-Id: <20190815093839.23710-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.20.1
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

This patch adds some additional checks to the pwm core that help getting
the details right. The check about rounding isn't approved yet, but I
consider that sensible as it helps consistency when all drivers round in
the same direction. The other checks are in line with what I understood
are the intended requirements.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this patch is only compile tested up to now but still I think it adds
useful diagnostics for driver authors that helps even more than an exact
documentation. Feedback welcome.

Best regards
Uwe

 drivers/pwm/Kconfig |  8 +++++++
 drivers/pwm/core.c  | 56 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index a7e57516959e..76105cfd581d 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -33,6 +33,14 @@ config PWM_SYSFS
 	bool
 	default y if SYSFS
 
+config PWM_DEBUG
+	bool "Additional checks for correctness of lowlevel drivers"
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
index 8edfac17364e..6ce341a4574d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -467,12 +467,68 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
 		return 0;
 
 	if (pwm->chip->ops->apply) {
+		struct pwm_state state_pre = *state;
+
 		err = pwm->chip->ops->apply(pwm->chip, pwm, state);
 		if (err)
 			return err;
 
+		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
+			if (pwm->chip->ops->get_state) {
+				struct pwm_state state_post = { 0, };
+
+				pwm->chip->ops->get_state(pwm->chip, pwm, &state_post);
+
+				if (state_post.period != state->period ||
+				    state_post.duty_cycle != state->duty_cycle ||
+				    state_post.polarity != state->polarity ||
+				    state_post.enabled != state->enabled) {
+
+					dev_warn(pwm->chip->dev,
+						 ".apply is supposed to modify the pwm_state parameter to match the actual output.\n");
+				}
+
+				if (state_pre.polarity == state_post.polarity &&
+				    state_pre.enabled &&
+				    (state_pre.period > state_post.period ||
+				     state_pre.duty_cycle > state_post.period)) {
+
+					dev_warn(pwm->chip->dev,
+						 ".apply is supposed to round down both period and duty_cycle.\n");
+
+				}
+
+				*state = state_post;
+
+				/* reapply state_post and check it is unmodified */
+				err = pwm->chip->ops->apply(pwm->chip, pwm, state);
+				if (err) {
+					dev_err(pwm->chip->dev,
+						 "failed to reapply the current setting\n");
+					return err;
+				}
+
+				if (state_post.period != state->period ||
+				    state_post.duty_cycle != state->duty_cycle ||
+				    state_post.polarity != state->polarity ||
+				    state_post.enabled != state->enabled) {
+					dev_warn(pwm->chip->dev,
+						 "applying the settings that .get_state returned yields changes\n");
+				}
+
+			} else {
+				dev_warn(pwm->chip->dev,
+					 "Please update the driver to provide .get_state()\n");
+			}
+		}
+
 		pwm->state = *state;
 	} else {
+		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
+			dev_warn(pwm->chip->dev,
+				 "Please update the driver to provide .apply() instead of .config()\n");
+		}
+
 		/*
 		 * FIXME: restore the initial state in case of error.
 		 */
-- 
2.20.1

