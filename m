Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4BD339905
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 22:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhCLVVd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 16:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbhCLVVY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 12 Mar 2021 16:21:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D51C061574
        for <linux-pwm@vger.kernel.org>; Fri, 12 Mar 2021 13:21:24 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKpDm-0002g4-5z; Fri, 12 Mar 2021 22:21:22 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lKpDl-0003S5-J0; Fri, 12 Mar 2021 22:21:21 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v2] pwm: Soften potential loss of precision in compat code
Date:   Fri, 12 Mar 2021 22:21:19 +0100
Message-Id: <20210312212119.1342666-1-u.kleine-koenig@pengutronix.de>
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

The legacy callback .config() only uses int for period and duty_cycle
while the corresponding values in struct pwm_state are u64. To prevent
that a value bigger than INT_MAX is discarded to a very small value,
explicitly check for big values and pass INT_MAX instead of discarding.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

compared to (implicit) v1 I added a comment and used min instead of open
coding the calculation.

Best regards
Uwe

 drivers/pwm/core.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4b3779d58c5a..7d0266bc5fcb 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -605,9 +605,18 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
+			int duty_cycle, period;
+
+			/*
+			 * The legacy callbacks use only (signed!) int for
+			 * period and duty_cycle compared to u64 in struct
+			 * pwm_state. So clamp the values to INT_MAX.
+                         */
+			period = min(state->period, (u64)INT_MAX);
+			duty_cycle = min(state->duty_cycle, (u64)INT_MAX);
+
 			err = chip->ops->config(pwm->chip, pwm,
-						state->duty_cycle,
-						state->period);
+						duty_cycle, period);
 			if (err)
 				return err;
 
-- 
2.30.1

