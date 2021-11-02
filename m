Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC55442A64
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Nov 2021 10:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKBJat (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Nov 2021 05:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBJas (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Nov 2021 05:30:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907BBC061766
        for <linux-pwm@vger.kernel.org>; Tue,  2 Nov 2021 02:28:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5T-000350-GW; Tue, 02 Nov 2021 10:28:11 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5O-0008TL-CJ; Tue, 02 Nov 2021 10:28:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mhq5O-0005Ha-BS; Tue, 02 Nov 2021 10:28:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        Tony Prisk <linux@prisktech.co.nz>
Subject: [PATCH 1/2] pwm: vt8500: Implement .apply() callback
Date:   Tue,  2 Nov 2021 10:28:03 +0100
Message-Id: <20211102092804.296089-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211102092804.296089-1-u.kleine-koenig@pengutronix.de>
References: <20211102092804.296089-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=kUCY9L4JrDsDg/j7euSIYXyRiptGkOKO1yVlNu2XPRQ=; m=TzWDfn0QgyP4Qo0s0ELgUgvslQMmfgqYACV4fnO2KFo=; p=a2ymg8Cb6SrZGy75FqCYhS2mhx3DqAFdFafzg6kjHzE=; g=c83172edeea4810182ce0815168b009d2649768d
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGBBJwACgkQwfwUeK3K7Am5ogf9EaJ PRsxbCaIWMVHMXqBdJWQQ6MaVYCjr3tpfBTwJrz86k6N/uWbT6RsWzJalBqtdDEB+/YDxotWZYvSL ufZZTtDUNA+oj0ohlELTGLfHsI7ONrkNdoUpeVZeuNlddYfjzLP26Tjfhn6io321xodWnYmvHRsHy 1+DxN7hWT408omMinkizfpUwQzj4RkuLJb4pQfxDPnK5n5CZvF/88awVoEzr9dc3ZMMNqYJZ1sTdE w2K1Rau0RsE/914umoltZjen+/sPo+jBLqfkiUkKJYrujG8kOQbKM+4Ojnm57YhbhevKaom48JVQ+ a4YISbz0zF9WTPr4vpnB/lOXAihi+CQ==
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
 drivers/pwm/pwm-vt8500.c | 57 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index ea2aa151080a..3203ec1b0d24 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -70,7 +70,7 @@ static inline void pwm_busy_wait(struct vt8500_chip *vt8500, int nr, u8 bitmask)
 }
 
 static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-		int duty_ns, int period_ns)
+		u64 duty_ns, u64 period_ns)
 {
 	struct vt8500_chip *vt8500 = to_vt8500_chip(chip);
 	unsigned long long c;
@@ -102,8 +102,8 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	c = (unsigned long long)pv * duty_ns;
-	do_div(c, period_ns);
-	dc = c;
+
+	dc = div64_u64(c, period_ns);
 
 	writel(prescale, vt8500->base + REG_SCALAR(pwm->hwpwm));
 	pwm_busy_wait(vt8500, pwm->hwpwm, STATUS_SCALAR_UPDATE);
@@ -176,11 +176,54 @@ static int vt8500_pwm_set_polarity(struct pwm_chip *chip,
 	return 0;
 }
 
+static int vt8500_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		/*
+		 * Changing the polarity of a running PWM is only allowed when
+		 * the PWM driver implements ->apply().
+		 */
+		if (enabled) {
+			vt8500_pwm_disable(chip, pwm);
+
+			enabled = false;
+		}
+
+		err = vt8500_pwm_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			vt8500_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	/*
+	 * We cannot skip calling ->config even if state->period ==
+	 * pwm->state.period && state->duty_cycle == pwm->state.duty_cycle
+	 * because we might have exited early in the last call to
+	 * pwm_apply_state because of !state->enabled and so the two values in
+	 * pwm->state might not be configured in hardware.
+	 */
+	err = vt8500_pwm_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!enabled)
+		err = vt8500_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops vt8500_pwm_ops = {
-	.enable = vt8500_pwm_enable,
-	.disable = vt8500_pwm_disable,
-	.config = vt8500_pwm_config,
-	.set_polarity = vt8500_pwm_set_polarity,
+	.apply = vt8500_pwm_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.2

