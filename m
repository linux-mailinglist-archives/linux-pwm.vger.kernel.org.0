Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C749C6F29A2
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjD3RAh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbjD3RAg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BB1535A4
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VXHwsCXKeMn1KRwGbgqGGqTyQsRETIoDYs3QhSTfM0c=;
        b=NUnxA9ALUctgzPkSk/9+41q5glVdxdJzwx0dM9ypzIO0XiKKcXFBQL9d+/51g3RnW4Tjfl
        bVnu68bxY7dXA62xQk2kwzWHLbPvWIjkW0GJzVMcHbpFs3foYXL5y0FhLoCWpHW1qdJIaV
        dp8jLMCWQtoimoiG7qx6Hput48sgCzg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-16-p88xneZUMDKCDxpZuh7mDw-1; Sun, 30 Apr 2023 12:58:30 -0400
X-MC-Unique: p88xneZUMDKCDxpZuh7mDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 596CC1C06EC1;
        Sun, 30 Apr 2023 16:58:30 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DEE62166B26;
        Sun, 30 Apr 2023 16:58:29 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 10/19] platform/x86: lenovo-yogabook: Split probe() into generic and WMI specific parts
Date:   Sun, 30 Apr 2023 18:57:58 +0200
Message-Id: <20230430165807.472798-11-hdegoede@redhat.com>
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

Split probe() and remove() into generic and WMI specific parts.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use "return dev_err_probe(...);" in several places to simplify
  error-exits in the new yogabook_probe() function
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 118 ++++++++++++---------
 1 file changed, 65 insertions(+), 53 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 68057150f465..e583ae146323 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -199,74 +199,38 @@ static struct led_lookup_data yogabook_pen_led = {
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
 	data->dev = dev;
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
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
 	led_remove_lookup(&yogabook_pen_led);
 
-	if (IS_ERR(data->pen_led)) {
-		r = PTR_ERR(data->pen_led);
-		dev_err_probe(dev, r, "Getting pen icon LED\n");
-		goto error_put_devs;
-	}
+	if (IS_ERR(data->pen_led))
+		return dev_err_probe(dev, PTR_ERR(data->pen_led), "Getting pen icon LED\n");
 
 	yogabook_wmi_gpios.dev_id = dev_name(dev);
 	gpiod_add_lookup_table(&yogabook_wmi_gpios);
 	data->backside_hall_gpio = devm_gpiod_get(dev, "backside_hall_sw", GPIOD_IN);
 	gpiod_remove_lookup_table(&yogabook_wmi_gpios);
 
-	if (IS_ERR(data->backside_hall_gpio)) {
-		r = PTR_ERR(data->backside_hall_gpio);
-		dev_err_probe(dev, r, "Getting backside_hall_sw GPIO\n");
-		goto error_put_devs;
-	}
+	if (IS_ERR(data->backside_hall_gpio))
+		return dev_err_probe(dev, PTR_ERR(data->backside_hall_gpio),
+				     "Getting backside_hall_sw GPIO\n");
 
 	r = gpiod_to_irq(data->backside_hall_gpio);
-	if (r < 0) {
-		dev_err_probe(dev, r, "Getting backside_hall_sw IRQ\n");
-		goto error_put_devs;
-	}
+	if (r < 0)
+		return dev_err_probe(dev, r, "Getting backside_hall_sw IRQ\n");
+
 	data->backside_hall_irq = r;
 
 	/* Set default brightness before enabling the IRQ */
@@ -275,14 +239,12 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	r = request_irq(data->backside_hall_irq, yogabook_backside_hall_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			"backside_hall_sw", data);
-	if (r) {
-		dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n");
-		goto error_put_devs;
-	}
+	if (r)
+		return dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n");
 
 	schedule_work(&data->work);
 
-	data->kbd_bl_led.name = "ybwmi::kbd_backlight";
+	data->kbd_bl_led.name = kbd_bl_led_name;
 	data->kbd_bl_led.brightness_set_blocking = kbd_brightness_set;
 	data->kbd_bl_led.brightness_get = kbd_brightness_get;
 	data->kbd_bl_led.max_brightness = 255;
@@ -299,6 +261,50 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
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
@@ -307,9 +313,8 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	return r;
 }
 
-static void yogabook_wmi_remove(struct wmi_device *wdev)
+static void yogabook_remove(struct yogabook_wmi *data)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
 	int r = 0;
 
 	free_irq(data->backside_hall_irq, data);
@@ -323,6 +328,13 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 
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

