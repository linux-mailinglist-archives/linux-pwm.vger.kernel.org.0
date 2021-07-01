Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEDA13B8E2C
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhGAHcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234824AbhGAHcE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 03:32:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B6CC0617AD
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 00:29:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8c-00038z-Ou; Thu, 01 Jul 2021 09:29:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8b-0006y4-V8; Thu, 01 Jul 2021 09:29:29 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] pwm: Prevent a glitch for legacy drivers
Date:   Thu,  1 Jul 2021 09:29:26 +0200
Message-Id: <20210701072927.328254-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=3jp+KNgBvhQphIgkyTxKed1TpNAQoyExL9GSbIVWWQw=; m=rP85FNWtFgXD27m7WY/IxRngNXRoyZYDgl17dsyh6Vo=; p=L5ZhrPYspHz4XDsRRnjWAFPVp9jL9aqm3h/Sc7WnMiw=; g=6b0f80e136ce6a82845a5ee3ecc159fe1446a3b4
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdbqkACgkQwfwUeK3K7AnCegf/cwR Jz9bOUzVELWnBWpzAOr57vKCfJH298VRn5JLVuZm2lYPrVQwlJ2EgLolq6UZsCIj5CYl41FI0jALc JLQON5qHOQF3y+wV3i4gwPOwQDvT6AdAF/HYUcj+RIiceqvRyVoc6L8ehwth6YYrEe36IvOIOTvpD h/pcOqaMMLIgd/aJmsIc0WZpFJMaGObCIn8fMiVJzUbBsHgSru752Qix+ShzGB21P8cmvenWoPwAe P0GVHVXNSiYDKvTXWPTVfpo/qp7Qqh8mSpGRz1e57zpuMaWTNLcIg1gn8+RTqBjGpgqmWsRKfyecy qPK+XoKq8+o5FgsZISUVwpaxrv5QOEA==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If a running PWM is reconfigured to disabled calling the ->config()
callback before disabling the hardware might result in a glitch where
the (maybe) new period and duty_cycle are visible on the output before
disabling the hardware.

So handle disabling before calling ->config(). Also exit early in this case
which is possible because period and duty_cycle don't matter for disabled PWMs.
In return however ->config has to be called even if state->period ==
pwm->state.period && state->duty_cycle != pwm->state.duty_cycle because setting
these might have been skipped in the previous call.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 3c72f8963073..20afe6d0bc5e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -568,26 +568,33 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
 		pwm->state.polarity = state->polarity;
 	}
 
-	if (state->period != pwm->state.period ||
-	    state->duty_cycle != pwm->state.duty_cycle) {
-		err = chip->ops->config(pwm->chip, pwm,
-					state->duty_cycle,
-					state->period);
-		if (err)
-			return err;
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			chip->ops->disable(chip, pwm);
 
-		pwm->state.period = state->period;
-		pwm->state.duty_cycle = state->duty_cycle;
+		return 0;
 	}
 
-	if (state->enabled != pwm->state.enabled) {
-		if (!pwm->state.enabled) {
-			err = chip->ops->enable(chip, pwm);
-			if (err)
-				return err;
-		} else {
-			chip->ops->disable(chip, pwm);
-		}
+	/*
+	 * We cannot skip calling ->config even if state->period ==
+	 * pwm->state.period && state->duty_cycle == pwm->state.duty_cycle
+	 * because we might have exited early in the last call to
+	 * pwm_apply_state because of !state->enabled and so the two values in
+	 * pwm->state might not be configured in hardware.
+	 */
+	err = chip->ops->config(pwm->chip, pwm,
+				state->duty_cycle,
+				state->period);
+	if (err)
+		return err;
+
+	pwm->state.period = state->period;
+	pwm->state.duty_cycle = state->duty_cycle;
+
+	if (!pwm->state.enabled) {
+		err = chip->ops->enable(chip, pwm);
+		if (err)
+			return err;
 	}
 
 	return 0;
-- 
2.30.2

