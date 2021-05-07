Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40FFB376602
	for <lists+linux-pwm@lfdr.de>; Fri,  7 May 2021 15:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236781AbhEGNUO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 7 May 2021 09:20:14 -0400
Received: from mail.pqgruber.com ([52.59.78.55]:37510 "EHLO mail.pqgruber.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235855AbhEGNUO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 7 May 2021 09:20:14 -0400
Received: from workstation.tuxnet (213-47-165-233.cable.dynamic.surfer.at [213.47.165.233])
        by mail.pqgruber.com (Postfix) with ESMTPSA id 9781CC7C83F;
        Fri,  7 May 2021 15:19:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqgruber.com;
        s=mail; t=1620393553;
        bh=azGR4lOgRoYBnA2FhEhdNxlES2odxqcYq1pWiYYKz8A=;
        h=From:To:Cc:Subject:Date:From;
        b=DdVTD0Xy89ktmT8RTM/brYmPUPsiyVXxrAe44/8UlHo4ui53W22dKBtWb1AVl8png
         vUoEwXYGpWp6SjDc+EpXAWE+FhxRovs5DXS7tEFCkZE31E5QyGe/3FVAVDFHPf5JzI
         mClRWTCgk+6Yx/6kK0bymfEBo9n/Wj4lfuUSvBos=
From:   Clemens Gruber <clemens.gruber@pqgruber.com>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sven Van Asbroeck <TheSven73@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-kernel@vger.kernel.org,
        Clemens Gruber <clemens.gruber@pqgruber.com>
Subject: [PATCH 1/4] pwm: core: Support new usage_power setting in PWM state
Date:   Fri,  7 May 2021 15:18:42 +0200
Message-Id: <20210507131845.37605-1-clemens.gruber@pqgruber.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If usage_power is set, the PWM driver is only required to maintain
the power output but has more freedom regarding signal form.

If supported, the signal can be optimized, for example to
improve EMI by phase shifting individual channels.

Signed-off-by: Clemens Gruber <clemens.gruber@pqgruber.com>
---
 Documentation/driver-api/pwm.rst | 4 ++++
 drivers/pwm/core.c               | 6 +++++-
 include/linux/pwm.h              | 7 +++++++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index a7ca4f58305a..750734a7f874 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -48,6 +48,10 @@ After being requested, a PWM has to be configured using::
 
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
+There is also a usage_power setting: If set, the PWM driver is only required to
+maintain the power output but has more freedom regarding signal form.
+If supported by the driver, the signal can be optimized, for example to improve
+EMI by phase shifting the individual channels of a chip.
 
 The pwm_config(), pwm_enable() and pwm_disable() functions are just wrappers
 around pwm_apply_state() and should not be used if the user wants to change
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..4aa5a24cc6c5 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -554,7 +554,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
 	    state->polarity == pwm->state.polarity &&
-	    state->enabled == pwm->state.enabled)
+	    state->enabled == pwm->state.enabled &&
+	    state->usage_power == pwm->state.usage_power)
 		return 0;
 
 	if (chip->ops->apply) {
@@ -1259,6 +1260,9 @@ static void pwm_dbg_show(struct pwm_chip *chip, struct seq_file *s)
 		seq_printf(s, " polarity: %s",
 			   state.polarity ? "inverse" : "normal");
 
+		if (state.usage_power)
+			seq_puts(s, " usage_power");
+
 		seq_puts(s, "\n");
 	}
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 5bb90af4997e..5a73251d28e3 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -54,12 +54,17 @@ enum {
  * @duty_cycle: PWM duty cycle (in nanoseconds)
  * @polarity: PWM polarity
  * @enabled: PWM enabled status
+ * @usage_power: If set, the PWM driver is only required to maintain the power
+ *               output but has more freedom regarding signal form.
+ *               If supported, the signal can be optimized, for example to
+ *               improve EMI by phase shifting individual channels.
  */
 struct pwm_state {
 	u64 period;
 	u64 duty_cycle;
 	enum pwm_polarity polarity;
 	bool enabled;
+	bool usage_power;
 };
 
 /**
@@ -188,6 +193,7 @@ static inline void pwm_init_state(const struct pwm_device *pwm,
 	state->period = args.period;
 	state->polarity = args.polarity;
 	state->duty_cycle = 0;
+	state->usage_power = false;
 }
 
 /**
@@ -558,6 +564,7 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	state.enabled = false;
 	state.polarity = pwm->args.polarity;
 	state.period = pwm->args.period;
+	state.usage_power = false;
 
 	pwm_apply_state(pwm, &state);
 }
-- 
2.31.1

