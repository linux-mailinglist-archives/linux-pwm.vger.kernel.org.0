Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301D27AB38B
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Sep 2023 16:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjIVOXW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 22 Sep 2023 10:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjIVOXV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 22 Sep 2023 10:23:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8D7196
        for <linux-pwm@vger.kernel.org>; Fri, 22 Sep 2023 07:23:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjh3l-0000pY-MN; Fri, 22 Sep 2023 16:23:09 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjh3i-008Bgp-MT; Fri, 22 Sep 2023 16:23:06 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qjh3i-003v4x-D5; Fri, 22 Sep 2023 16:23:06 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de, Fabio Estevam <festevam@denx.de>,
        Rogan Dawes <rogan@dawes.za.net>
Subject: [PATCH] leds: pwm: Don't disable the PWM when the LED should be off
Date:   Fri, 22 Sep 2023 16:23:04 +0200
Message-Id: <20230922142304.1685985-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2358; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=XnBN/XmJZQHCrjBXlLV8sinMK8oe+bJtL8pFLlH92vA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlDaNH8ZcBOorCKNAk1F+c/aYmIXMRpE3Whwz62 /JRGxg8HveJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZQ2jRwAKCRCPgPtYfRL+ Th5XB/9Phru/8jkIpHKhK8R3wYSxpyyqNpzFZp2qB62WUqLGi/iyrVy/ojDRg2YQXBA/CErKUby oewmtoXJyNI1oTCX9JKFl43oQD3JoGA2odNVarhtO3/0aX2w7NcHVAUyNwEIRRGV9FDFno5/wAE kaD7vv7ymcfIBp9ef5w4qhFsu1seVeK6MJ3Np9Vso4wuhN0HWSSDI1lXPpQ90tCPWAQx2XX+7y4 o1Cyx5BIiU4nRTFsjG/WyLTRfIgx5EnO/JwNlTP7wRaN2fabHHhYs9mDonXMQCZttKrJm/Ycxmg BSSAeA55jj3IIH6EnZy05p5tpoIdPWn5fEQ2jSp5YASz1dbx
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Disabling a PWM (i.e. calling pwm_apply_state with .enabled = false)
gives no guarantees about what the PWM output does. It might freeze
where it currently is, or go in a High-Z state or drive the active or
inactive state, it might even continue to toggle.

To ensure that the LED gets really disabled when brightness is set to
zero, don't disable the PWM.

This fixes disabling a leds-pwm LED on i.MX28 (and others). The PWM on
this SoC is one of those that freezes its output on disable, so if you
disable an LED that is full on, it stays on. If you disable a LED with
half brightness it goes off in 50% of the cases and full on in the other
50%.

Reported-by: Rogan Dawes <rogan@dawes.za.net>
Reported-by: Fabio Estevam <festevam@denx.de>
Fixes: 41c42ff5dbe2 ("leds: simple driver for pwm driven LEDs")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

this is a follow up to
https://lore.kernel.org/linux-pwm/20230922121752.344965-1-festevam@gmail.com

I knew the problem and already tried to address it a few years ago, see e.g.
https://lore.kernel.org/linux-pwm/20180806155129.cjcc7okmwtaujf43@pengutronix.de
. Back then the discussion didn't result in a fix, though. So here is
another effort to fix it. Since 2018 at least the documentation
situation is a bit clearer and we have:

	As a consumer, don't rely on the output's state for a disabled PWM. If it's
	easily possible, drivers are supposed to emit the inactive state, but some
	drivers cannot. If you rely on getting the inactive state, use .duty_cycle=0,
	.enabled=true.

in the docs since commit 80a22fde803a ("pwm: Document that the pinstate
of a disabled PWM isn't reliable").

Best regards
Uwe

 drivers/leds/leds-pwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 419b710984ab..5e26aa34de01 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -53,7 +53,7 @@ static int led_pwm_set(struct led_classdev *led_cdev,
 		duty = led_dat->pwmstate.period - duty;
 
 	led_dat->pwmstate.duty_cycle = duty;
-	led_dat->pwmstate.enabled = duty > 0;
+	led_dat->pwmstate.enabled = 1;
 	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 

base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
-- 
2.40.1

