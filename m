Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4DBE213F9A
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgGCSqo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCSqo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:44 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B07C061794;
        Fri,  3 Jul 2020 11:46:43 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t74so19056016lff.2;
        Fri, 03 Jul 2020 11:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q86XdCJfHm4NXa8RPuVpLMGPelEiFzOicNNaQKmE/Tg=;
        b=nBiBGqmR5JNs/DnxM/smCnXHsf8bZ9h+pbLeNYLjLQ2Rcovhk3ODpGdV50KiQt+Kca
         cuoq6henFkcNUS076lI9Ebou281QOyaIPCUw+yjymXUm30BXc/mVq9b+1WYkoCozQDo6
         i93T7vFV75j/Br4G3oixOkU86XkZCZGiK9F9pITDefqczikdFNmARPU3TcHWm9r0r6Ir
         ew4YX0S8lj3zWQ2vY1q/kTWWH77/XC72/vYsaSpaY3pWXmv7MjaLxlECYEGHrM7sv5/h
         ww5+gcgyjh/hmLUtWYFClvOccaVoOkUz2qsANjO8qhpe/VtvNCELy58jkG1Q+YUJ6eTG
         9lqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Q86XdCJfHm4NXa8RPuVpLMGPelEiFzOicNNaQKmE/Tg=;
        b=QX0DChELVucKVrE9CA2qtZL5CKiWu9CWnDvJxTL1llIFeEu8lSDXyAeMz+JZSz8oWT
         RLX9RaRtDJ632bmuBv8CpmIGttIzBJ+I+ywmzQoKhLhF9ca3UtQLZkrI09iTres3ufVe
         D6rjQPRVR1NVSJG4M9A/oN8yqerpUtuUjNav1Gr02BcmO/mFcsVr7viCR2YPC5oZEHDp
         eHpO3gzmcs69ImjqSfi8Yq9ZcNQSyah95NZzD4hQVZDO1G2qUe6AA/HUCoWFy81AH/Yg
         /gddUkfl9+wzkZi/cmzFWMIfXoRGtf6QYalQ6o03CTfxDFVcH7UBiSiW9m6zbULKZ/PA
         0odA==
X-Gm-Message-State: AOAM531+fvk1lG6UZJq/T2GEwbCF3iBx3Dow82lRpbh1WE+rlb2RkRbf
        qJHqaouC9lNUxMSUWk70sow=
X-Google-Smtp-Source: ABdhPJyac79zADQ53wcZqwr2NvTksQGiIwtv5yruNnDCMzz6vo8jWzvXmY58HB/AOxGojDo5ENwokA==
X-Received: by 2002:a19:787:: with SMTP id 129mr22863367lfh.147.1593802002408;
        Fri, 03 Jul 2020 11:46:42 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:41 -0700 (PDT)
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
Subject: [PATCH v4 19/20] backlight: make of_find_backlight static
Date:   Fri,  3 Jul 2020 20:45:45 +0200
Message-Id: <20200703184546.144664-20-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight,
as they have all changed to use the managed version.
Make of_find_backlight static to prevent new external users.

v3:
  - Move doc for devm_of_find_backlight out of this patch

v2:
  - Editorial corrections (Daniel)
  - Returns => RETURNS (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 18 +-----------------
 include/linux/backlight.h           |  6 ------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 099023771ab1..06f4da3c58e1 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -672,22 +672,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
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
@@ -713,7 +698,6 @@ struct backlight_device *of_find_backlight(struct device *dev)
 
 	return bd;
 }
-EXPORT_SYMBOL(of_find_backlight);
 
 static void devm_backlight_release(void *data)
 {
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index f3b484c99789..8b43fd90d84a 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -477,14 +477,8 @@ of_find_backlight_by_node(struct device_node *node)
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

