Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56B1B1E9E7E
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgFAGw1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGw0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:26 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53759C061A0E;
        Sun, 31 May 2020 23:52:26 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so6770184ljn.4;
        Sun, 31 May 2020 23:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgQFgo3RHYwmcB8tP1uDfvnC0G/9E3cMrWKRfBK9IL8=;
        b=FB8sUWHtOWot1aPy7v97jwE2MCN9TFsZ8Uzu9Z2YTCLVknO+bXcp3uJkdWR2fGuHs8
         ZWssNLxEldBQUfhYGP9t1ThPGqRMwdelU3gewbV3Rftyl9AAetV3O4zpyk8PPHf2QCZ5
         xNA7J6x6lk8QJrfOpVkNWjPfi3sXMAl1cVzqbbZurLhdkXvGsIh4A0AabGXW0yNUB/uu
         AvlqROHPpoYOwtV2h4TlIO7iJWcsAqfKczoGhIiw+uX3BsBm5DnRLmSy3/fbwWyY1CwX
         l45bKiFfSZbWa14DxgOYoXGnnpi4EinY4CzhASM382I0RrBG1IO9r1D5wH2KlqfmYfqM
         j2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wgQFgo3RHYwmcB8tP1uDfvnC0G/9E3cMrWKRfBK9IL8=;
        b=r8BqBsMM5xOmC6HYXFbxDGiYX4whgaKQdC26B33pRpDdY0sUkI+P7rj9ybGgKI2ozu
         U06kB9ZAUjuwBTjWt2gISITUQYVDJPVejJdde31QEGotqbhgu+oulLPHfW5Opw+InL6J
         TTi69+X1jDA9gkfVLYeWAPQuZnucA26RmtfB5ldi2SUPXcysb1CpPkFCjeRU+YJ9+BSv
         FhVpOWM7F6tzEFJfrxYTFPp+CtnG3Gz3XAB0BtkAYw2MPItobaMj1myIh4/lLnMJHJVo
         1XjqQn0KT4ZmmIO7wTckdVo5bWJEROAM2XQ3X9CB4WykDV37m27QXqbSCGFQLYBiDKLO
         ByrA==
X-Gm-Message-State: AOAM532vktNhY4dVcGtBNOfHQbxfiQWtN5aU27yFPNxYufdh0RkAIorv
        8nsG9TLTPXip8ND8TzH5ndc=
X-Google-Smtp-Source: ABdhPJzYtFLljsRs6Mh3pY4A40UVOWi60Y4AkVBMEcmu4THO7pQ00+38XavNrIHuVeGK1VbdGJyydg==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr5192012ljj.278.1590994344766;
        Sun, 31 May 2020 23:52:24 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:24 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v3 04/13] backlight: improve backlight_properties documentation
Date:   Mon,  1 Jun 2020 08:51:58 +0200
Message-Id: <20200601065207.492614-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_properties and
adapt it to kernel-doc style.

v2:
  - Added into for each field (Daniel)
  - Re-written some parts to explain what to do, rather
    than what not to do.
    Partly based on suggestions from the review (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 96 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index b6c1ab6c922a..69a20da03035 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -117,28 +117,102 @@ struct backlight_ops {
 	int (*check_fb)(struct backlight_device *bd, struct fb_info *info);
 };
 
-/* This structure defines all the properties of a backlight */
+/**
+ * struct backlight_properties - backlight properties
+ *
+ * This structure defines all the properties of a backlight.
+ */
 struct backlight_properties {
-	/* Current User requested brightness (0 - max_brightness) */
+	/**
+	 * @brightness: The current brightness requested by the user.
+	 *
+	 * The backlight core makes sure the range is (0 to max_brightness)
+	 * when the brightness is set via the sysfs attribute:
+	 * /sys/class/backlight/<backlight>/brightness.
+	 *
+	 * This value can be set in the backlight_properties passed
+	 * to devm_backlight_device_register() to set a default brightness
+	 * value.
+	 */
 	int brightness;
-	/* Maximal value for brightness (read-only) */
+
+	/**
+	 * @max_brightness: The maximum brightness value.
+	 *
+	 * This value must be set in the backlight_properties passed to
+	 * devm_backlight_device_register() and shall not be modified by the
+	 * driver after registration.
+	 */
 	int max_brightness;
-	/* Current FB Power mode (0: full on, 1..3: power saving
-	   modes; 4: full off), see FB_BLANK_XXX */
+
+	/**
+	 * @power: The current power mode.
+	 *
+	 * User space can configure the power mode using the sysfs
+	 * attribute: /sys/class/backlight/<backlight>/bl_power
+	 * When the power property is updated update_status() is called.
+	 *
+	 * The possible values are: (0: full on, 1 to 3: power saving
+	 * modes; 4: full off), see FB_BLANK_XXX.
+	 *
+	 * When the backlight device is enabled @power is set
+	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
+	 * @power is set to FB_BLANK_POWERDOWN.
+	 */
 	int power;
-	/* FB Blanking active? (values as for power) */
-	/* Due to be removed, please use (state & BL_CORE_FBBLANK) */
+
+	/**
+	 * @fb_blank: The power state from the FBIOBLANK ioclt.
+	 *
+	 * When the FBIOBLANK ioctl is called fb_blank is set to the
+	 * blank parameter and the update_status() operation is called.
+	 *
+	 * When the backlight device is enabled @fb_blank is set
+	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
+	 * @fb_blank is set to FB_BLANK_POWERDOWN.
+	 *
+	 * Backlight drivers should avoid using this property. It has been
+	 * replaced by state & BL_CORE_FBLANK (although most drivers should
+	 * use backlight_is_blank() as the preferred means to get the blank
+	 * state).
+	 *
+	 * fb_blank is deprecated and will be removed.
+	 */
 	int fb_blank;
-	/* Backlight type */
+
+	/**
+	 * @type: The type of backlight supported.
+	 *
+	 * The backlight type allows userspace to make appropriate
+	 * policy desicions based on the backlight type.
+	 *
+	 * This value must be set in the backlight_properties
+	 * passed to devm_backlight_device_register().
+	 */
 	enum backlight_type type;
-	/* Flags used to signal drivers of state changes */
+
+	/**
+	 * @state: The state of the backlight core.
+	 *
+	 * The state is a bitmask. BL_CORE_FBBLANK is set when the display
+	 * is expected to be blank. BL_CORE_SUSPENDED is set when the
+	 * driver is suspended.
+	 *
+	 * backlight drivers are excpected to use backlight_is_blank()
+	 * in their update_status() operation rather than reading the
+	 * state property.
+	 *
+	 * The state is maintained by the core and drivers may not modify it.
+	 */
 	unsigned int state;
-	/* Type of the brightness scale (linear, non-linear, ...) */
-	enum backlight_scale scale;
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
 
+	/**
+	 * @scale: The type of the brightness scale.
+	 */
+	enum backlight_scale scale;
 };
 
 struct backlight_device {
-- 
2.25.1

