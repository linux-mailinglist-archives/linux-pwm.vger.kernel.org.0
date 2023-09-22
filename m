Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C514A7ABA13
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 21:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjIVT2z (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 15:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbjIVT2y (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 15:28:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D01DC6
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 12:28:49 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjlpT-0008Ti-OT; Fri, 22 Sep 2023 21:28:43 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjlpS-008Ei9-7n; Fri, 22 Sep 2023 21:28:42 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjlpR-003ymr-UV; Fri, 22 Sep 2023 21:28:41 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     linux-pwm@vger.kernel.org, Fabio Estevam <festevam@denx.de>,
        Rogan Dawes <rogan@dawes.za.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de, linux-leds@vger.kernel.org
Subject: [PATCH v2] leds: pwm: Don't disable the PWM when the LED should be off
Date:   Fri, 22 Sep 2023 21:28:34 +0200
Message-Id: <20230922192834.1695727-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2101; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=YQULS5nn70vH2x9IM1JE9IcARldHBYVPhEH9hJaOOCo=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlDerhBE4sCtfRtqVTUH+6U2VMDRD+b3qTqOnpn b0KngBbpciJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQ3q4QAKCRCPgPtYfRL+ TqCBB/9jmSxn2JnBS6EcdbL+qkiJJQcQvkHo+BCtXDLmgKYZQLlaCgtOXxkVIfwbQ8JkUCGY5Pm 3T/TNSFPEXkIYmqHMwYL/NExJ+zBCF7n7GzDoTXPlrk0yMtvRJFEXKOYFKuTadbE4bRkv/lI7t/ h3e5z4tRJNPUr2OnBwTu8LvBBgI5PRnKiFDmBDXd6QCg4fR0cJVQPIFp1ZT2CBCrfz7posysR+Y +SIYPoRTa5AN/cNNeJFxfyKmsvvT7thppItHaMaLnkqcDMZs9XMuNoE6VRXox82s5/nvWfLb/uz un2Olo8hBQQ8bLx9kgr+VWCq6tDWPTQQ5c4jgHMXzFMkgfZi
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Disabling a PWM (i.e. calling pwm_apply_state with .enabled = false)
gives no guarantees what the PWM output does. It might freeze where it
currently is, or go in a High-Z state or drive the active or inactive
state, it might even continue to toggle.

To ensure that the LED gets really disabled, don't disable the PWM even
when .duty_cycle is zero.

This fixes disabling a leds-pwm LED on i.MX28. The PWM on this SoC is
one of those that freezes its output on disable, so if you disable an
LED that is full on, it stays on. If you disable a LED with half
brightness it goes off in 50% of the cases and full on in the other 50%.

Reported-by: Rogan Dawes <rogan@dawes.za.net>
Reported-by: Fabio Estevam <festevam@denx.de>
Reviewed-by: Fabio Estevam <festevam@denx.de>
Fixes: 41c42ff5dbe2 ("leds: simple driver for pwm driven LEDs")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since (implicit) v1 sent with Message-Id:
20230922142304.1685985-1-u.kleine-koenig@pengutronix.de:

 - Use true instead of 1 to assign the boot .enabled. Thanks Fabio for
   that hint.
 - Add Reviewed-by: tag for Fabio

In reply to the first iteration, Rogan wrote that
"led_dat->pwmstate.enabled = true; also addresses the problem".

BTW, this patch is similar to deaeeda2051f ("backlight: pwm_bl: Don't
rely on a disabled PWM emiting inactive state") which fixed the same
issue for PWM backlights.

Best regards
Uwe

 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 419b710984ab..2b3bf1353b70 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,7 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty = led_dat->pwmstate.period - duty;
 
 	led_dat->pwmstate.duty_cycle = duty;
-	led_dat->pwmstate.enabled = duty > 0;
+	led_dat->pwmstate.enabled = true;
 	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

