Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F784625EA
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Nov 2021 23:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234535AbhK2Wod (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 29 Nov 2021 17:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234556AbhK2WoL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 29 Nov 2021 17:44:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38FAC0E2EEC
        for <linux-pwm@vger.kernel.org>; Mon, 29 Nov 2021 13:28:17 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mroC7-0006IO-Pm; Mon, 29 Nov 2021 22:28:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mroC6-001o1p-Du; Mon, 29 Nov 2021 22:28:13 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mroC5-0005mh-5J; Mon, 29 Nov 2021 22:28:13 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: pxa: Implement .apply() callback
Date:   Mon, 29 Nov 2021 22:28:05 +0100
Message-Id: <20211129212805.294177-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=GPZ9oAtJS9J7GGBIy1sji/HXqdnfYtqa+Wp4DZ6ysP4=; m=TzWDfn0QgyP4Qo0s0ELgUgvslQMmfgqYACV4fnO2KFo=; p=JR6CbSCnnfiLkD4GmawtdqFsnQ4pN7PdhTNa7GMItO4=; g=8037982b4a19f16c5bd3a14f1fb3c6268106ccf0
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGlReEACgkQwfwUeK3K7Ak2/wf/WIi Bt0y+qek8zPNVUAUl8W28TRzyoD7bt/huc29qCbVxxCcYjDjqf45Ow5fSL0SUboeC1CfBQGiMjLeY xMSObCn4c6fqg1XJJgKPoVbZlS1cYY9/KLELQQzLmFgdbPceIekmAW0X+uOnuo6b0PyToUo79gfkj 4HRr8Kw9kn4D0T4K+RvKNXZZiazvkbzLLnk5Ddecf6M2+OyVRAX7EncXBmPH1KGFp1Uo+Kfg1aJM2 51ZXSI13FLmjjHv01/4nF+DvobljqTFOy5Ri2yZhJn4aBy7RWZI2gpRoBAfzs63Q3fZumVErRAuqT 7ycPbKerJ7e6StXs5gDK5Nn7LKAPRJg==
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
 drivers/pwm/pwm-pxa.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-pxa.c b/drivers/pwm/pwm-pxa.c
index 238ec88c130b..0bcaa58c6a91 100644
--- a/drivers/pwm/pwm-pxa.c
+++ b/drivers/pwm/pwm-pxa.c
@@ -58,7 +58,7 @@ static inline struct pxa_pwm_chip *to_pxa_pwm_chip(struct pwm_chip *chip)
  * duty_ns   = 10^9 * (PRESCALE + 1) * DC / PWM_CLK_RATE
  */
 static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			  int duty_ns, int period_ns)
+			  u64 duty_ns, u64 period_ns)
 {
 	struct pxa_pwm_chip *pc = to_pxa_pwm_chip(chip);
 	unsigned long long c;
@@ -84,7 +84,7 @@ static int pxa_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (duty_ns == period_ns)
 		dc = PWMDCR_FD;
 	else
-		dc = (pv + 1) * duty_ns / period_ns;
+		dc = mul_u64_u64_div_u64(pv + 1, duty_ns, period_ns);
 
 	/* NOTE: the clock to PWM has to be enabled first
 	 * before writing to the registers
@@ -115,10 +115,33 @@ static void pxa_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	clk_disable_unprepare(pc->clk);
 }
 
+static int pxa_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			 const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			pxa_pwm_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = pxa_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		return pxa_pwm_enable(chip, pwm);
+
+	return 0;
+}
+
 static const struct pwm_ops pxa_pwm_ops = {
-	.config = pxa_pwm_config,
-	.enable = pxa_pwm_enable,
-	.disable = pxa_pwm_disable,
+	.apply = pxa_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: b6ce2af8766c39a5b09afa466ed4d0ef2d8b5a65
prerequisite-patch-id: b990c8483bb4fb1637c6d956e60e160524bd84ba
-- 
2.30.2

