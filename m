Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BED5223D00
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 15:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGQNiR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 09:38:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28712 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726512AbgGQNiR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 09:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594993095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZtt75CEcTdNAp9GFIY6y7MMo5rkA/s2Do7t8OqOgL8=;
        b=BdPJGF4epZMbra1wwuovNCJm0401ddl15adUErZ9EyPyQxcSknnTamVbhKGQP9dmAq5DSH
        V4z9kclUga8wjnhD8Zst31TjBpPi6+krS0QQWC0dQcS3jTgmU2gv8N9wL++B/7FK5N8eBM
        2Q97VUhI8qwDIiP9JymjBWErVaI5igY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-KnMtlRA_M86BSXcFzF_l5g-1; Fri, 17 Jul 2020 09:38:10 -0400
X-MC-Unique: KnMtlRA_M86BSXcFzF_l5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C06C21DE3;
        Fri, 17 Jul 2020 13:38:08 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AA1B98FA27;
        Fri, 17 Jul 2020 13:38:03 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pwm@vger.kernel.org,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org
Subject: [PATCH v5 03/16] pwm: lpss: Fix off by one error in base_unit math in pwm_lpss_prepare()
Date:   Fri, 17 Jul 2020 15:37:40 +0200
Message-Id: <20200717133753.127282-4-hdegoede@redhat.com>
In-Reply-To: <20200717133753.127282-1-hdegoede@redhat.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

According to the data-sheet the way the PWM controller works is that
each input clock-cycle the base_unit gets added to a N bit counter and
that counter overflowing determines the PWM output frequency.

So assuming e.g. a 16 bit counter this means that if base_unit is set to 1,
after 65535 input clock-cycles the counter has been increased from 0 to
65535 and it will overflow on the next cycle, so it will overflow after
every 65536 clock cycles and thus the calculations done in
pwm_lpss_prepare() should use 65536 and not 65535.

This commit fixes this. Note this also aligns the calculations in
pwm_lpss_prepare() with those in pwm_lpss_get_state().

Note this effectively reverts commit 684309e5043e ("pwm: lpss: Avoid
potential overflow of base_unit"). The next patch in this series really
fixes the potential overflow of the base_unit value.

Fixes: 684309e5043e ("pwm: lpss: Avoid potential overflow of base_unit")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v3:
- Add Fixes tag
- Add Reviewed-by: Andy Shevchenko tag
---
 drivers/pwm/pwm-lpss.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 9d965ffe66d1..43b1fc634af1 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -93,7 +93,7 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	 * The equation is:
 	 * base_unit = round(base_unit_range * freq / c)
 	 */
-	base_unit_range = BIT(lpwm->info->base_unit_bits) - 1;
+	base_unit_range = BIT(lpwm->info->base_unit_bits);
 	freq *= base_unit_range;
 
 	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
@@ -104,8 +104,8 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 
 	orig_ctrl = ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~PWM_ON_TIME_DIV_MASK;
-	ctrl &= ~(base_unit_range << PWM_BASE_UNIT_SHIFT);
-	base_unit &= base_unit_range;
+	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
+	base_unit &= (base_unit_range - 1);
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 
-- 
2.26.2

