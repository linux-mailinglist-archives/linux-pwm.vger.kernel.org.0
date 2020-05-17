Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357BF1D6BEB
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgEQTCA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTB7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:01:59 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5334DC061A0C;
        Sun, 17 May 2020 12:01:59 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 82so6130485lfh.2;
        Sun, 17 May 2020 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XV8ji1IDXAzgoqiTjEkmwRFdCjcd4KoRPZRb8vwPSkM=;
        b=CPPI6Nv0NmK6Jgf2qWm7LYYc+OuCbj2lFpHs1PWenFVqPIVubsIY83GZvYfeDuppos
         UkKB3SeT6wmalj7wHr0oN6C1ufkJOkyXOcJqgi8JvXafMrk3IxyVYUBqxIQpxz8M1BRu
         m8uCTaCRadc6URt5l2kNGHcofVYu/BUShyR2qfoPk/5F4JHzLNg2Hy9fS7252RoAuqYv
         mAvgo0uEuHFzYcTcs6oom0VuAihNXBJ7jfkOIP555X56lPxO72xF3KeO2fxuRVY6QiHH
         qzbbyIMyEa1FaULMciY+6rD5k6LCqb1L9z4LhPk6eQmA3GTSvgWlPfUZ1OSAt8aimkDl
         P/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XV8ji1IDXAzgoqiTjEkmwRFdCjcd4KoRPZRb8vwPSkM=;
        b=G0ATi/zZ6HNqZrutTC6XnVfieidB5ybFvrExc5ZkBwGtSqybiA9JbddyVhSRR38Cw6
         TNv5ulRvEZKCrsbIN4j10cbdHTTZMR40sdona5XlS471IgIM0iypVIhCqLhCqX45U8H6
         PEki9q8G45KmtsKaJwyeani3T9EGFzV0MfMDJunoCyCf/9yyztYVXl/3Hb8lmwYSKIAU
         K3L0kqBrqzutC6OyrQEsbd8Yr5t0vMCgEFjGIiQRIuZkewWvrmxzaFt1RV5sPacalV/e
         dE5BuD4Zd5L3n7kkit68ggloe9gZiUpW6E77QfTeQOIjOpcaQQPMikcK4X132S2Z8ny7
         JTOg==
X-Gm-Message-State: AOAM531MN+zZwIQ+v1tSpKOa5yY5IjYa/8jXh9JFbX987h96xYfA6NOz
        GLdIYqIxkveS5OxDHOGxHgQ=
X-Google-Smtp-Source: ABdhPJxELt7Vi9287IQwgCidWZHrUTSvjwrWfyZWE3Fzz5jgr5WONsYAndwhLNaQsrNw5sDoIgf/1g==
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr9221349lfg.150.1589742117777;
        Sun, 17 May 2020 12:01:57 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:01:57 -0700 (PDT)
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
Subject: [PATCH v2 04/16] backlight: improve backlight_ops documentation
Date:   Sun, 17 May 2020 21:01:27 +0200
Message-Id: <20200517190139.740249-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_ops and
adapt it to kernel-doc style.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 60 +++++++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index a0a083b35c47..519dc61ce7e4 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -55,19 +55,67 @@ enum backlight_scale {
 struct backlight_device;
 struct fb_info;
 
+/**
+ * struct backlight_ops - backlight operations
+ *
+ * The backlight operations are specifed when the backlight device is registered.
+ */
 struct backlight_ops {
+	/**
+	 * @options:
+	 *
+	 * The options parameter is used to adjust the behaviour of the core.
+	 * Set BL_CORE_SUSPENDRESUME to get the update_status() operation called
+	 * upon suspend and resume.
+	 */
 	unsigned int options;
 
 #define BL_CORE_SUSPENDRESUME	(1 << 0)
 
-	/* Notify the backlight driver some property has changed */
+	/**
+	 * @update_status:
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
+	 * @get_brightness:
+	 *
+	 * Return the current backlight brightness.
+	 * The driver may implement this as a readback from the HW.
+	 * This operation is optional and if not present then the current brightness
+	 * property value is used.
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
+	 * @check_fb:
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

