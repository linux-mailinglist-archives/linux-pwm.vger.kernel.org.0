Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4F8213F8E
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGCSqg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCSqf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:35 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4913EC061794;
        Fri,  3 Jul 2020 11:46:35 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id t25so33478501lji.12;
        Fri, 03 Jul 2020 11:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yEjF7pEN/xrGxy0935aYNV70k+jmMYiQOI/9QnjZUaY=;
        b=kGXo9YiHByb/ZdboHuQZf8/EXqVwrUOLV9K0C5ghuKRYxJjlsf1mC0LWPcUal83U3e
         T0NSF9MKhwJ9kEvgnNnnDN1t2KVI47sT0lxaLwGz7KhVbKvICydANUR8r0UECtRAnNo4
         sp11uPYqiDOWsw90j4YKvQ8YGCI6nEzY+3hajSV2DjnNctILaLi29pooDiv/3JlfcmFN
         CudZEwUe0wsT7+YCX4E3CkwvdzbZe0bltiUrqFPzZBgpg0G3VCnFsLxJRWsA+uLAtyKC
         S0SkhTxqUhvYc3BjntJLaG8/zLUt4V//9sY3veBe0vSrzuLckbEkE3RCOWUoVb6A++2U
         55rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yEjF7pEN/xrGxy0935aYNV70k+jmMYiQOI/9QnjZUaY=;
        b=sa3G6L69wyztnGAxlk69qqEhloQtHHAVDp6jtqB7egngDcITyySBbx4f5eiVz0bt3d
         MXYsy2R65JLt33xcRVUSY19WjibcsbW4ZNFX+2jM/m3VT4At6C0JTP1J/ihXXgsubalQ
         3elhadF2GmqNUvUGGSFokr546bIIbaHckF7AoPwvo2P3oO/eI83+707tgHbiBa4oaX+S
         FOSESNW+MS+D98N1KpmVCQU45Riw7ZtDr3WZk6DTwkCWsmKxQ3zkVk1TxAdeOxEmJthu
         6UmwJ2WRSVmOzyABXqZGeEMRPtkbAIUpw0a7Ab4c08pKdxr68sKJgG6/aggZVKPH0qQ7
         xyXQ==
X-Gm-Message-State: AOAM5313rMnkdJTKeinWiZztsRwq/vnUzcvuMR/HPQJAdQO1FIf5zRdO
        dWt2CNffc28MuQTbOevr7wE=
X-Google-Smtp-Source: ABdhPJzXfRgTjlP6hr/OlcHKewcVR9hdREuWmRp2p6dKhsVeuObmf+HrkvtKNrQTf3gBMQArzdojCQ==
X-Received: by 2002:a05:651c:3c2:: with SMTP id f2mr20912755ljp.37.1593801993807;
        Fri, 03 Jul 2020 11:46:33 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:33 -0700 (PDT)
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
Subject: [PATCH v4 15/20] backlight: gpio_backlight: simplify update_status()
Date:   Fri,  3 Jul 2020 20:45:41 +0200
Message-Id: <20200703184546.144664-16-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Introduce the use of backlight_get_brightness() to simplify
the update_status() operation.
With the simpler implementation drop the gpio_backlight_get_next_brightness()
helper as it was now a one-liner.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/gpio_backlight.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/backlight/gpio_backlight.c
index 75409ddfba3e..6f78d928f054 100644
--- a/drivers/video/backlight/gpio_backlight.c
+++ b/drivers/video/backlight/gpio_backlight.c
@@ -21,24 +21,11 @@ struct gpio_backlight {
 	struct gpio_desc *gpiod;
 };
 
-static int gpio_backlight_get_next_brightness(struct backlight_device *bl)
-{
-	int brightness = bl->props.brightness;
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
-
-	return brightness;
-}
-
 static int gpio_backlight_update_status(struct backlight_device *bl)
 {
 	struct gpio_backlight *gbl = bl_get_data(bl);
-	int brightness = gpio_backlight_get_next_brightness(bl);
 
-	gpiod_set_value_cansleep(gbl->gpiod, brightness);
+	gpiod_set_value_cansleep(gbl->gpiod, backlight_get_brightness(bl));
 
 	return 0;
 }
@@ -108,7 +95,7 @@ static int gpio_backlight_probe(struct platform_device *pdev)
 
 	bl->props.brightness = 1;
 
-	init_brightness = gpio_backlight_get_next_brightness(bl);
+	init_brightness = backlight_get_brightness(bl);
 	ret = gpiod_direction_output(gbl->gpiod, init_brightness);
 	if (ret) {
 		dev_err(dev, "failed to set initial brightness\n");
-- 
2.25.1

