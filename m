Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B93148C8E
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Jan 2020 17:54:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgAXQyT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 24 Jan 2020 11:54:19 -0500
Received: from antares.kleine-koenig.org ([94.130.110.236]:38354 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387674AbgAXQyS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 24 Jan 2020 11:54:18 -0500
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 4510C8CCA34; Fri, 24 Jan 2020 17:54:17 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Jeff LaBundy <jeff@labundy.com>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 3/3] leds: pwm: don't set the brightness during .probe
Date:   Fri, 24 Jan 2020 17:54:09 +0100
Message-Id: <20200124165409.12422-4-uwe@kleine-koenig.org>
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

The explicit call to led_pwm_set() prevents that the led's state can
stay as configured by the bootloader.

Note that brightness is always 0 here as the led_pwm driver doesn't
provide a .brightness_get() callback and so the LED was disabled
unconditionally.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/leds/leds-pwm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 9111cdede0ee..de74e1c8d234 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -83,13 +83,11 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		led_data->pwmstate.period = led->pwm_period_ns;
 
 	ret = devm_led_classdev_register(dev, &led_data->cdev);
-	if (ret == 0) {
+	if (ret == 0)
 		priv->num_leds++;
-		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
-	} else {
+	else
 		dev_err(dev, "failed to register PWM led for %s: %d\n",
 			led->name, ret);
-	}
 
 	return ret;
 }
-- 
2.24.0

