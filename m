Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6876F25B2
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjD2SRl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjD2SRk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124B1FD7
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kPDyQiAp0xYxJERZlYj6oAAMtlBC2K4CrJ1pqDsDgAo=;
        b=PrqjVT2aawxrdIkVW4KuEeSUB58eooFMJYQIPXbBLqHOUoNBnnzEHQ8+V+YW1CCQvIzWKU
        P7uED+ghVk/fdGDFyJu1Em66gqOGRGP23qzZLuLoIheJ12IrRBfxGzXxe57hYryx2ICjnt
        docxhHmPkxFzBNTe50YDVft/NOHFRH4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-qYq7SOUEMhiQ3RFksIVhqQ-1; Sat, 29 Apr 2023 14:16:45 -0400
X-MC-Unique: qYq7SOUEMhiQ3RFksIVhqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 992C28828C0;
        Sat, 29 Apr 2023 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 80E312027043;
        Sat, 29 Apr 2023 18:16:43 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 14/19] platform/x86: lenovo-yogabook: Drop _wmi_ from remaining generic symbols
Date:   Sat, 29 Apr 2023 20:15:46 +0200
Message-Id: <20230429181551.98201-15-hdegoede@redhat.com>
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

Change the yogabook_wmi_ prefix of remaining generic (non WMI specific)
symbols to yogabook_ .

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index bbe4f2fb6fe9..9cfb2515740b 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -24,7 +24,7 @@ enum {
 	YB_SUSPENDED,
 };
 
-struct yogabook_wmi {
+struct yogabook_data {
 	struct device *dev;
 	struct acpi_device *kbd_adev;
 	struct acpi_device *dig_adev;
@@ -32,7 +32,7 @@ struct yogabook_wmi {
 	struct device *dig_dev;
 	struct led_classdev *pen_led;
 	struct gpio_desc *backside_hall_gpio;
-	int (*set_kbd_backlight)(struct yogabook_wmi *data, u8 level);
+	int (*set_kbd_backlight)(struct yogabook_data *data, u8 level);
 	int backside_hall_irq;
 	struct work_struct work;
 	struct led_classdev kbd_bl_led;
@@ -44,7 +44,7 @@ struct yogabook_wmi {
  * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
  * device (Goodix touchpad acts as virtual sensor keyboard).
  */
-static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data, u8 level)
+static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data, u8 level)
 {
 	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
 	struct acpi_object_list input;
@@ -73,9 +73,9 @@ static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data, u8 level)
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
@@ -166,8 +166,8 @@ static irqreturn_t yogabook_backside_hall_irq(int irq, void *_data)
 
 static enum led_brightness kbd_brightness_get(struct led_classdev *cdev)
 {
-	struct yogabook_wmi *data =
-		container_of(cdev, struct yogabook_wmi, kbd_bl_led);
+	struct yogabook_data *data =
+		container_of(cdev, struct yogabook_data, kbd_bl_led);
 
 	return data->brightness;
 }
@@ -175,8 +175,8 @@ static enum led_brightness kbd_brightness_get(struct led_classdev *cdev)
 static int kbd_brightness_set(struct led_classdev *cdev,
 			      enum led_brightness value)
 {
-	struct yogabook_wmi *data =
-		container_of(cdev, struct yogabook_wmi, kbd_bl_led);
+	struct yogabook_data *data =
+		container_of(cdev, struct yogabook_data, kbd_bl_led);
 
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
@@ -212,7 +212,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
-	INIT_WORK(&data->work, yogabook_wmi_work);
+	INIT_WORK(&data->work, yogabook_work);
 
 	yogabook_pen_led.dev_id = dev_name(dev);
 	led_add_lookup(&yogabook_pen_led);
@@ -225,10 +225,10 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 		return r;
 	}
 
-	yogabook_wmi_gpios.dev_id = dev_name(dev);
-	gpiod_add_lookup_table(&yogabook_wmi_gpios);
+	yogabook_gpios.dev_id = dev_name(dev);
+	gpiod_add_lookup_table(&yogabook_gpios);
 	data->backside_hall_gpio = devm_gpiod_get(dev, "backside_hall_sw", GPIOD_IN);
-	gpiod_remove_lookup_table(&yogabook_wmi_gpios);
+	gpiod_remove_lookup_table(&yogabook_gpios);
 
 	if (IS_ERR(data->backside_hall_gpio)) {
 		r = PTR_ERR(data->backside_hall_gpio);
@@ -278,7 +278,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_wmi *data,
 static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct device *dev = &wdev->dev;
-	struct yogabook_wmi *data;
+	struct yogabook_data *data;
 	int r;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -326,7 +326,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	return r;
 }
 
-static void yogabook_remove(struct yogabook_wmi *data)
+static void yogabook_remove(struct yogabook_data *data)
 {
 	int r = 0;
 
@@ -345,7 +345,7 @@ static void yogabook_remove(struct yogabook_wmi *data)
 
 static void yogabook_wmi_remove(struct wmi_device *wdev)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
+	struct yogabook_data *data = dev_get_drvdata(&wdev->dev);
 
 	yogabook_remove(data);
 
@@ -357,7 +357,7 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 
 static int yogabook_suspend(struct device *dev)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(dev);
+	struct yogabook_data *data = dev_get_drvdata(dev);
 
 	set_bit(YB_SUSPENDED, &data->flags);
 
@@ -367,7 +367,7 @@ static int yogabook_suspend(struct device *dev)
 
 static int yogabook_resume(struct device *dev)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(dev);
+	struct yogabook_data *data = dev_get_drvdata(dev);
 
 	if (test_bit(YB_KBD_IS_ON, &data->flags))
 		data->set_kbd_backlight(data, data->brightness);
-- 
2.39.2

