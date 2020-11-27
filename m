Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E041C2C67A0
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 15:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbgK0OOc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 09:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729169AbgK0OOc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Nov 2020 09:14:32 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC8EC0613D1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2020 06:14:31 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kieW3-00030i-KY; Fri, 27 Nov 2020 15:14:27 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kieW2-00048a-G9; Fri, 27 Nov 2020 15:14:26 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jeff LaBundy <jeff@labundy.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: iqs620a: Fix overflow and optimize calculations
Date:   Fri, 27 Nov 2020 15:14:04 +0100
Message-Id: <20201127141403.3433678-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

If state->duty_cycle is 0x100000000000000, the previous calculation of
duty_scale overflows and yields a duty cycle ratio of 0% instead of
100%. Fix this by comparing the requested duty cycle against the maximal
possible duty cycle first. This way it is possible to use a native
integer division instead of a (depending on the architecture) more
expensive 64bit division. Also duty_val cannot be bigger than 0xff which
allows to simplify the code a bit further down.

Fixes: 6f0841a8197b ("pwm: Add support for Azoteq IQS620A PWM generator")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

even though this is a fix, I don't consider it critical enough to apply
it before v5.10.

Best regards
Uwe

 drivers/pwm/pwm-iqs620a.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 7d33e3646436..0c9e2a876a05 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -46,7 +46,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 	struct iqs62x_core *iqs62x;
-	u64 duty_scale;
+	u8 duty_val;
 	int ret;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
@@ -70,20 +70,22 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
+
+	if (state->duty_cycle < IQS620_PWM_PERIOD_NS)
+		duty_val = ((unsigned int)state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS;
+	else
+		duty_val = 0xff;
 
 	mutex_lock(&iqs620_pwm->lock);
 
-	if (!state->enabled || !duty_scale) {
+	if (!state->enabled || !duty_val) {
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
 					 IQS620_PWR_SETTINGS_PWM_OUT, 0);
 		if (ret)
 			goto err_mutex;
 	}
 
-	if (duty_scale) {
-		u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
-
+	if (duty_val) {
 		ret = regmap_write(iqs62x->regmap, IQS620_PWM_DUTY_CYCLE,
 				   duty_val);
 		if (ret)
@@ -92,7 +94,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		iqs620_pwm->duty_val = duty_val;
 	}
 
-	if (state->enabled && duty_scale) {
+	if (state->enabled && duty_val) {
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
 					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
 		if (ret)
-- 
2.29.2

