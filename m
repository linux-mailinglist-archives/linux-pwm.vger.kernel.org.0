Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A040A25C50E
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Sep 2020 17:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgICPVo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Sep 2020 11:21:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35101 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728468AbgICLYW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Sep 2020 07:24:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599132242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oeojNYihj1/4GnBYNf4T6ofPGFiKE3ZSQ6kb3lrJ21A=;
        b=bdGBE9IVxYD0nrHks7bi3l+ij1iiGM0+iQOvgY51ezrfst1lkCN9HaSfKgvxqazXeUv5+X
        AVo/HWA+51ZbWNIat78i/x911Pv3I/MmWl+JuI7RBIVg7qSxMBTsXdUxGCAUs4UgsxwIUE
        jOgbVzkFb4CyeBqwyowaIXIO7HsoT/Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-7d56g-MINIe_IRrt3oiCgQ-1; Thu, 03 Sep 2020 07:24:00 -0400
X-MC-Unique: 7d56g-MINIe_IRrt3oiCgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A9FD1008552;
        Thu,  3 Sep 2020 11:23:58 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-3.ams2.redhat.com [10.36.113.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F202A5C1C2;
        Thu,  3 Sep 2020 11:23:54 +0000 (UTC)
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
Subject: [PATCH v10 05/17] pwm: lpss: Add pwm_lpss_prepare_enable() helper
Date:   Thu,  3 Sep 2020 13:23:25 +0200
Message-Id: <20200903112337.4113-6-hdegoede@redhat.com>
In-Reply-To: <20200903112337.4113-1-hdegoede@redhat.com>
References: <20200903112337.4113-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In the not-enabled -> enabled path pwm_lpss_apply() needs to get a
runtime-pm reference; and then on any errors it needs to release it
again.

This leads to somewhat hard to read code. This commit introduces a new
pwm_lpss_prepare_enable() helper and moves all the steps necessary for
the not-enabled -> enabled transition there, so that we can error check
the entire transition in a single place and only have one pm_runtime_put()
on failure call site.

While working on this I noticed that the enabled -> enabled (update
settings) path was quite similar, so I've added an enable parameter to
the new pwm_lpss_prepare_enable() helper, which allows using it in that
path too.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pwm/pwm-lpss.c | 45 ++++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index da9bc3d10104..8a136ba2a583 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -122,41 +122,48 @@ static inline void pwm_lpss_cond_enable(struct pwm_device *pwm, bool cond)
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) | PWM_ENABLE);
 }
 
+static int pwm_lpss_prepare_enable(struct pwm_lpss_chip *lpwm,
+				   struct pwm_device *pwm,
+				   const struct pwm_state *state,
+				   bool enable)
+{
+	int ret;
+
+	ret = pwm_lpss_is_updating(pwm);
+	if (ret)
+		return ret;
+
+	pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
+	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == false);
+	ret = pwm_lpss_wait_for_update(pwm);
+	if (ret)
+		return ret;
+
+	pwm_lpss_cond_enable(pwm, enable && lpwm->info->bypass == true);
+	return 0;
+}
+
 static int pwm_lpss_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			  const struct pwm_state *state)
 {
 	struct pwm_lpss_chip *lpwm = to_lpwm(chip);
-	int ret;
+	int ret = 0;
 
 	if (state->enabled) {
 		if (!pwm_is_enabled(pwm)) {
 			pm_runtime_get_sync(chip->dev);
-			ret = pwm_lpss_is_updating(pwm);
-			if (ret) {
-				pm_runtime_put(chip->dev);
-				return ret;
-			}
-			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == false);
-			ret = pwm_lpss_wait_for_update(pwm);
-			if (ret) {
+			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, true);
+			if (ret)
 				pm_runtime_put(chip->dev);
-				return ret;
-			}
-			pwm_lpss_cond_enable(pwm, lpwm->info->bypass == true);
 		} else {
-			ret = pwm_lpss_is_updating(pwm);
-			if (ret)
-				return ret;
-			pwm_lpss_prepare(lpwm, pwm, state->duty_cycle, state->period);
-			return pwm_lpss_wait_for_update(pwm);
+			ret = pwm_lpss_prepare_enable(lpwm, pwm, state, false);
 		}
 	} else if (pwm_is_enabled(pwm)) {
 		pwm_lpss_write(pwm, pwm_lpss_read(pwm) & ~PWM_ENABLE);
 		pm_runtime_put(chip->dev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void pwm_lpss_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.28.0

