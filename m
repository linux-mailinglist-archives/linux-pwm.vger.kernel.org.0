Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B7145595D
	for <lists+linux-pwm@lfdr.de>; Thu, 18 Nov 2021 11:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245744AbhKRKuB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 18 Nov 2021 05:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245691AbhKRKt6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 18 Nov 2021 05:49:58 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91304C061570
        for <linux-pwm@vger.kernel.org>; Thu, 18 Nov 2021 02:46:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnewQ-0002Jy-Lj; Thu, 18 Nov 2021 11:46:54 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnewO-000OXo-TA; Thu, 18 Nov 2021 11:46:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mnewN-0000DI-Mp; Thu, 18 Nov 2021 11:46:51 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pwm: imx1: Implement .apply callback
Date:   Thu, 18 Nov 2021 11:46:44 +0100
Message-Id: <20211118104644.1380314-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=gRVnXlghIXHzgAvRFg0S8lPDuKuA0kJvE80ggGbEy5U=; m=cVulRjjrTLU+Jd0VyL38w9jbAd/xXwpqRdpyBRJwe6A=; p=d5oDekhocvHeNrd0ePH7CHxbTzc5ife5txfBrvkdefw=; g=bc021e0a4f590cd954995dfd580f8f2ac9054a32
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGWLxEACgkQwfwUeK3K7Amb9Af+Jl2 RyeXAKKxYOB/1KSbLq23ezK7z/JA8+gVhOfAB9we60AWJFeVhpNgGKRFhzQc6HV5T0bHMWEK91fM6 BHPua0kBqMX1C6gJKt60CkuEA2psza3dbPmu5sb5W5vgpPzdOkjgaiC2T8VT14Gd7vndyLgXmDKNb j1nQS4tXs2Ly9qhrDazrM8dlJIqNvsStOCGXM27JLm4yu9iM9FkpYTmOCuokAT/aJqTg1QzGJAqom YUML9OSXDoL53TUhgZF20F69in/K2FL2IOwVB4k/pdDP8IQZl6f0+ze6igeVkqdFos87tP7ROQN1L qpkbFRdwV5nryO5F2jUveAMsJCcXokQ==
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

As a side effect this improves the behaviour for big duty cycles where
max * duty_ns overflowed before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-imx1.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-imx1.c b/drivers/pwm/pwm-imx1.c
index bcd849496f8d..1f2eb1c8ff6c 100644
--- a/drivers/pwm/pwm-imx1.c
+++ b/drivers/pwm/pwm-imx1.c
@@ -61,7 +61,7 @@ static void pwm_imx1_clk_disable_unprepare(struct pwm_chip *chip)
 }
 
 static int pwm_imx1_config(struct pwm_chip *chip,
-			   struct pwm_device *pwm, int duty_ns, int period_ns)
+			   struct pwm_device *pwm, u64 duty_ns, u64 period_ns)
 {
 	struct pwm_imx1_chip *imx = to_pwm_imx1_chip(chip);
 	u32 max, p;
@@ -84,7 +84,7 @@ static int pwm_imx1_config(struct pwm_chip *chip,
 	 * (/2 .. /16).
 	 */
 	max = readl(imx->mmio_base + MX1_PWMP);
-	p = max * duty_ns / period_ns;
+	p = mul_u64_u64_div_u64(max, duty_ns, period_ns);
 
 	writel(max - p, imx->mmio_base + MX1_PWMS);
 
@@ -120,10 +120,33 @@ static void pwm_imx1_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pwm_imx1_clk_disable_unprepare(chip);
 }
 
+static int pwm_imx1_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			  const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			pwm_imx1_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = pwm_imx1_config(chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		return pwm_imx1_enable(chip, pwm);
+
+	return 0;
+}
+
 static const struct pwm_ops pwm_imx1_ops = {
-	.enable = pwm_imx1_enable,
-	.disable = pwm_imx1_disable,
-	.config = pwm_imx1_config,
+	.apply = pwm_imx1_apply,
 	.owner = THIS_MODULE,
 };
 
-- 
2.30.2

