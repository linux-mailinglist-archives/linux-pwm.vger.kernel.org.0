Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B1D223D13
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jul 2020 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgGQNjR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 17 Jul 2020 09:39:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60704 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726113AbgGQNjR (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 17 Jul 2020 09:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594993155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cOeaPycuz3pd2BsD3TwE5ShVvLycX2FCdXrVRwJqqNk=;
        b=guvP1JMTg/efgVQUs+XpkuhwAKawbDBcseQZjzvwS18BitGdCDRUw40BbjE9FfbdSxnnB6
        SF4ZklLUskd6s/ajWklSn6lFR3IA5BQ2efS8RkrQzxaUxPk38f9/DJgeTpDf7/REqJBhV7
        e+qgsJehC/PU1ppjOj3muqTemrWJFBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-1VVgLKf2Mp6mXDdecFm5og-1; Fri, 17 Jul 2020 09:39:13 -0400
X-MC-Unique: 1VVgLKf2Mp6mXDdecFm5og-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6184A10BA;
        Fri, 17 Jul 2020 13:39:03 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-162.ams2.redhat.com [10.36.112.162])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 776CE8FA27;
        Fri, 17 Jul 2020 13:39:00 +0000 (UTC)
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
        linux-acpi@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v5 14/16] drm/i915: panel: Honor the VBT PWM frequency for devs with an external PWM controller
Date:   Fri, 17 Jul 2020 15:37:51 +0200
Message-Id: <20200717133753.127282-15-hdegoede@redhat.com>
In-Reply-To: <20200717133753.127282-1-hdegoede@redhat.com>
References: <20200717133753.127282-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

So far for devices using an external PWM controller (devices using
pwm_setup_backlight()), we have been hardcoding the period-time passed to
pwm_config() to 21333 ns.

I suspect this was done because many VBTs set the PWM frequency to 200
which corresponds to a period-time of 5000000 ns, which greatly exceeds
the PWM_MAX_PERIOD_NS define in the Crystal Cove PMIC PWM driver, which
used to be 21333.

This PWM_MAX_PERIOD_NS define was actually based on a bug in the PWM
driver where its period and duty-cycle times where off by a factor of 256.

Due to this bug the hardcoded CRC_PMIC_PWM_PERIOD_NS value of 21333 would
result in the PWM driver using its divider of 128, which would result in
a PWM output frequency of 6000000 Hz / 256 / 128 = 183 Hz. So actually
pretty close to the default VBT value of 200 Hz.

Now that this bug in the pwm-crc driver is fixed, we can actually use
the VBT defined frequency.

This is important because:

a) With the pwm-crc driver fixed it will now translate the hardcoded
CRC_PMIC_PWM_PERIOD_NS value of 21333 ns / 46 Khz to a PWM output
frequency of 23 KHz (the max it can do).

b) The pwm-lpss driver used on many models has always honored the
21333 ns / 46 Khz request

Some panels do not like such high output frequencies. E.g. on a Terra
Pad 1061 tablet, using the LPSS PWM controller, the backlight would go
from off to max, when changing the sysfs backlight brightness value from
90-100%, anything under aprox. 90% would turn the backlight fully off.

Honoring the VBT specified PWM frequency will also hopefully fix the
various bug reports which we have received about users perceiving the
backlight to flicker after a suspend/resume cycle.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 .../drm/i915/display/intel_display_types.h    |  1 +
 drivers/gpu/drm/i915/display/intel_panel.c    | 19 +++++++++++--------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 2bf3d4cb4ea9..de32f9efb120 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -223,6 +223,7 @@ struct intel_panel {
 		bool util_pin_active_low;	/* bxt+ */
 		u8 controller;		/* bxt+ only */
 		struct pwm_device *pwm;
+		int pwm_period_ns;
 
 		/* DPCD backlight */
 		u8 pwmgen_bit_count;
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 8efdd9f08a08..14e611c92194 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -40,8 +40,6 @@
 #include "intel_dsi_dcs_backlight.h"
 #include "intel_panel.h"
 
-#define CRC_PMIC_PWM_PERIOD_NS	21333
-
 void
 intel_fixed_panel_mode(const struct drm_display_mode *fixed_mode,
 		       struct drm_display_mode *adjusted_mode)
@@ -597,7 +595,7 @@ static u32 pwm_get_backlight(struct intel_connector *connector)
 	int duty_ns;
 
 	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
-	return DIV_ROUND_UP(duty_ns * 100, CRC_PMIC_PWM_PERIOD_NS);
+	return DIV_ROUND_UP(duty_ns * 100, panel->backlight.pwm_period_ns);
 }
 
 static void lpt_set_backlight(const struct drm_connector_state *conn_state, u32 level)
@@ -671,9 +669,10 @@ static void bxt_set_backlight(const struct drm_connector_state *conn_state, u32
 static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
 {
 	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
-	int duty_ns = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
+	int duty_ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
-	pwm_config(panel->backlight.pwm, duty_ns, CRC_PMIC_PWM_PERIOD_NS);
+	pwm_config(panel->backlight.pwm, duty_ns,
+		   panel->backlight.pwm_period_ns);
 }
 
 static void
@@ -1917,6 +1916,9 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 		return -ENODEV;
 	}
 
+	panel->backlight.pwm_period_ns = NSEC_PER_SEC /
+					 get_vbt_pwm_freq(dev_priv);
+
 	/*
 	 * FIXME: pwm_apply_args() should be removed when switching to
 	 * the atomic PWM API.
@@ -1926,9 +1928,10 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 	panel->backlight.min = 0; /* 0% */
 	panel->backlight.max = 100; /* 100% */
 	level = intel_panel_compute_brightness(connector, 100);
-	ns = DIV_ROUND_UP(level * CRC_PMIC_PWM_PERIOD_NS, 100);
+	ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
-	retval = pwm_config(panel->backlight.pwm, ns, CRC_PMIC_PWM_PERIOD_NS);
+	retval = pwm_config(panel->backlight.pwm, ns,
+			    panel->backlight.pwm_period_ns);
 	if (retval < 0) {
 		drm_err(&dev_priv->drm, "Failed to configure the pwm chip\n");
 		pwm_put(panel->backlight.pwm);
@@ -1937,7 +1940,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 	}
 
 	level = DIV_ROUND_UP(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
-			     CRC_PMIC_PWM_PERIOD_NS);
+			     panel->backlight.pwm_period_ns);
 	panel->backlight.level =
 		intel_panel_compute_brightness(connector, level);
 	panel->backlight.enabled = panel->backlight.level != 0;
-- 
2.26.2

