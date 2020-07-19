Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BB4225088
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgGSIIJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:09 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC83DC0619D2;
        Sun, 19 Jul 2020 01:08:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f5so17026125ljj.10;
        Sun, 19 Jul 2020 01:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IVQg6N9Y7IT+7TfYzwS4f6zi+ddclNT7W4+DeE2wDo=;
        b=i0E8gCL48VpYyuEGykDhenbE3iBlRnlQ5FR4r7PXKxUOUAe0muJPVupH9d/Fk+n325
         v5wig+bRKhZbAE10i+qkAgv0dyz6FZ5SLpA+MQzKOHFFmBCinyTtvZ2QjRWoyR/DwvEG
         yqLPjaOPDDSXcPvBPby1psHUWpgu3J8GQmbRxesQMcPAr90bf2wH74rMmyeTywwiDslS
         nn+HZ5RevlFCafij8xAC49Y4CornFojE+GgwsYwXRUQ600kXJRhP/r12OmX2JF2BEA/K
         jFPIAWHf70NeowfroGq5i42WVJxmD6GUx1i07ugPoDwhXwvvrI+m8Nbk3h1znbAN0bu7
         PMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7IVQg6N9Y7IT+7TfYzwS4f6zi+ddclNT7W4+DeE2wDo=;
        b=E1xgIi2fbr28hYer8DbN5SSjmS1M2ww/qv7WhHKARG72NfocDPBrtKElCzdJQvFnk0
         mi09l4nBFT305CYJ7cmcSBrIg6KUaglCvHZQmXFZt1kep+0eqaDxVvzethxl0mWY5FtO
         O55I2Pcvyz7kQl4m8EVs77hXXrfzeSk81NXnAK25IjGB1iuoMZzoVqnCeM7oQQ4zSqu9
         KKQ1KCGKUfTwQIGGgy10KjSqfzPW0yR3ZHDc0RTg3qji/LNcvL0YeSgm45+iD6MRgoNM
         xu0rw/2TxZCgeN4ohcDAhYEtPYPpY/67jOPiztL/QwHnMAzPU0RJEMHHQ5ZtR9fnzDe2
         tpuw==
X-Gm-Message-State: AOAM530VxXpRKD3K+oo6vhnDGfA48SpNy4oTYxqIVIt60sOfXQkPJ6Ml
        JYnPkEUr/1eW84yWuNPS/lI=
X-Google-Smtp-Source: ABdhPJxDEQw9zqp/E7cibISbe2kJD9a7+oyRLBO2wfiqQnoW5MHIuyj/0dlgQ4dS3nSDsdxFf/JRcw==
X-Received: by 2002:a2e:8199:: with SMTP id e25mr7189788ljg.307.1595146087170;
        Sun, 19 Jul 2020 01:08:07 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:06 -0700 (PDT)
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
Subject: [PATCH v5 03/19] backlight: improve backlight_ops documentation
Date:   Sun, 19 Jul 2020 10:07:27 +0200
Message-Id: <20200719080743.8560-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
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

