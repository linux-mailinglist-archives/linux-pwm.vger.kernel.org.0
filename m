Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 322B6213F69
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGCSqL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE98C061794;
        Fri,  3 Jul 2020 11:46:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id o4so19046340lfi.7;
        Fri, 03 Jul 2020 11:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IVQg6N9Y7IT+7TfYzwS4f6zi+ddclNT7W4+DeE2wDo=;
        b=NN0cF9PcXBtt5ay+WTZ71waV5oPagPhgRWuVg7vbghnZ6i5YM5Re+IGejakQTtnmpm
         1t0DuQJ4FdwcWhZxHPKkInyIhxys8OAYMv+vJ7eISf33Oy3E41Big2T+T41oXJyRX1eB
         JktCqfQoZtFje5t/bocmLZNm6vE4XrNISrS55nH3VlIktDKm1/+pDCA03NOhvcoj/7KV
         Cp8bHHRMdWehBhYbjpM9LC/Rgpi0zF8dayMGJK0zURWeBVAQIS8za2L9hxBLT8iFD/oI
         c5SXHtPHIAprvz+8WQh/Whch7xVPggIpuMQh9LFsRhS4EY/DOiayCWxuVIcV9O5UMLN6
         Mpng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7IVQg6N9Y7IT+7TfYzwS4f6zi+ddclNT7W4+DeE2wDo=;
        b=pgE/IaNttXp+XU59fLMSMYge6CFF7LP//FWzTsxDJMh0HOJdr7sr6+86uY5YGbGwMK
         e6cUVUN2hUrytyNd3CQYMzkAySJ5rSrJkXFqkFQ9hYovKBETvSFzWmOAZ+mEkp9z4cgZ
         zjmCyRhpQHaAR3s9Lj1nKmfe6CxcS5++3M4TurPVjwfYdX3OFcCntate5RpOajL/ouM7
         +NctH9JICKH5yQHWwmkKHTW7X8G0yP1DQr1XDfyka5DMeiUN4Qkj5i2bDgHpdjvmzQ0d
         hdm6fFcmAPM8H13CI2jlwVYF45N979Qwi75SHQmIO4p4DL5gZRCdVQsVanAZLRt8+rOM
         ZHFw==
X-Gm-Message-State: AOAM531GacW6phwMUsNj615258sU4A6ldeWA6XL4UsWN4FLuBPATeysi
        aaTJrMUub5qZ66/h4dlrO6E=
X-Google-Smtp-Source: ABdhPJzceajSEflpyNDbvmbQ5SE9lYyuwdyQ3ujHp2eBq+Gvz2qzAiPY5DvHTg24oWc7pxGMT9Y9hA==
X-Received: by 2002:ac2:508d:: with SMTP id f13mr8858766lfm.65.1593801968942;
        Fri, 03 Jul 2020 11:46:08 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:08 -0700 (PDT)
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
Subject: [PATCH v4 03/20] backlight: improve backlight_ops documentation
Date:   Fri,  3 Jul 2020 20:45:29 +0200
Message-Id: <20200703184546.144664-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_ops and
adapt it to kernel-doc style.

v2:
  - Add intro for each field (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 56e51ebab740..dfb43ee02ea0 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -55,19 +55,66 @@ enum backlight_scale {
 struct backlight_device;
 struct fb_info;
 
+/**
+ * struct backlight_ops - backlight operations
+ *
+ * The backlight operations are specifed when the backlight device is registered.
+ */
 struct backlight_ops {
+	/**
+	 * @options: Configure how operations are called from the core.
+	 *
+	 * The options parameter is used to adjust the behaviour of the core.
+	 * Set BL_CORE_SUSPENDRESUME to get the update_status() operation called
+	 * upon suspend and resume.
+	 */
 	unsigned int options;
 
 #define BL_CORE_SUSPENDRESUME	(1 << 0)
 
-	/* Notify the backlight driver some property has changed */
+	/**
+	 * @update_status: Operation called when properties have changed.
+	 *
+	 * Notify the backlight driver some property has changed.
+	 * The update_status operation is protected by the update_lock.
+	 *
+	 * The backlight driver is expected to use backlight_is_blank()
+	 * to check if the display is blanked and set brightness accordingly.
+	 * update_status() is called when any of the properties has changed.
+	 *
+	 * RETURNS:
+	 *
+	 * 0 on sucees, negative error code if any failure occured.
+	 */
 	int (*update_status)(struct backlight_device *);
-	/* Return the current backlight brightness (accounting for power,
-	   fb_blank etc.) */
+
+	/**
+	 * @get_brightness: Return the current backlight brightness.
+	 *
+	 * The driver may implement this as a readback from the HW.
+	 * This operation is optional and if not present then the current
+	 * brightness property value is used.
+	 *
+	 * RETURNS:
+	 *
+	 * A brightness value which is 0 or a positive numer.
+	 * On failure a negative error code is returned.
+	 */
 	int (*get_brightness)(struct backlight_device *);
-	/* Check if given framebuffer device is the one bound to this backlight;
-	   return 0 if not, !=0 if it is. If NULL, backlight always matches the fb. */
-	int (*check_fb)(struct backlight_device *, struct fb_info *);
+
+	/**
+	 * @check_fb: Check the framebuffer device.
+	 *
+	 * Check if given framebuffer device is the one bound to this backlight.
+	 * This operation is optional and if not implemented it is assumed that the
+	 * fbdev is always the one bound to the backlight.
+	 *
+	 * RETURNS:
+	 *
+	 * If info is NULL or the info matches the fbdev bound to the backlight return true.
+	 * If info does not match the fbdev bound to the backlight return false.
+	 */
+	int (*check_fb)(struct backlight_device *bd, struct fb_info *info);
 };
 
 /* This structure defines all the properties of a backlight */
-- 
2.25.1

