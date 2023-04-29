Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D16F2597
	for <lists+linux-pwm@lfdr.de>; Sat, 29 Apr 2023 20:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjD2SRB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 29 Apr 2023 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229882AbjD2SQ7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 29 Apr 2023 14:16:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC91BF4
        for <linux-pwm@vger.kernel.org>; Sat, 29 Apr 2023 11:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682792166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mCBm5jOnhjJEt6pe1UKwQEu4teSD01GVaLjt+SyOQmE=;
        b=UoE3XWi9TL6kIEP58jAjd2g92av01Yu18u5OV1NqXD2nr+7sPlbjhSk6EcOyoqTrVKuFZd
        OcgjjO+7EST+/XA8hLYMsQ6NUqpxKDcz4ZpscdFxGqBVeaFeewMsBHvxdeZDk0MEZfj1+E
        LbOUjuuKwR58CcFA7Td16hMveOqMm50=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-UQ1SQ7OUPZaaUD70OvASSg-1; Sat, 29 Apr 2023 14:16:03 -0400
X-MC-Unique: UQ1SQ7OUPZaaUD70OvASSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CCA0101A550;
        Sat, 29 Apr 2023 18:16:02 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44F972027043;
        Sat, 29 Apr 2023 18:16:01 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH 01/19] pwm: Export pwm_add_table() / pwm_remove_table()
Date:   Sat, 29 Apr 2023 20:15:33 +0200
Message-Id: <20230429181551.98201-2-hdegoede@redhat.com>
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

Lenovo Yoga Book 1 (yb1-x90f/l) models have a backlit keyboard where
the brightness is directly controlled by one of the Intel Cherry Trail
SoCs PWM controllers.

To control the backlight the drivers/platform/lenovo-yogabook.c needs
to add a pwm_lookup table entry so that it can call pwm_get() to get
a reference to the PWM controller.

The lenovo-yogabook driver can be build as a module, export
pwm_add_table() and pwm_remove_table() so that the lenovo-yogabook
driver can use them when build as a module.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 474725714a05..c66daac6154f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -881,6 +881,7 @@ void pwm_add_table(struct pwm_lookup *table, size_t num)
 
 	mutex_unlock(&pwm_lookup_lock);
 }
+EXPORT_SYMBOL_GPL(pwm_add_table);
 
 /**
  * pwm_remove_table() - unregister PWM device consumers
@@ -898,6 +899,7 @@ void pwm_remove_table(struct pwm_lookup *table, size_t num)
 
 	mutex_unlock(&pwm_lookup_lock);
 }
+EXPORT_SYMBOL_GPL(pwm_remove_table);
 
 /**
  * pwm_get() - look up and request a PWM device
-- 
2.39.2

