Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 410012250A6
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgGSII1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSII0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E115C0619D2;
        Sun, 19 Jul 2020 01:08:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q4so17106112lji.2;
        Sun, 19 Jul 2020 01:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aaf0m4BLcrTG4bMWWq/JZ557CUtwpSzBtZ2OTxRtuus=;
        b=GpOG2BPM6f5ErHn2xTcOlwxzr5xwmH1d1aGpPaEJPXsgMC4QDyfeZkFgghp4piUO8y
         +5C+T+Kzr12eQ4+Bk2Hqer/2yy12yeqTyT7HNh7UzFPgTdfMsOBXc7STcsT1pvDYNcM9
         ZbRlkNGMg34d9eYoXgR11qZ/5w14LeYcXhahnHNYTDFo9kIK7P0n2A0XEz9aYqw2hOaQ
         xMFk/+HZXNv9fG0MC8hrMKlb9tqBjTmh4OIe0tJEmjg3AzIwtDTQQnp6Owj+nlPrOHSn
         bh7VsAmWwEnU/mdJVN69dukCa6B0wytKhRD7zJ+SK/emst/IpfnyLSRkJo7DImz0sgfI
         AjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aaf0m4BLcrTG4bMWWq/JZ557CUtwpSzBtZ2OTxRtuus=;
        b=jVvLoVjgEkBmsmRHD3YrMNepwyLmwP0x3M/pxL1HsvSnOnfopbClkkZXZT+FYx2SRc
         N61wKiVDZYBPv9iJsoqWbnDXwZ4f0mShfM30oI+ej34NAO8adC57lJuZQ9oZCuDo1qT5
         OHZsAWcVuRsocWYIbkj8Z005IW3SxSs89H8HsbxnvBuujjzSeXKnMhDlvdfoIN0cxqTX
         MClEgxB13kY3Q/UxLNpizoBzZ43IbVyN3mKRwUYmWnSUElIB9QVWfQpdbQy1/D7dUHy7
         mt4H8DKQkgbyOcWinL4fzdKD/sQ1Ixd3R1ckPVZ2RNHKdQto3Q832HZysjAFIEy6oimF
         nu7g==
X-Gm-Message-State: AOAM5305Ac7PiXOzUPusFYSftEWUeIwhFnmznKnQobNJZK137sQaJP/U
        i1XAx4FOhuCkJ/ja4su49mk=
X-Google-Smtp-Source: ABdhPJybMbA1pMekauiLuL0JlrMRVGGlU0yp7hTxsmGJsZ92Yg3niEUhn+aR9X1ycKIdPJ3lX4crwQ==
X-Received: by 2002:a2e:5806:: with SMTP id m6mr7129681ljb.23.1595146104801;
        Sun, 19 Jul 2020 01:08:24 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:24 -0700 (PDT)
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
Subject: [PATCH v5 15/19] backlight: gpio_backlight: simplify update_status()
Date:   Sun, 19 Jul 2020 10:07:39 +0200
Message-Id: <20200719080743.8560-16-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
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

