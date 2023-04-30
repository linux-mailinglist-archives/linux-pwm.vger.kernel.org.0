Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF4716F2996
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 18:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbjD3Q7u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 12:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjD3Q7s (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 12:59:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA0E2729
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hPUodKH8f+H/JW+lPIMV3CIdr4U3egsnh7kn3ioo34Q=;
        b=ASQvurTYRNGgEbAFrvcf0ReMjDxOdkvpDPW2nk9lWhTQdhwsHIIXCllS3JCC2y5ztgr+49
        OMCDxacsibJ9ek4ywyIlOPyWzh7YrMRGjZe57F4AobMJuvM9QweAsozNL7Gir7ZptApEPM
        5Z8ImVVMDQnLc39xcvGfo1zGQlbkQME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-Aniwy0goP_Or2D1SQIUjVw-1; Sun, 30 Apr 2023 12:58:20 -0400
X-MC-Unique: Aniwy0goP_Or2D1SQIUjVw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C575B185A79C;
        Sun, 30 Apr 2023 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AADB72166B26;
        Sun, 30 Apr 2023 16:58:18 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 02/19] platform/x86: lenovo-yogabook: Fix work race on remove()
Date:   Sun, 30 Apr 2023 18:57:50 +0200
Message-Id: <20230430165807.472798-3-hdegoede@redhat.com>
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

When yogabook_wmi_remove() runs yogabook_wmi_work might still be running
and using the devices which yogabook_wmi_remove() puts.

To avoid this move to explicitly cancelling the work rather then using
devm_work_autocancel().

This requires also making the yogabook_backside_hall_irq handler non
devm managed, so that it cannot re-queue the work while
yogabook_wmi_remove() runs.

Fixes: c0549b72d99d ("platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Drop no longer used include <linux/devm-helpers.h>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 5f4bd1eec38a..3a6de4ab74a4 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -2,7 +2,6 @@
 /* WMI driver for Lenovo Yoga Book YB1-X90* / -X91* tablets */
 
 #include <linux/acpi.h>
-#include <linux/devm-helpers.h>
 #include <linux/gpio/consumer.h>
 #include <linux/gpio/machine.h>
 #include <linux/interrupt.h>
@@ -248,10 +247,7 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	data->brightness = YB_KBD_BL_DEFAULT;
 	set_bit(YB_KBD_IS_ON, &data->flags);
 	set_bit(YB_DIGITIZER_IS_ON, &data->flags);
-
-	r = devm_work_autocancel(&wdev->dev, &data->work, yogabook_wmi_work);
-	if (r)
-		return r;
+	INIT_WORK(&data->work, yogabook_wmi_work);
 
 	data->kbd_adev = acpi_dev_get_first_match_dev("GDIX1001", NULL, -1);
 	if (!data->kbd_adev) {
@@ -299,10 +295,9 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	}
 	data->backside_hall_irq = r;
 
-	r = devm_request_irq(&wdev->dev, data->backside_hall_irq,
-			     yogabook_backside_hall_irq,
-			     IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
-			     "backside_hall_sw", data);
+	r = request_irq(data->backside_hall_irq, yogabook_backside_hall_irq,
+			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			"backside_hall_sw", data);
 	if (r) {
 		dev_err_probe(&wdev->dev, r, "Requesting backside_hall_sw IRQ\n");
 		goto error_put_devs;
@@ -318,11 +313,14 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	r = devm_led_classdev_register(&wdev->dev, &data->kbd_bl_led);
 	if (r < 0) {
 		dev_err_probe(&wdev->dev, r, "Registering backlight LED device\n");
-		goto error_put_devs;
+		goto error_free_irq;
 	}
 
 	return 0;
 
+error_free_irq:
+	free_irq(data->backside_hall_irq, data);
+	cancel_work_sync(&data->work);
 error_put_devs:
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
@@ -335,6 +333,8 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 {
 	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
 
+	free_irq(data->backside_hall_irq, data);
+	cancel_work_sync(&data->work);
 	put_device(data->dig_dev);
 	put_device(data->kbd_dev);
 	acpi_dev_put(data->dig_adev);
-- 
2.39.2

