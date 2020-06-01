Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA4201E9E81
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgFAGw3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGw3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:29 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BC0C061A0E;
        Sun, 31 May 2020 23:52:28 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so5299147ljc.8;
        Sun, 31 May 2020 23:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E7HkxkpHSeUWg+0ye+F2gdRI1PIMCE5pzVQmnOBV6l0=;
        b=ojtUytOV3rh6oRh5gNALmSYwsY5lka6bh6bPFygGrqRWn80LmipzWwpSs4c6LXmhmN
         tNYD09IlEn/d/tFmyncf+SctnMXKDdnT9+xSu/HNxvafs2F3VDDzOaTbWqWmeLgHa4vc
         9ZXMNcOnncjuneXMoyRSESy1eMDgokSzFP11lxe21mMyFPcj5bhKGGfsW1ZuWW7RbHUf
         Bxg4WVZYXcr5QVs8H/tB0jQUvJIZZC9vS5sqMHia5j25MdgQtlOeJhxkpeG807zfqhyl
         a4BZ7U6EfAHlRp0+N3f5jXM/sa86ICY2iLtKejHrcuNloG/onPi8uePTHsSWUW2O4KUr
         m98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=E7HkxkpHSeUWg+0ye+F2gdRI1PIMCE5pzVQmnOBV6l0=;
        b=bqOH8VDTXaMiHh/3KmdzRX2XuA1/BVZNFgEl6cJJsVmGjohQHfjovwSS51RyulaP5H
         7SIAOXSEAxNEzehhbqgDsfHU33W7oyK44DjlAX/IEh8IwIhZvdNo/GnBmOPdDGiKm0E6
         XeLIkPopE6fDRHcDdV3sq5IUG1Mvy+lrSTr9Z9ekxrFglnmRCrArSGjggKQOMbd6QLyZ
         lvfiLEadvAhhV3vnl6pxia0bo9jgD/KtilZPWOYiXH4RFlDPZAmyS7KgnPJTUhePv0CL
         H9iayYwPmrJhOCUMKADouYDdLsp89Tebs6T3afPqD4JAnYRef1F4xJhMRXCVF4JuKWVb
         KpAA==
X-Gm-Message-State: AOAM532/lS40dkSbDeqFK8UbsdrQb9YAfT2+T+JcxeQiD6BMuyElNBPb
        jOnCEviorkZoXrdVo34GJi0=
X-Google-Smtp-Source: ABdhPJy37DH82D0CeHL7Sr2OMF4RZfTIP5Kb12jq2LE9Ca3vZgAarg4cgPeBxOMFux4+KcCV6O1+ow==
X-Received: by 2002:a2e:b4e7:: with SMTP id s7mr4553753ljm.336.1590994347111;
        Sun, 31 May 2020 23:52:27 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:26 -0700 (PDT)
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
Subject: [PATCH v3 05/13] backlight: improve backlight_device documentation
Date:   Mon,  1 Jun 2020 08:51:59 +0200
Message-Id: <20200601065207.492614-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_device and
adapt it to kernel-doc style.

v2:
  - Add short intro to all fields (Daniel)
  - Updated description of update_lock (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 69a20da03035..cae1af95dd9d 100644
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
@@ -215,30 +200,71 @@ struct backlight_properties {
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
+	 * @props: Backlight properties
+	 */
 	struct backlight_properties props;
 
-	/* Serialise access to update_status method */
+	/**
+	 * @update_lock: The lock used when calling the update_status() operation.
+	 *
+	 * update_lock is an internal backlight lock that serialise access
+	 * to the update_status() operation. The backlight core holds the update_lock
+	 * when calling the update_status() operation. The update_lock shall not
+	 * be used by backlight drivers.
+	 */
 	struct mutex update_lock;
 
-	/* This protects the 'ops' field. If 'ops' is NULL, the driver that
-	   registered this device has been unloaded, and if class_get_devdata()
-	   points to something in the body of that driver, it is also invalid. */
+	/**
+	 * @ops_lock: The lock used around everything related to backlight_ops.
+	 *
+	 * ops_lock is an internal backlight lock that protects the ops pointer
+	 * and is used around all accesses to ops and when the operations are
+	 * invoked. The ops_lock shall not be used by backlight drivers.
+	 */
 	struct mutex ops_lock;
+
+	/**
+	 * @ops: Pointer to the backlight operations.
+	 *
+	 * If ops is NULL, the driver that registered this device has been unloaded,
+	 * and if class_get_devdata() points to something in the body of that driver,
+	 * it is also invalid.
+	 */
 	const struct backlight_ops *ops;
 
-	/* The framebuffer notifier block */
+	/**
+	 * @fb_notif: The framebuffer notifier block
+	 */
 	struct notifier_block fb_notif;
 
-	/* list entry of all registered backlight devices */
+	/**
+	 * @entry: List entry of all registered backlight devices
+	 */
 	struct list_head entry;
 
+	/**
+	 * @dev: Parent device.
+	 */
 	struct device dev;
 
-	/* Multiple framebuffers may share one backlight device */
+	/**
+	 * @fb_bl_on: The state of individual fbdev's.
+	 *
+	 * Multiple fbdev's may share one backlight device. The fb_bl_on
+	 * records the state of the individual fbdev.
+	 */
 	bool fb_bl_on[FB_MAX];
 
+	/**
+	 * @use_count: The number of uses of fb_bl_on.
+	 */
 	int use_count;
 };
 
-- 
2.25.1

