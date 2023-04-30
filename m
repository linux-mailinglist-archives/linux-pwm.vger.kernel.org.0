Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691E96F29AE
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjD3RAo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjD3RAn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E635B8
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K8/uuKsiCeKwUAmdNTojaP58o37PBpkrS4yfaiIq/3o=;
        b=doh8HgpCWumC/upM879706RHetIHth9fO1E8IR7eIS7AqUQcvxQrHwcnArMCoBF0EyzBUP
        keoC2BmJrO/F8UdCLTt2pvOyGYk116A0kR3qKfCp+I89l0BjfspgqQ9vDFExg6MQVVSuEO
        yXMFU/tunEE/9lTcWelEdtsWbuNQZKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-iywYBAGXPdCyedIsQIQa0g-1; Sun, 30 Apr 2023 12:58:40 -0400
X-MC-Unique: iywYBAGXPdCyedIsQIQa0g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86E65A0F387;
        Sun, 30 Apr 2023 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D1F42166B26;
        Sun, 30 Apr 2023 16:58:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 17/19] platform/x86: lenovo-yogabook: Add platform driver support
Date:   Sun, 30 Apr 2023 18:58:05 +0200
Message-Id: <20230430165807.472798-18-hdegoede@redhat.com>
In-Reply-To: <20230430165807.472798-1-hdegoede@redhat.com>
References: <20230430165807.472798-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The Lenovo Yoga Book 1 comes in 2 versions.

Version 1: The yb1-x91f/l currently supported by lenovo-yogabook-wmi, which
has a WMI interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Version 2: The yb1-x90f/l which is the same hardware shipping with Android
as factory OS. This version has a very different BIOS and ACPI tables which
lack the WMI interface.

Instead the x86-android-tablets.ko code which does devices instantiation
for devices missing from ACPI on various x86 Android tablets will
instantiate a platform device for the keyboard half touch-kbd/digitizer
toggle functionality.

This patch adds a platform driver to the lenovo-yogabook code which binds
to the platform device instantiated by x86-android-tablets.ko offering
touch-kbd/digitizer toggle functionality on the Android model.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use r = dev_err_probe(...) in various places
- Error-exit handling fixes in yogabook_pdev_probe() and
  yogabook_module_init()
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 164 ++++++++++++++++++++-
 1 file changed, 160 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index f413af41e3c0..0183b75a47e8 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -1,12 +1,24 @@
 // SPDX-License-Identifier: GPL-2.0
-/* WMI driver for Lenovo Yoga Book YB1-X90* / -X91* tablets */
+/*
+ * Platform driver for Lenovo Yoga Book YB1-X90F/L tablets (Android model)
+ * WMI driver for Lenovo Yoga Book YB1-X91F/L tablets (Windows model)
+ *
+ * The keyboard half of the YB1 models can function as both a capacitive
+ * touch keyboard or as a Wacom digitizer, but not at the same time.
+ *
+ * This driver takes care of switching between the 2 functions.
+ *
+ * Copyright 2023 Hans de Goede <hansg@kernel.org>
+ */
 
 #include <linux/acpi.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
-#include <linux/module.h>
 #include <linux/leds.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/wmi.h>
 #include <linux/workqueue.h>
 
@@ -15,6 +27,8 @@
 #define YB_KBD_BL_DEFAULT	128
 #define YB_KBD_BL_MAX		255
 
+#define YB_PDEV_NAME		"yogabook-touch-kbd-digitizer-switch"
+
 /* flags */
 enum {
 	YB_KBD_IS_ON,
@@ -31,8 +45,11 @@ struct yogabook_data {
 	struct device *kbd_dev;
 	struct device *dig_dev;
 	struct led_classdev *pen_led;
+	struct gpio_desc *pen_touch_event;
+	struct gpio_desc *kbd_bl_led_enable;
 	struct gpio_desc *backside_hall_gpio;
 	int (*set_kbd_backlight)(struct yogabook_data *data, uint8_t level);
+	int pen_touch_irq;
 	int backside_hall_irq;
 	struct work_struct work;
 	struct led_classdev kbd_bl_led;
@@ -272,6 +289,8 @@ static int yogabook_resume(struct device *dev)
 
 static DEFINE_SIMPLE_DEV_PM_OPS(yogabook_pm_ops, yogabook_suspend, yogabook_resume);
 
+/********** WMI driver code **********/
+
 /*
  * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
  * device (Goodix touchpad acts as virtual sensor keyboard).
@@ -393,8 +412,145 @@ static struct wmi_driver yogabook_wmi_driver = {
 	.remove = yogabook_wmi_remove,
 	.notify = yogabook_wmi_notify,
 };
-module_wmi_driver(yogabook_wmi_driver);
 
+/********** platform driver code **********/
+
+static struct gpiod_lookup_table yogabook_pdev_gpios = {
+	.dev_id = YB_PDEV_NAME,
+	.table = {
+		GPIO_LOOKUP("INT33FF:00", 95, "pen_touch_event", GPIO_ACTIVE_HIGH),
+		GPIO_LOOKUP("INT33FF:03", 52, "enable_keyboard_led", GPIO_ACTIVE_HIGH),
+		{}
+	},
+};
+
+static int yogabook_pdev_set_kbd_backlight(struct yogabook_data *data, u8 level)
+{
+	gpiod_set_value(data->kbd_bl_led_enable, level ? 1 : 0);
+	return 0;
+}
+
+static irqreturn_t yogabook_pen_touch_irq(int irq, void *data)
+{
+	yogabook_toggle_digitizer_mode(data);
+	return IRQ_HANDLED;
+}
+
+static int yogabook_pdev_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct yogabook_data *data;
+	int r;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data->kbd_dev = bus_find_device_by_name(&i2c_bus_type, NULL, "i2c-goodix_ts");
+	if (!data->kbd_dev || !data->kbd_dev->driver) {
+		r = -EPROBE_DEFER;
+		goto error_put_devs;
+	}
+
+	data->dig_dev = bus_find_device_by_name(&i2c_bus_type, NULL, "i2c-wacom");
+	if (!data->dig_dev || !data->dig_dev->driver) {
+		r = -EPROBE_DEFER;
+		goto error_put_devs;
+	}
+
+	gpiod_add_lookup_table(&yogabook_pdev_gpios);
+	data->pen_touch_event = devm_gpiod_get(dev, "pen_touch_event", GPIOD_IN);
+	data->kbd_bl_led_enable = devm_gpiod_get(dev, "enable_keyboard_led", GPIOD_OUT_HIGH);
+	gpiod_remove_lookup_table(&yogabook_pdev_gpios);
+
+	if (IS_ERR(data->pen_touch_event)) {
+		r = dev_err_probe(dev, PTR_ERR(data->pen_touch_event),
+				  "Getting pen_touch_event GPIO\n");
+		goto error_put_devs;
+	}
+
+	if (IS_ERR(data->kbd_bl_led_enable)) {
+		r = dev_err_probe(dev, PTR_ERR(data->kbd_bl_led_enable),
+				  "Getting enable_keyboard_led GPIO\n");
+		goto error_put_devs;
+	}
+
+	r = gpiod_to_irq(data->pen_touch_event);
+	if (r < 0) {
+		dev_err_probe(dev, r, "Getting pen_touch_event IRQ\n");
+		goto error_put_devs;
+	}
+	data->pen_touch_irq = r;
+
+	r = request_irq(data->pen_touch_irq, yogabook_pen_touch_irq, IRQF_TRIGGER_FALLING,
+			"pen_touch_event", data);
+	if (r) {
+		dev_err_probe(dev, r, "Requesting pen_touch_event IRQ\n");
+		goto error_put_devs;
+	}
+
+	data->set_kbd_backlight = yogabook_pdev_set_kbd_backlight;
+
+	r = yogabook_probe(dev, data, "yogabook::kbd_backlight");
+	if (r)
+		goto error_free_irq;
+
+	return 0;
+
+error_free_irq:
+	free_irq(data->pen_touch_irq, data);
+	cancel_work_sync(&data->work);
+error_put_devs:
+	put_device(data->dig_dev);
+	put_device(data->kbd_dev);
+	return r;
+}
+
+static void yogabook_pdev_remove(struct platform_device *pdev)
+{
+	struct yogabook_data *data = platform_get_drvdata(pdev);
+
+	yogabook_remove(data);
+	free_irq(data->pen_touch_irq, data);
+	cancel_work_sync(&data->work);
+	put_device(data->dig_dev);
+	put_device(data->kbd_dev);
+}
+
+static struct platform_driver yogabook_pdev_driver = {
+	.probe = yogabook_pdev_probe,
+	.remove_new = yogabook_pdev_remove,
+	.driver = {
+		.name = YB_PDEV_NAME,
+		.pm = pm_sleep_ptr(&yogabook_pm_ops),
+	},
+};
+
+static int __init yogabook_module_init(void)
+{
+	int r;
+
+	r = wmi_driver_register(&yogabook_wmi_driver);
+	if (r)
+		return r;
+
+	r = platform_driver_register(&yogabook_pdev_driver);
+	if (r)
+		wmi_driver_unregister(&yogabook_wmi_driver);
+
+	return r;
+}
+
+static void __exit yogabook_module_exit(void)
+{
+	platform_driver_unregister(&yogabook_pdev_driver);
+	wmi_driver_unregister(&yogabook_wmi_driver);
+}
+
+module_init(yogabook_module_init);
+module_exit(yogabook_module_exit);
+
+MODULE_ALIAS("platform:" YB_PDEV_NAME);
 MODULE_AUTHOR("Yauhen Kharuzhy");
-MODULE_DESCRIPTION("Lenovo Yoga Book WMI driver");
+MODULE_DESCRIPTION("Lenovo Yoga Book driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2

