Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284E31D3CD1
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgENTKX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730284AbgENTKW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD888C061A0F;
        Thu, 14 May 2020 12:10:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f18so4723558lja.13;
        Thu, 14 May 2020 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvAqoIVnlBgyd68hnn1WiT3rXHhwfxcl0UeJKweLhko=;
        b=OaZrLbTWdUNdE4LXccXwIoqLV+2ksJ4Yz7Tv7vBdYId/RUkl1J0RJkHGPtLE+qYQGD
         A3lwKWbkJx/maHhmD8hyeQvedIL+YgJAm5IIMnc/f7FcnwTB+mkaVDOussWdSjd3TC95
         S4SVAwpqeGMuoL4PsU0pdB46yS0P/3VYKCz04GBoWP+uMYBLflp74lTTunGciS/ZNmI2
         AEWlRbgNES13Gr1h6jAp6FjKHLxqsvKiEeYOrZJwoKwadRo0GU8h5epYANQi32oo8O7i
         QAF7LXsTMpCAxVGAamcGOH1pWHqo7ppeP4H5AKbRB2xrYCxVnfxd14kZBurnDchUwezT
         QTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=uvAqoIVnlBgyd68hnn1WiT3rXHhwfxcl0UeJKweLhko=;
        b=Ss7pwryxiCm60sPiT/rippAkBoNsVxr2Mnm1uzE/WqpGLnoAlSovMLbkQEbLbxB+Y7
         a/EngUzVcdeLNPuvBQnsgIR5TI09sSAAJi4cKYVfFPwO6fDgS6l1qej6/nl38LwRaLuh
         yK6FOjWUFwPVoGG/8FYq+c5LgINwfiDmlroOGSxDFVBTAmPn1rr3s68JAFVQ2kEfQX4Z
         QPFuyRhU6ld/324UYTfuDmsf5v6oKOrto+r/F2m1WddN15itXDXSGF5in7rxv0I5cnp0
         tIybGY9rYi4MwGkFKrJrl8YYO46aE/EojxXZQZ39hAzL5iZXZs3HGrpCW3xgm1DISAmR
         1x7A==
X-Gm-Message-State: AOAM530Rar9j/zpOVtqKroRi3bxdVjEkz7SKwV+NYO+9saamAIeyaS+t
        ycuFWRfMXuf/Z0WbdwEFKFM=
X-Google-Smtp-Source: ABdhPJz1wwUxhhbKyXbGPZbBiIEsG4KEM76cKxu9cIh2796pYawzu/mXE3iTzXyvDvGKAApNYB578A==
X-Received: by 2002:a2e:8805:: with SMTP id x5mr3852963ljh.223.1589483420269;
        Thu, 14 May 2020 12:10:20 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:19 -0700 (PDT)
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
Subject: [PATCH v1 03/18] video: amba-clcd: use devm_of_find_backlight
Date:   Thu, 14 May 2020 21:09:46 +0200
Message-Id: <20200514191001.457441-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Look up backlight device using devm_of_find_backlight().
This simplifies the code and prevents us from hardcoding
the node name in the driver.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Douglas Anderson <dianders@chromium.org>
---
 drivers/video/fbdev/amba-clcd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba-clcd.c
index c3d55fc6c4e0..b7682de412d8 100644
--- a/drivers/video/fbdev/amba-clcd.c
+++ b/drivers/video/fbdev/amba-clcd.c
@@ -602,20 +602,17 @@ static int clcdfb_snprintf_mode(char *buf, int size, struct fb_videomode *mode)
 			mode->refresh);
 }
 
-static int clcdfb_of_get_backlight(struct device_node *panel,
+static int clcdfb_of_get_backlight(struct device *dev,
 				   struct clcd_panel *clcd_panel)
 {
-	struct device_node *backlight;
+	struct backlight_device *backlight;
 
-	/* Look up the optional backlight phandle */
-	backlight = of_parse_phandle(panel, "backlight", 0);
-	if (backlight) {
-		clcd_panel->backlight = of_find_backlight_by_node(backlight);
-		of_node_put(backlight);
+	/* Look up the optional backlight device */
+	backlight = devm_of_find_backlight(dev);
+	if (IS_ERR(backlight))
+		return PTR_ERR(backlight);
 
-		if (!clcd_panel->backlight)
-			return -EPROBE_DEFER;
-	}
+	clcd_panel->backlight = backlight;
 	return 0;
 }
 
@@ -717,7 +714,7 @@ static int clcdfb_of_init_display(struct clcd_fb *fb)
 	if (!panel)
 		return -ENODEV;
 
-	err = clcdfb_of_get_backlight(panel, fb->panel);
+	err = clcdfb_of_get_backlight(&fb->dev->dev, fb->panel);
 	if (err)
 		return err;
 
-- 
2.25.1

