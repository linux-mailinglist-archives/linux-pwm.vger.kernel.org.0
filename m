Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778876F29B2
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbjD3RAq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjD3RAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823635A8
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873919;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YHxn+EYB8bEJntnB5GyXCcUrS6A/Gr/OSshXvA47i2I=;
        b=V1/H2nJ5ehrCLjmCZhEyg+ovhJCHrfV+2hapV2FrbwHGj1VwIrUYonJdZErM0xExFQfUYn
        xbCkOsKM0gdD6Q13exv8/HWU7ay+zjp/DeB4CsvPixg+hWYL11SnnGh86t/LoGX8xPCH2T
        IXMnKq7k08j8UX27W+Fs/xuhIl8e2jU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-uq4PmadpN4qB0voG-M10_w-1; Sun, 30 Apr 2023 12:58:37 -0400
X-MC-Unique: uq4PmadpN4qB0voG-M10_w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E1D3C3C0ED4B;
        Sun, 30 Apr 2023 16:58:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8D522166B26;
        Sun, 30 Apr 2023 16:58:35 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 15/19] platform/x86: lenovo-yogabook: Group WMI specific code together
Date:   Sun, 30 Apr 2023 18:58:03 +0200
Message-Id: <20230430165807.472798-16-hdegoede@redhat.com>
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

Group WMI specific code together. Note this just moves a bunch of
code-blocks around, not a single line is changed.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 162 ++++++++++-----------
 1 file changed, 81 insertions(+), 81 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index f1876c587757..c0c6997b9f61 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -39,40 +39,6 @@ struct yogabook_data {
 	uint8_t brightness;
 };
 
-/*
- * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
- * device (Goodix touchpad acts as virtual sensor keyboard).
- */
-static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data,
-					  uint8_t level)
-{
-	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
-	struct acpi_object_list input;
-	union acpi_object param;
-	acpi_status status;
-
-	dev_dbg(data->dev, "Set KBLC level to %u\n", level);
-
-	/* Ensure keyboard touchpad is on before we call KBLC() */
-	acpi_device_set_power(data->kbd_adev, ACPI_STATE_D0);
-
-	input.count = 1;
-	input.pointer = &param;
-
-	param.type = ACPI_TYPE_INTEGER;
-	param.integer.value = 255 - level;
-
-	status = acpi_evaluate_object(acpi_device_handle(data->kbd_adev), "KBLC",
-				      &input, &output);
-	if (ACPI_FAILURE(status)) {
-		dev_err(data->dev, "Failed to call KBLC method: 0x%x\n", status);
-		return status;
-	}
-
-	kfree(output.pointer);
-	return 0;
-}
-
 static void yogabook_work(struct work_struct *work)
 {
 	struct yogabook_data *data = container_of(work, struct yogabook_data, work);
@@ -145,11 +111,6 @@ static void yogabook_toggle_digitizer_mode(struct yogabook_data *data)
 	schedule_work(&data->work);
 }
 
-static void yogabook_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
-{
-	yogabook_toggle_digitizer_mode(dev_get_drvdata(&wdev->dev));
-}
-
 static irqreturn_t yogabook_backside_hall_irq(int irq, void *_data)
 {
 	struct yogabook_data *data = _data;
@@ -266,6 +227,84 @@ static int yogabook_probe(struct device *dev, struct yogabook_data *data,
 	return r;
 }
 
+static void yogabook_remove(struct yogabook_data *data)
+{
+	int r = 0;
+
+	free_irq(data->backside_hall_irq, data);
+	cancel_work_sync(&data->work);
+
+	if (!test_bit(YB_KBD_IS_ON, &data->flags))
+		r |= device_reprobe(data->kbd_dev);
+
+	if (!test_bit(YB_DIGITIZER_IS_ON, &data->flags))
+		r |= device_reprobe(data->dig_dev);
+
+	if (r)
+		dev_warn(data->dev, "Reprobe of devices failed\n");
+}
+
+static int yogabook_suspend(struct device *dev)
+{
+	struct yogabook_data *data = dev_get_drvdata(dev);
+
+	set_bit(YB_SUSPENDED, &data->flags);
+
+	flush_work(&data->work);
+	return 0;
+}
+
+static int yogabook_resume(struct device *dev)
+{
+	struct yogabook_data *data = dev_get_drvdata(dev);
+
+	if (test_bit(YB_KBD_IS_ON, &data->flags))
+		data->set_kbd_backlight(data, data->brightness);
+
+	clear_bit(YB_SUSPENDED, &data->flags);
+
+	/* Check for YB_TABLET_MODE changes made during suspend */
+	schedule_work(&data->work);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(yogabook_pm_ops, yogabook_suspend, yogabook_resume);
+
+/*
+ * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
+ * device (Goodix touchpad acts as virtual sensor keyboard).
+ */
+static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data,
+					  uint8_t level)
+{
+	struct acpi_buffer output = { ACPI_ALLOCATE_BUFFER, NULL };
+	struct acpi_object_list input;
+	union acpi_object param;
+	acpi_status status;
+
+	dev_dbg(data->dev, "Set KBLC level to %u\n", level);
+
+	/* Ensure keyboard touchpad is on before we call KBLC() */
+	acpi_device_set_power(data->kbd_adev, ACPI_STATE_D0);
+
+	input.count = 1;
+	input.pointer = &param;
+
+	param.type = ACPI_TYPE_INTEGER;
+	param.integer.value = 255 - level;
+
+	status = acpi_evaluate_object(acpi_device_handle(data->kbd_adev), "KBLC",
+				      &input, &output);
+	if (ACPI_FAILURE(status)) {
+		dev_err(data->dev, "Failed to call KBLC method: 0x%x\n", status);
+		return status;
+	}
+
+	kfree(output.pointer);
+	return 0;
+}
+
 static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 {
 	struct device *dev = &wdev->dev;
@@ -317,23 +356,6 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	return r;
 }
 
-static void yogabook_remove(struct yogabook_data *data)
-{
-	int r = 0;
-
-	free_irq(data->backside_hall_irq, data);
-	cancel_work_sync(&data->work);
-
-	if (!test_bit(YB_KBD_IS_ON, &data->flags))
-		r |= device_reprobe(data->kbd_dev);
-
-	if (!test_bit(YB_DIGITIZER_IS_ON, &data->flags))
-		r |= device_reprobe(data->dig_dev);
-
-	if (r)
-		dev_warn(data->dev, "Reprobe of devices failed\n");
-}
-
 static void yogabook_wmi_remove(struct wmi_device *wdev)
 {
 	struct yogabook_data *data = dev_get_drvdata(&wdev->dev);
@@ -346,29 +368,9 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 	acpi_dev_put(data->kbd_adev);
 }
 
-static int yogabook_suspend(struct device *dev)
-{
-	struct yogabook_data *data = dev_get_drvdata(dev);
-
-	set_bit(YB_SUSPENDED, &data->flags);
-
-	flush_work(&data->work);
-	return 0;
-}
-
-static int yogabook_resume(struct device *dev)
+static void yogabook_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
 {
-	struct yogabook_data *data = dev_get_drvdata(dev);
-
-	if (test_bit(YB_KBD_IS_ON, &data->flags))
-		data->set_kbd_backlight(data, data->brightness);
-
-	clear_bit(YB_SUSPENDED, &data->flags);
-
-	/* Check for YB_TABLET_MODE changes made during suspend */
-	schedule_work(&data->work);
-
-	return 0;
+	yogabook_toggle_digitizer_mode(dev_get_drvdata(&wdev->dev));
 }
 
 static const struct wmi_device_id yogabook_wmi_id_table[] = {
@@ -377,8 +379,7 @@ static const struct wmi_device_id yogabook_wmi_id_table[] = {
 	},
 	{ } /* Terminating entry */
 };
-
-static DEFINE_SIMPLE_DEV_PM_OPS(yogabook_pm_ops, yogabook_suspend, yogabook_resume);
+MODULE_DEVICE_TABLE(wmi, yogabook_wmi_id_table);
 
 static struct wmi_driver yogabook_wmi_driver = {
 	.driver = {
@@ -393,7 +394,6 @@ static struct wmi_driver yogabook_wmi_driver = {
 };
 module_wmi_driver(yogabook_wmi_driver);
 
-MODULE_DEVICE_TABLE(wmi, yogabook_wmi_id_table);
 MODULE_AUTHOR("Yauhen Kharuzhy");
 MODULE_DESCRIPTION("Lenovo Yoga Book WMI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2

