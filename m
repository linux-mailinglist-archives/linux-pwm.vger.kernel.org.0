Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD7444BD4A
	for <lists+linux-pwm@lfdr.de>; Wed, 10 Nov 2021 09:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhKJIw7 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 10 Nov 2021 03:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhKJIw5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 10 Nov 2021 03:52:57 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 985F3C061766
        for <linux-pwm@vger.kernel.org>; Wed, 10 Nov 2021 00:50:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkjJ2-0000J6-8O; Wed, 10 Nov 2021 09:50:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkjJ0-00034q-Gq; Wed, 10 Nov 2021 09:50:06 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mkjJ0-0007A0-G3; Wed, 10 Nov 2021 09:50:06 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 3/3] pwm: lpc18xx-sct: Simplify driver by not using pwm_[gs]et_chip_data()
Date:   Wed, 10 Nov 2021 09:49:50 +0100
Message-Id: <20211110084950.1053426-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
References: <20211110084950.1053426-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=d8rxaOTgA2xY54jWbGABE7hGMwn/bvyAnTGud05R5sY=; m=YpIM+nfa6AvxkhnQUF/sZAyGJPGWbHfrRiJ7viZvBEk=; p=kUOy9osXQpsj0+Z5LGH5LByYfNeKHHrWAL+pMG62uXU=; g=5eb12795569df959259c3dab590be54e4c362223
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmGLh6oACgkQwfwUeK3K7AkCIgf9F3y FXrtlBexGJTh3OCYiUxvv5SoEwRkg3WOYQXVd1oPkXExBK7kMG6YENJBnx+3fZs3j6mqmQ9WrLp5t wVtS9HyQrqU4ifpp2mMyuXJwWYEB3yPNhUqCxo0aw8HAjq2yJlnL3+eQ9e6kelWjXKeyxRfSff8XP T7j4tzD3ZyqqPo6VTlQZgZSiDkwtuiIseuXPTmxegrg2zqN6JBrcBrSBZALVaCj0uJEgQUfE9M62P xPpTpFbB3+zb6GAUmpHZNYjaC1W/Xea3Ccq5rdGmmhv/gE9P8YsmlULKyOM9ZLy0YKGi5k+CjtnJI LqlnURZaNAUNHmtkiVhrEsr+mNYG4Sg==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The per-channel data is available directly in the driver data struct. So
use it without making use of pwm_[gs]et_chip_data().

The relevant change introduced by this patch to lpc18xx_pwm_disable() at
the assembler level (for an arm lpc18xx_defconfig build) is:

	push    {r3, r4, r5, lr}
	mov     r4, r0
	mov     r0, r1
	mov     r5, r1
	bl      0 <pwm_get_chip_data>
	ldr     r3, [r0, #0]

changes to

	ldr     r3, [r1, #8]
	push    {r4, lr}
	add.w   r3, r0, r3, lsl #2
	ldr     r3, [r3, #92]   ; 0x5c

So this reduces stack usage, has an improved runtime behavior because of
better pipeline usage, doesn't branch to an external function and the
generated code is a bit smaller occupying less memory.

The codesize of lpc18xx_pwm_probe() is reduced by 32 bytes.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 6cf02554066c..b909096dba2f 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -166,7 +166,7 @@ static void lpc18xx_pwm_config_duty(struct pwm_chip *chip,
 				    struct pwm_device *pwm, int duty_ns)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
 	u64 val;
 
 	val = (u64)duty_ns * lpc18xx_pwm->clk_rate;
@@ -236,7 +236,7 @@ static int lpc18xx_pwm_set_polarity(struct pwm_chip *chip,
 static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
 	enum lpc18xx_pwm_res_action res_action;
 	unsigned int set_event, clear_event;
 
@@ -271,7 +271,7 @@ static int lpc18xx_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 static void lpc18xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
 
 	lpc18xx_pwm_writel(lpc18xx_pwm,
 			   LPC18XX_PWM_EVCTRL(lpc18xx_data->duty_event), 0);
@@ -282,7 +282,7 @@ static void lpc18xx_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
 	unsigned long event;
 
 	event = find_first_zero_bit(&lpc18xx_pwm->event_map,
@@ -303,7 +303,7 @@ static int lpc18xx_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 static void lpc18xx_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	struct lpc18xx_pwm_data *lpc18xx_data = pwm_get_chip_data(pwm);
+	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
 
 	clear_bit(lpc18xx_data->duty_event, &lpc18xx_pwm->event_map);
 }
@@ -327,8 +327,7 @@ MODULE_DEVICE_TABLE(of, lpc18xx_pwm_of_match);
 static int lpc18xx_pwm_probe(struct platform_device *pdev)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm;
-	struct pwm_device *pwm;
-	int ret, i;
+	int ret;
 	u64 val;
 
 	lpc18xx_pwm = devm_kzalloc(&pdev->dev, sizeof(*lpc18xx_pwm),
@@ -398,16 +397,6 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 	lpc18xx_pwm_writel(lpc18xx_pwm, LPC18XX_PWM_LIMIT,
 			   BIT(lpc18xx_pwm->period_event));
 
-	for (i = 0; i < lpc18xx_pwm->chip.npwm; i++) {
-		struct lpc18xx_pwm_data *data;
-
-		pwm = &lpc18xx_pwm->chip.pwms[i];
-
-		data = &lpc18xx_pwm->channeldata[i];
-
-		pwm_set_chip_data(pwm, data);
-	}
-
 	val = lpc18xx_pwm_readl(lpc18xx_pwm, LPC18XX_PWM_CTRL);
 	val &= ~LPC18XX_PWM_BIDIR;
 	val &= ~LPC18XX_PWM_CTRL_HALT;
-- 
2.30.2

