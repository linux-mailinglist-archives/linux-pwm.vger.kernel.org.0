Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0C2A01BF
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 10:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbgJ3Jsm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 05:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726208AbgJ3Jsm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 05:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604051321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MF/4BiOE93CsaCnBKTbZLd1/1CyRGcAJc7zDo9/0bF0=;
        b=Krj8kRkYVfemkWCnooczmsoxR2sqYKRNYUaET/EXrjm5jxreRLODVOfYuWBSQAxu1lPeLO
        WCcKMACKZ13ls4Gva+KjUcpQm+LPgGX5jn/fO6RmH5CAk6L7xnoMb7/8XCEG4QcgpDkIo5
        rxy1RT6IqCxkino1fuYaZkfiM9ReF8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-siJshy_sOjWUpHwKdk7rAA-1; Fri, 30 Oct 2020 05:48:38 -0400
X-MC-Unique: siJshy_sOjWUpHwKdk7rAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E467101F000;
        Fri, 30 Oct 2020 09:48:37 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 43A505C1CF;
        Fri, 30 Oct 2020 09:48:36 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 2/3] pwm: lpss: Use DPM_FLAG_NO_DIRECT_COMPLETE instead of declaring a prepare handler
Date:   Fri, 30 Oct 2020 10:48:31 +0100
Message-Id: <20201030094832.18297-3-hdegoede@redhat.com>
In-Reply-To: <20201030094832.18297-1-hdegoede@redhat.com>
References: <20201030094832.18297-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

ACPI LPSS devices use direct-complete style suspend/resume handling by
default. We set the DPM_FLAG_SMART_PREPARE and define a prepare handler
to disable this on Cherry Trail devices.

Clean this up a bit by setting the DPM_FLAG_NO_DIRECT_COMPLETE flag for
Cherry Trail devices, instead of defining a prepare handler.

While at it also improve the comment explaining why this is necessary.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 35 ++++++++++++++-------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index c6502cf7a7af..ac33861edb48 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -58,7 +58,21 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, lpwm);
 
-	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_PREPARE);
+	/*
+	 * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
+	 * is on and if it is not on it turns it on and restores what it
+	 * believes is the correct state to the PWM controller.
+	 * Because of this we must disallow direct-complete, which keeps the
+	 * controller (runtime)suspended on resume, to avoid 2 issues:
+	 * 1. The controller getting turned on without the linux-pm code
+	 *    knowing about this. On devices where the controller is unused
+	 *    this causes it to stay on during the next suspend causing high
+	 *    battery drain (because S0i3 is not reached)
+	 * 2. The state restoring code unexpectedly messing with the controller
+	 */
+	if (info->other_devices_aml_touches_pwm_regs)
+		dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
@@ -73,24 +87,6 @@ static int pwm_lpss_remove_platform(struct platform_device *pdev)
 	return pwm_lpss_remove(lpwm);
 }
 
-static int pwm_lpss_prepare(struct device *dev)
-{
-	struct pwm_lpss_chip *lpwm = dev_get_drvdata(dev);
-
-	/*
-	 * If other device's AML code touches the PWM regs on suspend/resume
-	 * force runtime-resume the PWM controller to allow this.
-	 */
-	if (lpwm->info->other_devices_aml_touches_pwm_regs)
-		return 0; /* Force runtime-resume */
-
-	return 1; /* If runtime-suspended leave as is */
-}
-
-static const struct dev_pm_ops pwm_lpss_platform_pm_ops = {
-	.prepare = pwm_lpss_prepare,
-};
-
 static const struct acpi_device_id pwm_lpss_acpi_match[] = {
 	{ "80860F09", (unsigned long)&pwm_lpss_byt_info },
 	{ "80862288", (unsigned long)&pwm_lpss_bsw_info },
@@ -104,7 +100,6 @@ static struct platform_driver pwm_lpss_driver_platform = {
 	.driver = {
 		.name = "pwm-lpss",
 		.acpi_match_table = pwm_lpss_acpi_match,
-		.pm = &pwm_lpss_platform_pm_ops,
 	},
 	.probe = pwm_lpss_probe_platform,
 	.remove = pwm_lpss_remove_platform,
-- 
2.28.0

