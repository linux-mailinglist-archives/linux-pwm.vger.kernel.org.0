Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8669134A3A9
	for <lists+linux-pwm@lfdr.de>; Fri, 26 Mar 2021 10:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhCZJHS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 26 Mar 2021 05:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhCZJGs (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 26 Mar 2021 05:06:48 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728E0C0613AA
        for <linux-pwm@vger.kernel.org>; Fri, 26 Mar 2021 02:06:48 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPiQV-0002vm-OY; Fri, 26 Mar 2021 10:06:43 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lPiQV-0003NR-6h; Fri, 26 Mar 2021 10:06:43 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] ARM: s3c/rx1950: Use pwm_get() in favour of pwm_request()
Date:   Fri, 26 Mar 2021 10:06:41 +0100
Message-Id: <20210326090641.122436-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
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

pwm_request() is deprecated because (among others) it depends on a global
numbering of PWM devices. So register a pwm_lookup to pick the right PWM
device (identified by provider and its local id) and use pwm_get().

Before this patch the PWM #1 was used. This is provided by the
samsung-pwm device which is the only PWM provider on this machine. The
local offset is 1, see also commit c107fe904a10 ("ARM: S3C24XX: Use PWM
lookup table for mach-rx1950") with a similar conversion for PWM #0.

As a follow up specify the period only once and symmetrically use pwm_put()
instead of pwm_free() to drop the reference.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

it looks a bit strange to me that the backlight requires two PWMs. But I
think the conversion is done correctly and the code behaves as it did
before.

Best regards
Uwe

 arch/arm/mach-s3c/mach-rx1950.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s3c/mach-rx1950.c b/arch/arm/mach-s3c/mach-rx1950.c
index 6e19add158a9..a3f46aa61c45 100644
--- a/arch/arm/mach-s3c/mach-rx1950.c
+++ b/arch/arm/mach-s3c/mach-rx1950.c
@@ -384,6 +384,8 @@ static struct s3c2410fb_mach_info rx1950_lcd_cfg = {
 static struct pwm_lookup rx1950_pwm_lookup[] = {
 	PWM_LOOKUP("samsung-pwm", 0, "pwm-backlight.0", NULL, 48000,
 		   PWM_POLARITY_NORMAL),
+	PWM_LOOKUP("samsung-pwm", 1, "pwm-backlight.0", "RX1950 LCD", LCD_PWM_PERIOD,
+		   PWM_POLARITY_NORMAL),
 };
 
 static struct pwm_device *lcd_pwm;
@@ -498,19 +500,18 @@ static void rx1950_bl_power(int enable)
 static int rx1950_backlight_init(struct device *dev)
 {
 	WARN_ON(gpio_request(S3C2410_GPB(0), "Backlight"));
-	lcd_pwm = pwm_request(1, "RX1950 LCD");
+	lcd_pwm = pwm_get(dev, "RX1950 LCD");
 	if (IS_ERR(lcd_pwm)) {
 		dev_err(dev, "Unable to request PWM for LCD power!\n");
 		return PTR_ERR(lcd_pwm);
 	}
 
 	/*
-	 * This is only required to initialize .polarity; all other values are
-	 * fixed in this driver.
+	 * Call pwm_init_state to initialize .polarity and .period. The other
+	 * values are fixed in this driver.
 	 */
 	pwm_init_state(lcd_pwm, &lcd_pwm_state);
 
-	lcd_pwm_state.period = LCD_PWM_PERIOD;
 	lcd_pwm_state.duty_cycle = LCD_PWM_DUTY;
 
 	rx1950_lcd_power(1);
@@ -524,7 +525,7 @@ static void rx1950_backlight_exit(struct device *dev)
 	rx1950_bl_power(0);
 	rx1950_lcd_power(0);
 
-	pwm_free(lcd_pwm);
+	pwm_put(lcd_pwm);
 	gpio_free(S3C2410_GPB(0));
 }
 
-- 
2.30.2

