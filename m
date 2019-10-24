Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9069E2BC7
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2019 10:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436539AbfJXIIz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 24 Oct 2019 04:08:55 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51007 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfJXIIy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 24 Oct 2019 04:08:54 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNYAq-00084U-Ti; Thu, 24 Oct 2019 10:08:48 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1iNYAp-0007sk-Nh; Thu, 24 Oct 2019 10:08:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: implement tracing for .get_state() and .apply_state()
Date:   Thu, 24 Oct 2019 10:08:29 +0200
Message-Id: <20191024080829.16783-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.23.0
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

This allows to log all calls to the driver's lowlevel functions which
simplifies debugging in some cases.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I didn't add a trace call to .get_state added in 
01ccf903edd6 ("pwm: Let pwm_get_state() return the last implemented state")
in the expectation that this will be reverted very soon anyhow and
addint it there would only complicate reverting (or applying this
patch).

Best regards
Uwe

 drivers/pwm/core.c         |  9 +++++-
 include/trace/events/pwm.h | 58 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/pwm.h

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 6ad51aa60c03..7af8e5200d1d 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -20,6 +20,9 @@
 
 #include <dt-bindings/pwm/pwm.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/pwm.h>
+
 #define MAX_PWMS 1024
 
 static DEFINE_MUTEX(pwm_lookup_lock);
@@ -283,8 +286,10 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
 		pwm->hwpwm = i;
 		pwm->state.polarity = polarity;
 
-		if (chip->ops->get_state)
+		if (chip->ops->get_state) {
 			chip->ops->get_state(chip, pwm, &pwm->state);
+			trace_pwm_get(pwm, &pwm->state);
+		}
 
 		radix_tree_insert(&pwm_tree, pwm->pwm, pwm);
 	}
@@ -472,6 +477,8 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		if (err)
 			return err;
 
+		trace_pwm_apply(pwm, state);
+
 		/*
 		 * .apply might have to round some values in *state, if possible
 		 * read the actually implemented value back.
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
new file mode 100644
index 000000000000..cf243de41cc8
--- /dev/null
+++ b/include/trace/events/pwm.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pwm
+
+#if !defined(_TRACE_PWM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PWM_H
+
+#include <linux/pwm.h>
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(pwm,
+
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+
+	TP_ARGS(pwm, state),
+
+	TP_STRUCT__entry(
+		__field(struct pwm_device *, pwm)
+		__field(u64, period)
+		__field(u64, duty_cycle)
+		__field(enum pwm_polarity, polarity)
+		__field(bool, enabled)
+	),
+
+	TP_fast_assign(
+		__entry->pwm = pwm;
+		__entry->period = state->period;
+		__entry->duty_cycle = state->duty_cycle;
+		__entry->polarity = state->polarity;
+		__entry->enabled = state->enabled;
+	),
+
+	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d",
+		  __entry->pwm, __entry->period, __entry->duty_cycle,
+		  __entry->polarity, __entry->enabled)
+
+);
+
+DEFINE_EVENT(pwm, pwm_apply,
+
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+
+	TP_ARGS(pwm, state)
+
+);
+
+DEFINE_EVENT(pwm, pwm_get,
+
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+
+	TP_ARGS(pwm, state)
+
+);
+
+#endif /* _TRACE_PWM_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.23.0

