Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 919F92AB598
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Nov 2020 11:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgKIK5i (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Nov 2020 05:57:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49867 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729081AbgKIK5i (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Nov 2020 05:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604919457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPG94ysVOebXbhN6vHzcu17giV7+YhMXljfh3FMPh2U=;
        b=E5dHmkJYTBteiAzvt9/r7YAKcZeTFdsRBlOUU6/NyugzbpMf3D7UADghUL0yqlmVruS+qB
        wbBWyripHGy0pMGiWRZUCKc8evzgFyb7cRi+PoKhr3B2eWF/meQe838UwJDaj7wLlXgjd/
        X38QVHKHICcpJK2PfYqstlu0L6o4Nj0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-BOFS-y12NjKwHJNILYEKgw-1; Mon, 09 Nov 2020 05:57:33 -0500
X-MC-Unique: BOFS-y12NjKwHJNILYEKgw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9C7B61005504;
        Mon,  9 Nov 2020 10:57:32 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-3.ams2.redhat.com [10.36.114.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2EC606EF4B;
        Mon,  9 Nov 2020 10:57:31 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 1/3] pwm: lpss: Log error from pwm_lpss_is_updating() if the update bit is still set
Date:   Mon,  9 Nov 2020 11:57:24 +0100
Message-Id: <20201109105726.121512-2-hdegoede@redhat.com>
In-Reply-To: <20201109105726.121512-1-hdegoede@redhat.com>
References: <20201109105726.121512-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_lpss_is_updating() does a sanity check which should never fail.
If the check does actually fail that is worth logging an error,
especially since this means that we will skip making the requested
changes to the PWM settings.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 3444c56b4bed..939de93c157b 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -76,7 +76,12 @@ static int pwm_lpss_wait_for_update(struct pwm_device *pwm)
 
 static inline int pwm_lpss_is_updating(struct pwm_device *pwm)
 {
-	return (pwm_lpss_read(pwm) & PWM_SW_UPDATE) ? -EBUSY : 0;
+	if (pwm_lpss_read(pwm) & PWM_SW_UPDATE) {
+		dev_err(pwm->chip->dev, "PWM_SW_UPDATE is still set, skipping update\n");
+		return -EBUSY;
+	}
+
+	return 0;
 }
 
 static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
-- 
2.28.0

