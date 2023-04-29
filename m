Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232BB6F25AA
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjD2SRh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjD2SRg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A72A1709
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792208;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hQupVWC3H7K4qahqTSNOhREQCoyFYgYcmQJHKGlQ8d4=;
        b=SPjO75W4zPsf01qYgRPy8QDGJfsQcVPkehxZ54DiEhhxvxEN6E0oKOySlDeDPM3sXnVEF8
        FtTXhc/GvWRMe5KBni0FAeMe2/RhMPW7uloYldy7pWrg5Rqzd7CnXEyvgqCBfTW4p+jut9
        6YzOsbOQWazpT5zEOocG7SHGGQYKCZ4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-323-Wolqp1ajNEaSKR9gSlu7YQ-1; Sat, 29 Apr 2023 14:16:43 -0400
X-MC-Unique: Wolqp1ajNEaSKR9gSlu7YQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4AD1D185A78B;
        Sat, 29 Apr 2023 18:16:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2D6DB2027043;
        Sat, 29 Apr 2023 18:16:42 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 13/19] platform/x86: lenovo-yogabook: Add a yogabook_toggle_digitizer_mode() helper function
Date:   Sat, 29 Apr 2023 20:15:45 +0200
Message-Id: <20230429181551.98201-14-hdegoede@redhat.com>
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

Add a yogabook_toggle_digitizer_mode() helper function.

This is a preparation patch for making lenovo-yogabook-wmi also work
on the Android version of the Yoga Book 1 which does not have a WMI
interface to deal with toggling the keyboard half between
touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index efdb20bfe8f5..bbe4f2fb6fe9 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -128,10 +128,8 @@ static void yogabook_wmi_work(struct work_struct *work)
 	}
 }
 
-static void yogabook_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
+static void yogabook_toggle_digitizer_mode(struct yogabook_wmi *data)
 {
-	struct yogabook_wmi *data = dev_get_drvdata(&wdev->dev);
-
 	if (test_bit(YB_SUSPENDED, &data->flags))
 		return;
 
@@ -147,6 +145,11 @@ static void yogabook_wmi_notify(struct wmi_device *wdev, union acpi_object *dumm
 	schedule_work(&data->work);
 }
 
+static void yogabook_wmi_notify(struct wmi_device *wdev, union acpi_object *dummy)
+{
+	yogabook_toggle_digitizer_mode(dev_get_drvdata(&wdev->dev));
+}
+
 static irqreturn_t yogabook_backside_hall_irq(int irq, void *_data)
 {
 	struct yogabook_wmi *data = _data;
-- 
2.39.2

