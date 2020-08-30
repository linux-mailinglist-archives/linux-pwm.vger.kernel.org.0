Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8AC256DFE
	for <lists+linux-pwm@lfdr.de>; Sun, 30 Aug 2020 15:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728783AbgH3NAu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 30 Aug 2020 09:00:50 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:40615 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728910AbgH3M7F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 30 Aug 2020 08:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598792329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1wMXBHDyyQ6t98T6xFtSD2movAwUy8KekR8cCyDYfqQ=;
        b=eGP52Y4ckPkNMqknN60PYaQ9owoAW8OVlV3eb1rGsnx3GIe56C9qUiP0stz/N3l8wLI9Sx
        iJhASJnc15YIA2T24kU6Qhxd9RLvktKLrL/d1Gzz/A6peKu8f+KfCS+eoR+d283S3v3ryA
        FFGbbztcVToFBrv26fMiwFOjgTGfTHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-cD2kDO3lO5mNHbOuhgplmA-1; Sun, 30 Aug 2020 08:58:43 -0400
X-MC-Unique: cD2kDO3lO5mNHbOuhgplmA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35ED7801AC3;
        Sun, 30 Aug 2020 12:58:41 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-77.ams2.redhat.com [10.36.112.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 760C01A8EC;
        Sun, 30 Aug 2020 12:58:38 +0000 (UTC)
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
Subject: [PATCH v8 14/17] drm/i915: panel: Add get_vbt_pwm_freq() helper
Date:   Sun, 30 Aug 2020 14:57:50 +0200
Message-Id: <20200830125753.230420-15-hdegoede@redhat.com>
In-Reply-To: <20200830125753.230420-1-hdegoede@redhat.com>
References: <20200830125753.230420-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Factor the code which checks and drm_dbg_kms-s the VBT PWM frequency
out of get_backlight_max_vbt().

This is a preparation patch for honering the VBT PWM frequency for
devices which use an external PWM controller (devices using
pwm_setup_backlight()).

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 27 ++++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 4072d7062efd..df7472a3b9f8 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -1543,18 +1543,9 @@ static u32 vlv_hz_to_pwm(struct intel_connector *connector, u32 pwm_freq_hz)
 	return DIV_ROUND_CLOSEST(clock, pwm_freq_hz * mul);
 }
 
-static u32 get_backlight_max_vbt(struct intel_connector *connector)
+static u16 get_vbt_pwm_freq(struct drm_i915_private *dev_priv)
 {
-	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
-	struct intel_panel *panel = &connector->panel;
 	u16 pwm_freq_hz = dev_priv->vbt.backlight.pwm_freq_hz;
-	u32 pwm;
-
-	if (!panel->backlight.hz_to_pwm) {
-		drm_dbg_kms(&dev_priv->drm,
-			    "backlight frequency conversion not supported\n");
-		return 0;
-	}
 
 	if (pwm_freq_hz) {
 		drm_dbg_kms(&dev_priv->drm,
@@ -1567,6 +1558,22 @@ static u32 get_backlight_max_vbt(struct intel_connector *connector)
 			    pwm_freq_hz);
 	}
 
+	return pwm_freq_hz;
+}
+
+static u32 get_backlight_max_vbt(struct intel_connector *connector)
+{
+	struct drm_i915_private *dev_priv = to_i915(connector->base.dev);
+	struct intel_panel *panel = &connector->panel;
+	u16 pwm_freq_hz = get_vbt_pwm_freq(dev_priv);
+	u32 pwm;
+
+	if (!panel->backlight.hz_to_pwm) {
+		drm_dbg_kms(&dev_priv->drm,
+			    "backlight frequency conversion not supported\n");
+		return 0;
+	}
+
 	pwm = panel->backlight.hz_to_pwm(connector, pwm_freq_hz);
 	if (!pwm) {
 		drm_dbg_kms(&dev_priv->drm,
-- 
2.28.0

