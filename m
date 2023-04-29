Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681946F2599
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjD2SRC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjD2SRA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:17:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D822115
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792170;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=62Yi2Jjnyy26lNioZG1Br/J+lKBQfeCWwgBhSe0CTWw=;
        b=QIKoM/a19F1lT7EeYieMYmZJ/XLC4kIjlaml++dsntHwRvNN8Z/E6QV3yf4jh6QyE3t5aL
        yo7A1Ux3yrNPEZddb/bhDoZ7xdKwJIm/EwEKU2CsQymM1OAHPNK1wQbe7ejpejrQwWoz4F
        X1tDaTDE0J6wIQv7Oc3fCneZL2IkcIM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-247-jzDUuBSfOhuZAU_24ViZZQ-1; Sat, 29 Apr 2023 14:16:06 -0400
X-MC-Unique: jzDUuBSfOhuZAU_24ViZZQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A842800B35;
        Sat, 29 Apr 2023 18:16:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3279A2027043;
        Sat, 29 Apr 2023 18:16:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 04/19] platform/x86: lenovo-yogabook: Set default keyboard backligh brightness on probe()
Date:   Sat, 29 Apr 2023 20:15:36 +0200
Message-Id: <20230429181551.98201-5-hdegoede@redhat.com>
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

Set default keyboard backlight brightness on probe(), this fixes
the backlight being off after a rmmod + modprobe.

Fixes: c0549b72d99d ("platform/x86: lenovo-yogabook-wmi: Add driver for Lenovo Yoga Book")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/lenovo-yogabook-wmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/lenovo-yogabook-wmi.c b/drivers/platform/x86/lenovo-yogabook-wmi.c
index ed8015d6c582..727e3ae5e8f5 100644
--- a/drivers/platform/x86/lenovo-yogabook-wmi.c
+++ b/drivers/platform/x86/lenovo-yogabook-wmi.c
@@ -296,6 +296,9 @@ static int yogabook_wmi_probe(struct wmi_device *wdev, const void *context)
 	}
 	data->backside_hall_irq = r;
 
+	/* Set default brightness before enabling the IRQ */
+	yogabook_wmi_set_kbd_backlight(data->wdev, YB_KBD_BL_DEFAULT);
+
 	r = request_irq(data->backside_hall_irq, yogabook_backside_hall_irq,
 			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
 			"backside_hall_sw", data);
-- 
2.39.2

