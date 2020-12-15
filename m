Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11FD32DA9F7
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Dec 2020 10:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbgLOJVf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 15 Dec 2020 04:21:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728109AbgLOJVc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 15 Dec 2020 04:21:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E59D3C0617B0
        for <linux-pwm@vger.kernel.org>; Tue, 15 Dec 2020 01:20:51 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kp6Vd-0007FP-Ny; Tue, 15 Dec 2020 10:20:41 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kp6Vb-00020G-W6; Tue, 15 Dec 2020 10:20:39 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 1/2] hwmon: pwm-fan: Ensure that calculation doesn't discard big period values
Date:   Tue, 15 Dec 2020 10:20:30 +0100
Message-Id: <20201215092031.152243-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
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

With MAX_PWM being defined to 255 the code

	unsigned long period;
	...
	period = ctx->pwm->args.period;
	state.duty_cycle = DIV_ROUND_UP(pwm * (period - 1), MAX_PWM);

calculates a too small value for duty_cycle if the configured period is
big (either by discarding the 64 bit value ctx->pwm->args.period or by
overflowing the multiplication). As this results in a too slow fan and
so maybe an overheating machine better be safe than sorry and error out
in .probe.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/hwmon/pwm-fan.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 1f63807c0399..ec171f2b684a 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -324,8 +324,18 @@ static int pwm_fan_probe(struct platform_device *pdev)
 
 	ctx->pwm_value = MAX_PWM;
 
-	/* Set duty cycle to maximum allowed and enable PWM output */
 	pwm_init_state(ctx->pwm, &state);
+	/*
+	 * __set_pwm assumes that MAX_PWM * (period - 1) fits into an unsigned
+	 * long. Check this here to prevent the fan running at a too low
+	 * frequency.
+	 */
+	if (state.period > ULONG_MAX / MAX_PWM + 1) {
+		dev_err(dev, "Configured period too big\n");
+		return -EINVAL;
+	}
+
+	/* Set duty cycle to maximum allowed and enable PWM output */
 	state.duty_cycle = ctx->pwm->args.period - 1;
 	state.enabled = true;
 

base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
-- 
2.29.2

