Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14B66F25B8
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjD2SRr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjD2SRp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EB61FDD
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792214;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VI8KFPBEode1Ja3mAtQlDz4gzrYpRITAbj+ORHjEuAQ=;
        b=gdiN1lSE9nS58QMQm0iovunn+k6RP2911qjtiD828qWjmZOjOcW8wDbKGFruIU0Wq2MCWp
        ya3B7DP/MBJtGioBKQO0/MeQ2/hWTwrCl1rj7zhBU1nEOl70sZSmZX0SBNrE4PaE12Vf4D
        iNgg/Uegt9iPLFSDo/n/LQI8Aajm72s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-223-4E9_S1-JP46viUO1NgugTA-1; Sat, 29 Apr 2023 14:16:50 -0400
X-MC-Unique: 4E9_S1-JP46viUO1NgugTA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DA757811E7B;
        Sat, 29 Apr 2023 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC3672027043;
        Sat, 29 Apr 2023 18:16:48 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 18/19] platform/x86: lenovo-yogabook: Add keyboard backlight control to platform driver
Date:   Sat, 29 Apr 2023 20:15:50 +0200
Message-Id: <20230429181551.98201-19-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-1-hdegoede@redhat.com>
References: <20230429181551.98201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 26 ++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index afb11d25abc8..8e12a625ee65 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -20,6 +20,7 @@
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pwm.h>
 #include <linux/wmi.h>
 #include <linux/workqueue.h>
 
@@ -27,6 +28,7 @@
 
 #define YB_KBD_BL_DEFAULT	128
 #define YB_KBD_BL_MAX		255
+#define YB_KBD_BL_PWM_PERIOD	13333
 
 #define YB_PDEV_NAME		"yogabook-touch-kbd-digitizer-switch"
 
@@ -49,6 +51,7 @@ struct yogabook_data {
 	struct gpio_desc *pen_touch_event;
 	struct gpio_desc *kbd_bl_led_enable;
 	struct gpio_desc *backside_hall_gpio;
+	struct pwm_device *kbd_bl_pwm;
 	int (*set_kbd_backlight)(struct yogabook_data *data, u8 level);
 	int pen_touch_irq;
 	int backside_hall_irq;
@@ -433,8 +436,21 @@ static struct gpiod_lookup_table yogabook_pdev_gpios = {
 	},
 };
 
+static struct pwm_lookup yogabook_pdev_pwm_lookup[] = {
+	PWM_LOOKUP_WITH_MODULE("80862289:00", 0, YB_PDEV_NAME,
+			       "kbd_bl_pwm", 13333, PWM_POLARITY_NORMAL,
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
@@ -484,6 +500,16 @@ static int yogabook_pdev_probe(struct platform_device *pdev)
 		goto error_put_devs;
 	}
 
+	pwm_add_table(yogabook_pdev_pwm_lookup, ARRAY_SIZE(yogabook_pdev_pwm_lookup));
+	data->kbd_bl_pwm = devm_pwm_get(dev, "kbd_bl_pwm");
+	pwm_remove_table(yogabook_pdev_pwm_lookup, ARRAY_SIZE(yogabook_pdev_pwm_lookup));
+
+	if (IS_ERR(data->kbd_bl_pwm)) {
+		r = PTR_ERR(data->kbd_bl_pwm);
+		dev_err_probe(dev, r, "Getting keyboard backlight PWM\n");
+		goto error_put_devs;
+	}
+
 	r = gpiod_to_irq(data->pen_touch_event);
 	if (r < 0) {
 		dev_err_probe(dev, r, "Getting pen_touch_event IRQ\n");
-- 
2.39.2

