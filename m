Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 629B2330A3A
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Mar 2021 10:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbhCHJYC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 8 Mar 2021 04:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhCHJXb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 8 Mar 2021 04:23:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4677EC06174A
        for <linux-pwm@vger.kernel.org>; Mon,  8 Mar 2021 01:23:30 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJC6q-00077I-8Z; Mon, 08 Mar 2021 10:23:28 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lJC6n-0008EA-MI; Mon, 08 Mar 2021 10:23:25 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: soften potential loss of precision in compat code
Date:   Mon,  8 Mar 2021 10:23:22 +0100
Message-Id: <20210308092322.24502-1-u.kleine-koenig@pengutronix.de>
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
 drivers/pwm/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c4d5c0667137..4058d3c86a45 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -599,9 +599,20 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 
 		if (state->period != pwm->state.period ||
 		    state->duty_cycle != pwm->state.duty_cycle) {
+			int duty_cycle, period;
+
+			if (state->period < INT_MAX)
+				period = state->period;
+			else
+				period = INT_MAX;
+
+			if (state->duty_cycle < INT_MAX)
+				duty_cycle = state->duty_cycle;
+			else
+				duty_cycle = INT_MAX;
+
 			err = chip->ops->config(pwm->chip, pwm,
-						state->duty_cycle,
-						state->period);
+						duty_cycle, period);
 			if (err)
 				return err;
 
-- 
2.30.1

