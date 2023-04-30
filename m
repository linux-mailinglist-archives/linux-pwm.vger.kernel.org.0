Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B806F29BA
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjD3RBY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbjD3RBY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:01:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206A33A92
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CM1fKYx1KiYBHGTxfG6gfnt6X+KPTwf3j2MNI0Aw5ts=;
        b=RZDQyPFCpL5hjxk9U1jYqWsPuKfVyTEA6TAK0KVrqVXjOfrO1VZycTE6z2g5DHplGnH/IY
        gn49I2QUWqxKSX0vWt/Uea+rjleaw0woPN9UwQwllLV21sjaSy3FigwNJ2A7f1wMY4Csjj
        FkK63qdGy7MaFph+rnTcW0NAOQ9vB1Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-Gr8aawj3Nea0H_xbH-INxg-1; Sun, 30 Apr 2023 12:58:42 -0400
X-MC-Unique: Gr8aawj3Nea0H_xbH-INxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D86EF3C0ED4B;
        Sun, 30 Apr 2023 16:58:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B9D902166B26;
        Sun, 30 Apr 2023 16:58:39 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 18/19] platform/x86: lenovo-yogabook: Add keyboard backlight control to platform driver
Date:   Sun, 30 Apr 2023 18:58:06 +0200
Message-Id: <20230430165807.472798-19-hdegoede@redhat.com>
In-Reply-To: <20230430165807.472798-1-hdegoede@redhat.com>
References: <20230430165807.472798-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On the Android yb1-x90f/l models there is not ACPI method to control
the keyboard backlight brightness. Instead the second PWM controller
is exposed directly to the OS there.

Add support for controlling keyboard backlight brightness on the Android
model by using the PWM subsystem to directly control the PWM.

The Android model also requires explicitly turning the backlight off
on suspend, which on the Windows model was done automatically.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use YB_KBD_BL_PWM_PERIOD define in yogabook_pdev_pwm_lookup[]
- Turn off keyboard backlight on suspend
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 31 +++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 0183b75a47e8..b49109d91ec3 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -19,6 +19,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pwm.h>
 #include <linux/wmi.h>
 #include <linux/workqueue.h>
 
@@ -26,6 +27,7 @@
 
 #define YB_KBD_BL_DEFAULT	128
 #define YB_KBD_BL_MAX		255
+#define YB_KBD_BL_PWM_PERIOD	13333
 
 #define YB_PDEV_NAME		"yogabook-touch-kbd-digitizer-switch"
 
@@ -48,6 +50,7 @@ struct yogabook_data {
 	struct gpio_desc *pen_touch_event;
 	struct gpio_desc *kbd_bl_led_enable;
 	struct gpio_desc *backside_hall_gpio;
+	struct pwm_device *kbd_bl_pwm;
 	int (*set_kbd_backlight)(struct yogabook_data *data, uint8_t level);
 	int pen_touch_irq;
 	int backside_hall_irq;
@@ -267,8 +270,11 @@ static int yogabook_suspend(struct device *dev)
 	struct yogabook_data *data = dev_get_drvdata(dev);
 
 	set_bit(YB_SUSPENDED, &data->flags);
-
 	flush_work(&data->work);
+
+	if (test_bit(YB_KBD_IS_ON, &data->flags))
+		data->set_kbd_backlight(data, 0);
+
 	return 0;
 }
 
@@ -424,8 +430,21 @@ static struct gpiod_lookup_table yogabook_pdev_gpios = {
 	},
 };
 
+static struct pwm_lookup yogabook_pdev_pwm_lookup[] = {
+	PWM_LOOKUP_WITH_MODULE("80862289:00", 0, YB_PDEV_NAME, "kbd_bl_pwm",
+			       YB_KBD_BL_PWM_PERIOD, PWM_POLARITY_NORMAL,
+			       "pwm-lpss-platform"),
+};
+
 static int yogabook_pdev_set_kbd_backlight(struct yogabook_data *data, u8 level)
 {
+	struct pwm_state state = {
+		.period = YB_KBD_BL_PWM_PERIOD,
+		.duty_cycle = YB_KBD_BL_PWM_PERIOD * level / YB_KBD_BL_MAX,
+		.enabled = level,
+	};
+
+	pwm_apply_state(data->kbd_bl_pwm, &state);
 	gpiod_set_value(data->kbd_bl_led_enable, level ? 1 : 0);
 	return 0;
 }
@@ -475,6 +494,16 @@ static int yogabook_pdev_probe(struct platform_device *pdev)
 		goto error_put_devs;
 	}
 
+	pwm_add_table(yogabook_pdev_pwm_lookup, ARRAY_SIZE(yogabook_pdev_pwm_lookup));
+	data->kbd_bl_pwm = devm_pwm_get(dev, "kbd_bl_pwm");
+	pwm_remove_table(yogabook_pdev_pwm_lookup, ARRAY_SIZE(yogabook_pdev_pwm_lookup));
+
+	if (IS_ERR(data->kbd_bl_pwm)) {
+		r = dev_err_probe(dev, PTR_ERR(data->kbd_bl_pwm),
+				  "Getting keyboard backlight PWM\n");
+		goto error_put_devs;
+	}
+
 	r = gpiod_to_irq(data->pen_touch_event);
 	if (r < 0) {
 		dev_err_probe(dev, r, "Getting pen_touch_event IRQ\n");
-- 
2.39.2

