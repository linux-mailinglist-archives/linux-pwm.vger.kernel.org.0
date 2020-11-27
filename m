Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD772C6C94
	for <lists+linux-pwm@lfdr.de>; Fri, 27 Nov 2020 21:33:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbgK0UdM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 27 Nov 2020 15:33:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732377AbgK0Ucx (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 27 Nov 2020 15:32:53 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3BC1C0613D1
        for <linux-pwm@vger.kernel.org>; Fri, 27 Nov 2020 12:32:52 -0800 (PST)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1kikQE-000803-5j; Fri, 27 Nov 2020 21:32:50 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1kikQD-0000jc-6o; Fri, 27 Nov 2020 21:32:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Jeff LaBundy <jeff@labundy.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        kernel@pengutronix.de,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2] pwm: iqs620a: Fix overflow and optimize calculations
Date:   Fri, 27 Nov 2020 21:32:44 +0100
Message-Id: <20201127203244.3439478-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127201051.GA32257@labundy.com>
References: <20201127201051.GA32257@labundy.com>
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

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

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
Hello Jeff,

On Fri, Nov 27, 2020 at 02:10:51PM -0600, Jeff LaBundy wrote:
> I tested this patch on actual hardware but the newly calculated register
> values are incorrect. We used to get:
>
> [...]
> >                     goto err_mutex;
> >     }
> >  
> > -   if (duty_scale) {
> > -           u8 duty_val = min_t(u64, duty_scale - 1, 0xff);
> > -
> > +   if (duty_val) {
> 
> This is part of the problem; the device's formula for duty cycle has a
> plus one that is getting dropped now (see comments in iqs620_pwm_apply).

Good catch, I indeed missed that - 1.

This patch should be better in this regard.

Thanks for particular attention and testing,
Uwe

 drivers/pwm/pwm-iqs620a.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 7d33e3646436..6789e117f123 100644
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
@@ -70,29 +70,31 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * For lower duty cycles (e.g. 0), the PWM output is simply disabled to
 	 * allow an external pull-down resistor to hold the GPIO3/LTX pin low.
 	 */
-	duty_scale = div_u64(state->duty_cycle * 256, IQS620_PWM_PERIOD_NS);
+
+	if (state->duty_cycle < IQS620_PWM_PERIOD_NS)
+		duty_val = ((unsigned int)state->duty_cycle * 256) / IQS620_PWM_PERIOD_NS;
+	else
+		duty_val = 256;
 
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
-				   duty_val);
+				   duty_val - 1);
 		if (ret)
 			goto err_mutex;
 
 		iqs620_pwm->duty_val = duty_val;
 	}
 
-	if (state->enabled && duty_scale) {
+	if (state->enabled && duty_val) {
 		ret = regmap_update_bits(iqs62x->regmap, IQS620_PWR_SETTINGS,
 					 IQS620_PWR_SETTINGS_PWM_OUT, 0xff);
 		if (ret)
-- 
2.29.2

