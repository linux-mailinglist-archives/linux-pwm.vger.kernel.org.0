Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C6C6F25A0
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjD2SRG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjD2SRF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F32108
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9v5loeDDhZZgQOdMVIhhpp9a5j4sKs0E1SutRjyJTk=;
        b=Xq+eFdU6GnG5ICWHWs0OTf+Pi5l4jHCMOvsg3bgkwTYVo34PCel189V+Ue1H3x1BS+VlUs
        1yTi5ciI4I0RsdBYCnh4qvqaS5oPyBZvw8CBbtOhZla25VXPn48yyE9jgHXvaBsBUoAxY5
        LIFRkIBJFXxVkkLOyzztC47QmYp0iNo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-tl7dA9GQNY2ObZCu3c3oHA-1; Sat, 29 Apr 2023 14:16:10 -0400
X-MC-Unique: tl7dA9GQNY2ObZCu3c3oHA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D68E811E7B;
        Sat, 29 Apr 2023 18:16:10 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 358972027043;
        Sat, 29 Apr 2023 18:16:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 07/19] platform/x86: lenovo-yogabook: Store dev instead of wdev in drvdata struct
Date:   Sat, 29 Apr 2023 20:15:39 +0200
Message-Id: <20230429181551.98201-8-hdegoede@redhat.com>
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

Store a "struct device *dev" instead of a "struct wmi_device *wdev;"
in the "struct yogabook_wmi" driver-data.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 47 ++++++++++------------
 1 file changed, 21 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 61076137a350..2bf40930c51a 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -30,7 +30,7 @@ enum {
 };
 
 struct yogabook_wmi {
-	struct wmi_device *wdev;
+	struct device *dev;
 	struct acpi_device *kbd_adev;
 	struct acpi_device *dig_adev;
 	struct device *kbd_dev;
@@ -43,14 +43,14 @@ struct yogabook_wmi {
 	uint8_t brightness;
 };
 
-static int yogabook_wmi_do_action(struct wmi_device *wdev, int action)
+static int yogabook_wmi_do_action(struct yogabook_wmi *data, int action)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_buffer input;
 	acpi_status status;
 	u32 dummy_arg = 0;
 
-	dev_dbg(&wdev->dev, "Do action: %d\n", action);
+	dev_dbg(data->dev, "Do action: %d\n", action);
 
 	input.pointer = &dummy_arg;
 	input.length = sizeof(dummy_arg);
@@ -58,7 +58,7 @@ static int yogabook_wmi_do_action(struct wmi_device *wdev, int action)
 	status = wmi_evaluate_method(YB_MBTN_METHOD_GUID, 0, action, &input,
 				     &output);
 	if (ACPI_FAILURE(status)) {
-		dev_err(&wdev->dev, "Calling WMI method failure: 0x%x\n",
+		dev_err(data->dev, "Calling WMI method failure: 0x%x\n",
 			status);
 		return status;
 	}
@@ -72,21 +72,20 @@ static int yogabook_wmi_do_action(struct wmi_device *wdev, int action)
  * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
  * device (Goodix touchpad acts as virtual sensor keyboard).
  */
-static int yogabook_wmi_set_kbd_backlight(struct wmi_device *wdev,
+static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data,
 					  uint8_t level)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
 	union acpi_object param;
 	acpi_status status;
 
 	if (data->kbd_adev->power.state != ACPI_STATE_D0) {
-		dev_warn(&wdev->dev, "keyboard touchscreen not in D0, cannot set brightness\n");
+		dev_warn(data->dev, "keyboard touchscreen not in D0, cannot set brightness\n");
 		return -ENXIO;
 	}
 
-	dev_dbg(&wdev->dev, "Set KBLC level to %u\n", level);
+	dev_dbg(data->dev, "Set KBLC level to %u\n", level);
 
 	input.count = 1;
 	input.pointer = &param;
@@ -97,7 +96,7 @@ static int yogabook_wmi_set_kbd_backlight(struct wmi_device *wdev,
 	status = acpi_evaluate_object(acpi_device_handle(data->kbd_adev), "KBLC",
 				      &input, &output);
 	if (ACPI_FAILURE(status)) {
-		dev_err(&wdev->dev, "Failed to call KBLC method: 0x%x\n", status);
+		dev_err(data->dev, "Failed to call KBLC method: 0x%x\n", status);
 		return status;
 	}
 
@@ -108,7 +107,6 @@ static int yogabook_wmi_set_kbd_backlight(struct wmi_device *wdev,
 static void yogabook_wmi_work(struct work_struct *work)
 {
 	struct yogabook_wmi *data = container_of(work, struct yogabook_wmi, work);
-	struct device *dev = &data->wdev->dev;
 	bool kbd_on, digitizer_on;
 	int r;
 
@@ -131,13 +129,13 @@ static void yogabook_wmi_work(struct work_struct *work)
 		 * Must be done before releasing the keyboard touchscreen driver,
 		 * so that the keyboard touchscreen dev is still in D0.
 		 */
-		yogabook_wmi_set_kbd_backlight(data->wdev, 0);
+		yogabook_wmi_set_kbd_backlight(data, 0);
 		device_release_driver(data->kbd_dev);
 		clear_bit(YB_KBD_IS_ON, &data->flags);
 	}
 
 	if (!digitizer_on && test_bit(YB_DIGITIZER_IS_ON, &data->flags)) {
-		yogabook_wmi_do_action(data->wdev, YB_PAD_DISABLE);
+		yogabook_wmi_do_action(data, YB_PAD_DISABLE);
 		device_release_driver(data->dig_dev);
 		clear_bit(YB_DIGITIZER_IS_ON, &data->flags);
 	}
@@ -145,18 +143,18 @@ static void yogabook_wmi_work(struct work_struct *work)
 	if (kbd_on && !test_bit(YB_KBD_IS_ON, &data->flags)) {
 		r = device_reprobe(data->kbd_dev);
 		if (r)
-			dev_warn(dev, "Reprobe of keyboard touchscreen failed: %d\n", r);
+			dev_warn(data->dev, "Reprobe of keyboard touchscreen failed: %d\n", r);
 
-		yogabook_wmi_set_kbd_backlight(data->wdev, data->brightness);
+		yogabook_wmi_set_kbd_backlight(data, data->brightness);
 		set_bit(YB_KBD_IS_ON, &data->flags);
 	}
 
 	if (digitizer_on && !test_bit(YB_DIGITIZER_IS_ON, &data->flags)) {
 		r = device_reprobe(data->dig_dev);
 		if (r)
-			dev_warn(dev, "Reprobe of digitizer failed: %d\n", r);
+			dev_warn(data->dev, "Reprobe of digitizer failed: %d\n", r);
 
-		yogabook_wmi_do_action(data->wdev, YB_PAD_ENABLE);
+		yogabook_wmi_do_action(data, YB_PAD_ENABLE);
 		set_bit(YB_DIGITIZER_IS_ON, &data->flags);
 	}
 }
@@ -207,7 +205,6 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 {
 	struct yogabook_wmi *data =
 		container_of(cdev, struct yogabook_wmi, kbd_bl_led);
-	struct wmi_device *wdev = data->wdev;
 
 	if ((value < 0) || (value > 255))
 		return -EINVAL;
@@ -217,7 +214,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 	if (data->kbd_adev->power.state != ACPI_STATE_D0)
 		return 0;
 
-	return yogabook_wmi_set_kbd_backlight(wdev, data->brightness);
+	return yogabook_wmi_set_kbd_backlight(data, data->brightness);
 }
 
 static struct gpiod_lookup_table yogabook_wmi_gpios = {
@@ -239,7 +236,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 
 	dev_set_drvdata(&wdev->dev, data);
 
-	data->wdev = wdev;
+	data->dev = &wdev->dev;
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
@@ -288,7 +285,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	data->backside_hall_irq = r;
 
 	/* Set default brightness before enabling the IRQ */
-	yogabook_wmi_set_kbd_backlight(data->wdev, YB_KBD_BL_DEFAULT);
+	yogabook_wmi_set_kbd_backlight(data, YB_KBD_BL_DEFAULT);
 
 	r = request_irq(data->backside_hall_irq, yogabook_backside_hall_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
@@ -339,7 +336,7 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 		r |= device_reprobe(data->dig_dev);
 
 	if (r)
-		dev_warn(&wdev->dev, "Reprobe of devices failed\n");
+		dev_warn(data->dev, "Reprobe of devices failed\n");
 
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
@@ -349,7 +346,6 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 
 static int yogabook_suspend(struct device *dev)
 {
-	struct wmi_device *wdev = container_of(dev, struct wmi_device, dev);
 	struct yogabook_wmi *data = dev_get_drvdata(dev);
 
 	set_bit(YB_SUSPENDED, &data->flags);
@@ -358,24 +354,23 @@ static int yogabook_suspend(struct device *dev)
 
 	/* Turn off the pen button at sleep */
 	if (test_bit(YB_DIGITIZER_IS_ON, &data->flags))
-		yogabook_wmi_do_action(wdev, YB_PAD_DISABLE);
+		yogabook_wmi_do_action(data, YB_PAD_DISABLE);
 
 	return 0;
 }
 
 static int yogabook_resume(struct device *dev)
 {
-	struct wmi_device *wdev = container_of(dev, struct wmi_device, dev);
 	struct yogabook_wmi *data = dev_get_drvdata(dev);
 
 	if (test_bit(YB_KBD_IS_ON, &data->flags)) {
 		/* Ensure keyboard touchpad is on before we call KBLC() */
 		acpi_device_set_power(data->kbd_adev, ACPI_STATE_D0);
-		yogabook_wmi_set_kbd_backlight(wdev, data->brightness);
+		yogabook_wmi_set_kbd_backlight(data, data->brightness);
 	}
 
 	if (test_bit(YB_DIGITIZER_IS_ON, &data->flags))
-		yogabook_wmi_do_action(wdev, YB_PAD_ENABLE);
+		yogabook_wmi_do_action(data, YB_PAD_ENABLE);
 
 	clear_bit(YB_SUSPENDED, &data->flags);
 
-- 
2.39.2

