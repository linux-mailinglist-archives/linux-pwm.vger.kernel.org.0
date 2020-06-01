Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06D611E9E7C
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFAGwY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGwY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16648C061A0E;
        Sun, 31 May 2020 23:52:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so6773174ljp.3;
        Sun, 31 May 2020 23:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Sfwu+QYJQXZ27WkGs9nXQTR3LioIzX0uzeUzjF2u24=;
        b=lHZrAwhUA9ZqnUgZgH1Uy8rPayRa8+BTvae7rSKE/cCa3u7kO5sWAq9xUYPl0Ke4Lr
         vtDnJ1QOX71BFFBG5IEiRda0pFP45GOr3rfOevTOf9dGjdPIpA6cODMDfRiVJDAFm2lw
         UETyEg7wFFOygA5/Owq7S0CRF3F4MUgfoQ1/DRA1h5zh6N0f0FxGTw0jREkc97L4dv89
         8rMTLcspJBO5HBc/Sq6UjpCZ6GmIe8Bf7qyAAc05F7sFfSlSig6c1xhbprA0T+smHr2K
         kIru4fB5iXgftMdzZFZNSIm1AFAk8biSle6XgWDB7HU7moXWhSB/qddLZJLDgGpQP1Qi
         t3bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=8Sfwu+QYJQXZ27WkGs9nXQTR3LioIzX0uzeUzjF2u24=;
        b=q/bxvfKB5toYO1E3p0WK3kGk7HHQevjRH9Fm+jk8QU5xnSTDPhfTfhFSE1K5Cl4v8u
         5KE3TfmnOgKtNUR9rLdJ++FwoSk7m95BBSep1X8HmCb3YHp6KxdoCP/3Ube4fsnctvfi
         /k6DQMaZD9LUFVq5XU1Ptu6z6iUC8Hsqa/zzUmf7uK3uhWTDb7Xb80Jy4uUxXGiflhDb
         smuWIKlTa0ZmSXxk4083rC0SQRynBNDgmN6syIzQgP8Hv8/74jYMpY4aV9iuF8OvvwN9
         w/rqOuCTWdnTozj3EgxsmBawkgrtOhpHXYTj9SRWe5+sBVl7In+iFJWkPooTn4WnU6Mt
         1DgQ==
X-Gm-Message-State: AOAM531Mz+z1AWQoaQtQ/DoDaqFh9KA7Sz5Tcb0TibmPOSPsthfT2qMd
        /apWmYb1L0Z2Atcqsn8YoIs=
X-Google-Smtp-Source: ABdhPJxYPLRO1ryCQRr5AV72Ht6tCVngauJZ8/BPYmkzbfRWcgO0pHV8+nxu8ltid+CauVRtj5x2gw==
X-Received: by 2002:a2e:b8ce:: with SMTP id s14mr2045697ljp.89.1590994342576;
        Sun, 31 May 2020 23:52:22 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:22 -0700 (PDT)
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
Subject: [PATCH v3 03/13] backlight: improve backlight_ops documentation
Date:   Mon,  1 Jun 2020 08:51:57 +0200
Message-Id: <20200601065207.492614-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
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
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 59 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 6 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index a0a083b35c47..b6c1ab6c922a 100644
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

