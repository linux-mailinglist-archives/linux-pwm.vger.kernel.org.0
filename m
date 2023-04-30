Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADD46F29B5
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjD3RAr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjD3RAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D181D35B5
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1n74BbC/XLCNWwnyUU0jCRRJYN14mXJtJBdobArEOw=;
        b=PxV4Wg4FqfbgKZp0uj7AJPF9y2BNC+o22xMVJwPur5b0XIcjYUE9OyaxBAJDdnPue7EKi4
        GDVM0ohZ3oXAd/dvg/9isAuesoymX/CJy5lBD1sQSTsZQOOpqZzPTvRvxYP0LUozmIJbpd
        OcQ6DF+WkPgQ8cy6dBqXTnVw1+cq3y0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-3JGaNXPEM8qCG3Ad-XJtfQ-1; Sun, 30 Apr 2023 12:58:38 -0400
X-MC-Unique: 3JGaNXPEM8qCG3Ad-XJtfQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3854B101A531;
        Sun, 30 Apr 2023 16:58:38 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 202BE2166B26;
        Sun, 30 Apr 2023 16:58:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 16/19] platform/x86: lenovo-yogabook: Add YB_KBD_BL_MAX define
Date:   Sun, 30 Apr 2023 18:58:04 +0200
Message-Id: <20230430165807.472798-17-hdegoede@redhat.com>
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

Add a define for the max brightness level instead of hardcoding
this to 255 in multiple places.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index c0c6997b9f61..f413af41e3c0 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -12,7 +12,8 @@
 
 #define YB_MBTN_EVENT_GUID	"243FEC1D-1963-41C1-8100-06A9D82A94B4"
 
-#define YB_KBD_BL_DEFAULT 128
+#define YB_KBD_BL_DEFAULT	128
+#define YB_KBD_BL_MAX		255
 
 /* flags */
 enum {
@@ -139,7 +140,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 {
 	struct yogabook_data *data = kbd_led_to_yogabook(cdev);
 
-	if ((value < 0) || (value > 255))
+	if ((value < 0) || (value > YB_KBD_BL_MAX))
 		return -EINVAL;
 
 	data->brightness = value;
@@ -210,7 +211,7 @@ static int yogabook_probe(struct device *dev, struct yogabook_data *data,
 	data->kbd_bl_led.name = kbd_bl_led_name;
 	data->kbd_bl_led.brightness_set_blocking = kbd_brightness_set;
 	data->kbd_bl_led.brightness_get = kbd_brightness_get;
-	data->kbd_bl_led.max_brightness = 255;
+	data->kbd_bl_led.max_brightness = YB_KBD_BL_MAX;
 
 	r = devm_led_classdev_register(dev, &data->kbd_bl_led);
 	if (r < 0) {
@@ -292,7 +293,7 @@ static int yogabook_wmi_set_kbd_backlight(struct yogabook_data *data,
 	input.pointer = &param;
 
 	param.type = ACPI_TYPE_INTEGER;
-	param.integer.value = 255 - level;
+	param.integer.value = YB_KBD_BL_MAX - level;
 
 	status = acpi_evaluate_object(acpi_device_handle(data->kbd_adev), "KBLC",
 				      &input, &output);
-- 
2.39.2

