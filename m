Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2156F25A8
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjD2SRN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbjD2SRL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280A9170F
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5l0NBjekwPt1tm9cy4sXp5WtDAZ1a/Mpkik0NMxwolI=;
        b=JdQKT8uEp+4HtI6buDA0EjhrD70V9a4dcHPg0JFqdB0S/osDxepEIWthBy3wqvIL3AROxG
        32tKtEV3rQBvHSdQdXSlcnpkOi3QwVHl4XWW719tZpXnQTVoAMD+DdExWtM3uD4nDz6bm9
        nRrLre3m3h0/WY3HvLaPd4qznkG5WWc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-594-GSzfOu8wMd6m9N4LM_ic7g-1; Sat, 29 Apr 2023 14:16:13 -0400
X-MC-Unique: GSzfOu8wMd6m9N4LM_ic7g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB01D185A78B;
        Sat, 29 Apr 2023 18:16:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CC6C32027043;
        Sat, 29 Apr 2023 18:16:11 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 09/19] platform/x86: lenovo-yogabook: Use PMIC LED driver for pen icon LED control
Date:   Sat, 29 Apr 2023 20:15:41 +0200
Message-Id: <20230429181551.98201-10-hdegoede@redhat.com>
In-Reply-To: <20230429181551.98201-1-hdegoede@redhat.com>
References: <20230429181551.98201-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use the (new) PMIC LED driver for pen icon LED control instead of using
custom WMI calls for this.

This will also work on the Android version of the Lenovo Yoga Book 1,
where there is no WMI interface for this.

The dev_id of the lookup is set using dev_name() so that it will also
work for both the Windows YB1 WMI-device as well as the Android YB1
platform-device. While at it also move the gpio_lookup to using dev_name()
for the dev_id.

Note this also removes the need to turn of the LED during suspend since
the PMIC LED driver now already does that.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 63 ++++++++--------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index b1d17ce9a46c..c5d103099ea9 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -12,11 +12,6 @@
 #include <linux/workqueue.h>
 
 #define YB_MBTN_EVENT_GUID	"243FEC1D-1963-41C1-8100-06A9D82A94B4"
-#define YB_MBTN_METHOD_GUID	"742B0CA1-0B20-404B-9CAA-AEFCABF30CE0"
-
-#define YB_PAD_ENABLE	1
-#define YB_PAD_DISABLE	2
-#define YB_LIGHTUP_BTN	3
 
 #define YB_KBD_BL_DEFAULT 128
 
@@ -35,6 +30,7 @@ struct yogabook_wmi {
 	struct acpi_device *dig_adev;
 	struct device *kbd_dev;
 	struct device *dig_dev;
+	struct led_classdev *pen_led;
 	struct gpio_desc *backside_hall_gpio;
 	int backside_hall_irq;
 	struct work_struct work;
@@ -43,31 +39,6 @@ struct yogabook_wmi {
 	uint8_t brightness;
 };
 
-static int yogabook_wmi_do_action(struct yogabook_wmi *data, int action)
-{
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_buffer input;
-	acpi_status status;
-	u32 dummy_arg = 0;
-
-	dev_dbg(data->dev, "Do action: %d\n", action);
-
-	input.pointer = &dummy_arg;
-	input.length = sizeof(dummy_arg);
-
-	status = wmi_evaluate_method(YB_MBTN_METHOD_GUID, 0, action, &input,
-				     &output);
-	if (ACPI_FAILURE(status)) {
-		dev_err(data->dev, "Calling WMI method failure: 0x%x\n",
-			status);
-		return status;
-	}
-
-	kfree(output.pointer);
-
-	return 0;
-}
-
 /*
  * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
  * device (Goodix touchpad acts as virtual sensor keyboard).
@@ -135,7 +106,7 @@ static void yogabook_wmi_work(struct work_struct *work)
 	}
 
 	if (!digitizer_on && test_bit(YB_DIGITIZER_IS_ON, &data->flags)) {
-		yogabook_wmi_do_action(data, YB_PAD_DISABLE);
+		led_set_brightness(data->pen_led, LED_OFF);
 		device_release_driver(data->dig_dev);
 		clear_bit(YB_DIGITIZER_IS_ON, &data->flags);
 	}
@@ -154,7 +125,7 @@ static void yogabook_wmi_work(struct work_struct *work)
 		if (r)
 			dev_warn(data->dev, "Reprobe of digitizer failed: %d\n", r);
 
-		yogabook_wmi_do_action(data, YB_PAD_ENABLE);
+		led_set_brightness(data->pen_led, LED_FULL);
 		set_bit(YB_DIGITIZER_IS_ON, &data->flags);
 	}
 }
@@ -218,13 +189,17 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 }
 
 static struct gpiod_lookup_table yogabook_wmi_gpios = {
-	.dev_id		= "243FEC1D-1963-41C1-8100-06A9D82A94B4",
-	.table		= {
+	.table = {
 		GPIO_LOOKUP("INT33FF:02", 18, "backside_hall_sw", GPIO_ACTIVE_LOW),
 		{}
 	},
 };
 
+static struct led_lookup_data yogabook_pen_led = {
+	.provider = "platform::indicator",
+	.con_id = "pen-icon-led",
+};
+
 static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct device *dev = &wdev->dev;
@@ -268,6 +243,18 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 		goto error_put_devs;
 	}
 
+	yogabook_pen_led.dev_id = dev_name(dev);
+	led_add_lookup(&yogabook_pen_led);
+	data->pen_led = devm_led_get(dev, "pen-icon-led");
+	led_remove_lookup(&yogabook_pen_led);
+
+	if (IS_ERR(data->pen_led)) {
+		r = PTR_ERR(data->pen_led);
+		dev_err_probe(dev, r, "Getting pen icon LED\n");
+		goto error_put_devs;
+	}
+
+	yogabook_wmi_gpios.dev_id = dev_name(dev);
 	gpiod_add_lookup_table(&yogabook_wmi_gpios);
 	data->backside_hall_gpio = devm_gpiod_get(dev, "backside_hall_sw", GPIOD_IN);
 	gpiod_remove_lookup_table(&yogabook_wmi_gpios);
@@ -352,11 +339,6 @@ static int yogabook_suspend(struct device *dev)
 	set_bit(YB_SUSPENDED, &data->flags);
 
 	flush_work(&data->work);
-
-	/* Turn off the pen button at sleep */
-	if (test_bit(YB_DIGITIZER_IS_ON, &data->flags))
-		yogabook_wmi_do_action(data, YB_PAD_DISABLE);
-
 	return 0;
 }
 
@@ -370,9 +352,6 @@ static int yogabook_resume(struct device *dev)
 		yogabook_wmi_set_kbd_backlight(data, data->brightness);
 	}
 
-	if (test_bit(YB_DIGITIZER_IS_ON, &data->flags))
-		yogabook_wmi_do_action(data, YB_PAD_ENABLE);
-
 	clear_bit(YB_SUSPENDED, &data->flags);
 
 	/* Check for YB_TABLET_MODE changes made during suspend */
-- 
2.39.2

