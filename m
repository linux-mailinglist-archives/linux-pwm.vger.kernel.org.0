Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78B724FD36
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHXMCA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 08:02:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50835 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727029AbgHXMB6 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 08:01:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598270513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3mqN9rDcCqr7nh6Hbhh29SJWkRViinBk1n4ManKQOrs=;
        b=h1hRkkLTC4gPaDQ64YIlsdo67Dhkjf0HOwKSMd9s0vMbr8UC80YXkVliyvmrpffyIKu4pF
        8FBsv9duCtBMG+6/JFNLUOa84CVYEckCMsZGX6MRZpIIGSE5t9F8/3j+gvkTTHibNCzN2G
        h+EXeqwvjdXpzwCiZIxx8EXD9SlJK5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-8wGAtGR8MBGmNoDAfNODMg-1; Mon, 24 Aug 2020 08:01:49 -0400
X-MC-Unique: 8wGAtGR8MBGmNoDAfNODMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE9F41005E63;
        Mon, 24 Aug 2020 12:01:46 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-147.ams2.redhat.com [10.36.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0AB115D9DD;
        Mon, 24 Aug 2020 12:01:43 +0000 (UTC)
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
Subject: [PATCH v6 04/16] pwm: lpss: Add range limit check for the base_unit register value
Date:   Mon, 24 Aug 2020 14:01:14 +0200
Message-Id: <20200824120126.7116-5-hdegoede@redhat.com>
In-Reply-To: <20200824120126.7116-1-hdegoede@redhat.com>
References: <20200824120126.7116-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When the user requests a high enough period ns value, then the
calculations in pwm_lpss_prepare() might result in a base_unit value of 0.

But according to the data-sheet the way the PWM controller works is that
each input clock-cycle the base_unit gets added to a N bit counter and
that counter overflowing determines the PWM output frequency. Adding 0
to the counter is a no-op. The data-sheet even explicitly states that
writing 0 to the base_unit bits will result in the PWM outputting a
continuous 0 signal.

When the user requestes a low enough period ns value, then the
calculations in pwm_lpss_prepare() might result in a base_unit value
which is bigger then base_unit_range - 1. Currently the codes for this
deals with this by applying a mask:

	base_unit &= (base_unit_range - 1);

But this means that we let the value overflow the range, we throw away the
higher bits and store whatever value is left in the lower bits into the
register leading to a random output frequency, rather then clamping the
output frequency to the highest frequency which the hardware can do.

This commit fixes both issues by clamping the base_unit value to be
between 1 and (base_unit_range - 1).

Fixes: 684309e5043e ("pwm: lpss: Avoid potential overflow of base_unit")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v5:
- Use clamp_val(... instead of clam_t(unsigned long long, ...

Changes in v3:
- Change upper limit of clamp to (base_unit_range - 1)
- Add Fixes tag
---
 drivers/pwm/pwm-lpss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 43b1fc634af1..da9bc3d10104 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -97,6 +97,8 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	freq *= base_unit_range;
 
 	base_unit = DIV_ROUND_CLOSEST_ULL(freq, c);
+	/* base_unit must not be 0 and we also want to avoid overflowing it */
+	base_unit = clamp_val(base_unit, 1, base_unit_range - 1);
 
 	on_time_div = 255ULL * duty_ns;
 	do_div(on_time_div, period_ns);
@@ -105,7 +107,6 @@ static void pwm_lpss_prepare(struct pwm_lpss_chip *lpwm, struct pwm_device *pwm,
 	orig_ctrl = ctrl = pwm_lpss_read(pwm);
 	ctrl &= ~PWM_ON_TIME_DIV_MASK;
 	ctrl &= ~((base_unit_range - 1) << PWM_BASE_UNIT_SHIFT);
-	base_unit &= (base_unit_range - 1);
 	ctrl |= (u32) base_unit << PWM_BASE_UNIT_SHIFT;
 	ctrl |= on_time_div;
 
-- 
2.28.0

