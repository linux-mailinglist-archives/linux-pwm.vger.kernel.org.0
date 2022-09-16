Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E7C5BB003
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Sep 2022 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbiIPPPj (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Sep 2022 11:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIPPPi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Sep 2022 11:15:38 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827164A101
        for <linux-pwm@vger.kernel.org>; Fri, 16 Sep 2022 08:15:36 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZD3p-0003yT-JJ; Fri, 16 Sep 2022 17:15:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZD3l-0016t6-EA; Fri, 16 Sep 2022 17:15:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZD3i-001KHl-Nq; Fri, 16 Sep 2022 17:15:14 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Douglas Anderson <dianders@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH 2/3] pwm/tracing: Also record trace events for failed apply calls
Date:   Fri, 16 Sep 2022 17:15:05 +0200
Message-Id: <20220916151506.298488-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220916151506.298488-1-u.kleine-koenig@pengutronix.de>
References: <20220916151506.298488-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=E3AG5YYUjxpilr4EcU0F6ojjwczwFoEye3EvPgGiZXA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBjJJL0+nJpefslWpwi1jy221iYiRUnhwYMHQc0hZQg +05hOzCJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYySS9AAKCRDB/BR4rcrsCb67B/ 4ijup1xrBCXE4uMcAUC/zac9L2dQhGtHBA83d1WLO9NCst9t1N3f3awu/ViFMY6Li/IrfwRg3YinAb mu0nvQBqYTGYIHL2Yb+tHQ1/UGMpdQCmQcAFaZRZsYgxBCIAI1tU7w8+49Aq69j0cIvaaU0tsQOegP G8RZrBIxKOIqNI2vmWg5pjocGyc7/Sl7an2uB86UkFOU22WFhyz/zezKTCVfQ7O0aXXI/EO5LSM0Xt PLBrMEQYPhCHIqRkltKCUdIi2HVw+b1eGQQKBZRfxz/nbXOSkHLJLpvs3VM8pwYQLJ0YPs+6Lc3bK3 hQrkz6ipAyixvsp8m3CXj/xg8/yta2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Record and report an error code for the events. This allows to report
about failed calls without ambiguity and so gives a more complete
picture.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c         | 18 ++++++++----------
 include/trace/events/pwm.h | 20 ++++++++++----------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0e042410f6b9..381db04cfa00 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -108,8 +108,8 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	}
 
 	if (pwm->chip->ops->get_state) {
-		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
-		trace_pwm_get(pwm, &pwm->state);
+		err = pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
+		trace_pwm_get(pwm, &pwm->state, err);
 
 		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
@@ -457,8 +457,8 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 	 * checks.
 	 */
 
-	chip->ops->get_state(chip, pwm, &s1);
-	trace_pwm_get(pwm, &s1);
+	err = chip->ops->get_state(chip, pwm, &s1);
+	trace_pwm_get(pwm, &s1, err);
 
 	/*
 	 * The lowlevel driver either ignored .polarity (which is a bug) or as
@@ -514,16 +514,15 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	/* reapply the state that the driver reported being configured. */
 	err = chip->ops->apply(chip, pwm, &s1);
+	trace_pwm_apply(pwm, &s1, err);
 	if (err) {
 		*last = s1;
 		dev_err(chip->dev, "failed to reapply current setting\n");
 		return;
 	}
 
-	trace_pwm_apply(pwm, &s1);
-
-	chip->ops->get_state(chip, pwm, last);
-	trace_pwm_get(pwm, last);
+	err = chip->ops->get_state(chip, pwm, last);
+	trace_pwm_get(pwm, last, err);
 
 	/* reapplication of the current state should give an exact match */
 	if (s1.enabled != last->enabled ||
@@ -571,11 +570,10 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 		return 0;
 
 	err = chip->ops->apply(chip, pwm, state);
+	trace_pwm_apply(pwm, state, err);
 	if (err)
 		return err;
 
-	trace_pwm_apply(pwm, state);
-
 	pwm->state = *state;
 
 	/*
diff --git a/include/trace/events/pwm.h b/include/trace/events/pwm.h
index cf243de41cc8..12b35e4ff917 100644
--- a/include/trace/events/pwm.h
+++ b/include/trace/events/pwm.h
@@ -10,9 +10,9 @@
 
 DECLARE_EVENT_CLASS(pwm,
 
-	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
 
-	TP_ARGS(pwm, state),
+	TP_ARGS(pwm, state, err),
 
 	TP_STRUCT__entry(
 		__field(struct pwm_device *, pwm)
@@ -20,6 +20,7 @@ DECLARE_EVENT_CLASS(pwm,
 		__field(u64, duty_cycle)
 		__field(enum pwm_polarity, polarity)
 		__field(bool, enabled)
+		__field(int, err)
 	),
 
 	TP_fast_assign(
@@ -28,28 +29,27 @@ DECLARE_EVENT_CLASS(pwm,
 		__entry->duty_cycle = state->duty_cycle;
 		__entry->polarity = state->polarity;
 		__entry->enabled = state->enabled;
+		__entry->err = err;
 	),
 
-	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d",
+	TP_printk("%p: period=%llu duty_cycle=%llu polarity=%d enabled=%d err=%d",
 		  __entry->pwm, __entry->period, __entry->duty_cycle,
-		  __entry->polarity, __entry->enabled)
+		  __entry->polarity, __entry->enabled, __entry->err)
 
 );
 
 DEFINE_EVENT(pwm, pwm_apply,
 
-	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
-
-	TP_ARGS(pwm, state)
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
 
+	TP_ARGS(pwm, state, err)
 );
 
 DEFINE_EVENT(pwm, pwm_get,
 
-	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state),
-
-	TP_ARGS(pwm, state)
+	TP_PROTO(struct pwm_device *pwm, const struct pwm_state *state, int err),
 
+	TP_ARGS(pwm, state, err)
 );
 
 #endif /* _TRACE_PWM_H */
-- 
2.37.2

