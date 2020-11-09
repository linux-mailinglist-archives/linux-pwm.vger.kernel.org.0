Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C52AB59A
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 11:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgKIK5l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 05:57:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729168AbgKIK5k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 05:57:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604919459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFQ3NXM+Ll2VDtzUJoZCbgvc0RCST66Ng0luYaRPOdM=;
        b=gptLYbK+G0C4UhviJndoOgg4p3nbxPGU+zc7PxKaqgyF2pH40OtcxwP6xlpbg5ZLPyvZjd
        LSyu9QmUdvsP5hztnLXsCoLAnWi9sM0pkptOS+huAY4qwvnYSDKJwLglLdy27vhyLf+ik6
        U7lh4mfJMyr+THaqBnNBbgld4U/Lv8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350--V8jmxqEMeSDz1gB4i3GwQ-1; Mon, 09 Nov 2020 05:57:37 -0500
X-MC-Unique: -V8jmxqEMeSDz1gB4i3GwQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 43FE357201;
        Mon,  9 Nov 2020 10:57:36 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6A546EF45;
        Mon,  9 Nov 2020 10:57:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 3/3] pwm: lpss: Set DPM_FLAG_SMART_SUSPEND on Cherry Trail devices
Date:   Mon,  9 Nov 2020 11:57:26 +0100
Message-Id: <20201109105726.121512-4-hdegoede@redhat.com>
In-Reply-To: <20201109105726.121512-1-hdegoede@redhat.com>
References: <20201109105726.121512-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

As the comment above the code setting the DPM_FLAG_NO_DIRECT_COMPLETE
flag explains:

    /*
     * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
     * is on and if it is not on it turns it on and restores what it
     * believes is the correct state to the PWM controller.
     * Because of this we must disallow direct-complete, which keeps the
     * controller (runtime)suspended, on resume to avoid 2 issues:
     * 1. The controller getting turned on without the linux-pm code
     *    knowing about this. On devices where the controller is unused
     *    this causes it to stay on during the next suspend causing high
     *    battery drain (because S0i3 is not reached)
     * 2. The state restoring code unexpectedly messing with the controller
     */

The pm-core must not skip resume to avoid the GFX0._PS0 AML code messing
with the PWM controller behind our back. But leaving the controller
runtime-suspended (skipping runtime-resume + normal-suspend) during
suspend is fine. Set the DPM_FLAG_SMART_SUSPEND flag to allow this.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Extend comment to explain why the DPM_FLAG_SMART_SUSPEND is set
---
 drivers/pwm/pwm-lpss-platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index ac33861edb48..986786be1e49 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -69,9 +69,13 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	 *    this causes it to stay on during the next suspend causing high
 	 *    battery drain (because S0i3 is not reached)
 	 * 2. The state restoring code unexpectedly messing with the controller
+	 *
+	 * Leaving the controller runtime-suspended (skipping runtime-resume +
+	 * normal-suspend) during suspend is fine.
 	 */
 	if (info->other_devices_aml_touches_pwm_regs)
-		dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE|
+						    DPM_FLAG_SMART_SUSPEND);
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.28.0

