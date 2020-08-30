Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B87D7256DF1
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Aug 2020 15:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgH3M75 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Aug 2020 08:59:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33726 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728903AbgH3M6g (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Aug 2020 08:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598792313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X/u2P3rm/Mt8sbxumEdSG8Sz04qHhuY60Fsw4/vcSuw=;
        b=d+0zRtwGu1vG31Sb0P+Kh2swNgdQfEJeYSQfn+vbwgSmuoIPfFBmcjZnpZTgR4YE9StdMk
        xjE/sE16xG9HqsT1tbx6q+nJw+2c0qKtRHJDKuLma8NGULQZuIJIebICNmLfK3npYjFyKu
        IvXKVmbc2oE3GUWJ3HQ1MA2LGM0/GU4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-b1lbtesMPeaZG07-icrtLw-1; Sun, 30 Aug 2020 08:58:31 -0400
X-MC-Unique: b1lbtesMPeaZG07-icrtLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 794121005E5F;
        Sun, 30 Aug 2020 12:58:29 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-77.ams2.redhat.com [10.36.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DCB65171C6;
        Sun, 30 Aug 2020 12:58:26 +0000 (UTC)
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
Subject: [PATCH v8 10/17] pwm: crc: Fix period changes not having any effect
Date:   Sun, 30 Aug 2020 14:57:46 +0200
Message-Id: <20200830125753.230420-11-hdegoede@redhat.com>
In-Reply-To: <20200830125753.230420-1-hdegoede@redhat.com>
References: <20200830125753.230420-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The pwm-crc code is using 2 different enable bits:
1. bit 7 of the PWM0_CLK_DIV (PWM_OUTPUT_ENABLE)
2. bit 0 of the BACKLIGHT_EN register

The BACKLIGHT_EN register at address 0x51 really controls a separate
output-only GPIO which is earmarked to be used as output connected to the
backlight-enable pin for LCD panels, this GPO is part of the PMIC's
"Display Panel Control Block." . This pin should probably be moved over
to a GPIO provider driver (and consumers modified accordingly), but that
is something for an(other) patch.

Enabling / disabling the actual PWM output is controlled by the
PWM_OUTPUT_ENABLE bit of the PWM0_CLK_DIV register.

As the comment in the old code already indicates we must disable the PWM
before we can change the clock divider. But the crc_pwm_disable() and
crc_pwm_enable() calls the old code make for this only change the
BACKLIGHT_EN register; and the value of that register does not matter for
changing the period / the divider. What does matter is that the
PWM_OUTPUT_ENABLE bit must be cleared before a new value can be written.

This commit modifies crc_pwm_config() to clear PWM_OUTPUT_ENABLE instead
when changing the period, so that period changes actually work.

Note this fix will cause a significant behavior change on some devices
using the CRC PWM output to drive their backlight. Before the PWM would
always run with the output frequency configured by the BIOS at boot, now
the period time specified by the i915 driver will actually be honored.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 44ec7d5b63e1..81232da0c767 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -82,14 +82,11 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 	if (pwm_get_period(pwm) != period_ns) {
 		int clk_div = crc_pwm_calc_clk_div(period_ns);
 
-		/* changing the clk divisor, need to disable fisrt */
-		crc_pwm_disable(c, pwm);
+		/* changing the clk divisor, clear PWM_OUTPUT_ENABLE first */
+		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV, 0);
 
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
-
-		/* enable back */
-		crc_pwm_enable(c, pwm);
 	}
 
 	/* change the pwm duty cycle */
-- 
2.28.0

