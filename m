Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F036F25B4
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjD2SRn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjD2SRm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066C41703
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V2r9YP9+6XCB8LrHi10le5UmITSB/dJ3lI7NCVm0ako=;
        b=Z/RLjruIEZe6nPoO7DBtKYH5pFH33WQWpuPH2puBQc1dqbrYXhhs/37U18xO95MlK642zT
        1f/fy6/3EMa/LjckYPHNkMW82MpGyOrfgKptQo4F0dGyk//17BUCYsD0OFcl+mMoi7RhYh
        wsUj2rpix5S8GPnUaL+h1Fn2RJ/Hgew=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-jnNDI76OM0CCs_1faG29ZA-1; Sat, 29 Apr 2023 14:16:48 -0400
X-MC-Unique: jnNDI76OM0CCs_1faG29ZA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3AB50811E7B;
        Sat, 29 Apr 2023 18:16:47 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22F2E2027043;
        Sat, 29 Apr 2023 18:16:46 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 16/19] platform/x86: lenovo-yogabook: Add YB_KBD_BL_MAX define
Date:   Sat, 29 Apr 2023 20:15:48 +0200
Message-Id: <20230429181551.98201-17-hdegoede@redhat.com>
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

Add a define for the max brightness level instead of hardcoding
this to 255 in multiple places.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index cc280ec80b8c..0c5475127ac2 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -13,7 +13,8 @@
 
 #define YB_MBTN_EVENT_GUID	"243FEC1D-1963-41C1-8100-06A9D82A94B4"
 
-#define YB_KBD_BL_DEFAULT 128
+#define YB_KBD_BL_DEFAULT	128
+#define YB_KBD_BL_MAX		255
 
 /* flags */
 enum {
@@ -140,7 +141,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 	struct yogabook_data *data =
 		container_of(cdev, struct yogabook_data, kbd_bl_led);
 
-	if ((value < 0) || (value > 255))
+	if ((value < 0) || (value > YB_KBD_BL_MAX))
 		return -EINVAL;
 
 	data->brightness = value;
@@ -221,7 +222,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_data *data,
 	data->kbd_bl_led.name = kbd_bl_led_name;
 	data->kbd_bl_led.brightness_set_blocking = kbd_brightness_set;
 	data->kbd_bl_led.brightness_get = kbd_brightness_get;
-	data->kbd_bl_led.max_brightness = 255;
+	data->kbd_bl_led.max_brightness = YB_KBD_BL_MAX;
 
 	r = devm_led_classdev_register(dev, &data->kbd_bl_led);
 	if (r < 0) {
@@ -301,7 +302,7 @@ static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data, u8 level)
 	input.pointer = &param;
 
 	param.type = ACPI_TYPE_INTEGER;
-	param.integer.value = 255 - level;
+	param.integer.value = YB_KBD_BL_MAX - level;
 
 	status = acpi_evaluate_object(acpi_device_handle(data->kbd_adev), "KBLC",
 				      &input, &output);
-- 
2.39.2

