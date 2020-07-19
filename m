Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929702250B2
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgGSIId (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIId (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE2AC0619D2;
        Sun, 19 Jul 2020 01:08:32 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t9so8182696lfl.5;
        Sun, 19 Jul 2020 01:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9uNwKzv8b/C+0SI0qOFOrsb7npxZ7PTzq2BdWF06ubw=;
        b=GY8/416esOptHiTcw/hru9S/6/vqdc0yetjpC6SPZf7xPtxO7FP6ADL0+LdKqYdNX5
         MZJHj3PUr6ys19l9+TGsMvagycygO8p25T8ixdmvOgRNAHQ2VomonsNYPX06+tBCnFjo
         GJaZn4IM50ItSes0ZOX4hOMHOYGW278fxUtfyTOklTkUErjNwtDEmLqUxnOzHfEYDMH+
         W54+6nwZl0n5aGK8NW2W3tslN6ZiJw+15pQuv3wC6/kdV00bfIp0TUCXCVnxKoIzWbUe
         cdMEKz1sGLGNsnO9EukHPzelYqK57AqIDGf9mqxP2VXeBL4HEtJ9xjpOYYEBADn7VUKo
         e6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=9uNwKzv8b/C+0SI0qOFOrsb7npxZ7PTzq2BdWF06ubw=;
        b=nq5CP2hH+ktwmOYFF0V4dSa0eH5BqpMQqgBkZyrm+ugY7aytLsOJlxrjH7YbGs6A67
         dTYmbgSgFVdpju6yLm08Oil1FcrKiRrrUHJzrhzqZMP8PpySKmcMuhk99GmXPzNmU4df
         7klVBMrAqyUDDhDT4bmhvjtntzUH7CjFCDD7jrUG2BRboXIzTyMH5mGZh0qofLzuarR/
         F6t1Fc8RLbctrglnLzMzc8kvEEjgL/6RbrYrbSgQbHNeYSDd1DciHXroZ9wITqvWi16I
         fUCzUTp9hUVNzrvOB2wjR9JaT+qIJ4fbzkGR0J2WGYyJOzcrWAj/pVaj02CxHEaC6g6w
         kjQA==
X-Gm-Message-State: AOAM530l31eb6G+3shmUryldEFs9LTaJnS0ojhqqSdlcKjMhmztVK6RE
        s+FOtGLYr85GJ6+AMZ5YlDo=
X-Google-Smtp-Source: ABdhPJwIH7f1kYdsfJVH3BGHUjihRFZqPKBCA9Z4ih5Z5OGknuirQDjZF0kxMmmxuEi/yIgniGV3rA==
X-Received: by 2002:ac2:4ec9:: with SMTP id p9mr779615lfr.142.1595146111102;
        Sun, 19 Jul 2020 01:08:31 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:30 -0700 (PDT)
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
Subject: [PATCH v5 19/19] backlight: make of_find_backlight static
Date:   Sun, 19 Jul 2020 10:07:43 +0200
Message-Id: <20200719080743.8560-20-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 18 +-----------------
 include/linux/backlight.h           |  6 ------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index d8387c8e7112..ff8406a15545 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -673,22 +673,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
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
@@ -714,7 +699,6 @@ struct backlight_device *of_find_backlight(struct device *dev)
 
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

