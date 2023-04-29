Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025A56F25A6
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjD2SRL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjD2SRL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F951FEB
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792178;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9rJXX1tgci+VDsSJf8Lz44fVxxbVWd7xxyC68+Dpa5A=;
        b=WtU/Imx/Y32OnWf4aATP8glLk8gfz+CO9Htt0eQYCk7Y2JObuix7eJYgSeoFOtcM+tDh63
        ynjUKWLXMGlJFsysLN4igYjfDRcbBEC1ivnqAV+vvGgs2yG3ndUbg1PXxYl8JfTmlZ8YQk
        5TQXzAy/WhuH/rJ53L9ZCaEsfcXqpqE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-2Jw4URJ4M_ik5MpWYHxlkw-1; Sat, 29 Apr 2023 14:16:14 -0400
X-MC-Unique: 2Jw4URJ4M_ik5MpWYHxlkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46A8A1C05ACC;
        Sat, 29 Apr 2023 18:16:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29F1A2027043;
        Sat, 29 Apr 2023 18:16:13 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 10/19] platform/x86: lenovo-yogabook: Split probe() into generic and WMI specific parts
Date:   Sat, 29 Apr 2023 20:15:42 +0200
Message-Id: <20230429181551.98201-11-hdegoede@redhat.com>
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

Split probe() and remove() into generic and WMI specific parts.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 98 +++++++++++++---------
 1 file changed, 59 insertions(+), 39 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index c5d103099ea9..4bcbf0f84732 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -200,16 +200,11 @@ static struct led_lookup_data yogabook_pen_led = {
 	.con_id = "pen-icon-led",
 };
 
-static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
+static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
+			  const char *kbd_bl_led_name)
 {
-	struct device *dev = &wdev->dev;
-	struct yogabook_wmi *data;
 	int r;
 
-	data = devm_kzalloc(dev, sizeof(struct yogabook_wmi), GFP_KERNEL);
-	if (data == NULL)
-		return -ENOMEM;
-
 	dev_set_drvdata(dev, data);
 
 	data->dev = dev;
@@ -218,31 +213,6 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
 	INIT_WORK(&data->work, yogabook_wmi_work);
 
-	data->kbd_adev = acpi_dev_get_first_match_dev("GDIX1001", NULL, -1);
-	if (!data->kbd_adev) {
-		dev_err(dev, "Cannot find the touchpad device in ACPI tables\n");
-		return -ENODEV;
-	}
-
-	data->dig_adev = acpi_dev_get_first_match_dev("WCOM0019", NULL, -1);
-	if (!data->dig_adev) {
-		dev_err(dev, "Cannot find the digitizer device in ACPI tables\n");
-		r = -ENODEV;
-		goto error_put_devs;
-	}
-
-	data->kbd_dev = get_device(acpi_get_first_physical_node(data->kbd_adev));
-	if (!data->kbd_dev || !data->kbd_dev->driver) {
-		r = -EPROBE_DEFER;
-		goto error_put_devs;
-	}
-
-	data->dig_dev = get_device(acpi_get_first_physical_node(data->dig_adev));
-	if (!data->dig_dev || !data->dig_dev->driver) {
-		r = -EPROBE_DEFER;
-		goto error_put_devs;
-	}
-
 	yogabook_pen_led.dev_id = dev_name(dev);
 	led_add_lookup(&yogabook_pen_led);
 	data->pen_led = devm_led_get(dev, "pen-icon-led");
@@ -251,7 +221,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	if (IS_ERR(data->pen_led)) {
 		r = PTR_ERR(data->pen_led);
 		dev_err_probe(dev, r, "Getting pen icon LED\n");
-		goto error_put_devs;
+		return r;
 	}
 
 	yogabook_wmi_gpios.dev_id = dev_name(dev);
@@ -262,13 +232,13 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	if (IS_ERR(data->backside_hall_gpio)) {
 		r = PTR_ERR(data->backside_hall_gpio);
 		dev_err_probe(dev, r, "Getting backside_hall_sw GPIO\n");
-		goto error_put_devs;
+		return r;
 	}
 
 	r = gpiod_to_irq(data->backside_hall_gpio);
 	if (r < 0) {
 		dev_err_probe(dev, r, "Getting backside_hall_sw IRQ\n");
-		goto error_put_devs;
+		return r;
 	}
 	data->backside_hall_irq = r;
 
@@ -280,12 +250,12 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 			"backside_hall_sw", data);
 	if (r) {
 		dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n");
-		goto error_put_devs;
+		return r;
 	}
 
 	schedule_work(&data->work);
 
-	data->kbd_bl_led.name = "ybwmi::kbd_backlight";
+	data->kbd_bl_led.name = kbd_bl_led_name;
 	data->kbd_bl_led.brightness_set_blocking = kbd_brightness_set;
 	data->kbd_bl_led.brightness_get = kbd_brightness_get;
 	data->kbd_bl_led.max_brightness = 255;
@@ -301,6 +271,50 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 error_free_irq:
 	free_irq(data->backside_hall_irq, data);
 	cancel_work_sync(&data->work);
+	return r;
+}
+
+static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
+{
+	struct device *dev = &wdev->dev;
+	struct yogabook_wmi *data;
+	int r;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (data == NULL)
+		return -ENOMEM;
+
+	data->kbd_adev = acpi_dev_get_first_match_dev("GDIX1001", NULL, -1);
+	if (!data->kbd_adev) {
+		dev_err(dev, "Cannot find the touchpad device in ACPI tables\n");
+		return -ENODEV;
+	}
+
+	data->dig_adev = acpi_dev_get_first_match_dev("WCOM0019", NULL, -1);
+	if (!data->dig_adev) {
+		dev_err(dev, "Cannot find the digitizer device in ACPI tables\n");
+		r = -ENODEV;
+		goto error_put_devs;
+	}
+
+	data->kbd_dev = get_device(acpi_get_first_physical_node(data->kbd_adev));
+	if (!data->kbd_dev || !data->kbd_dev->driver) {
+		r = -EPROBE_DEFER;
+		goto error_put_devs;
+	}
+
+	data->dig_dev = get_device(acpi_get_first_physical_node(data->dig_adev));
+	if (!data->dig_dev || !data->dig_dev->driver) {
+		r = -EPROBE_DEFER;
+		goto error_put_devs;
+	}
+
+	r = yogabook_probe(dev, data, "ybwmi::kbd_backlight");
+	if (r)
+		goto error_put_devs;
+
+	return 0;
+
 error_put_devs:
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
@@ -309,9 +323,8 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	return r;
 }
 
-static void yogabook_wmi_remove(struct wmi_device *wdev)
+static void yogabook_remove(struct yogabook_wmi *data)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
 	int r = 0;
 
 	free_irq(data->backside_hall_irq, data);
@@ -325,6 +338,13 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 
 	if (r)
 		dev_warn(data->dev, "Reprobe of devices failed\n");
+}
+
+static void yogabook_wmi_remove(struct wmi_device *wdev)
+{
+	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
+
+	yogabook_remove(data);
 
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
-- 
2.39.2

