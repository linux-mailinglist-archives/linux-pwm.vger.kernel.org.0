Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA886F29B1
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjD3RAp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjD3RAo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBC435B0
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVR7TexQKfeLS5rOEDGLj4FhW1DU+GoqAR7wL+xU1So=;
        b=dwt9EEfTNr+CGqU2gRMLSKqg5Hhx8z/fd7/8NNogL5MS/PSJP2AVpoj4CMALJmLViKQBr/
        AFlqC3jMNMa6reOXPZfmBTM3p5zH4xJ2XietKn/MDAb+mWX/+srWwq9txses/YJkMmFtXd
        cBhAo/YzTlBzvYCjnuJQX+ZlunayEmA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-y2JSmfnEMv2PEXu4TUzMhA-1; Sun, 30 Apr 2023 12:58:36 -0400
X-MC-Unique: y2JSmfnEMv2PEXu4TUzMhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 95F4B2A59553;
        Sun, 30 Apr 2023 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DB2E2166B26;
        Sun, 30 Apr 2023 16:58:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 14/19] platform/x86: lenovo-yogabook: Drop _wmi_ from remaining generic symbols
Date:   Sun, 30 Apr 2023 18:58:02 +0200
Message-Id: <20230430165807.472798-15-hdegoede@redhat.com>
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

Change the yogabook_wmi_ prefix of remaining generic (non WMI specific)
symbols to yogabook_ .

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Add kbd_led_to_yogabook() macro
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 87bea6987681..f1876c587757 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -23,7 +23,7 @@ enum {
 	YB_SUSPENDED,
 };
 
-struct yogabook_wmi {
+struct yogabook_data {
 	struct device *dev;
 	struct acpi_device *kbd_adev;
 	struct acpi_device *dig_adev;
@@ -31,7 +31,7 @@ struct yogabook_wmi {
 	struct device *dig_dev;
 	struct led_classdev *pen_led;
 	struct gpio_desc *backside_hall_gpio;
-	int (*set_kbd_backlight)(struct yogabook_wmi *data, uint8_t level);
+	int (*set_kbd_backlight)(struct yogabook_data *data, uint8_t level);
 	int backside_hall_irq;
 	struct work_struct work;
 	struct led_classdev kbd_bl_led;
@@ -43,7 +43,7 @@ struct yogabook_wmi {
  * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
  * device (Goodix touchpad acts as virtual sensor keyboard).
  */
-static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data,
+static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data,
 					  uint8_t level)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
@@ -73,9 +73,9 @@ static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data,
 	return 0;
 }
 
-static void yogabook_wmi_work(struct work_struct *work)
+static void yogabook_work(struct work_struct *work)
 {
-	struct yogabook_wmi *data = container_of(work, struct yogabook_wmi, work);
+	struct yogabook_data *data = container_of(work, struct yogabook_data, work);
 	bool kbd_on, digitizer_on;
 	int r;
 
@@ -128,7 +128,7 @@ static void yogabook_wmi_work(struct work_struct *work)
 	}
 }
 
-static void yogabook_toggle_digitizer_mode(struct yogabook_wmi *data)
+static void yogabook_toggle_digitizer_mode(struct yogabook_data *data)
 {
 	if (test_bit(YB_SUSPENDED, &data->flags))
 		return;
@@ -152,7 +152,7 @@ static void yogabook_wmi_notify(struct wmi_device *wdev, union acpi_object *dumm
 
 static irqreturn_t yogabook_backside_hall_irq(int irq, void *_data)
 {
-	struct yogabook_wmi *data = _data;
+	struct yogabook_data *data = _data;
 
 	if (gpiod_get_value(data->backside_hall_gpio))
 		set_bit(YB_TABLET_MODE, &data->flags);
@@ -164,10 +164,11 @@ static irqreturn_t yogabook_backside_hall_irq(int irq, void *_data)
 	return IRQ_HANDLED;
 }
 
+#define kbd_led_to_yogabook(cdev) container_of(cdev, struct yogabook_data, kbd_bl_led)
+
 static enum led_brightness kbd_brightness_get(struct led_classdev *cdev)
 {
-	struct yogabook_wmi *data =
-		container_of(cdev, struct yogabook_wmi, kbd_bl_led);
+	struct yogabook_data *data = kbd_led_to_yogabook(cdev);
 
 	return data->brightness;
 }
@@ -175,8 +176,7 @@ static enum led_brightness kbd_brightness_get(struct led_classdev *cdev)
 static int kbd_brightness_set(struct led_classdev *cdev,
 			      enum led_brightness value)
 {
-	struct yogabook_wmi *data =
-		container_of(cdev, struct yogabook_wmi, kbd_bl_led);
+	struct yogabook_data *data = kbd_led_to_yogabook(cdev);
 
 	if ((value < 0) || (value > 255))
 		return -EINVAL;
@@ -189,7 +189,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 	return data->set_kbd_backlight(data, data->brightness);
 }
 
-static struct gpiod_lookup_table yogabook_wmi_gpios = {
+static struct gpiod_lookup_table yogabook_gpios = {
 	.table = {
 		GPIO_LOOKUP("INT33FF:02", 18, "backside_hall_sw", GPIO_ACTIVE_LOW),
 		{}
@@ -201,7 +201,7 @@ static struct led_lookup_data yogabook_pen_led = {
 	.con_id = "pen-icon-led",
 };
 
-static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
+static int yogabook_probe(struct device *dev, struct yogabook_data *data,
 			  const char *kbd_bl_led_name)
 {
 	int r;
@@ -210,7 +210,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
-	INIT_WORK(&data->work, yogabook_wmi_work);
+	INIT_WORK(&data->work, yogabook_work);
 
 	yogabook_pen_led.dev_id = dev_name(dev);
 	led_add_lookup(&yogabook_pen_led);
@@ -220,10 +220,10 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 	if (IS_ERR(data->pen_led))
 		return dev_err_probe(dev, PTR_ERR(data->pen_led), "Getting pen icon LED\n");
 
-	yogabook_wmi_gpios.dev_id = dev_name(dev);
-	gpiod_add_lookup_table(&yogabook_wmi_gpios);
+	yogabook_gpios.dev_id = dev_name(dev);
+	gpiod_add_lookup_table(&yogabook_gpios);
 	data->backside_hall_gpio = devm_gpiod_get(dev, "backside_hall_sw", GPIOD_IN);
-	gpiod_remove_lookup_table(&yogabook_wmi_gpios);
+	gpiod_remove_lookup_table(&yogabook_gpios);
 
 	if (IS_ERR(data->backside_hall_gpio))
 		return dev_err_probe(dev, PTR_ERR(data->backside_hall_gpio),
@@ -269,7 +269,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct device *dev = &wdev->dev;
-	struct yogabook_wmi *data;
+	struct yogabook_data *data;
 	int r;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -317,7 +317,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	return r;
 }
 
-static void yogabook_remove(struct yogabook_wmi *data)
+static void yogabook_remove(struct yogabook_data *data)
 {
 	int r = 0;
 
@@ -336,7 +336,7 @@ static void yogabook_remove(struct yogabook_wmi *data)
 
 static void yogabook_wmi_remove(struct wmi_device *wdev)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
+	struct yogabook_data *data = dev_get_drvdata(&wdev->dev);
 
 	yogabook_remove(data);
 
@@ -348,7 +348,7 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 
 static int yogabook_suspend(struct device *dev)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(dev);
+	struct yogabook_data *data = dev_get_drvdata(dev);
 
 	set_bit(YB_SUSPENDED, &data->flags);
 
@@ -358,7 +358,7 @@ static int yogabook_suspend(struct device *dev)
 
 static int yogabook_resume(struct device *dev)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(dev);
+	struct yogabook_data *data = dev_get_drvdata(dev);
 
 	if (test_bit(YB_KBD_IS_ON, &data->flags))
 		data->set_kbd_backlight(data, data->brightness);
-- 
2.39.2

