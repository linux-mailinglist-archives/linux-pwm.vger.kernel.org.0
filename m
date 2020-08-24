Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D39624FD64
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Aug 2020 14:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgHXMDC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Aug 2020 08:03:02 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49292 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726075AbgHXMDB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Aug 2020 08:03:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598270579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=puAmXDd6EiL8rTF6O9zpnbNaLdjyvCdTVvw0Dd1y4KM=;
        b=ChdAc9UBa4ncfTCK0TZc9nPlesziPpom3HiMG9ECrzNyVlRcJ9DEoA4so/Al5HIAEWXgIl
        ycDbidXi9ObhepXb0dgMNJybRHHS2V0JzQed1+ZHbIKElPeXjFwsTMcBlwwlhrdwbUy0hQ
        lObbGDKSPyoSk/cMBDc6jKG16GkrMd8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-q8POy85FPpiMyb4FePkyAQ-1; Mon, 24 Aug 2020 08:02:54 -0400
X-MC-Unique: q8POy85FPpiMyb4FePkyAQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A663518A224A;
        Mon, 24 Aug 2020 12:02:52 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-113-147.ams2.redhat.com [10.36.113.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBA385D9DD;
        Mon, 24 Aug 2020 12:02:44 +0000 (UTC)
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
Subject: [PATCH v6 16/16] drm/i915: panel: Use atomic PWM API for devs with an external PWM controller
Date:   Mon, 24 Aug 2020 14:01:26 +0200
Message-Id: <20200824120126.7116-17-hdegoede@redhat.com>
In-Reply-To: <20200824120126.7116-1-hdegoede@redhat.com>
References: <20200824120126.7116-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Now that the PWM drivers which we use have been converted to the atomic
PWM API, we can move the i915 panel code over to using the atomic PWM API.

The removes a long standing FIXME and this removes a flicker where
the backlight brightness would jump to 100% when i915 loads even if
using the fastset path.

Note that this commit also simplifies pwm_disable_backlight(), by dropping
the intel_panel_actually_set_backlight(..., 0) call. This call sets the
PWM to 0% duty-cycle. I believe that this call was only present as a
workaround for a bug in the pwm-crc.c driver where it failed to clear the
PWM_OUTPUT_ENABLE bit. This is fixed by an earlier patch in this series.

After the dropping of this workaround, the usleep call, which seems
unnecessary to begin with, has no useful effect anymore, so drop that too.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v6:
- Drop the pwm_get_period() check in pwm_setup(), it is now longer needed
  now that we use pwm_get_relative_duty_cycle()

Changes in v4:
- Add a note to the commit message about the dropping of the
  intel_panel_actually_set_backlight() and usleep() calls from
  pwm_disable_backlight()
- Use the pwm_set/get_relative_duty_cycle() helpers instead of using DIY code
  for this
---
 .../drm/i915/display/intel_display_types.h    |  3 +-
 drivers/gpu/drm/i915/display/intel_panel.c    | 70 ++++++++-----------
 2 files changed, 33 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 7171e7c8d928..e3ebe7c313ba 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -28,6 +28,7 @@
 
 #include <linux/async.h>
 #include <linux/i2c.h>
+#include <linux/pwm.h>
 #include <linux/sched/clock.h>
 
 #include <drm/drm_atomic.h>
@@ -223,7 +224,7 @@ struct intel_panel {
 		bool util_pin_active_low;	/* bxt+ */
 		u8 controller;		/* bxt+ only */
 		struct pwm_device *pwm;
-		int pwm_period_ns;
+		struct pwm_state pwm_state;
 
 		/* DPCD backlight */
 		u8 pwmgen_bit_count;
diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 6d27630dd1e4..f2b725f85f99 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -592,10 +592,10 @@ static u32 bxt_get_backlight(struct intel_connector *connector)
 static u32 pwm_get_backlight(struct intel_connector *connector)
 {
 	struct intel_panel *panel = &connector->panel;
-	int duty_ns;
+	struct pwm_state state;
 
-	duty_ns = pwm_get_duty_cycle(panel->backlight.pwm);
-	return DIV_ROUND_UP(duty_ns * 100, panel->backlight.pwm_period_ns);
+	pwm_get_state(panel->backlight.pwm, &state);
+	return pwm_get_relative_duty_cycle(&state, 100);
 }
 
 static void lpt_set_backlight(const struct drm_connector_state *conn_state, u32 level)
@@ -669,10 +669,9 @@ static void bxt_set_backlight(const struct drm_connector_state *conn_state, u32
 static void pwm_set_backlight(const struct drm_connector_state *conn_state, u32 level)
 {
 	struct intel_panel *panel = &to_intel_connector(conn_state->connector)->panel;
-	int duty_ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
-	pwm_config(panel->backlight.pwm, duty_ns,
-		   panel->backlight.pwm_period_ns);
+	pwm_set_relative_duty_cycle(&panel->backlight.pwm_state, level, 100);
+	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 }
 
 static void
@@ -841,10 +840,8 @@ static void pwm_disable_backlight(const struct drm_connector_state *old_conn_sta
 	struct intel_connector *connector = to_intel_connector(old_conn_state->connector);
 	struct intel_panel *panel = &connector->panel;
 
-	/* Disable the backlight */
-	intel_panel_actually_set_backlight(old_conn_state, 0);
-	usleep_range(2000, 3000);
-	pwm_disable(panel->backlight.pwm);
+	panel->backlight.pwm_state.enabled = false;
+	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 }
 
 void intel_panel_disable_backlight(const struct drm_connector_state *old_conn_state)
@@ -1176,9 +1173,12 @@ static void pwm_enable_backlight(const struct intel_crtc_state *crtc_state,
 {
 	struct intel_connector *connector = to_intel_connector(conn_state->connector);
 	struct intel_panel *panel = &connector->panel;
+	int level = panel->backlight.level;
 
-	pwm_enable(panel->backlight.pwm);
-	intel_panel_actually_set_backlight(conn_state, panel->backlight.level);
+	level = intel_panel_compute_brightness(connector, level);
+	pwm_set_relative_duty_cycle(&panel->backlight.pwm_state, level, 100);
+	panel->backlight.pwm_state.enabled = true;
+	pwm_apply_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 }
 
 static void __intel_panel_enable_backlight(const struct intel_crtc_state *crtc_state,
@@ -1897,8 +1897,7 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 	struct drm_i915_private *dev_priv = to_i915(dev);
 	struct intel_panel *panel = &connector->panel;
 	const char *desc;
-	u32 level, ns;
-	int retval;
+	u32 level;
 
 	/* Get the right PWM chip for DSI backlight according to VBT */
 	if (dev_priv->vbt.dsi.config->pwm_blc == PPS_BLC_PMIC) {
@@ -1916,35 +1915,28 @@ static int pwm_setup_backlight(struct intel_connector *connector,
 		return -ENODEV;
 	}
 
-	panel->backlight.pwm_period_ns = NSEC_PER_SEC /
-					 get_vbt_pwm_freq(dev_priv);
-
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to
-	 * the atomic PWM API.
-	 */
-	pwm_apply_args(panel->backlight.pwm);
-
 	panel->backlight.max = 100; /* 100% */
 	panel->backlight.min = get_backlight_min_vbt(connector);
-	level = intel_panel_compute_brightness(connector, 100);
-	ns = DIV_ROUND_UP(level * panel->backlight.pwm_period_ns, 100);
 
-	retval = pwm_config(panel->backlight.pwm, ns,
-			    panel->backlight.pwm_period_ns);
-	if (retval < 0) {
-		drm_err(&dev_priv->drm, "Failed to configure the pwm chip\n");
-		pwm_put(panel->backlight.pwm);
-		panel->backlight.pwm = NULL;
-		return retval;
-	}
+	if (pwm_is_enabled(panel->backlight.pwm)) {
+		/* PWM is already enabled, use existing settings */
+		pwm_get_state(panel->backlight.pwm, &panel->backlight.pwm_state);
 
-	level = DIV_ROUND_UP_ULL(pwm_get_duty_cycle(panel->backlight.pwm) * 100,
-				 panel->backlight.pwm_period_ns);
-	level = intel_panel_compute_brightness(connector, level);
-	panel->backlight.level = clamp(level, panel->backlight.min,
-				       panel->backlight.max);
-	panel->backlight.enabled = panel->backlight.level != 0;
+		level = pwm_get_relative_duty_cycle(&panel->backlight.pwm_state,
+						    100);
+		level = intel_panel_compute_brightness(connector, level);
+		panel->backlight.level = clamp(level, panel->backlight.min,
+					       panel->backlight.max);
+		panel->backlight.enabled = true;
+
+		drm_dbg_kms(&dev_priv->drm, "PWM already enabled at freq %lld, VBT freq %d, level %d\n",
+			    NSEC_PER_SEC / panel->backlight.pwm_state.period,
+			    get_vbt_pwm_freq(dev_priv), level);
+	} else {
+		/* Set period from VBT frequency, leave other settings at 0. */
+		panel->backlight.pwm_state.period =
+			NSEC_PER_SEC / get_vbt_pwm_freq(dev_priv);
+	}
 
 	drm_info(&dev_priv->drm, "Using %s PWM for LCD backlight control\n",
 		 desc);
-- 
2.28.0

