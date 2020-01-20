Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC67143285
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2020 20:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgATTkN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Jan 2020 14:40:13 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:40204 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgATTkM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Jan 2020 14:40:12 -0500
X-Greylist: delayed 398 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Jan 2020 14:40:11 EST
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id C09B98C57CE; Mon, 20 Jan 2020 20:33:32 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH] ARM: s3c24xx/rx1950: switch to atomic pwm API
Date:   Mon, 20 Jan 2020 20:33:28 +0100
Message-Id: <20200120193328.17007-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Stop using the legacy PWM API which only still exists because there are
some users left.

Note this change make use of the fact that the value of struct
pwm_state::duty_cycle doesn't matter for a disabled PWM and so its value
can stay constant simplifying the code a bit.

A side effect of the conversion is that the pwm isn't stopped in
rx1950_backlight_init() by the call to pwm_apply_args() just before
reenabling it when rx1950_lcd_power(1) is called.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 arch/arm/mach-s3c24xx/mach-rx1950.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s3c24xx/mach-rx1950.c b/arch/arm/mach-s3c24xx/mach-rx1950.c
index 29f9b345a531..03d8f27cdc32 100644
--- a/arch/arm/mach-s3c24xx/mach-rx1950.c
+++ b/arch/arm/mach-s3c24xx/mach-rx1950.c
@@ -377,6 +377,7 @@ static struct pwm_lookup rx1950_pwm_lookup[] = {
 };
 
 static struct pwm_device *lcd_pwm;
+static struct pwm_state lcd_pwm_state;
 
 static void rx1950_lcd_power(int enable)
 {
@@ -429,15 +430,16 @@ static void rx1950_lcd_power(int enable)
 
 		/* GPB1->OUTPUT, GPB1->0 */
 		gpio_direction_output(S3C2410_GPB(1), 0);
-		pwm_config(lcd_pwm, 0, LCD_PWM_PERIOD);
-		pwm_disable(lcd_pwm);
+
+		lcd_pwm_state.enabled = false;
+		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
 
 		/* GPC0->0, GPC10->0 */
 		gpio_direction_output(S3C2410_GPC(0), 0);
 		gpio_direction_output(S3C2410_GPC(10), 0);
 	} else {
-		pwm_config(lcd_pwm, LCD_PWM_DUTY, LCD_PWM_PERIOD);
-		pwm_enable(lcd_pwm);
+		lcd_pwm_state.enabled = true;
+		pwm_apply_state(lcd_pwm, &lcd_pwm_state);
 
 		gpio_direction_output(S3C2410_GPC(0), 1);
 		gpio_direction_output(S3C2410_GPC(5), 1);
@@ -493,10 +495,13 @@ static int rx1950_backlight_init(struct device *dev)
 	}
 
 	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
+	 * This is only required to initialize .polarity; all other values are
+	 * fixed in this driver.
 	 */
-	pwm_apply_args(lcd_pwm);
+	pwm_init_state(lcd_pwm, &lcd_pwm_state);
+
+	lcd_pwm_state.period = LCD_PWM_PERIOD;
+	lcd_pwm_state.duty_cycle = LCD_PWM_DUTY;
 
 	rx1950_lcd_power(1);
 	rx1950_bl_power(1);
-- 
2.24.0

