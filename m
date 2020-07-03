Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA5E7213F78
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGCSqV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:21 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91AAC061794;
        Fri,  3 Jul 2020 11:46:20 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u25so19059492lfm.1;
        Fri, 03 Jul 2020 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DyGPI75iVIn4zSAbyXty7YPUo17h6RwpsgJybxzcfiE=;
        b=GeFJaWFx7DzXF5WaoiOt3YVO308KSx5ai3uoIfkbrusBBdhN8+3Nh5NspFKQUa0EeA
         Lb+2o8PK1umste5xUNQ34dd2Zx1lt9xTVORBm/mwV7KZ+TkmplyPEJWai3qIE/4p5M+B
         9L0hbR3fW51INBaTUTIW5X1x4hcCBD5djoiWFpk0/7j/d4Wh5yItQUHtZN+qv2ogZ1k1
         x6sYPv1F0swtpzlwIwGlvXQ6b96loKPHMbn0Zkj0zI94HRMA6aob5f4V9fQZPK848Z/M
         Ua0Fd9iDeoK4WMnIfoUbil42ThLSJyPpMYbxWXh0ME4ojKi1Zn+cIh26yiwzYXscH51m
         GIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=DyGPI75iVIn4zSAbyXty7YPUo17h6RwpsgJybxzcfiE=;
        b=d1h4ClJYKcl7witCzbKJZK3BZc02rT4lscE8Cc5QKjqKWz1GHD0/zb+lmVj0xLerAk
         C5Y1Y8oiotn/8Ey5MeYY2sNEkrTMaKCL/72bnioHnYqehLsUh9H+iSJ4DgiKpvcIdOqt
         Sd1ajgerngiSejpYoc+qU9IMplc64jqN2gtVKHZNb9ZmxLPI/8yOajM2MmUswpNGvlaK
         hGrbYNLfIr75RJBRtLV5n1vdjp6spj6h0w3DQxB6vVwqbGx6hqMm/ms4N1T74MB0NprP
         4MYzxI318kYYw3Rjs2WdkDY4OHASBFYYPaAeFo06ITDaY7XbnF9OTuiUkPFZipXDt+Aw
         65jQ==
X-Gm-Message-State: AOAM530c1Tf2uNKnRxPuMnQgm2Xq8fsP6r6cjGNfKBME4TdT9075J6yl
        qW4On0eMctjZQO6pH7IbUQI=
X-Google-Smtp-Source: ABdhPJxWAGpokmBlMdz4EupmP9LWdBe3jxR4pP1/De7yLnALWqE4Roc1hCXZGQ357KSercARwbQuig==
X-Received: by 2002:a19:7d84:: with SMTP id y126mr23115474lfc.149.1593801979148;
        Fri, 03 Jul 2020 11:46:19 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:18 -0700 (PDT)
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
Subject: [PATCH v4 08/20] backlight: remove the unused backlight_bl driver
Date:   Fri,  3 Jul 2020 20:45:34 +0200
Message-Id: <20200703184546.144664-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The backlight_bl driver required initialization using
struct generic_bl_info. As there are no more references
to this struct there is no users left.
So it is safe to delete the driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/Kconfig      |   8 --
 drivers/video/backlight/Makefile     |   1 -
 drivers/video/backlight/generic_bl.c | 110 ---------------------------
 include/linux/backlight.h            |   9 ---
 4 files changed, 128 deletions(-)
 delete mode 100644 drivers/video/backlight/generic_bl.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7d22d7377606..14abfeee8868 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -173,14 +173,6 @@ config BACKLIGHT_EP93XX
 	  To compile this driver as a module, choose M here: the module will
 	  be called ep93xx_bl.
 
-config BACKLIGHT_GENERIC
-	tristate "Generic (aka Sharp Corgi) Backlight Driver"
-	default y
-	help
-	  Say y to enable the generic platform backlight driver previously
-	  known as the Corgi backlight driver. If you have a Sharp Zaurus
-	  SL-C7xx, SL-Cxx00 or SL-6000x say y.
-
 config BACKLIGHT_IPAQ_MICRO
 	tristate "iPAQ microcontroller backlight driver"
 	depends on MFD_IPAQ_MICRO
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 0c1a1524627a..9b998cfdc56d 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -31,7 +31,6 @@ obj-$(CONFIG_BACKLIGHT_CLASS_DEVICE)	+= backlight.o
 obj-$(CONFIG_BACKLIGHT_DA903X)		+= da903x_bl.o
 obj-$(CONFIG_BACKLIGHT_DA9052)		+= da9052_bl.o
 obj-$(CONFIG_BACKLIGHT_EP93XX)		+= ep93xx_bl.o
-obj-$(CONFIG_BACKLIGHT_GENERIC)		+= generic_bl.o
 obj-$(CONFIG_BACKLIGHT_GPIO)		+= gpio_backlight.o
 obj-$(CONFIG_BACKLIGHT_HP680)		+= hp680_bl.o
 obj-$(CONFIG_BACKLIGHT_HP700)		+= jornada720_bl.o
diff --git a/drivers/video/backlight/generic_bl.c b/drivers/video/backlight/generic_bl.c
deleted file mode 100644
index 8fe63dbc8590..000000000000
--- a/drivers/video/backlight/generic_bl.c
+++ /dev/null
@@ -1,110 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  Generic Backlight Driver
- *
- *  Copyright (c) 2004-2008 Richard Purdie
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <linux/mutex.h>
-#include <linux/fb.h>
-#include <linux/backlight.h>
-
-static int genericbl_intensity;
-static struct backlight_device *generic_backlight_device;
-static struct generic_bl_info *bl_machinfo;
-
-static int genericbl_send_intensity(struct backlight_device *bd)
-{
-	int intensity = bd->props.brightness;
-
-	if (bd->props.power != FB_BLANK_UNBLANK)
-		intensity = 0;
-	if (bd->props.state & BL_CORE_FBBLANK)
-		intensity = 0;
-	if (bd->props.state & BL_CORE_SUSPENDED)
-		intensity = 0;
-
-	bl_machinfo->set_bl_intensity(intensity);
-
-	genericbl_intensity = intensity;
-
-	if (bl_machinfo->kick_battery)
-		bl_machinfo->kick_battery();
-
-	return 0;
-}
-
-static int genericbl_get_intensity(struct backlight_device *bd)
-{
-	return genericbl_intensity;
-}
-
-static const struct backlight_ops genericbl_ops = {
-	.options = BL_CORE_SUSPENDRESUME,
-	.get_brightness = genericbl_get_intensity,
-	.update_status  = genericbl_send_intensity,
-};
-
-static int genericbl_probe(struct platform_device *pdev)
-{
-	struct backlight_properties props;
-	struct generic_bl_info *machinfo = dev_get_platdata(&pdev->dev);
-	const char *name = "generic-bl";
-	struct backlight_device *bd;
-
-	bl_machinfo = machinfo;
-	if (!machinfo->limit_mask)
-		machinfo->limit_mask = -1;
-
-	if (machinfo->name)
-		name = machinfo->name;
-
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = machinfo->max_intensity;
-	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
-					NULL, &genericbl_ops, &props);
-	if (IS_ERR(bd))
-		return PTR_ERR(bd);
-
-	platform_set_drvdata(pdev, bd);
-
-	bd->props.power = FB_BLANK_UNBLANK;
-	bd->props.brightness = machinfo->default_intensity;
-	backlight_update_status(bd);
-
-	generic_backlight_device = bd;
-
-	dev_info(&pdev->dev, "Generic Backlight Driver Initialized.\n");
-	return 0;
-}
-
-static int genericbl_remove(struct platform_device *pdev)
-{
-	struct backlight_device *bd = platform_get_drvdata(pdev);
-
-	bd->props.power = 0;
-	bd->props.brightness = 0;
-	backlight_update_status(bd);
-
-	dev_info(&pdev->dev, "Generic Backlight Driver Unloaded\n");
-	return 0;
-}
-
-static struct platform_driver genericbl_driver = {
-	.probe		= genericbl_probe,
-	.remove		= genericbl_remove,
-	.driver		= {
-		.name	= "generic-bl",
-	},
-};
-
-module_platform_driver(genericbl_driver);
-
-MODULE_AUTHOR("Richard Purdie <rpurdie@rpsys.net>");
-MODULE_DESCRIPTION("Generic Backlight Driver");
-MODULE_LICENSE("GPL");
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 0f425b32e6be..8f2005a6f8a9 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -454,15 +454,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
 	return dev_get_drvdata(&bl_dev->dev);
 }
 
-struct generic_bl_info {
-	const char *name;
-	int max_intensity;
-	int default_intensity;
-	int limit_mask;
-	void (*set_bl_intensity)(int intensity);
-	void (*kick_battery)(void);
-};
-
 #ifdef CONFIG_OF
 struct backlight_device *of_find_backlight_by_node(struct device_node *node);
 #else
-- 
2.25.1

