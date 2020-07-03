Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C58213F9D
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgGCSqq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCSqq (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:46 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB19FC061794;
        Fri,  3 Jul 2020 11:46:45 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so38111647ljn.4;
        Fri, 03 Jul 2020 11:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hT0shvcR5E7UTkS/zrKMtVL3+oENb6Mn/8BtotMdc8Y=;
        b=IJ2pvZZu0XFyrYCZR2R+QxMO9PRsdBwoi67YSGTnXEoC6Xq35Un0PVtT9vh44xnDXP
         TEGeRIMsZGiYY6Awzwdq+jUzsSGLB4ADGwQ5ok8jjv4wOuWndRvZyE5OMfDznoZo90Th
         pQcuWXf8XYXOT5JioZmngSaaYWiRgjJLjdtvcWBOXqXAbHLIakqb1FUs9Jj7IOY1MgLt
         ONhxzqoJfYbWq2QSd6qoKs6tCTsLdmwEw77REvuGMEl0iwJS2rQFwTCmd9xNtGeisMjM
         gjOHzaRw4srWPfNxRglgv6ILapKfzB1ETl+0v76GQhbHDgft/Z8QaE1QiJoHBEmHxr1+
         y7vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=hT0shvcR5E7UTkS/zrKMtVL3+oENb6Mn/8BtotMdc8Y=;
        b=ckDyTf4i9lYYc2uN/EQ5RjWWIAzpauocMxePEsO99LpCC2vHa5p40GLe3TQmAbcVdE
         hIWARlXg0Y8k9IaEPGKS4CAkmyXx7snzPqNs6J1V1zQ0U7E7tBcoaYAapXQjo1dAJLAu
         H1lr4ov8cRosZGov+BmfxH48crkrr/DV9ze1DQRjRN99TC6jp40lZXtQJe1gf8B/hGp3
         HMUudD4juw9JA/XdWhGsRCpcIZ5DYKBgSvbpHh/NV7qlLQF1lHRGt5tzlbB6Itc5OT/s
         D1zjgN00E6nT51T07cTxrjLWEXFkfs0D7Z8re7a5+4NLIWTULm5HrkrZJLd3wFCo+UhE
         5e+w==
X-Gm-Message-State: AOAM532AewBsjMU6S4O9vZENw4OQ8qS2GsxNclGynIAQm+Uefu0kqerN
        +4A1b5yu0jePPOOsm3DlGmc=
X-Google-Smtp-Source: ABdhPJxYcPNmrmNBGSR3OEKzHcluG3e3qxVbhV/zKtVskDiIRKCh+SQkMLB/z9B+fykgAg9N0oyykQ==
X-Received: by 2002:a2e:3311:: with SMTP id d17mr19563882ljc.13.1593802004416;
        Fri, 03 Jul 2020 11:46:44 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:44 -0700 (PDT)
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
Subject: [PATCH v4 20/20] backlight: make of_find_backlight_by_node() static
Date:   Fri,  3 Jul 2020 20:45:46 +0200
Message-Id: <20200703184546.144664-21-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight_by_node().
Make it static so we keep it that way.

v2:
  - drop EXPORT of of_find_backlight_by_node

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 23 +++++++++--------------
 include/linux/backlight.h           | 10 ----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 06f4da3c58e1..ff84e6607486 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -649,19 +649,9 @@ static int of_parent_match(struct device *dev, const void *data)
 	return dev->parent && dev->parent->of_node == data;
 }
 
-/**
- * of_find_backlight_by_node() - find backlight device by device-tree node
- * @node: device-tree node of the backlight device
- *
- * Returns a pointer to the backlight device corresponding to the given DT
- * node or NULL if no such backlight device exists or if the device hasn't
- * been probed yet.
- *
- * This function obtains a reference on the backlight device and it is the
- * caller's responsibility to drop the reference by calling put_device() on
- * the backlight device's .dev field.
- */
-struct backlight_device *of_find_backlight_by_node(struct device_node *node)
+/* Find backlight device by device-tree node */
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
@@ -669,7 +659,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
-EXPORT_SYMBOL(of_find_backlight_by_node);
+#else
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
+{
+	return NULL;
+}
 #endif
 
 static struct backlight_device *of_find_backlight(struct device *dev)
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 8b43fd90d84a..fa443899b4ee 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -466,16 +466,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
 	return dev_get_drvdata(&bl_dev->dev);
 }
 
-#ifdef CONFIG_OF
-struct backlight_device *of_find_backlight_by_node(struct device_node *node);
-#else
-static inline struct backlight_device *
-of_find_backlight_by_node(struct device_node *node)
-{
-	return NULL;
-}
-#endif
-
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 struct backlight_device *devm_of_find_backlight(struct device *dev);
 #else
-- 
2.25.1

