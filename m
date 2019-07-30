Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B3B7ACB0
	for <lists+linux-pwm@lfdr.de>; Tue, 30 Jul 2019 17:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfG3Psx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 30 Jul 2019 11:48:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725974AbfG3Psw (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Tue, 30 Jul 2019 11:48:52 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D0CD300194A;
        Tue, 30 Jul 2019 15:48:52 +0000 (UTC)
Received: from shalem.localdomain.com (unknown [10.36.118.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C48AD600CC;
        Tue, 30 Jul 2019 15:48:50 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        youling257@gmail.com,
        Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Subject: [PATCH 5.3 regression fix] pwm: Fallback to the static lookup-list when acpi_pwm_get fails
Date:   Tue, 30 Jul 2019 17:48:48 +0200
Message-Id: <20190730154848.5164-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Jul 2019 15:48:52 +0000 (UTC)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
made pwm_get unconditionally return the acpi_pwm_get return value if
the device passed to pwm_get has an ACPI fwnode.

But even if the passed in device has an ACPI fwnode, it does not
necessarily have the necessary ACPI package defining its pwm bindings,
especially since the binding / API of this ACPI package has only been
introduced very recently.

Up until now X86/ACPI devices which use a separate pwm controller for
controlling their LCD screen's backlight brightness have been relying
on the static lookup-list to get their pwm.

pwm_get unconditionally returning the acpi_pwm_get return value breaks
this, breaking backlight control on these devices.

This commit fixes this by making pwm_get fall back to the static
lookup-list if acpi_pwm_get returns -ENOENT.

BugLink: https://bugs.freedesktop.org/show_bug.cgi?id=96571
Reported-by: youling257@gmail.com
Fixes: 4a6ef8e37c4d ("pwm: Add support referencing PWMs from ACPI")
Cc: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c3ab07ab31a9..8edfac17364e 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -882,8 +882,11 @@ struct pwm_device *pwm_get(struct device *dev, const char *con_id)
 		return of_pwm_get(dev, dev->of_node, con_id);
 
 	/* then lookup via ACPI */
-	if (dev && is_acpi_node(dev->fwnode))
-		return acpi_pwm_get(dev->fwnode);
+	if (dev && is_acpi_node(dev->fwnode)) {
+		pwm = acpi_pwm_get(dev->fwnode);
+		if (!IS_ERR(pwm) || PTR_ERR(pwm) != -ENOENT)
+			return pwm;
+	}
 
 	/*
 	 * We look up the provider in the static table typically provided by
-- 
2.21.0

