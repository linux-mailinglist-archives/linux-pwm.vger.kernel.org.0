Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5106A5BB001
	for <lists+linux-pwm@lfdr.de>; Fri, 16 Sep 2022 17:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiIPPPi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 16 Sep 2022 11:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIPPPh (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 16 Sep 2022 11:15:37 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A96481FF
        for <linux-pwm@vger.kernel.org>; Fri, 16 Sep 2022 08:15:35 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZD3p-0003yS-JO; Fri, 16 Sep 2022 17:15:21 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZD3l-0016t7-EM; Fri, 16 Sep 2022 17:15:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oZD3i-001KHo-TK; Fri, 16 Sep 2022 17:15:14 +0200
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
Subject: [PATCH 3/3] pwm: Handle .get_state() failures
Date:   Fri, 16 Sep 2022 17:15:06 +0200
Message-Id: <20220916151506.298488-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220916151506.298488-1-u.kleine-koenig@pengutronix.de>
References: <20220916151506.298488-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1545; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yRNfMNUl3EWYauPtdr8Q5dOzGtnTvg1riQcLCuuQwro=; b=owGbwMvMwMV48I9IxdpTbzgZT6slMSSrTPrubcN224Djq8gEu7yr52o0UwQV7R/Utndef8XX9eqM vVpYJ6MxCwMjF4OsmCJLXZGW2ASJNf/tSpZwwwxiZQKZwsDFKQAT2VnM/ldO1MlmZQ/n5hm5UtwfTH 8fCnMs39J9X7n78UVRDgvGxNL8i+28bXlJ89Lrje8ziYtWJX786VL0v0L10faISEar+B1fBTdJ2nse V4378K1D00X0w7SdZu/5yt7mrz+lbTjb7LtA4t25N4MOcj7imWo6sTeL61d6JeP07zMro5vZpRoX/w o0+388Nedof5/BrWcesx8u/mml27D0wSaOrSpOv+3+HKgRMtSUkGdMv6s4VU8gZ8om49sVpd0LnWRu 9+ke2XBHvU5Jku1O9q/SX4eeGjdXM822MOnmdI2z23gtZLHgXDnO/ZZsV0RzhL3i7h0OcO2+LxnG9Z lJsfD54uKICL5LOuLqttPttVwB
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

This suppresses diagnosis for PWM_DEBUG routines and makes sure that
pwm->state isn't modified in pwm_device_request() if .get_state() fails.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 381db04cfa00..421573590613 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -108,9 +108,14 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 	}
 
 	if (pwm->chip->ops->get_state) {
-		err = pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
+		struct pwm_state state;
+
+		err = pwm->chip->ops->get_state(pwm->chip, pwm, &state);
 		trace_pwm_get(pwm, &pwm->state, err);
 
+		if (!err)
+			pwm->state = state;
+
 		if (IS_ENABLED(CONFIG_PWM_DEBUG))
 			pwm->last = pwm->state;
 	}
@@ -459,6 +464,9 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	err = chip->ops->get_state(chip, pwm, &s1);
 	trace_pwm_get(pwm, &s1, err);
+	if (err)
+		/* If that failed there isn't much to debug */
+		return;
 
 	/*
 	 * The lowlevel driver either ignored .polarity (which is a bug) or as
@@ -523,6 +531,8 @@ static void pwm_apply_state_debug(struct pwm_device *pwm,
 
 	err = chip->ops->get_state(chip, pwm, last);
 	trace_pwm_get(pwm, last, err);
+	if (err)
+		return;
 
 	/* reapplication of the current state should give an exact match */
 	if (s1.enabled != last->enabled ||
-- 
2.37.2

