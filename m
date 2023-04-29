Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7D86F25AD
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjD2SRi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjD2SRi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9522122
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O7hcrC0aNx3o+Pxd2o1hIxA4Dt31Ay71yh4PZoiwG9Q=;
        b=WfWuPew6M/dcbWPf1GcQvyJcVRQ5yS895qd22jFGePsN8yR30trrTz0UPCmQqkdfKSGUFc
        rg33NKKHls9AMJftddXmlVOE0A9lYQbrLZRd23SO0RClIU9bDlP3Is7177LQROhPw0w4Br
        yR17bHPrsvNtgjb7BLH68FbwST5WDiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-97-6xoe-fRENGOLfBukKbSWyg-1; Sat, 29 Apr 2023 14:16:42 -0400
X-MC-Unique: 6xoe-fRENGOLfBukKbSWyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EF0A7101A531;
        Sat, 29 Apr 2023 18:16:41 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C78662027043;
        Sat, 29 Apr 2023 18:16:15 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 12/19] platform/x86: lenovo-yogabook: Abstract kbd backlight setting
Date:   Sat, 29 Apr 2023 20:15:44 +0200
Message-Id: <20230429181551.98201-13-hdegoede@redhat.com>
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

Abstract kbd backlight setting. While at it also replace the ugly
uint8_t type with u8.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 8d461fb8eac3..efdb20bfe8f5 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -32,19 +32,19 @@ struct yogabook_wmi {
 	struct device *dig_dev;
 	struct led_classdev *pen_led;
 	struct gpio_desc *backside_hall_gpio;
+	int (*set_kbd_backlight)(struct yogabook_wmi *data, u8 level);
 	int backside_hall_irq;
 	struct work_struct work;
 	struct led_classdev kbd_bl_led;
 	unsigned long flags;
-	uint8_t brightness;
+	u8 brightness;
 };
 
 /*
  * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
  * device (Goodix touchpad acts as virtual sensor keyboard).
  */
-static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data,
-					  uint8_t level)
+static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data, u8 level)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
@@ -98,7 +98,7 @@ static void yogabook_wmi_work(struct work_struct *work)
 		 * Must be done before releasing the keyboard touchscreen driver,
 		 * so that the keyboard touchscreen dev is still in D0.
 		 */
-		yogabook_wmi_set_kbd_backlight(data, 0);
+		data->set_kbd_backlight(data, 0);
 		device_release_driver(data->kbd_dev);
 		clear_bit(YB_KBD_IS_ON, &data->flags);
 	}
@@ -114,7 +114,7 @@ static void yogabook_wmi_work(struct work_struct *work)
 		if (r)
 			dev_warn(data->dev, "Reprobe of keyboard touchscreen failed: %d\n", r);
 
-		yogabook_wmi_set_kbd_backlight(data, data->brightness);
+		data->set_kbd_backlight(data, data->brightness);
 		set_bit(YB_KBD_IS_ON, &data->flags);
 	}
 
@@ -183,7 +183,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 	if (!test_bit(YB_KBD_IS_ON, &data->flags))
 		return 0;
 
-	return yogabook_wmi_set_kbd_backlight(data, data->brightness);
+	return data->set_kbd_backlight(data, data->brightness);
 }
 
 static struct gpiod_lookup_table yogabook_wmi_gpios = {
@@ -241,7 +241,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 	data->backside_hall_irq = r;
 
 	/* Set default brightness before enabling the IRQ */
-	yogabook_wmi_set_kbd_backlight(data, YB_KBD_BL_DEFAULT);
+	data->set_kbd_backlight(data, YB_KBD_BL_DEFAULT);
 
 	r = request_irq(data->backside_hall_irq, yogabook_backside_hall_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
@@ -307,6 +307,8 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 		goto error_put_devs;
 	}
 
+	data->set_kbd_backlight = yogabook_wmi_set_kbd_backlight;
+
 	r = yogabook_probe(dev, data, "ybwmi::kbd_backlight");
 	if (r)
 		goto error_put_devs;
@@ -365,7 +367,7 @@ static int yogabook_resume(struct device *dev)
 	struct yogabook_wmi *data = dev_get_drvdata(dev);
 
 	if (test_bit(YB_KBD_IS_ON, &data->flags))
-		yogabook_wmi_set_kbd_backlight(data, data->brightness);
+		data->set_kbd_backlight(data, data->brightness);
 
 	clear_bit(YB_SUSPENDED, &data->flags);
 
-- 
2.39.2

