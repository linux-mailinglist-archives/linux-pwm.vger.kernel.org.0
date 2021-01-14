Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B26062F6D84
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Jan 2021 22:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbhANVvO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 Jan 2021 16:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727105AbhANVvN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 Jan 2021 16:51:13 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7535BC061575
        for <linux-pwm@vger.kernel.org>; Thu, 14 Jan 2021 13:50:33 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0AVj-0004w6-9i; Thu, 14 Jan 2021 22:50:31 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1l0AVi-0000Gi-Af; Thu, 14 Jan 2021 22:50:30 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de
Subject: [PATCH v3] pwm: iqs620a: Fix overflow and optimize calculations
Date:   Thu, 14 Jan 2021 22:50:26 +0100
Message-Id: <20210114215026.163424-1-u.kleine-koenig@pengutronix.de>
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

If state->duty_cycle is 0x100000000000000, the previous calculation of
duty_scale overflows and yields a duty cycle ratio of 0% instead of
100%. Fix this by clamping the requested duty cycle to the maximal
possible duty cycle first. This way it is possible to use a native
integer division instead of a (depending on the architecture) more
expensive 64bit division.

With this change in place duty_scale cannot be bigger than 256 which
allows to simplify the calculation of duty_val.

Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 5ede8255926e..eb03f60c5db8 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -46,7 +46,9 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 	struct iqs62x_core *iqs62x;
-	u64 duty_scale;
+	unsigned duty_cycle;
+	unsigned duty_scale;
+
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -70,7 +72,8 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
+	duty_cycle = min_t(u64, state->duty_cycle, IQS620_PWM_PERIOD_NS);
+	duty_scale = duty_cycle * 256 / IQS620_PWM_PERIOD_NS;
 
 	mutex_lock(&iqs620_pwm->lock);
 
@@ -82,7 +85,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	}
 
 	if (duty_scale) {
-		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
+		u8 duty_val = duty_scale - 1;
 
 		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 				   duty_val);
-- 
2.29.2

