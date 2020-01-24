Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A877148C8D
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jan 2020 17:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389773AbgAXQyR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jan 2020 11:54:17 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:38350 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387670AbgAXQyR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2020 11:54:17 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id E4B7C8CCA30; Fri, 24 Jan 2020 17:54:15 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Jeff LaBundy <jeff@labundy.com>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 2/3] leds: pwm: convert to atomic PWM API
Date:   Fri, 24 Jan 2020 17:54:08 +0100
Message-Id: <20200124165409.12422-3-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200124165409.12422-1-uwe@kleine-koenig.org>
References: <20200124165409.12422-1-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_config(), pwm_enable() and pwm_disable() should get removed in the
long run. So update the driver to use the atomic API that is here to
stay.

A few side effects:

 - led_pwm_set() now returns an error when setting the PWM fails.
 - During .probe() the PWM isn't disabled implicitly by pwm_apply_args()
   any more.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/leds/leds-pwm.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index b72fd89ff390..9111cdede0ee 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -22,9 +22,8 @@
 struct led_pwm_data {
 	struct led_classdev	cdev;
 	struct pwm_device	*pwm;
+	struct pwm_state	pwmstate;
 	unsigned int		active_low;
-	unsigned int		period;
-	int			duty;
 };
 
 struct led_pwm_priv {
@@ -32,44 +31,29 @@ struct led_pwm_priv {
 	struct led_pwm_data leds[0];
 };
 
-static void __led_pwm_set(struct led_pwm_data *led_dat)
-{
-	int new_duty = led_dat->duty;
-
-	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty == 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
-}
-
 static int led_pwm_set(struct led_classdev *led_cdev,
 		       enum led_brightness brightness)
 {
 	struct led_pwm_data *led_dat =
 		container_of(led_cdev, struct led_pwm_data, cdev);
 	unsigned int max = led_dat->cdev.max_brightness;
-	unsigned long long duty =  led_dat->period;
+	unsigned long long duty = led_dat->pwmstate.period;
 
 	duty *= brightness;
 	do_div(duty, max);
 
 	if (led_dat->active_low)
-		duty = led_dat->period - duty;
-
-	led_dat->duty = duty;
-
-	__led_pwm_set(led_dat);
+		duty = led_dat->pwmstate.period - duty;
 
-	return 0;
+	led_dat->pwmstate.duty_cycle = duty;
+	led_dat->pwmstate.enabled = duty > 0;
+	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
-	struct pwm_args pargs;
 	int ret;
 
 	led_data->active_low = led->active_low;
@@ -93,17 +77,10 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 
 	led_data->cdev.brightness_set_blocking = led_pwm_set;
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(led_data->pwm);
-
-	pwm_get_args(led_data->pwm, &pargs);
+	pwm_init_state(led_data->pwm, &led_data->pwmstate);
 
-	led_data->period = pargs.period;
-	if (!led_data->period)
-		led_data->period = led->pwm_period_ns;
+	if (!led_data->pwmstate.period)
+		led_data->pwmstate.period = led->pwm_period_ns;
 
 	ret = devm_led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
-- 
2.24.0

