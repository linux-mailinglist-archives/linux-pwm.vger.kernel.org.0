Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10DF01F0DD4
	for <lists+linux-pwm@lfdr.de>; Sun,  7 Jun 2020 20:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbgFGSTR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 7 Jun 2020 14:19:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35924 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730115AbgFGSTP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 7 Jun 2020 14:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591553954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=enDmigKPZ6hGhbnIXLCk/1+mW1SDxZUvwf02x4z1WGI=;
        b=ivUE9OLNdcgMLmqWFyf7gVAsM7Y7Dj/ySbSpAqJutWxmAVyxtnb5rD7PC/k0udR5txrC2T
        ebkjU8onnnCl3jBuFKytQ3R4wRNqR4Hd36P3jzo2tZmElT+6VEOg1B9zpoeNQ8tnLsSa8u
        M3oE7h1cies+TxHkp2+t1+CRP60DN4c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-CJJhDXefOBaofatwiqt3zw-1; Sun, 07 Jun 2020 14:19:10 -0400
X-MC-Unique: CJJhDXefOBaofatwiqt3zw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88C36464;
        Sun,  7 Jun 2020 18:19:08 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-92.ams2.redhat.com [10.36.112.92])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 168D45C1BD;
        Sun,  7 Jun 2020 18:19:05 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
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
Subject: [PATCH v2 07/15] pwm: crc: Fix off-by-one error in the clock-divider calculations
Date:   Sun,  7 Jun 2020 20:18:32 +0200
Message-Id: <20200607181840.13536-8-hdegoede@redhat.com>
In-Reply-To: <20200607181840.13536-1-hdegoede@redhat.com>
References: <20200607181840.13536-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The CRC PWM controller has a clock-divider which divides the clock with
a value between 1-128. But as can seen from the PWM_DIV_CLK_xxx
defines, this range maps to a register value of 0-127.

So after calculating the clock-divider we must subtract 1 to get the
register value, unless the requested frequency was so high that the
calculation has already resulted in a (rounded) divider value of 0.

Note that before this fix, setting a period of PWM_MAX_PERIOD_NS which
corresponds to the max. divider value of 128 could have resulted in a
bug where the code would use 128 as divider-register value which would
have resulted in an actual divider value of 0 (and the enable bit being
set). A rounding error stopped this bug from actually happen. This
same rounding error means that after the subtraction of 1 it is impossible
to set the divider to 128. Also bump PWM_MAX_PERIOD_NS by 1 ns to allow
setting a divider of 128 (register-value 127).

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 43fc912c1fe9..5ba2a65c524c 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -22,7 +22,7 @@
 #define PWM_MAX_LEVEL		0xFF
 
 #define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
-#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
+#define PWM_MAX_PERIOD_NS	5461334	/* 183 Hz */
 
 #define NSEC_PER_MHZ		1000
 
@@ -75,6 +75,9 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 		/* changing the clk divisor, need to disable fisrt */
 		crc_pwm_disable(c, pwm);
 		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
+		/* clk_div 1 - 128, maps to register values 0-127 */
+		if (clk_div > 0)
+			clk_div--;
 
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
-- 
2.26.2

