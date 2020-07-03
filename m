Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE714213F6C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgGCSqN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:12 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF41C061794;
        Fri,  3 Jul 2020 11:46:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f5so22205755ljj.10;
        Fri, 03 Jul 2020 11:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nbqgxv/h5SeSHOXMolpp1BPamIvzkqESgLDvhPwqMhU=;
        b=aUrQbKZdkhxD1Dd4uBn5ucmlkFRreyu98hbK7o3nUJZwjsPOawXWWS3FA7FkPHM25i
         t+C8U4CEYx2Yg5LL/Vs9FGMuAvPEf1RTdiSrn8EvyIxw0IQmpmxWlfxR5tK5D36ezspC
         VqkBZ7eiUJKfCW88KNSRS0JtIBAGLD+KKpPMpyDTOFfUI3wCZx+MfDnHO+YMtMp9i4fN
         Ym/N7AHLblWfueGGKW8aszqrB0bYioGSbtVSsrZUvIdOTEhWfUqmBaNpQS3xmKxDUouD
         ar0ODZlYti3Y9E2NBZ9hkIJC24AyseEOkN1Vjxc+BfGlvVCtCHe8yNYEqFXWa0z/3Zbx
         aNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nbqgxv/h5SeSHOXMolpp1BPamIvzkqESgLDvhPwqMhU=;
        b=kLai0/cagnB1bgrhXAinzdYjWMaxlkOxCzCP2sUtuJL/RT90yvzjp9axlqV6uH2Ust
         kXQvbFcN8qWEy2zYjxtSJlbUHXiiIL9xyII7uxnYnNLRwFtPR6H1nIplZSr1Oj8Xja3P
         n5F/wTnt5EFXre9HyFGp0vrNelGqJ9+he4X9qG/M3hbJ/LCXVQgiReEyaF5Cz4ZpVzpH
         MUY09NDT+YbZH6D2J2DufxJjySnozKHM1mdsHmOgwLb51K11N28Lm+w9yVz6Av5VCY+v
         /HCN9RYanlk7YK6qzTjnHZm1b31de2ZEg518L2BEqNNN683gf+dfvr9tS9rBvlopsIVh
         HVQA==
X-Gm-Message-State: AOAM533cJPoUV6dotGr1KA/B2yAKNItN9IZmWFPvtNSk+DsCp5iXBXXC
        LAPYrMFiyDe1tF5EZWcBTUU=
X-Google-Smtp-Source: ABdhPJyB2KLbGvSFYJK9M08dD+WetXzOuCGvcnziBRnn8Uhx16R3/LsaKsRHnGUZi1/20iEoXXzyoQ==
X-Received: by 2002:a2e:8804:: with SMTP id x4mr20595944ljh.56.1593801971005;
        Fri, 03 Jul 2020 11:46:11 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:10 -0700 (PDT)
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
Subject: [PATCH v4 04/20] backlight: improve backlight_properties documentation
Date:   Fri,  3 Jul 2020 20:45:30 +0200
Message-Id: <20200703184546.144664-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_properties and
adapt it to kernel-doc style.

v3:
  - Added missing '@' in kernel-doc

v2:
  - Added into for each field (Daniel)
  - Re-written some parts to explain what to do, rather
    than what not to do.
    Partly based on suggestions from the review (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 96 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 11 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index dfb43ee02ea0..10518b00b059 100644
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
+	 * When the FBIOBLANK ioctl is called @fb_blank is set to the
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

