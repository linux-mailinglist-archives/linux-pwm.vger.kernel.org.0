Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495CF1D3CE3
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730299AbgENTKk (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728366AbgENTKg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:36 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD0BC061A0C;
        Thu, 14 May 2020 12:10:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 8so3611613lfp.4;
        Thu, 14 May 2020 12:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=62dugcWsovCeCskk/LKWdY/i7tcZK4WDkmw+PPDUYp0=;
        b=hmEzwt90DZ7x99DPyRV6/hvrG2vuVWtFc62KnUO3UBwXxpBa4RO+CO0Yd4cwPS1GPU
         PsZhmR/YGuJbKV1hs5Ah0j2oll5bCnbp+SJLk4CiL76I9JpIYfKvDGXMs410dHKyLFVV
         2QFgL0oKBOSbKK5nfGLrWpfz1AzvNAuWO2G7nlYD1KwjaqZd6efLZLTcWEg6kdCXkq/y
         d08f96AQ7fGekUXvVfIVuvX7qjp3qfJaEa7Nry04lPM8p5aJDuJJoZAX19OX4qydbEH3
         ewBrwT57tPyR9qdrYGwCDHi59X+F8Z/b5cpdzF83DmfGG6VIgbzDjX0u/NH0SbSfxZP5
         d1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=62dugcWsovCeCskk/LKWdY/i7tcZK4WDkmw+PPDUYp0=;
        b=ou4zDtqeRekqF0a/23E7a/ESb3To92FBWH/ydiGEKo76ih/gRuWQSkCyVhMZIBXVTB
         HvZZiETWKV6IiAo/mKTUzPpFqtaqNsiR5nshIFFIGwLMEG3eRsGk+FoLQGwhhTL5QB24
         w9F6to8LivyvG+7YeYvNksgJ1ReiSY/YmkCY/MtNsaqkeHB4TZlSBf2bf0jUnpLDV98u
         9s1yPen9eNC5uigHX08V38X8W+gXciYixXNUKRhss47NQ1H0lxDh/rNbG26CpLO+aqwH
         k7ugjA77Feo6e/ftiYObQU8/tgPbTXyBL3EfSqAi6AruQJunD1UqdHyGxDcGIkEuklhj
         1lCQ==
X-Gm-Message-State: AOAM530xR6M9Dqz9CbFWkZ+YkSsjnw31fgZNDSVO+ate4xAcJbJS1VCx
        8u2z43O2h32xHR27gWHAzgg=
X-Google-Smtp-Source: ABdhPJw+1WHsEHe6VbX3gtcUnN10QNwuwD64Zx0hRMjc16fHurTG/QV6aCvAhZrWJ1MOCzc4ALaROA==
X-Received: by 2002:ac2:4da1:: with SMTP id h1mr4242794lfe.152.1589483434518;
        Thu, 14 May 2020 12:10:34 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:33 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Allison Randal <allison@lohutok.net>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        Zheng Bin <zhengbin13@huawei.com>
Subject: [PATCH v1 09/18] backlight: improve backlight_ops documentation
Date:   Thu, 14 May 2020 21:09:52 +0200
Message-Id: <20200514191001.457441-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
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
index e67e926de1e2..51f0d0abea25 100644
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

