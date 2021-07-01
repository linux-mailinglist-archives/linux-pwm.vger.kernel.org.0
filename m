Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B83B8E2B
	for <lists+linux-pwm@lfdr.de>; Thu,  1 Jul 2021 09:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhGAHcE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 1 Jul 2021 03:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbhGAHcE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 1 Jul 2021 03:32:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FAD0C0617AE
        for <linux-pwm@vger.kernel.org>; Thu,  1 Jul 2021 00:29:33 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8c-000391-Ou; Thu, 01 Jul 2021 09:29:30 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lyr8c-0006yA-5B; Thu, 01 Jul 2021 09:29:30 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/3] pwm: Restore initial state if a legacy callback fails
Date:   Thu,  1 Jul 2021 09:29:27 +0200
Message-Id: <20210701072927.328254-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
References: <20210701072927.328254-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=NKl7qBUDZ4t5WRIxEdUoKhwmGiKzejmC7NB0eOp7sJM=; m=VkgWLiZafRShbBgwl+M9ZkcM1pqbPA2BmrjkiU0Ckrc=; p=qrgcSIeKy6cUIOC+EtdUMUjaGm9f9sUXBDJRKZszYuQ=; g=3631a5b206800449c9da6c96dba155575e518015
X-Patch-Sig: m=pgp; i=uwe@kleine-koenig.org; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmDdbn8ACgkQwfwUeK3K7AlRAwf+NzP EnzoTbHITOg/hYZFVb11X4f+S6HfrPY/fHhD1KD3xbGCYmlz1iZhMRP79I3o+vi3TznM40mR8XTub bVZYW3Z2u4x7MdsssLNVR1E5GQYfkoFjWXIzaNkUFIo05je6yndc1TpE6qeKhj+/IzghJjuQmEvgM 2ggm0v99WYlp9Mzpk9m2VK4XMectn1vVVyl22R5OzlvXRu4MJIe0cKLEtDu2qiXJRN3S10diAr3V2 951ScNxhXRA9sn1c9PJRBDV+RdDvHIeHbEhFZP5bQHUg94l/kl1XpA0pSqfCirWNeZlGLnrlSdaMy +6G0yyub26fYhVVuz9ujfkLxVN2jLig==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

It is not entirely accurate to go back to the initial state after e.g.
.enable() failed, as .config() still modified the hardware, but this same
inconsistency exists for drivers that implement .apply().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 20afe6d0bc5e..6e30ef9b9b79 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -539,10 +539,8 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
 	int err;
+	struct pwm_state initial_state = pwm->state;
 
-	/*
-	 * FIXME: restore the initial state in case of error.
-	 */
 	if (state->polarity != pwm->state.polarity) {
 		if (!chip->ops->set_polarity)
 			return -EINVAL;
@@ -563,7 +561,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		err = chip->ops->set_polarity(chip, pwm, state->polarity);
 		if (err)
-			return err;
+			goto rollback;
 
 		pwm->state.polarity = state->polarity;
 	}
@@ -586,7 +584,7 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
 				state->duty_cycle,
 				state->period);
 	if (err)
-		return err;
+		goto rollback;
 
 	pwm->state.period = state->period;
 	pwm->state.duty_cycle = state->duty_cycle;
@@ -594,10 +592,14 @@ static int pwm_apply_legacy(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!pwm->state.enabled) {
 		err = chip->ops->enable(chip, pwm);
 		if (err)
-			return err;
+			goto rollback;
 	}
 
 	return 0;
+
+rollback:
+	pwm->state = initial_state;
+	return err;
 }
 
 /**
-- 
2.30.2

