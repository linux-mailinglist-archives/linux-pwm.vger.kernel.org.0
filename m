Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 554711D6C01
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgEQTCT (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:18 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F70C061A0C;
        Sun, 17 May 2020 12:02:18 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a4so6085553lfh.12;
        Sun, 17 May 2020 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MFJX6FiHgUvM5du18LNwu9CVftjjLHmI1GzjS1q+q/Q=;
        b=B13Oum2xPyDoHpM0lQkr7cuaYQNcL9llzZJP5V1B3Cqvh/fSYNrttVnZ4pFOB/wqr5
         M+cc/Opykr97ClGnVHt/huyK7oNA+gLsBtyolUZt897VeepHPl12s5LTN3hqhVNZrG77
         JRN1AZ4z4/nB2uyyHgtk1HzK+GMOTvT29LRZpRuYhFVUQlfh9QudAb2KR16L7OXWyrP1
         lMSFQnQE7X5dJxq79Qfzgh+gTH9TS9qkaeovpTo54PxLHUpPam2nqZjbMj2cTiT0jZSl
         VGJDXQ+oh4f8lLS73R53XU00XaIEvB+aJE+giCpdY1TNgSx/gg8H6yRTcvWOvN/jRaAt
         QU5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MFJX6FiHgUvM5du18LNwu9CVftjjLHmI1GzjS1q+q/Q=;
        b=p7F+pPNbo2qVEtAudq27ot+21/Lj1Xa51JRpu6/mUh798BvN2srD6wuek/CmXIKoOd
         DE0XL3qzKQvwpmxAGx4qpnSl25p0FQyEmTOrQ0YYsb1PUicoIfojdvWL1NY3RIw6XnK5
         HBlOjfMm5aJwcVJ+g58qx3IZRIwwiA7ti+8AuZGox75iRmpJuLB2x182o8LiWpdZttVK
         xPlhqIifT5q7Xu+0n5M/IOH8OPJya01XTY6qNDNmcmRxGDwE1rDCsiPmMkbModNe6pAT
         4jIcbm+JTvr4z8mmSyIVqQuwYoXJJJ2bnjTiT6JS/sc8EZA0McwO9FEcf5D4qfHSydQM
         0q+A==
X-Gm-Message-State: AOAM531vyQ3YF9o1BYjYkxopj0KCakVUXWFDr8i5WvYdZXLEd+wSARcw
        HUrVzDn5U2s/RI6GNptT+HA=
X-Google-Smtp-Source: ABdhPJzvLFoza9YMOVKHGWEUso8Itb2Pt8LTJswrOAdPeBH1TSQSghWCNAiyrcFaRbrv37Yc2g2O2A==
X-Received: by 2002:ac2:558e:: with SMTP id v14mr9080244lfg.138.1589742136713;
        Sun, 17 May 2020 12:02:16 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:16 -0700 (PDT)
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
Subject: [PATCH v2 11/16] backlight: add overview and update existing doc
Date:   Sun, 17 May 2020 21:01:34 +0200
Message-Id: <20200517190139.740249-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add overview chapter to backlight.c.
Update existing kernel-doc to follow a more consistent
style and drop kernel-doc for deprecated functions.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 131 +++++++++++++++++++---------
 1 file changed, 90 insertions(+), 41 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 17f04cff50ab..2212f0e3570e 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -22,6 +22,45 @@
 #include <asm/backlight.h>
 #endif
 
+/**
+ * DOC: overview
+ *
+ * The backlight core supports implementing backlight drivers.
+ *
+ * backlight is controlled from userspace via firmware, a platform
+ * specific way or via sysfs. The backlight core provide support
+ * for all three types of backlight control.
+ *
+ * A backlight driver registers a driver using
+ * devm_backlight_device_register(). The properties of the backlight
+ * driver such as type and max_brightness must be specified.
+ * When the core detect changes in for example brightness or power state
+ * the update_status() operation is called. The backlight driver shall
+ * implement this operation and use it to adjust backlight.
+ *
+ * Several sysfs attributes are provided by the backlight core::
+ *
+ * - brightness         R/W, set the requested brightness level
+ * - actual_brighness   RO, the brightness level used by the HW
+ * - max_brightness     RO, the maximum  brightness level supported
+ *
+ * See Documentation/ABI/stable/sysfs-class-backlight for the full list.
+ *
+ * The driver shall implement the get_brightness() operation if
+ * the HW do not support all the levels that can be specified in
+ * brightness, thus providing user-space access to the actual level
+ * via the actual_brightness attribute.
+ * When the backlight changes this is reported to user-space using
+ * an uevent connected to the actual_brightness attribute.
+ * When brightness is set by platform specific means, for example
+ * a hot-key to adjust backlight, the driver must notify the backlight
+ * core that brighness has changed using backlight_force_update().
+ *
+ * The backlight driver core receives notifications from fbdev and
+ * if the event is FB_EVENT_BLANK the value of blank, from the FBIOBLANK
+ * ioclt, is passed to the driver via the update_status() operation.
+ */
+
 static struct list_head backlight_dev_list;
 static struct mutex backlight_dev_list_mutex;
 static struct blocking_notifier_head backlight_notifier;
@@ -40,9 +79,17 @@ static const char *const backlight_scale_types[] = {
 
 #if defined(CONFIG_FB) || (defined(CONFIG_FB_MODULE) && \
 			   defined(CONFIG_BACKLIGHT_CLASS_DEVICE_MODULE))
-/* This callback gets called when something important happens inside a
- * framebuffer driver. We're looking if that important event is blanking,
- * and if it is and necessary, we're switching backlight power as well ...
+/*
+ * fb_notifier_callback
+ *
+ * This callback gets called when something important happens inside a
+ * framebuffer driver. The backlight core only care about FB_BLANK_UNBLANK
+ * which is reported to the driver using backlight_update_status()
+ * as a state change.
+ *
+ * There may be several fbdev's connected to the backlight device,
+ * in which case they are kept track of. A state change is only reported
+ * if there is a change in backligt for the specified fbdev.
  */
 static int fb_notifier_callback(struct notifier_block *self,
 				unsigned long event, void *data)
@@ -318,12 +365,16 @@ static struct attribute *bl_device_attrs[] = {
 ATTRIBUTE_GROUPS(bl_device);
 
 /**
- * backlight_force_update - tell the backlight subsystem that hardware state
- *   has changed
+ * backlight_force_update - force an update due to a hardware change
  * @bd: the backlight device to update
+ * @reason: the method used for the backlight update
  *
  * Updates the internal state of the backlight in response to a hardware event,
- * and generate a uevent to notify userspace
+ * and generate an uevent to notify userspace.
+ * A backlight driver shall call backlight_force_update() when the backlight
+ * is changed using, for example, a hot-key.
+ * The updated brightness is read using get_brightness() and the brightness
+ * value is reported using an uevent.
  */
 void backlight_force_update(struct backlight_device *bd,
 			    enum backlight_update_reason reason)
@@ -336,19 +387,7 @@ void backlight_force_update(struct backlight_device *bd,
 }
 EXPORT_SYMBOL(backlight_force_update);
 
-/**
- * backlight_device_register - create and register a new object of
- *   backlight_device class.
- * @name: the name of the new object(must be the same as the name of the
- *   respective framebuffer device).
- * @parent: a pointer to the parent device
- * @devdata: an optional pointer to be stored for private driver use. The
- *   methods may retrieve it by using bl_get_data(bd).
- * @ops: the backlight operations structure.
- *
- * Creates and registers new backlight device. Returns either an
- * ERR_PTR() or a pointer to the newly allocated device.
- */
+/* deprecated - use devm_backlight_device_register() */
 struct backlight_device *backlight_device_register(const char *name,
 	struct device *parent, void *devdata, const struct backlight_ops *ops,
 	const struct backlight_properties *props)
@@ -415,6 +454,15 @@ struct backlight_device *backlight_device_register(const char *name,
 }
 EXPORT_SYMBOL(backlight_device_register);
 
+/** backlight_device_get_by_type - find first backlight device of a type
+ * @type: the type of backlight device
+ *
+ * Look up the first backlight device of the specified type
+ *
+ * RETURNS:
+ *
+ * Pointer to backlight device if any was found. Otherwise NULL.
+ */
 struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
 {
 	bool found = false;
@@ -433,12 +481,7 @@ struct backlight_device *backlight_device_get_by_type(enum backlight_type type)
 }
 EXPORT_SYMBOL(backlight_device_get_by_type);
 
-/**
- * backlight_device_unregister - unregisters a backlight device object.
- * @bd: the backlight device object to be unregistered and freed.
- *
- * Unregisters a previously registered via backlight_device_register object.
- */
+/* deprecated - use devm_backlight_device_unregister() */
 void backlight_device_unregister(struct backlight_device *bd)
 {
 	if (!bd)
@@ -486,10 +529,12 @@ static int devm_backlight_device_match(struct device *dev, void *res,
  * backlight_register_notifier - get notified of backlight (un)registration
  * @nb: notifier block with the notifier to call on backlight (un)registration
  *
- * @return 0 on success, otherwise a negative error code
- *
  * Register a notifier to get notified when backlight devices get registered
  * or unregistered.
+ *
+ * RETURNS:
+ *
+ * 0 on success, otherwise a negative error code
  */
 int backlight_register_notifier(struct notifier_block *nb)
 {
@@ -501,10 +546,12 @@ EXPORT_SYMBOL(backlight_register_notifier);
  * backlight_unregister_notifier - unregister a backlight notifier
  * @nb: notifier block to unregister
  *
- * @return 0 on success, otherwise a negative error code
- *
  * Register a notifier to get notified when backlight devices get registered
  * or unregistered.
+ *
+ * RETURNS:
+ *
+ * 0 on success, otherwise a negative error code
  */
 int backlight_unregister_notifier(struct notifier_block *nb)
 {
@@ -513,20 +560,22 @@ int backlight_unregister_notifier(struct notifier_block *nb)
 EXPORT_SYMBOL(backlight_unregister_notifier);
 
 /**
- * devm_backlight_device_register - resource managed backlight_device_register()
+ * devm_backlight_device_register - registering a new backlight device
  * @dev: the device to register
  * @name: the name of the device
- * @parent: a pointer to the parent device
+ * @parent: a pointer to the parent device (often the same as @dev)
  * @devdata: an optional pointer to be stored for private driver use
  * @ops: the backlight operations structure
  * @props: the backlight properties
  *
- * @return a struct backlight on success, or an ERR_PTR on error
+ * Creates and registers new backlight device. When a backlight device
+ * is registered the configuration must be specified in the @props
+ * parameter. See description of &backlight_properties.
  *
- * Managed backlight_device_register(). The backlight_device returned
- * from this function are automatically freed on driver detach.
- * See backlight_device_register() for more information.
- */
+ * RETURNS:
+ *
+ * struct backlight on success, or an ERR_PTR on error
+*/
 struct backlight_device *devm_backlight_device_register(struct device *dev,
 	const char *name, struct device *parent, void *devdata,
 	const struct backlight_ops *ops,
@@ -553,13 +602,13 @@ struct backlight_device *devm_backlight_device_register(struct device *dev,
 EXPORT_SYMBOL(devm_backlight_device_register);
 
 /**
- * devm_backlight_device_unregister - resource managed backlight_device_unregister()
+ * devm_backlight_device_unregister - backlight device unregister
  * @dev: the device to unregister
  * @bd: the backlight device to unregister
  *
- * Deallocated a backlight allocated with devm_backlight_device_register().
+ * Deallocates a backlight allocated with devm_backlight_device_register().
  * Normally this function will not need to be called and the resource management
- * code will ensure that the resource is freed.
+ * code will ensure that the resources are freed.
  */
 void devm_backlight_device_unregister(struct device *dev,
 				struct backlight_device *bd)
@@ -650,8 +699,8 @@ static void devm_backlight_release(void *data)
 }
 
 /**
- * devm_of_find_backlight - Resource-managed of_find_backlight()
- * @dev: Device
+ * devm_of_find_backlight - find backlight for a device
+ * @dev: the device
  *
  * Device managed version of of_find_backlight().
  * The reference on the backlight device is automatically
-- 
2.25.1

