Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6607E43DE75
	for <lists+linux-pwm@lfdr.de>; Thu, 28 Oct 2021 12:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1KMe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 28 Oct 2021 06:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbhJ1KMd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 28 Oct 2021 06:12:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA7FC061570
        for <linux-pwm@vger.kernel.org>; Thu, 28 Oct 2021 03:10:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mg2MG-0006ck-AQ; Thu, 28 Oct 2021 12:10:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mg2MA-0002Mb-I3; Thu, 28 Oct 2021 12:09:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mg2MA-0003q9-H2; Thu, 28 Oct 2021 12:09:58 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] pwm: twl: Implement .apply() callback
Date:   Thu, 28 Oct 2021 12:09:42 +0200
Message-Id: <20211028100942.161170-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=m3LAhGpwqhSAqNdCwaJ2Jom2Nqf53wuC4P6Kwp80glw=; m=TzWDfn0QgyP4Qo0s0ELgUgvslQMmfgqYACV4fnO2KFo=; p=fBu1T/SyT8wOV/p635fnQ4iElhJktOeUnbFGGePMKU8=; g=459fc2102d5cda4423da1a4a73a4f7cd397c03e6
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmF6dt0ACgkQwfwUeK3K7AnmuAgAj1n YP5tZQXe2oSpTe0c8SpIQFRjyHEi7yoSndSPDjugQyDGIEVeH5Er32XA6SbqGIgN9iKLvHG4u2LTS xTfzqCI2kxNV5WGx8sXiIMrrnkSNWzi8DCDnJjo0pOid0Cmum1icXk9L6DFAcZa+A7cAFLP48665g CnJCskUnk7aZUVBmWYBYD6qm8Y2vwOgL1goAWirb8Leoek17kuy9Mc7VLXPpZYI1ajJydAVVlQcNK u5OfFbCVFlG5fkO005SRyZUEyHAP+bfgQJhDQ01AdGFRR871wT3+JC/7CIEDjbNLR3c4hl1HxsWZL ok39nSm9LlOEWb2blSwIEbjsD6yEohQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply(). This just pushes down a slightly
optimized variant of how legacy drivers are handled in the core.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-twl.c | 62 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-twl.c b/drivers/pwm/pwm-twl.c
index 203194f2c92e..86567add79db 100644
--- a/drivers/pwm/pwm-twl.c
+++ b/drivers/pwm/pwm-twl.c
@@ -58,9 +58,9 @@ static inline struct twl_pwm_chip *to_twl(struct pwm_chip *chip)
 }
 
 static int twl_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			      int duty_ns, int period_ns)
+			  u64 duty_ns, u64 period_ns)
 {
-	int duty_cycle = DIV_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns) + 1;
+	int duty_cycle = DIV64_U64_ROUND_UP(duty_ns * TWL_PWM_MAX, period_ns) + 1;
 	u8 pwm_config[2] = { 1, 0 };
 	int base, ret;
 
@@ -279,19 +279,65 @@ static void twl6030_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	mutex_unlock(&twl->mutex);
 }
 
+static int twl4030_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			twl4030_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = twl_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = twl4030_pwm_enable(chip, pwm);
+
+	return err;
+}
+
+static int twl6030_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			     const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			twl6030_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = twl_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = twl6030_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops twl4030_pwm_ops = {
-	.config = twl_pwm_config,
-	.enable = twl4030_pwm_enable,
-	.disable = twl4030_pwm_disable,
+	.apply = twl4030_pwm_apply,
 	.request = twl4030_pwm_request,
 	.free = twl4030_pwm_free,
 	.owner = THIS_MODULE,
 };
 
 static const struct pwm_ops twl6030_pwm_ops = {
-	.config = twl_pwm_config,
-	.enable = twl6030_pwm_enable,
-	.disable = twl6030_pwm_disable,
+	.apply = twl6030_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea
-- 
2.30.2

