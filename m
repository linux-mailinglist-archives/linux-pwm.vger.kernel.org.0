Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB59C2A01BE
	for <lists+linux-pwm@lfdr.de>; Fri, 30 Oct 2020 10:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgJ3Jsm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 30 Oct 2020 05:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725808AbgJ3Jsm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 30 Oct 2020 05:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604051320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FSLnAFEw21e1S5ptHnCyHSEm/UCIVwUtWOv4W0bOiaQ=;
        b=VPLaXiS3z37N69gMmFIxuyPBdhSBJt63gQZrVod/3ctlBsvuXjNLSMoBGZC1SAE7WChpXu
        ToIq1wZsptxNPS9VHAYksXi4ePR3kfwcYINDmM0KFCnouUXF+wBT72wBhBlrTGJBt6TkcB
        lphQfq2WX9N6IyyCVxkpzlQnWVwZeiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-ca9K-PTfNQCz6reGTpC6ew-1; Fri, 30 Oct 2020 05:48:37 -0400
X-MC-Unique: ca9K-PTfNQCz6reGTpC6ew-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3001101F006;
        Fri, 30 Oct 2020 09:48:35 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-237.ams2.redhat.com [10.36.114.237])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A804D5C1CF;
        Fri, 30 Oct 2020 09:48:34 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        linux-pwm@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH 1/3] pwm: lpss: Log error from pwm_lpss_is_updating() if the update bit is still set
Date:   Fri, 30 Oct 2020 10:48:30 +0100
Message-Id: <20201030094832.18297-2-hdegoede@redhat.com>
In-Reply-To: <20201030094832.18297-1-hdegoede@redhat.com>
References: <20201030094832.18297-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_lpss_is_updating() does a sanity check which should never fail.
If the check does actually fail that is worth logging an error,
especially since this means that we will skip making the requested
changes to the PWM settings.

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

