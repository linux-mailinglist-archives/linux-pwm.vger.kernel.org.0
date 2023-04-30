Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161CB6F29B7
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Apr 2023 19:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjD3RBU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Apr 2023 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjD3RBT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Apr 2023 13:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3053A93
        for <linux-pwm@vger.kernel.org>; Sun, 30 Apr 2023 09:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682873929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FJiw9NzT9K0INdo4+f0MqL/Z4a7dmUaUvTLN8FJpYSU=;
        b=DV+BGrfDBa+7d7+RjHsAdhfDFfA44WqRKbz9oh3NY9PGkRwGWyowUhEgulUN3JOibhG0zF
        4+WjdnXk5zZVcNoXlT6dwJp4/86HIQNccg8vGeu77aqrHJ4cU8ustjwwlVfWecZhW71tQV
        6PA3gh65/X+lV35O6Hiyin6feMccjV4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-649-3a5UH9ogM2m1LeItfg_rzA-1; Sun, 30 Apr 2023 12:58:43 -0400
X-MC-Unique: 3a5UH9ogM2m1LeItfg_rzA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 39E0B3C0ED4F;
        Sun, 30 Apr 2023 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1689C2166B26;
        Sun, 30 Apr 2023 16:58:41 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 19/19] platform/x86: lenovo-yogabook: Rename lenovo-yogabook-wmi to lenovo-yogabook
Date:   Sun, 30 Apr 2023 18:58:07 +0200
Message-Id: <20230430165807.472798-20-hdegoede@redhat.com>
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

The lenovo-yogabook-wmi.c code now consists of both a platform and a WMI
driver and it does not use WMI at all when used on the Android model.

Rename the module from lenovo-yogabook-wmi to lenovo-yogabook to
reflect this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/Kconfig                                | 6 +++---
 drivers/platform/x86/Makefile                               | 2 +-
 .../x86/{lenovo-yogabook-wmi.c => lenovo-yogabook.c}        | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/platform/x86/{lenovo-yogabook-wmi.c => lenovo-yogabook.c} (100%)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 22052031c719..2039e3246e1b 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -121,8 +121,8 @@ config GIGABYTE_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called gigabyte-wmi.
 
-config YOGABOOK_WMI
-	tristate "Lenovo Yoga Book tablet WMI key driver"
+config YOGABOOK
+	tristate "Lenovo Yoga Book tablet key driver"
 	depends on ACPI_WMI
 	depends on INPUT
 	select LEDS_CLASS
@@ -132,7 +132,7 @@ config YOGABOOK_WMI
 	  control on the Lenovo Yoga Book tablets.
 
 	  To compile this driver as a module, choose M here: the module will
-	  be called lenovo-yogabook-wmi.
+	  be called lenovo-yogabook.
 
 config ACERHDF
 	tristate "Acer Aspire One temperature and fan driver"
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 2cafe51ec4d8..52dfdf574ac2 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -14,7 +14,6 @@ obj-$(CONFIG_MXM_WMI)			+= mxm-wmi.o
 obj-$(CONFIG_NVIDIA_WMI_EC_BACKLIGHT)	+= nvidia-wmi-ec-backlight.o
 obj-$(CONFIG_XIAOMI_WMI)		+= xiaomi-wmi.o
 obj-$(CONFIG_GIGABYTE_WMI)		+= gigabyte-wmi.o
-obj-$(CONFIG_YOGABOOK_WMI)		+= lenovo-yogabook-wmi.o
 
 # Acer
 obj-$(CONFIG_ACERHDF)		+= acerhdf.o
@@ -66,6 +65,7 @@ obj-$(CONFIG_LENOVO_YMC)	+= lenovo-ymc.o
 obj-$(CONFIG_SENSORS_HDAPS)	+= hdaps.o
 obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
 obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
+obj-$(CONFIG_YOGABOOK)		+= lenovo-yogabook.o
 
 # Intel
 obj-y				+= intel/
diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook.c
similarity index 100%
rename from drivers/platform/x86/lenovo-yogabook-wmi.c
rename to drivers/platform/x86/lenovo-yogabook.c
-- 
2.39.2

