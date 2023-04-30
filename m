Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2016F29A7
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjD3RAi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjD3RAg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A830D7
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc0o4FmfepKkzUDJlnn+iIoOvetPn6yXTjCkGtCtkSw=;
        b=ABcrmPh/NG+iu+wX9EI0qNoIUkv/izdd0LwvgRLcV6UTcpA7xU1xD6GiMlY6GZ6XgcSToj
        WMJKGdrY90PSxnCzEcDiaZN4v+iGX8q5+oBnEpWHUkxEVimrY7Su5O+UPVkRxMBCr0g7GB
        bo58FOtTH/lIO3IAjIz/rXMgXUvvpak=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-JRhLCf32NKqz_sDd3ckFkQ-1; Sun, 30 Apr 2023 12:58:28 -0400
X-MC-Unique: JRhLCf32NKqz_sDd3ckFkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B0A8C8828C1;
        Sun, 30 Apr 2023 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94EA02166B26;
        Sun, 30 Apr 2023 16:58:26 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 08/19] platform/x86: lenovo-yogabook: Add dev local variable to probe()
Date:   Sun, 30 Apr 2023 18:57:56 +0200
Message-Id: <20230430165807.472798-9-hdegoede@redhat.com>
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

Add a "struct device *dev" local variable to probe().

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

While at it also move the dev_set_drvdata() call to the end of probe().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Move the dev_set_drvdata() call to the end of probe()
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 24 +++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 1bbdc48aef5b..4f2624eba210 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -226,16 +226,15 @@ static struct gpiod_lookup_table yogabook_wmi_gpios = {
 
 static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 {
+	struct device *dev = &wdev->dev;
 	struct yogabook_wmi *data;
 	int r;
 
-	data = devm_kzalloc(&wdev->dev, sizeof(struct yogabook_wmi), GFP_KERNEL);
+	data = devm_kzalloc(dev, sizeof(struct yogabook_wmi), GFP_KERNEL);
 	if (data == NULL)
 		return -ENOMEM;
 
-	dev_set_drvdata(&wdev->dev, data);
-
-	data->dev = &wdev->dev;
+	data->dev = dev;
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
@@ -243,13 +242,13 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 
 	data->kbd_adev = acpi_dev_get_first_match_dev("GDIX1001", NULL, -1);
 	if (!data->kbd_adev) {
-		dev_err(&wdev->dev, "Cannot find the touchpad device in ACPI tables\n");
+		dev_err(dev, "Cannot find the touchpad device in ACPI tables\n");
 		return -ENODEV;
 	}
 
 	data->dig_adev = acpi_dev_get_first_match_dev("WCOM0019", NULL, -1);
 	if (!data->dig_adev) {
-		dev_err(&wdev->dev, "Cannot find the digitizer device in ACPI tables\n");
+		dev_err(dev, "Cannot find the digitizer device in ACPI tables\n");
 		r = -ENODEV;
 		goto error_put_devs;
 	}
@@ -267,18 +266,18 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	}
 
 	gpiod_add_lookup_table(&yogabook_wmi_gpios);
-	data->backside_hall_gpio = devm_gpiod_get(&wdev->dev, "backside_hall_sw", GPIOD_IN);
+	data->backside_hall_gpio = devm_gpiod_get(dev, "backside_hall_sw", GPIOD_IN);
 	gpiod_remove_lookup_table(&yogabook_wmi_gpios);
 
 	if (IS_ERR(data->backside_hall_gpio)) {
 		r = PTR_ERR(data->backside_hall_gpio);
-		dev_err_probe(&wdev->dev, r, "Getting backside_hall_sw GPIO\n");
+		dev_err_probe(dev, r, "Getting backside_hall_sw GPIO\n");
 		goto error_put_devs;
 	}
 
 	r = gpiod_to_irq(data->backside_hall_gpio);
 	if (r < 0) {
-		dev_err_probe(&wdev->dev, r, "Getting backside_hall_sw IRQ\n");
+		dev_err_probe(dev, r, "Getting backside_hall_sw IRQ\n");
 		goto error_put_devs;
 	}
 	data->backside_hall_irq = r;
@@ -290,7 +289,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			"backside_hall_sw", data);
 	if (r) {
-		dev_err_probe(&wdev->dev, r, "Requesting backside_hall_sw IRQ\n");
+		dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n");
 		goto error_put_devs;
 	}
 
@@ -301,12 +300,13 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	data->kbd_bl_led.brightness_get = kbd_brightness_get;
 	data->kbd_bl_led.max_brightness = 255;
 
-	r = devm_led_classdev_register(&wdev->dev, &data->kbd_bl_led);
+	r = devm_led_classdev_register(dev, &data->kbd_bl_led);
 	if (r < 0) {
-		dev_err_probe(&wdev->dev, r, "Registering backlight LED device\n");
+		dev_err_probe(dev, r, "Registering backlight LED device\n");
 		goto error_free_irq;
 	}
 
+	dev_set_drvdata(dev, data);
 	return 0;
 
 error_free_irq:
-- 
2.39.2

