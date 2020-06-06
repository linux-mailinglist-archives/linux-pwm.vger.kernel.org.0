Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718291F08A6
	for <lists+linux-pwm@lfdr.de>; Sat,  6 Jun 2020 22:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgFFU0l (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 6 Jun 2020 16:26:41 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36781 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728906AbgFFU0k (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 6 Jun 2020 16:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591475199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OyDeV0Z/UvojkUctUmW3EntL3TMpO41rrKpUP7M6VZg=;
        b=TG3X8I8oEYLK5o9grFONQamXCQsWiM25nVx9nmoWsLq77amGOEan0JDS9fYSyfXB0Nas42
        7YuD23X2yIrDA8IgThQNeGrvUjHxlUs74Ims2zpFlMdRJ/Vt0nT3D7FV3L1ymqNOmcDS/B
        1xKbN7FqcqUXHWgRc3gLx/cOXG+sn3E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-YakesdgHOR6dhfC8jZVQYw-1; Sat, 06 Jun 2020 16:26:26 -0400
X-MC-Unique: YakesdgHOR6dhfC8jZVQYw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D436B1853578;
        Sat,  6 Jun 2020 20:26:24 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6081D5C557;
        Sat,  6 Jun 2020 20:26:22 +0000 (UTC)
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
Subject: [PATCH 07/16] pwm: crc: Fix period / duty_cycle times being off by a factor of 256
Date:   Sat,  6 Jun 2020 22:25:52 +0200
Message-Id: <20200606202601.48410-8-hdegoede@redhat.com>
In-Reply-To: <20200606202601.48410-1-hdegoede@redhat.com>
References: <20200606202601.48410-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

While looking into adding atomic-pwm support to the pwm-crc driver I
noticed something odd, there is a PWM_BASE_CLK define of 6 MHz and
there is a clock-divider which divides this with a value between 1-128,
and there are 256 duty-cycle steps.

The pwm-crc code before this commit assumed that a clock-divider
setting of 1 means that the PWM output is running at 6 MHZ, if that
is true, where do these 256 duty-cycle steps come from?

This would require an internal frequency of 256 * 6 MHz = 1.5 GHz, that
seems unlikely for a PMIC which is using a silicon process optimized for
power-switching transistors. It is way more likely that there is an 8
bit counter for the duty cycle which acts as an extra fixed divider
wrt the PWM output frequency.

The main user of the pwm-crc driver is the i915 GPU driver which uses it
for backlight control. Lets compare the PWM register values set by the
video-BIOS (the GOP), assuming the extra fixed divider is present versus
the PWM frequency specified in the Video-BIOS-Tables:

Device:		PWM Hz set by BIOS	PWM Hz specified in VBT
Asus T100TA 	200			200
Asus T100HA 	200			200
Lenovo Miix 2 8	23437			20000
Toshiba WT8-A	23437			20000

So as we can see if we assume the extra division by 256 then the register
values set by the GOP are an exact match for the VBT values, where as
otherwise the values would be of by a factor of 256.

This commit fixes the period / duty_cycle calculations to take the
extra division by 256 into account.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-crc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index 272eeb071147..43fc912c1fe9 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -21,8 +21,10 @@
 
 #define PWM_MAX_LEVEL		0xFF
 
-#define PWM_BASE_CLK		6000000  /* 6 MHz */
-#define PWM_MAX_PERIOD_NS	21333    /* 46.875KHz */
+#define PWM_BASE_CLK_MHZ	6	/* 6 MHz */
+#define PWM_MAX_PERIOD_NS	5461333	/* 183 Hz */
+
+#define NSEC_PER_MHZ		1000
 
 /**
  * struct crystalcove_pwm - Crystal Cove PWM controller
@@ -72,7 +74,7 @@ static int crc_pwm_config(struct pwm_chip *c, struct pwm_device *pwm,
 
 		/* changing the clk divisor, need to disable fisrt */
 		crc_pwm_disable(c, pwm);
-		clk_div = PWM_BASE_CLK * period_ns / NSEC_PER_SEC;
+		clk_div = PWM_BASE_CLK_MHZ * period_ns / (256 * NSEC_PER_MHZ);
 
 		regmap_write(crc_pwm->regmap, PWM0_CLK_DIV,
 					clk_div | PWM_OUTPUT_ENABLE);
-- 
2.26.2

