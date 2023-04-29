Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781166F25A1
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjD2SRH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjD2SRG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16FE1BFE
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XkHaU9iWGHo1fzS/daje8Q+0SOFh8LE6niS3dLCvlts=;
        b=glSNSEorg1XdjIvGvMeEtMEDnzmtlBdc7rtUGtJZLbrTsNKIh1NVTKcuUNTAKFrpFqgp5W
        se5qKRoMtHOrDq/AnXjmVFbgJZedklWqm+1dlVNaa8vlQ17fNkdEeK9oOG6l7bRzvRyiIy
        nJYuVBWlC/Otr75p8UurrnbQFTy/cS4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-4ozlS26GPXuYQNF6KfUdqQ-1; Sat, 29 Apr 2023 14:16:09 -0400
X-MC-Unique: 4ozlS26GPXuYQNF6KfUdqQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 031C7185A78B;
        Sat, 29 Apr 2023 18:16:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D36852027043;
        Sat, 29 Apr 2023 18:16:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 06/19] platform/x86: lenovo-yogabook: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
Date:   Sat, 29 Apr 2023 20:15:38 +0200
Message-Id: <20230429181551.98201-7-hdegoede@redhat.com>
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

Switch to DEFINE_SIMPLE_DEV_PM_OPS() so that the __maybe_unused can
be dropped from the suspend/resume callbacks.

While at it also drop the _wmi_ part from the callback names in preparation
for making lenovo-yogabook-wmi also work on the Android version of
the Yoga Book 1 which does not have a WMI interface to deal with toggling
the keyboard half between touch-keyboard and wacom-digitizer mode.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index 62db455218a5..61076137a350 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -347,7 +347,7 @@ static void yogabook_wmi_remove(struct wmi_device *wdev)
 	acpi_dev_put(data->kbd_adev);
 }
 
-static int __maybe_unused yogabook_wmi_suspend(struct device *dev)
+static int yogabook_suspend(struct device *dev)
 {
 	struct wmi_device *wdev = container_of(dev, struct wmi_device, dev);
 	struct yogabook_wmi *data = dev_get_drvdata(dev);
@@ -363,7 +363,7 @@ static int __maybe_unused yogabook_wmi_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused yogabook_wmi_resume(struct device *dev)
+static int yogabook_resume(struct device *dev)
 {
 	struct wmi_device *wdev = container_of(dev, struct wmi_device, dev);
 	struct yogabook_wmi *data = dev_get_drvdata(dev);
@@ -392,13 +392,12 @@ static const struct wmi_device_id yogabook_wmi_id_table[] = {
 	{ } /* Terminating entry */
 };
 
-static SIMPLE_DEV_PM_OPS(yogabook_wmi_pm_ops,
-			 yogabook_wmi_suspend, yogabook_wmi_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(yogabook_pm_ops, yogabook_suspend, yogabook_resume);
 
 static struct wmi_driver yogabook_wmi_driver = {
 	.driver = {
 		.name = "yogabook-wmi",
-		.pm = &yogabook_wmi_pm_ops,
+		.pm = pm_sleep_ptr(&yogabook_pm_ops),
 	},
 	.no_notify_data = true,
 	.id_table = yogabook_wmi_id_table,
-- 
2.39.2

