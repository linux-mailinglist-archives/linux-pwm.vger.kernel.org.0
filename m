Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8818B463F20
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Nov 2021 21:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhK3UXI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Nov 2021 15:23:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234770AbhK3UXH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 30 Nov 2021 15:23:07 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9F1C061574
        for <linux-pwm@vger.kernel.org>; Tue, 30 Nov 2021 12:19:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ms9bM-0007KY-Ia; Tue, 30 Nov 2021 21:19:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ms9bK-001z5U-MD; Tue, 30 Nov 2021 21:19:41 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ms9bJ-0005DI-Hr; Tue, 30 Nov 2021 21:19:41 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: tiehrpwm: Implement .apply() callback
Date:   Tue, 30 Nov 2021 21:19:37 +0100
Message-Id: <20211130201937.360254-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=uoDPbl+Ng68oQ4pZuNQv6ueI6DXH7fJNi/WuUFO+2Bs=; m=TzWDfn0QgyP4Qo0s0ELgUgvslQMmfgqYACV4fnO2KFo=; p=VEqSpDZC10N8ur8KojnErIalLxfRfnM89ie6yz8k0HQ=; g=30398c0dc9ec65966771089dbd8e115726b01b06
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGmh1UACgkQwfwUeK3K7AnSDQf/dFE I8uv9HcIunbr/U+nOuDhShP2xJGMd1fEFsrF52B28fqFcKHyWHVByYss0NpSnJ51oTzjWO/llFr+F 2ZrdzDnTZnsI8Q6AwMGLcAMFWQgzslorJRqCTQA67T66Z46Gs1c7j7yKvDok2F0AI6D4t3dQob0sv 5K7R6/ahyniA8D4cgjFxEFf+ebohLkeumD+sTvDkUPu2fwpKiFLDZY59tplq62gLUJwar7sNGU3rZ hr6XVtQIN8+jK07UfEcyA3iKBGyEycwrLZGuof8KEbLsVBmVgjCmIm7ghiDcUP8PhHbdpiykvNKld +un56vQdInNmiOfxZNo1k9jjEYH/anQ==
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
 drivers/pwm/pwm-tiehrpwm.c | 40 +++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 5b723a48c5f1..48ca0ff690ae 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -216,7 +216,7 @@ static void configure_polarity(struct ehrpwm_pwm_chip *pc, int chan)
  * duty_ns   = 10^9 * (ps_divval * duty_cycles) / PWM_CLK_RATE
  */
 static int ehrpwm_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			     int duty_ns, int period_ns)
+			     u64 duty_ns, u64 period_ns)
 {
 	struct ehrpwm_pwm_chip *pc = to_ehrpwm_pwm_chip(chip);
 	u32 period_cycles, duty_cycles;
@@ -401,12 +401,42 @@ static void ehrpwm_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 	pc->period_cycles[pwm->hwpwm] = 0;
 }
 
+static int ehrpwm_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			    const struct pwm_state *state)
+{
+	int err;
+	bool enabled = pwm->state.enabled;
+
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			ehrpwm_pwm_disable(chip, pwm);
+			enabled = false;
+		}
+
+		err = ehrpwm_pwm_set_polarity(chip, pwm, state->polarity);
+		if (err)
+			return err;
+	}
+
+	if (!state->enabled) {
+		if (enabled)
+			ehrpwm_pwm_disable(chip, pwm);
+		return 0;
+	}
+
+	err = ehrpwm_pwm_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!enabled)
+		err = ehrpwm_pwm_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops ehrpwm_pwm_ops = {
 	.free = ehrpwm_pwm_free,
-	.config = ehrpwm_pwm_config,
-	.set_polarity = ehrpwm_pwm_set_polarity,
-	.enable = ehrpwm_pwm_enable,
-	.disable = ehrpwm_pwm_disable,
+	.apply = ehrpwm_pwm_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: b6ce2af8766c39a5b09afa466ed4d0ef2d8b5a65
-- 
2.30.2

