Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337242A01C1
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 10:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgJ3Jsn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 05:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60618 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgJ3Jsn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 05:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604051322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6Tcgj0B/qC3EjbSiarc6Rg5hdfvraCvvFuX9tXeK4U=;
        b=eQzKe/XrPt4goeFuciruGaJAzXOEYV/XxWWeQNPQLBY5uyEKtKJbCrKbvxCdHogVNhjrR3
        CJXv8Bjqza2jEy/ibqyB+tuqMmSE+aezHOcPVGweaQGdGHdQ9quEbt5Cw9DRD4U3fBI1Pi
        IdCRNZwiHCJybBDFkY7Jm4TxZ2+L6IU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-LGRW296XMdSP8kfZzUEGvA-1; Fri, 30 Oct 2020 05:48:40 -0400
X-MC-Unique: LGRW296XMdSP8kfZzUEGvA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1027EADC28;
        Fri, 30 Oct 2020 09:48:39 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C98745C1CF;
        Fri, 30 Oct 2020 09:48:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 3/3] pwm: lpss: Set DPM_FLAG_SMART_SUSPEND on Cherry Trail devices
Date:   Fri, 30 Oct 2020 10:48:32 +0100
Message-Id: <20201030094832.18297-4-hdegoede@redhat.com>
In-Reply-To: <20201030094832.18297-1-hdegoede@redhat.com>
References: <20201030094832.18297-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss-platform.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index ac33861edb48..38d17e2e2b4c 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -71,7 +71,8 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	 * 2. The state restoring code unexpectedly messing with the controller
 	 */
 	if (info->other_devices_aml_touches_pwm_regs)
-		dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NO_DIRECT_COMPLETE|
+						    DPM_FLAG_SMART_SUSPEND);
 
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
-- 
2.28.0

