Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB3BD1D6BFB
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgEQTCN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC1FC061A0C;
        Sun, 17 May 2020 12:02:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c12so2642980lfc.10;
        Sun, 17 May 2020 12:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQZMMaGfqoi+nADi25Ypq2G/dZHLYYCICAgFTmP8RIc=;
        b=HweipH6xBglnREByvV2nwMRID1YgCAcZyMc5G74M6ZgVg0fZq3Z34blvDim3Ei6jFV
         BB8SfoboS6DVONa+DpoguoLa07X5hA07mT6phWTw9jdkv+xYO8rwRs0zziPvka0UYfvV
         CTZoml5v/lV79dhSyT6ZnO/zNtjRkKSkfemh09I29vNB2nOc/e0plrUzM0P4O07escm0
         +TjJuOXkfEVTF6M8pVNTs97MSdP6g5viVQR4gvFZpTBRubN2zFjZjWAvCU43bpeX9BmH
         ryfy9oM6ptSvJcu2W+Qy586FJuWzOO+OXGmEo139Q7DwlYZgcDVi+Aqq2Q+7jmX+d+qJ
         DDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OQZMMaGfqoi+nADi25Ypq2G/dZHLYYCICAgFTmP8RIc=;
        b=abuiSUCewZZVwAzy/dz+3QkQfXmByFDpOK8niwQleJlPFgvhuC7reh/VEF2v2qirpu
         7A+YJ0R2NAysmLSiQ0IJEs0to8LKRw9KM1whHht3CPEALM8J9BErA3bvz1CMcxdmj8Ya
         APED14dpEsKsff7eK10RRvMXVg7A/o7xzLqtAq8Yt4FPRlM1QHMUD/iNHh5Z0fYDuQkp
         qgfXfSTN6oRleHWNos9ymotmC94ymUPO+gxGFqH9TAzct+12A3amljWG8Ch6rNudBxQT
         c7SMus5oikgZ3P1PpYbQbdPKotAdkXVGITPI3AK6tSo11lr2U2eechhmq7T+KpjJL9HP
         NImQ==
X-Gm-Message-State: AOAM532s4EJbyY56AIsx+YLBw+N2KSfhV3aSVQNHA8nwaoYRJIjS6CSc
        jqvzkVRGTybDVlB0aEgIUI8=
X-Google-Smtp-Source: ABdhPJwCSnCN/yeFIkM0E+0+3bg1RzFwItQXVzoLrUv6t99Ftn9GL48DZbBRvzABkvv/g49vMdpTYg==
X-Received: by 2002:ac2:4304:: with SMTP id l4mr9059863lfh.87.1589742131174;
        Sun, 17 May 2020 12:02:11 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:10 -0700 (PDT)
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
Subject: [PATCH v2 09/16] backlight: remove the unused backlight_bl driver
Date:   Sun, 17 May 2020 21:01:32 +0200
Message-Id: <20200517190139.740249-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The driver required initialization using struct generic_bl_info.
As there are no more references to this struct there is no users left.
So it is safe to delete the driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
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
index b779c29142fd..eae7a5e66248 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -480,15 +480,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
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

