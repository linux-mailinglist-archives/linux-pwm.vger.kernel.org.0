Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EACBB1D3CD5
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729256AbgENTK0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730284AbgENTKY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09A2C061A0C;
        Thu, 14 May 2020 12:10:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g4so4777558ljl.2;
        Thu, 14 May 2020 12:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5PQMEcv1NfMXN6wgUUifwpupdvWgrHF4WujE2wy4cnE=;
        b=oj0oQMsctNEpY1Wsm80tWYK/q7dzRkAqb6HlnzXJUL19Cgmz4XskAKYFsBqvAuDqmR
         Tb6ANd9TbmRjHWu2Fi4ZgPck973cCMYCiI2gGKP2evVR8HKW0Uec8a1bSvCX4jMsBtp7
         v+PgVhXgn1CHe9CRVJDwFex4n1MFv0Fq9MPCLFjQ1soe26jMwinI6RRNQVOrtUJjKFQD
         zk95KlNJOtSxy/L3D0nlWAmJuotrWdD9Rl/dQMGD7QjXrO1VMCxoZCdCWKu+n0OHOQsC
         OLAwaYaIaM9+L8bl5EYgYapIbN4gS07Zp9eAIW7DiVadx9TmJKp0aam96POD0/0IpIcO
         10fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5PQMEcv1NfMXN6wgUUifwpupdvWgrHF4WujE2wy4cnE=;
        b=joq7i9GEN6euVwz3qWMQXvEcTi+hTQ/2rjgs1Pdq6mOMunxVydHaCXJHU4umcJzNeq
         diWZs4s+YNfJDSwBsMpfHM/RH1nrUSKyh5iYC4s2d2Ebsg93+LFjr1THxkXnCWSMWO32
         Jpgvfz5llaUkWxYEOiruY575cscvCaB8dU6Mkz221abQmpeMm/9Krc0EjyEpRav9uz6g
         yoqz9bnnB92E9qXIVfYFFTBQeTD1RRWu2fBAMP/VrPJOwODQY8sbMYxUsT4NOlqyOKjI
         x4PE3zNuLhjTR+XQfgY0gjddlYICRcGnKB3Cb0wZpvw3z8++KQJ1lBPvjZtMU6vIPhda
         LGCQ==
X-Gm-Message-State: AOAM533lZJN/IlubdAteb6Sh5/9WTGIbWFe6w4XDq+C9UxKeqhReRTHs
        ZGy8awnXlXtHeUy4EPAAXU0=
X-Google-Smtp-Source: ABdhPJzQGH3odWJt1CgHuRerG8SSDuaUrK5vOO5PmO0Wr7eBmwauHxTg8DZWDE/ijgcS4S+dMFzoxg==
X-Received: by 2002:a2e:9843:: with SMTP id e3mr3717492ljj.249.1589483422387;
        Thu, 14 May 2020 12:10:22 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:21 -0700 (PDT)
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
Subject: [PATCH v1 04/18] backlight: make of_find_backlight static
Date:   Thu, 14 May 2020 21:09:47 +0200
Message-Id: <20200514191001.457441-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight,
as they have all changed to use the managed version.
Make of_find_backlight static to prevent new external users.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 31 ++++++++++-------------------
 include/linux/backlight.h           |  6 ------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index cac3e35d7630..511bb382c584 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -600,22 +600,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 EXPORT_SYMBOL(of_find_backlight_by_node);
 #endif
 
-/**
- * of_find_backlight - Get backlight device
- * @dev: Device
- *
- * This function looks for a property named 'backlight' on the DT node
- * connected to @dev and looks up the backlight device.
- *
- * Call backlight_put() to drop the reference on the backlight device.
- *
- * Returns:
- * A pointer to the backlight device if found.
- * Error pointer -EPROBE_DEFER if the DT property is set, but no backlight
- * device is found.
- * NULL if there's no backlight property.
- */
-struct backlight_device *of_find_backlight(struct device *dev)
+static struct backlight_device *of_find_backlight(struct device *dev)
 {
 	struct backlight_device *bd = NULL;
 	struct device_node *np;
@@ -641,7 +626,6 @@ struct backlight_device *of_find_backlight(struct device *dev)
 
 	return bd;
 }
-EXPORT_SYMBOL(of_find_backlight);
 
 static void devm_backlight_release(void *data)
 {
@@ -652,9 +636,16 @@ static void devm_backlight_release(void *data)
  * devm_of_find_backlight - Resource-managed of_find_backlight()
  * @dev: Device
  *
- * Device managed version of of_find_backlight().
- * The reference on the backlight device is automatically
- * dropped on driver detach.
+ * This function looks for a property named 'backlight' on the DT node
+ * connected to @dev and looks up the backlight device.
+ * The lookup is device managed so the reference to the backlight device
+ * is automatically dropped on driver detach.
+ *
+ * Returns:
+ * A pointer to the backlight device if found.
+ * Error pointer -EPROBE_DEFER if the DT property is set, but no backlight
+ * device is found.
+ * NULL if there's no backlight property.
  */
 struct backlight_device *devm_of_find_backlight(struct device *dev)
 {
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index c7d6b2e8c3b5..a0f03bb322d7 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -219,14 +219,8 @@ of_find_backlight_by_node(struct device_node *node)
 #endif
 
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
-struct backlight_device *of_find_backlight(struct device *dev);
 struct backlight_device *devm_of_find_backlight(struct device *dev);
 #else
-static inline struct backlight_device *of_find_backlight(struct device *dev)
-{
-	return NULL;
-}
-
 static inline struct backlight_device *
 devm_of_find_backlight(struct device *dev)
 {
-- 
2.25.1

