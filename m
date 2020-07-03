Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7FF213F6F
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgGCSqP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:15 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9FFC061794;
        Fri,  3 Jul 2020 11:46:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id h22so30915848lji.9;
        Fri, 03 Jul 2020 11:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+EMFfJ/GWN/oYTzmUu/mo7ItELrHC8VJ43RJqgEoQE=;
        b=HpaxBh5GXclKWorfDS8eeubjSbUnPeSdneyP8++kij8FIY+Qnp3c4K9T9afDl2eT/F
         kMzutjwUbVj9XeRzxdqtcKjTi7hRy3ksWM9rplbsHITFwGsyIg4BbGj1v9cqPy0RFeBd
         xKJxbxzSwMIvTLRgIIxRTFO0bEKMwQs9C1+fOrxXrD/jItC4h0rVXry/gsFbVk3zf/n+
         19TMl2UhhsocFn2yJIrmfW9qkxZpfWFIhY1p9XVPa05x1UYnLcT8dxCA3UCy/LA9HOc+
         mcMRtRYnOQxVeSDp7S1ktRoNFyozsHAbvaSIgkO3mrQlNtUGCtLX1MZlzHxOGDCYZk5Z
         7irQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3+EMFfJ/GWN/oYTzmUu/mo7ItELrHC8VJ43RJqgEoQE=;
        b=inaetudKLkvlvQ3WoRzKmsFVqn8ymVWcelUkYw8WMrGLnb5bf48mFd2fbaAaVHrqrv
         jwf3HLcH4lK64p9iLt/l/uEnF0ED/4Rmv/kjXoeorRAV/NS2F3Y7CGWFMwClHnxTZcnu
         94vXuYZedSnE9Ga0AiHTG3yJN0rzOOnYQg2b93wRsNQ5XgITColPgn6ge1OtTvVLojNU
         E0iLYPPbDyPf3d2+UHVL6666h0I72Jt7NdPpDdzg2r+SIFaQ3yBcipTB95S2qpbbHixS
         d5ADn+ilS35FNRsHl5ZvU5NiaZCfKkkmMh3/TrCgSXyn8c9TVkTNvHmyz7uYslgmGl9u
         WIZQ==
X-Gm-Message-State: AOAM530olNK9whfdYY8LR+xVBIYKdiN4xEYyJP94t0xEiZHM+wqZEBMv
        UFSt5YmiZngtEhAvVxc989s=
X-Google-Smtp-Source: ABdhPJxDMmMZURhZTC0zGczgDx+Llxqhg3gaeOXHUSat2Cl1VgrK5usCllaKBX0X8BU0F3tdoUNFCQ==
X-Received: by 2002:a2e:9c95:: with SMTP id x21mr13648532lji.234.1593801973131;
        Fri, 03 Jul 2020 11:46:13 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:12 -0700 (PDT)
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
Subject: [PATCH v4 05/20] backlight: improve backlight_device documentation
Date:   Fri,  3 Jul 2020 20:45:31 +0200
Message-Id: <20200703184546.144664-6-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Improve the documentation for backlight_device and
adapt it to kernel-doc style.

The updated documentation is more strict on how locking is used.
With the update neither update_lock nor ops_lock may be used
outside the backlight core.
This restriction was introduced to keep the locking simple
by keeping it in the core.
It was verified that this documents the current state by renaming
update_lock => bl_update_lock and ops_lock => bl_ops_lock.
The rename did not reveal any uses outside the backlight core.
The rename is NOT part of this patch.

v3:
  - Update changelog to explain locking details (Daniel)

v2:
  - Add short intro to all fields (Daniel)
  - Updated description of update_lock (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 72 ++++++++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 23 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 10518b00b059..7654fe5f1589 100644
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

