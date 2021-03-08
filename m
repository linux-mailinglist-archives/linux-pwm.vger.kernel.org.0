Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92052330A5A
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Mar 2021 10:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhCHJgH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Mar 2021 04:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbhCHJgD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Mar 2021 04:36:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FF8C06174A
        for <linux-pwm@vger.kernel.org>; Mon,  8 Mar 2021 01:36:03 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJCIz-0000DS-Ig; Mon, 08 Mar 2021 10:36:01 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJCIz-00016L-2S; Mon, 08 Mar 2021 10:36:01 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: Prevent a glitch in compat code
Date:   Mon,  8 Mar 2021 10:36:00 +0100
Message-Id: <20210308093600.25455-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.1
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

When a PWM is to be disabled, configuring the duty cycle and
period before actually disabling the hardware might result in either a
glitch or a delay. So check for disabling first and return early in this
case.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4058d3c86a45..4604ca3e0e62 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -597,6 +597,12 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 			pwm->state.polarity = state->polarity;
 		}
 
+		if (!state->enabled && pwm->state.enabled) {
+			chip->ops->disable(chip, pwm);
+			pwm->state.enabled = false;
+			return 0;
+		}
+
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
 			int duty_cycle, period;
@@ -620,16 +626,12 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 			pwm->state.period = state->period;
 		}
 
-		if (state->enabled != pwm->state.enabled) {
-			if (state->enabled) {
-				err = chip->ops->enable(chip, pwm);
-				if (err)
-					return err;
-			} else {
-				chip->ops->disable(chip, pwm);
-			}
+		if (!pwm->state.enabled) {
+			err = chip->ops->enable(chip, pwm);
+			if (err)
+				return err;
 
-			pwm->state.enabled = state->enabled;
+			pwm->state.enabled = true;
 		}
 	}
 
-- 
2.30.1

