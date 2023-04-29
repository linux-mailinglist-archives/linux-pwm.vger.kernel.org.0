Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E186F25A3
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjD2SRI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjD2SRH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300511FF6
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DyCEO1ipE4oGEN+JWXxrSWtKMscPFQ5UjuI+1nrch5Q=;
        b=Cqa038PgDSAEpmJniWUQzhYIDhrgpyAT/Ji308BCikpztjKAKCK2IgT4Q6dMVfhIxLtl7l
        EfHA6y/22Jnm1/DXfMs0VtlRFeb9JimhhJEJd9f59WuO/8X7FDoNJjG3DmxPYZdb0PjCLM
        xAcMJdpsyObbRVLPVxyB52k5mHMAkUs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-bmlvhZqIMAO9psqRDEy_gg-1; Sat, 29 Apr 2023 14:16:12 -0400
X-MC-Unique: bmlvhZqIMAO9psqRDEy_gg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9980638060FD;
        Sat, 29 Apr 2023 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81C752027043;
        Sat, 29 Apr 2023 18:16:10 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 08/19] platform/x86: lenovo-yogabook: Add dev local variable to probe()
Date:   Sat, 29 Apr 2023 20:15:40 +0200
Message-Id: <20230429181551.98201-9-hdegoede@redhat.com>
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

Add a "struct device *dev" local variable to probe().

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 23 +++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 2bf40930c51a..b1d17ce9a46c 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -227,16 +227,17 @@ static struct gpiod_lookup_table yogabook_wmi_gpios = {
 
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
+	dev_set_drvdata(dev, data);
 
-	data->dev = &wdev->dev;
+	data->dev = dev;
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
@@ -244,13 +245,13 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 
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
@@ -268,18 +269,18 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
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
@@ -291,7 +292,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			"backside_hall_sw", data);
 	if (r) {
-		dev_err_probe(&wdev->dev, r, "Requesting backside_hall_sw IRQ\n");
+		dev_err_probe(dev, r, "Requesting backside_hall_sw IRQ\n");
 		goto error_put_devs;
 	}
 
@@ -302,9 +303,9 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	data->kbd_bl_led.brightness_get = kbd_brightness_get;
 	data->kbd_bl_led.max_brightness = 255;
 
-	r = devm_led_classdev_register(&wdev->dev, &data->kbd_bl_led);
+	r = devm_led_classdev_register(dev, &data->kbd_bl_led);
 	if (r < 0) {
-		dev_err_probe(&wdev->dev, r, "Registering backlight LED device\n");
+		dev_err_probe(dev, r, "Registering backlight LED device\n");
 		goto error_free_irq;
 	}
 
-- 
2.39.2

