Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0B1D6BE3
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgEQTBw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTBv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:01:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393E7C061A0C;
        Sun, 17 May 2020 12:01:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so6112624lfb.3;
        Sun, 17 May 2020 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnGgD3EY2jc/ddlIc7dBV262lNj4TMCpBFkInlI9rBA=;
        b=YLg+lhCgBEEBqKJatWX0oNegoMaaysitawJfeATyjsFJhoPf0zO1armnUFjYOPMN+y
         VQhgIyxhgETI5Uz7YiuT3YCPZZL9ojyppZB1A+FgiEiRme4ii9ZessuxKf8rMIiX4KYt
         uXqMH/qs8dhlAjTQ6kMXcPl0lSH81KfU8EUKceF6y8noYXdEaGzt7xGYqlsO2Pnbetih
         UW08sv+ggB5rJ5n3vxZqJrUXeSdESogjvx3K0VtyQ1tjcU/wALa0GmLdD/dDtq1zP2os
         /yJtfx2wQh7BDdlar9vZgyMuuoNF067strqLO1U7HLFMV74q1vORX3vdKxJsLggcURHv
         7kXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=nnGgD3EY2jc/ddlIc7dBV262lNj4TMCpBFkInlI9rBA=;
        b=gM5dg87xFvGc/ilL3mP/g/dlRJ74ZyahOGoFll0Epht6OZLEKUN/aEr8H1v+oOu9Lp
         9C/rGuOkoDCKQZp0gSueHTiK3WdzlEQDjmlhpbT8DpK5F8TzV+pxxczts0cO28FWO6jk
         Ekncmr/eaCQQOIBAqess+lBiMFZ9FT0zDiI8qa8FolsLRTwmehlraqiQGRLjtqwEQDCi
         fN95oOBLFLyYPiai+hXIP3hQbIuJZNVDOi+Gkjo9WIAVqQQsQTlZm+woSaf5Tc6grzA4
         EXBh6NDkqSmWwDeUFPLJy3rmNGZi29OYZMUZWUURSxVo0q1Bzvi52Fk9fPQGKqVKd7Yp
         LUcg==
X-Gm-Message-State: AOAM532FfDcEhq1XJxWbMR2tBrXj23WlqGJsyRBbFTY2BiOTM0RLLmLV
        m2wXVS5XaSt8J0tESY2Br5o=
X-Google-Smtp-Source: ABdhPJy1vsYcgSkrn+HiZuSyph//uXWOOAOWkZC/5Xq9lJB0T2P/RlMecE5wtR8SB6YidOCu9FB1vg==
X-Received: by 2002:a19:c6c2:: with SMTP id w185mr7499670lff.69.1589742109709;
        Sun, 17 May 2020 12:01:49 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:01:49 -0700 (PDT)
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
Subject: [PATCH v2 01/16] video: amba-clcd: use devm_of_find_backlight
Date:   Sun, 17 May 2020 21:01:24 +0200
Message-Id: <20200517190139.740249-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Look up backlight device using devm_of_find_backlight().
This simplifies the code and prevents us from hardcoding
the node name in the driver.

v2:
  - Added Cc: Peter Ujfalusi

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
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

