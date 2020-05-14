Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D37B1D3CEB
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgENTKo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729158AbgENTKk (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E81C061A0E;
        Thu, 14 May 2020 12:10:40 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v5so3551082lfp.13;
        Thu, 14 May 2020 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w93KHIix1KwNNTaPJvVdVMvh/rS96v+7uJyDQPCp+jo=;
        b=eGDXq2gkkYR9ddSm7q5nNuNKvYqB6zVrH2D2RQC9Xt+MBfpZUUQ7kXef5J1CxCmeNC
         4t4nlDUVE7vNuetbObaCXcZ0N4C4NDzaGgMCdPTYgn1kqv694TEhGr9xtD0qbFNDO7fr
         zloc2SqbsohpuzLpixER84WBHIJCpAa515vPWwaq2CrhO5LFUMSuxfZO+BIX1EdBWMob
         4BhW9wqqDcHJMFd4eA1JkCCyKp5RbdbKU5vH3eYqz/PIZcPEGvwJsfetEAVLvrKeh55X
         X4FKRQDwx+e2gKr6srXsumCcrw7Aa9hQ2qVP8qAfWP2qSaLIRoORwrU6ZZdSVbHtiBCU
         6fgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=w93KHIix1KwNNTaPJvVdVMvh/rS96v+7uJyDQPCp+jo=;
        b=U5/t5+YlxLCEYrPBJB/u6eMKvP1mr9GZv6OfmnHquaGxkpGHzdXimjaWb16VCeuMGK
         QoSr6Q1zjdo3sU2+BYOyhwRIq3q/PiPIC8OzSTlH3H4tg6JsgODptvCZb6u6zoZaDOvd
         sX6KmXRJmRRvrP8bidmRMnmu0g+pDEf2CZu186ufzQ9rhCv90GphGTbmjGhkoGZP+hil
         R1nf3l3sk3bzXZx0v55gZpOiIOvH3bjpGoYVVuX+3V116zpvrgQDHWzm9YmGy1wQtrTF
         bTcKrFLHUakSddOoy3KAdOLYMKotH6d75Gsd7u+ovZ7KxZpp+ThEBCqlIt6nLKvXiMOm
         iFlQ==
X-Gm-Message-State: AOAM530GOH/JoqL4l/Z0xOxC2biFhe8ejddHMdy4gYrCnbghHt3uauD2
        R+P2SdEJyLBdsAy+JV2EY9o=
X-Google-Smtp-Source: ABdhPJxnjy1VIP5/HwcaRpS7WhqMTnte+MydT1bqKgrCc6fGers5oSxc2xs7YND2DJSTZnsR18PdZg==
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr4211562lfc.135.1589483438819;
        Thu, 14 May 2020 12:10:38 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:38 -0700 (PDT)
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
Subject: [PATCH v1 11/18] backlight: improve backlight_device documentation
Date:   Thu, 14 May 2020 21:09:54 +0200
Message-Id: <20200514191001.457441-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_device and
adapt it to kernel-doc style.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 81 ++++++++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index c81b77af44d4..34ba1e444334 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -14,21 +14,6 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
-/* Notes on locking:
- *
- * backlight_device->ops_lock is an internal backlight lock protecting the
- * ops pointer and no code outside the core should need to touch it.
- *
- * Access to update_status() is serialised by the update_lock mutex since
- * most drivers seem to need this and historically get it wrong.
- *
- * Most drivers don't need locking on their get_brightness() method.
- * If yours does, you need to implement it in the driver. You can use the
- * update_lock mutex if appropriate.
- *
- * Any other use of the locks below is probably wrong.
- */
-
 enum backlight_update_reason {
 	BACKLIGHT_UPDATE_HOTKEY,
 	BACKLIGHT_UPDATE_SYSFS,
@@ -221,30 +206,80 @@ struct backlight_properties {
 	enum backlight_scale scale;
 };
 
+/**
+ * struct backlight_device - backlight device data
+ *
+ * This structure holds all data required by a backlight device.
+ */
 struct backlight_device {
-	/* Backlight properties */
+	/**
+	 * @props:
+	 *
+	 * Backlight properties
+	 */
 	struct backlight_properties props;
 
-	/* Serialise access to update_status method */
+	/**
+	 * @update_lock:
+	 *
+	 * update_lock is an internal backlight lock that serialise access
+	 * to the update_status() method. The iupdate_lock mutex shall not be used
+	 * by backlight drivers.
+	 */
 	struct mutex update_lock;
 
-	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
-	   registered this device has been unloaded, and if class_get_devdata()
-	   points to something in the body of that driver, it is also invalid. */
+	/**
+	 * @ops_lock:
+	 *
+	 * ops_lock is an internal backlight lock that protects the ops pointer
+	 * and is used around all accesses to ops and when the operations are
+	 * invoked. The mutex shall not be used by backlight drivers.
+	 */
 	struct mutex ops_lock;
+
+	/**
+	 * @ops:
+	 *
+	 * Pointer to the backlight operations. If ops is NULL, the driver that
+	 * registered this device has been unloaded, and if class_get_devdata()
+	 * points to something in the body of that driver, it is also invalid.
+	 */
 	const struct backlight_ops *ops;
 
-	/* The framebuffer notifier block */
+	/**
+	 * @fb_notif:
+	 *
+	 * The framebuffer notifier block
+	 */
 	struct notifier_block fb_notif;
 
-	/* list entry of all registered backlight devices */
+	/**
+	 * @entry:
+	 *
+	 * List entry of all registered backlight devices
+	 */
 	struct list_head entry;
 
+	/**
+	 * @dev:
+	 *
+	 * Parent device.
+	 */
 	struct device dev;
 
-	/* Multiple framebuffers may share one backlight device */
+	/**
+	 * @fb_bl_on:
+	 *
+	 * Multiple fbdev's may share one backlight device. The fb_bl_on
+	 * records the state of the individual fbdev.
+	 */
 	bool fb_bl_on[FB_MAX];
 
+	/**
+	 * @use_count:
+	 *
+	 * The number of uses of fb_bl_on.
+	 */
 	int use_count;
 };
 
-- 
2.25.1

