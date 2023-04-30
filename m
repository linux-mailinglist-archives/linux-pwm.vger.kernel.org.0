Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E276F29A4
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjD3RAh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjD3RAg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:00:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F0D30F1
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmdQklIbseYwA9PrPuizdDnjHOffqQM2h31Eck4s7EE=;
        b=acaofeEziAJ+8ZFvDB2x2lL/QGwNbBVimIStoONxkWyeVz46olWkpAyd7QVivOfxLV0E0S
        VjZOKiF9MmqzgmRWPxP2ljOYjuuohVy84Sx7kDLS3PxAYdU1muRSPzRSzILC5nh16TUEdO
        H/1z8iQsKFnm1aJzSOjQ9ZF4KoDk1SA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-dH8Pkv4gPLii2jE7GwLQpg-1; Sun, 30 Apr 2023 12:58:32 -0400
X-MC-Unique: dH8Pkv4gPLii2jE7GwLQpg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A74C58828C0;
        Sun, 30 Apr 2023 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8C1622166B26;
        Sun, 30 Apr 2023 16:58:30 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 11/19] platform/x86: lenovo-yogabook: Stop checking adev->power.state
Date:   Sun, 30 Apr 2023 18:57:59 +0200
Message-Id: <20230430165807.472798-12-hdegoede@redhat.com>
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
index e583ae146323..7c7a945ed80d 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -50,13 +50,11 @@ static int yogabook_wmi_set_kbd_backlight(struct yogabook_wmi *data,
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
 
@@ -181,7 +179,7 @@ static int kbd_brightness_set(struct led_classdev *cdev,
 
 	data->brightness = value;
 
-	if (data->kbd_adev->power.state != ACPI_STATE_D0)
+	if (!test_bit(YB_KBD_IS_ON, &data->flags))
 		return 0;
 
 	return yogabook_wmi_set_kbd_backlight(data, data->brightness);
@@ -356,11 +354,8 @@ static int yogabook_resume(struct device *dev)
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

