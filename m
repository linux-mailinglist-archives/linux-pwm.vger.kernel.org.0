Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 482F41E9E85
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726146AbgFAGwe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGwd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:33 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32874C05BD43;
        Sun, 31 May 2020 23:52:33 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q2so6723813ljm.10;
        Sun, 31 May 2020 23:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NySSdlyQJkQGVkK1Cp0EHZZ6M2Ik0zG0av6w2Ego7I4=;
        b=rbuMMtwa32PlMgO3FLH9ovOTcW9dDxJqamtsGyz/yDGxwGhiZUOAictnebq5XGOUJa
         GYZvEoglN5aUz07Eb4Ee3r0Wm9PGmdbXlkyeB+jemEaWfvCvEH7w+t/werIAsAywDiZh
         KmYK99Ouzqz0FoNxuHqfn4P45jIzXf30SdpFboGDrjsHoYfaxCB8QP0+XD+OCivpqj9e
         akRwRzz7YLfe6sCinOxkIkYvq+HIEMUyDLTh6aFNitX7C2+2xVj9B2LLnkUJI0UksEnT
         NxBr+dxvmZYllzVKeglKLHrvkqRhYALq6R6Ni9HlDTtyBCtxtfb2UxmGSU2MA7XnbSif
         G5sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NySSdlyQJkQGVkK1Cp0EHZZ6M2Ik0zG0av6w2Ego7I4=;
        b=FIh5U4G2aPrv/3yiRhN2Wp+Sm0y0B49XKEzzvngxmz9jLyrgoVaSMgpClCDcbN0657
         dPiD8oG03wnS7qlROWzJz3gA7rnDg7ubBPIDWRKM/CFtt+tE7Gntf8oKTLai5It6+Mgn
         SVN4Eq8uZxzNwF35whHznb7CtKVm6AbqkXvmDmgXA6dwOFttpoQ0THxIuHo/xvvVQLsb
         aRp4NToNl87aOI9XQ6Ht3hXtMrsrHHWiMBaOBjXPkuHiVaLym0lQa93hbEjRc7HRaHvW
         5BIYBggL5SlS7IYgTbW+W3jDiX4oO28z6Qs3r7BmN0LAUusRyCC8MOs2cr1sPbByPt2i
         J/MQ==
X-Gm-Message-State: AOAM530Yz+lWXNciiT4gYPvLV6bD/4C0nyZ2xwMHvE9FgzUIDV2vlfIr
        pKSSNngLkjE2aGDQZ0ycJuk=
X-Google-Smtp-Source: ABdhPJzFLoA3566dKX71K1Hk/avEwSPU2a8TFY6W34e11xmPVzkT9VeSoTjpuep92eETOAu24eniEA==
X-Received: by 2002:a2e:82d0:: with SMTP id n16mr7862747ljh.6.1590994351618;
        Sun, 31 May 2020 23:52:31 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:31 -0700 (PDT)
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
Subject: [PATCH v3 07/13] backlight: document enums in backlight.h
Date:   Mon,  1 Jun 2020 08:52:01 +0200
Message-Id: <20200601065207.492614-8-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add kernel-doc documentation for the backlight enums

v2:
  - Add intro to each enum member (Daniel)
    Except backlight type as line lenght was too long.
    The generated HTML is the same.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 74 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index f99ca19cc3ec..c1c7b1666a9b 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -14,26 +14,98 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+/**
+ * enum backlight_update_reason - what method was used to update backlight
+ *
+ * A driver indicates the method (reason) used for updating the backlight
+ * when calling backlight_force_update().
+ */
 enum backlight_update_reason {
+	/**
+	 * @BACKLIGHT_UPDATE_HOTKEY: The backlight was updated using a hot-key.
+	 */
 	BACKLIGHT_UPDATE_HOTKEY,
+
+	/**
+	 * @BACKLIGHT_UPDATE_SYSFS: The backlight was updated using sysfs.
+	 */
 	BACKLIGHT_UPDATE_SYSFS,
 };
 
+/**
+ * enum backlight_type - the type of backlight control
+ *
+ * The type of interface used to control the backlight.
+ */
 enum backlight_type {
+	/**
+	 * @BACKLIGHT_RAW:
+	 *
+	 * The backlight is controlled using hardware registers.
+	 */
 	BACKLIGHT_RAW = 1,
+
+	/**
+	 * @BACKLIGHT_PLATFORM:
+	 *
+	 * The backlight is controlled using a platform-specific interface.
+	 */
 	BACKLIGHT_PLATFORM,
+
+	/**
+	 * @BACKLIGHT_FIRMWARE:
+	 *
+	 * The backlight is controlled using a standard firmware interface.
+	 */
 	BACKLIGHT_FIRMWARE,
+
+	/**
+	 * @BACKLIGHT_TYPE_MAX: Number of entries.
+	 */
 	BACKLIGHT_TYPE_MAX,
 };
 
+/**
+ * enum backlight_notification - the type of notification
+ *
+ * The notifications that is used for notification sent to the receiver
+ * that registered notifications using backlight_register_notifier().
+ */
 enum backlight_notification {
+	/**
+	 * @BACKLIGHT_REGISTERED: The backlight device is registered.
+	 */
 	BACKLIGHT_REGISTERED,
+
+	/**
+	 * @BACKLIGHT_UNREGISTERED: The backlight revice is unregistered.
+	 */
 	BACKLIGHT_UNREGISTERED,
 };
 
+/** enum backlight_scale - the type of scale used for brightness values
+ *
+ * The type of scale used for brightness values.
+ */
 enum backlight_scale {
+	/**
+	 * @BACKLIGHT_SCALE_UNKNOWN: The scale is unknown.
+	 */
 	BACKLIGHT_SCALE_UNKNOWN = 0,
+
+	/**
+	 * @BACKLIGHT_SCALE_LINEAR: The scale is linear.
+	 *
+	 * The linear scale will increase brightness the same for each step.
+	 */
 	BACKLIGHT_SCALE_LINEAR,
+
+	/**
+	 * @BACKLIGHT_SCALE_NON_LINEAR: The scale is not linear.
+	 *
+	 * This is often used when the brightness values tries to adjust to
+	 * the relative perception of the eye demanding a non-linear scale.
+	 */
 	BACKLIGHT_SCALE_NON_LINEAR,
 };
 
@@ -149,7 +221,7 @@ struct backlight_properties {
 	/**
 	 * @fb_blank: The power state from the FBIOBLANK ioclt.
 	 *
-	 * When the FBIOBLANK ioctl is called fb_blank is set to the
+	 * When the FBIOBLANK ioctl is called @fb_blank is set to the
 	 * blank parameter and the update_status() operation is called.
 	 *
 	 * When the backlight device is enabled @fb_blank is set
-- 
2.25.1

