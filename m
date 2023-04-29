Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E636F25B0
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjD2SRk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjD2SRj (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C26610FC
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0MGjeAtH/VXdhAqAUmcJEKZdOBhVSfRR9REZY1c9vJA=;
        b=Ce6WhvHdhHC8nyd2zYSBHC/ZoOCLanWZMGZGholLHfQUXTgtlYHpSNKqomH0Lz/Y2QAFTc
        lJ+oJfsPq5/DDHiKeKn8I6hckZlgU9af0867hY3ewk1S1ALOXfBaagzaNzZLZZMODq0TQi
        C4VtBbrWHgsSBBgSUTYgO79eskUr6RQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-xB3AdKKRP3qgCXQCL2YKDw-1; Sat, 29 Apr 2023 14:16:46 -0400
X-MC-Unique: xB3AdKKRP3qgCXQCL2YKDw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3C6685A588;
        Sat, 29 Apr 2023 18:16:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBFDD2027043;
        Sat, 29 Apr 2023 18:16:44 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 15/19] platform/x86: lenovo-yogabook: Group WMI specific code together
Date:   Sat, 29 Apr 2023 20:15:47 +0200
Message-Id: <20230429181551.98201-16-hdegoede@redhat.com>
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

Group WMI specific code together. Note this just moves a bunch of
code-blocks around, not a single line is changed.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 160 ++++++++++-----------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 9cfb2515740b..cc280ec80b8c 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -40,39 +40,6 @@ struct yogabook_data {
 	u8 brightness;
 };
 
-/*
- * To control keyboard backlight, call the method KBLC() of the TCS1 ACPI
- * device (Goodix touchpad acts as virtual sensor keyboard).
- */
-static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data, u8 level)
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
@@ -145,11 +112,6 @@ static void yogabook_toggle_digitizer_mode(struct yogabook_data *data)
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
@@ -275,6 +237,83 @@ static int yogabook_probe(struct device *dev, struct yogabook_data *data,
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
+static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data, u8 level)
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
@@ -326,23 +365,6 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
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
@@ -355,29 +377,9 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
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
@@ -386,8 +388,7 @@ static const struct wmi_device_id yogabook_wmi_id_table[] = {
 	},
 	{ } /* Terminating entry */
 };
-
-static DEFINE_SIMPLE_DEV_PM_OPS(yogabook_pm_ops, yogabook_suspend, yogabook_resume);
+MODULE_DEVICE_TABLE(wmi, yogabook_wmi_id_table);
 
 static struct wmi_driver yogabook_wmi_driver = {
 	.driver = {
@@ -402,7 +403,6 @@ static struct wmi_driver yogabook_wmi_driver = {
 };
 module_wmi_driver(yogabook_wmi_driver);
 
-MODULE_DEVICE_TABLE(wmi, yogabook_wmi_id_table);
 MODULE_AUTHOR("Yauhen Kharuzhy");
 MODULE_DESCRIPTION("Lenovo Yoga Book WMI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.39.2

