Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BF3B1D6BEE
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgEQTCC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:02 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A21C061A0C;
        Sun, 17 May 2020 12:02:02 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h188so6120065lfd.7;
        Sun, 17 May 2020 12:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2OyaYsRmUmiUCUJvfITROQWLR97jO+0C0lYl9AH4WQU=;
        b=sd5HbQvPYXGthPeXNT11+XC5IhL8tbrEv/tlpWGQWuboEtz8ooQZ/w/i2X1nXpuJ/w
         r3uus8JDr37mS9l1TO2Tzf/YwFvPIJuZFBnCr3y3xtQjnPHuhEZ7vrX4TYRV5L4uJKqW
         14kVX8mzHfgNDFkFSlhM8tG1sadfn0FZkdsWfhVVoMkXz2A8OtsVK7e92kP7sVxcnUEj
         KpnUYTqobTSk1CHA4yhFpmRk9IdPJyrHJVd+pm2rLfAKtmS/wJ1fN1Bz0RXPOeoxz8F9
         LY42Vc24W2BShHMZV9aiWEB0yYP1dwTphg+nrJYvhe7DwG0YkWeylaLBD3ZCqJ87Ow0G
         JC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2OyaYsRmUmiUCUJvfITROQWLR97jO+0C0lYl9AH4WQU=;
        b=Y95ybZPNUmxFWwwSlw2NYVYdKG1z0tEiufylMtfnzRxhJU3I2A3OhqJRZn7o+xIQ7r
         9DMAuvtPFRslQVgR/KCcwnvrXhaJeRXDThEhBI5fLsRInZVUuPTSP2plqmK6S4fGaYfZ
         p+HkNUulSw0rlj/jcMDLuCkJ774J8S6aDFRSvdYfAtdwGIKMPqeq9mSQcv6flsOegScD
         hnYfPZ6XB8vHST2z50moNU9y0sfR0b1tB33WAq9WOraAFT5kcN3pUFaoEIKnlTQplrPc
         3PBL8TvjZ59a0zMvQ9AFwXh9zc59T0VPXVSZcp7Ylzb7UMgisd9oG+FMQP9xSdhMLEyv
         10Mw==
X-Gm-Message-State: AOAM532ShX0ybyP0lq6gYmYOOQLLXy/0aQ8oHjU4BJXCyOee4FfJjtjU
        DYnqzodA46cdjH1SH+CrVRTukqpKGlM=
X-Google-Smtp-Source: ABdhPJwtH/nrY4fYZN9bngE/KOq8tn+zlHFgPBjISYbmUybw4qvIbTRjRsnxPXL0IdqN9jk3hvN7iw==
X-Received: by 2002:a05:6512:3082:: with SMTP id z2mr9189578lfd.32.1589742120583;
        Sun, 17 May 2020 12:02:00 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:00 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        patches@opensource.cirrus.com,
        Russell King <linux@armlinux.org.uk>,
        Sam Ravnborg <sam@ravnborg.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v2 05/16] backlight: improve backlight_properties documentation
Date:   Sun, 17 May 2020 21:01:28 +0200
Message-Id: <20200517190139.740249-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_properties and
adapt it to kernel-doc style.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 101 +++++++++++++++++++++++++++++++++-----
 1 file changed, 90 insertions(+), 11 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 519dc61ce7e4..7f9cef299d6e 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -118,28 +118,107 @@ struct backlight_ops {
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
+	 * @brightness:
+	 *
+	 * The current requested brightness by the user.
+	 * The backlight core makes sure the range is (0 - max_brightness)
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
+	 * @max_brightness:
+	 *
+	 * The maximum brightness value.
+	 *
+	 * This value must be set in the backlight_properties passed
+	 * to devm_backlight_device_register().
+	 *
+	 * This property must not be modified by a driver except
+	 * before registering the backlight device as explained above.
+	 */
 	int max_brightness;
-	/* Current FB Power mode (0: full on, 1..3: power saving
-	   modes; 4: full off), see FB_BLANK_XXX */
+
+	/**
+	 * @power:
+	 *
+	 * The current power mode. User space configure the power mode using
+	 * the sysfs attribute: /sys/class/backlight/<backlight>/bl_power
+	 * When the power property is updated update_status() is called.
+	 *
+	 * The possible values are: (0: full on, 1..3: power saving
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
+	 * @fb_blank:
+	 *
+	 * When the FBIOBLANK ioctl is called fb_blank is set to the
+	 * blank parameter and the update_status() operation is called.
+	 *
+	 * When the backlight device is enabled @fb_blank is set
+	 * to FB_BLANK_UNBLANK. When the backlight device is disabled
+	 * @fb_blank is set to FB_BLANK_POWERDOWN.
+	 *
+	 * This property must not be modified by a driver.
+	 * The backlight driver shall never read this variable,
+	 * as the necessary info is avaialble via the state.
+	 *
+	 * fb_blank is deprecated and will be removed.
+	 */
 	int fb_blank;
-	/* Backlight type */
+
+	/**
+	 * @type:
+	 *
+	 * The type of backlight supported.
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
+	 * @state:
+	 *
+	 * The state property is used to inform drivers of state changes
+	 * when the update_status() operation is called.
+	 * The state is a bitmask. BL_CORE_FBBLANK is set when the display
+	 * is expected to be blank. BL_CORE_SUSPENDED is set when the
+	 * driver is suspended.
+	 *
+	 * This property must not be modified by a driver.
+	 */
 	unsigned int state;
-	/* Type of the brightness scale (linear, non-linear, ...) */
-	enum backlight_scale scale;
 
 #define BL_CORE_SUSPENDED	(1 << 0)	/* backlight is suspended */
 #define BL_CORE_FBBLANK		(1 << 1)	/* backlight is under an fb blank event */
 
+	/**
+	 * @scale:
+	 *
+	 * The type of the brightness scale (linear, non-linear, ...)
+	 */
+	enum backlight_scale scale;
 };
 
 struct backlight_device {
-- 
2.25.1

