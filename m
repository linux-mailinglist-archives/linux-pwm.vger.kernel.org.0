Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 070D2219219
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Jul 2020 23:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHVPI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 8 Jul 2020 17:15:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26406 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726187AbgGHVPI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 8 Jul 2020 17:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594242907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/dGCo/xXzz/hMUGVIpBuI4CpNY9zSoguT4eSJC9/WpQ=;
        b=WL8UKZ9BiNhOguWOmBJZlnpKRs/khvWNBXjXzZRU4uzuP7anxP6GAwY10R2wfwqJIVAvMZ
        0/kBYPK0SU/mvk5KZUDvQhh8lheJHEL9gzpfBWdWFuAc7LIZutCxvfThrSQyqEwmWiPKj3
        e32CVTSNQbKn9ZSP12lc4Ym/qsXuYto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-478-t1CZuCdVPDGVw2Klnw34nQ-1; Wed, 08 Jul 2020 17:14:55 -0400
X-MC-Unique: t1CZuCdVPDGVw2Klnw34nQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B46B3E918;
        Wed,  8 Jul 2020 21:14:53 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-5.ams2.redhat.com [10.36.112.5])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 26CD179220;
        Wed,  8 Jul 2020 21:14:51 +0000 (UTC)
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
Subject: [PATCH v4 06/16] pwm: lpss: Correct get_state result for base_unit == 0
Date:   Wed,  8 Jul 2020 23:14:22 +0200
Message-Id: <20200708211432.28612-7-hdegoede@redhat.com>
In-Reply-To: <20200708211432.28612-1-hdegoede@redhat.com>
References: <20200708211432.28612-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The datasheet specifies that programming the base_unit part of the
ctrl register to 0 results in a contineous low signal.

Adjust the get_state method to reflect this by setting pwm_state.period
to 1 and duty_cycle to 0.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v4:
- This is a new patch in v4 of this patchset
---
 drivers/pwm/pwm-lpss.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 4f3d60ce9929..4d4de45cf99b 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -192,14 +192,16 @@ static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	freq = base_unit * lpwm->info->clk_rate;
 	do_div(freq, base_unit_range);
-	if (freq == 0)
-		state->period = NSEC_PER_SEC;
-	else
+	if (freq == 0) {
+		/* In this case the PWM outputs a continous low signal */
+		state->period = 1;
+		state->duty_cycle = 0;
+	} else {
 		state->period = NSEC_PER_SEC / (unsigned long)freq;
-
-	on_time_div *= state->period;
-	do_div(on_time_div, 255);
-	state->duty_cycle = on_time_div;
+		on_time_div *= state->period;
+		do_div(on_time_div, 255);
+		state->duty_cycle = on_time_div;
+	}
 
 	state->polarity = PWM_POLARITY_NORMAL;
 	state->enabled = !!(ctrl & PWM_ENABLE);
-- 
2.26.2

