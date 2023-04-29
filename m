Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83366F25A4
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjD2SRJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjD2SRI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850361BFB
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z1o8tVnuB54IHSh4GuzdVhDXojagCzRjZtCM0+1oxrw=;
        b=GOpUxsrlHrCT+0GfGnHQu1rBU5CiMfxJ47BZhI1T8lfNQV9tRk4DBbYGpT7Z4PSCculh2G
        42HmnAOl6t5aDgXtHVybfgHN5+UMYrvNKTI2PpZI6qHFV7hEq/383TA83O2Qg26Y/Qs77/
        tOLYpo9k9FQB0mybb8nXVypX/dUESig=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-0f75cS-xMbOpxbuGMj-_GQ-1; Sat, 29 Apr 2023 14:16:16 -0400
X-MC-Unique: 0f75cS-xMbOpxbuGMj-_GQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94432185A78B;
        Sat, 29 Apr 2023 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AA802027043;
        Sat, 29 Apr 2023 18:16:14 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 11/19] platform/x86: lenovo-yogabook: Stop checking adev->power.state
Date:   Sat, 29 Apr 2023 20:15:43 +0200
Message-Id: <20230429181551.98201-12-hdegoede@redhat.com>
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

lenovo-yogabook-wmi: controls the power-state itself and stores
this in data->flags so there is no need to poke inside ACPI device
internals.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 4bcbf0f84732..8d461fb8eac3 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -51,13 +51,11 @@ static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data,
 	union acpi_object param;
 	acpi_status status;
 
-	if (data->kbd_adev->power.state != ACPI_STATE_D0) {
-		dev_warn(data->dev, "keyboard touchscreen not in D0, cannot set brightness\n");
-		return -ENXIO;
-	}
-
 	dev_dbg(data->dev, "Set KBLC level to %u\n", level);
 
+	/* Ensure keyboard touchpad is on before we call KBLC() */
+	acpi_device_set_power(data->kbd_adev, ACPI_STATE_D0);
+
 	input.count = 1;
 	input.pointer = &param;
 
@@ -182,7 +180,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 
 	data->brightness = value;
 
-	if (data->kbd_adev->power.state != ACPI_STATE_D0)
+	if (!test_bit(YB_KBD_IS_ON, &data->flags))
 		return 0;
 
 	return yogabook_wmi_set_kbd_backlight(data, data->brightness);
@@ -366,11 +364,8 @@ static int yogabook_resume(struct device *dev)
 {
 	struct yogabook_wmi *data = dev_get_drvdata(dev);
 
-	if (test_bit(YB_KBD_IS_ON, &data->flags)) {
-		/* Ensure keyboard touchpad is on before we call KBLC() */
-		acpi_device_set_power(data->kbd_adev, ACPI_STATE_D0);
+	if (test_bit(YB_KBD_IS_ON, &data->flags))
 		yogabook_wmi_set_kbd_backlight(data, data->brightness);
-	}
 
 	clear_bit(YB_SUSPENDED, &data->flags);
 
-- 
2.39.2

