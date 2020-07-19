Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546C52250A1
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgGSIIY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C55C0619D2;
        Sun, 19 Jul 2020 01:08:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so17106049lji.2;
        Sun, 19 Jul 2020 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cuNmp2Y8twclxYeBZp9lqPlgdVdohaDn7/kP95qzQpY=;
        b=dt0gJHZiY7ngqE3Aru5QIDfzR/4WGSTSyw/onfx1owTURKpd8/LZItKX/EmdKaKww6
         hEY+0zYkVbTNplOGw96iVnVRNjbZWHPDFljhBoUh92L+g8R3zKPSCXN/FlSrE0ZrMQjL
         flVgCJgIHMHSllEEwnLlNoj5rphgeaU/JtmSmf30aDPkRG1UsPQDIXC5AHtRe/ec4dgi
         6j8DGlmB4suQ+Zb6MIlniulvpsxURfSw431sQ8R77cVRxVq/hvOa/CPcLxEbVGpJSnNN
         Ig5KaCsrzH4eiJ7xwYAcyxRQC0geH0KiJ9u8rcjpokzamfO3VgZqFfy0nuIwC3Ivi/aK
         KGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cuNmp2Y8twclxYeBZp9lqPlgdVdohaDn7/kP95qzQpY=;
        b=mgCJ99XL3M66YSxkumFS1TJ4JpMSJHuKcUZeeU6C15bVRKu0NcfTk/z0latTujJz9S
         C++BTp7BFGNB6Aavv2xL48mJhTJK8I3qZy+JANRkpbnjPNN7csw9Nnc+briKzM2u7jyQ
         jCwbRMsMV4ahn/j/76cYYul6MKA37/DbL3RX6xd39qJaTCir2s3lS2jIT33LLrYXomg3
         soSD74zUdUiyJKTbNlfGruqfDGDNPPyi7Ss3SwYXCPDudEMHjw8y78rx96CIMjejPXD0
         qvvhU5IP3WHtY78NyOPA0kZbusJMA8xJW7noe76GCRsAWPoICJfADyK0dl8ob/OuTknz
         73oA==
X-Gm-Message-State: AOAM531HYx+1v1+5zQwwE21aiRTQtOQoGJaGYdgMJGQg5v6zAYB1erCe
        oHOLqqXYl0h115eQfz+Gca8=
X-Google-Smtp-Source: ABdhPJxZxOr0snHuWFqr6G4SGAfzIJ3mgEFuX4BaVmV7mFdW770Cwt5XaQ0uxyD0rDUWC5CdQtyriA==
X-Received: by 2002:a2e:800b:: with SMTP id j11mr7692089ljg.105.1595146101920;
        Sun, 19 Jul 2020 01:08:21 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:21 -0700 (PDT)
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
Subject: [PATCH v5 13/19] backlight: as3711_bl: simplify update_status
Date:   Sun, 19 Jul 2020 10:07:37 +0200
Message-Id: <20200719080743.8560-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Replaces the open-coded checks of the state, with the
backlight_get_brightness() helper. This increases readability
of the code and align the functionality across the drivers.

Futhermore drop the debug prints in update_status().
If we need debug printing then we can add it to the backlight core.

v2:
  - Use backlight_get_brightness()

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
---
 drivers/video/backlight/as3711_bl.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/backlight/as3711_bl.c b/drivers/video/backlight/as3711_bl.c
index 33f0f0f2e8b3..3b60019cdc2b 100644
--- a/drivers/video/backlight/as3711_bl.c
+++ b/drivers/video/backlight/as3711_bl.c
@@ -104,17 +104,10 @@ static int as3711_bl_update_status(struct backlight_device *bl)
 	struct as3711_bl_data *data = bl_get_data(bl);
 	struct as3711_bl_supply *supply = to_supply(data);
 	struct as3711 *as3711 = supply->as3711;
-	int brightness = bl->props.brightness;
+	int brightness;
 	int ret = 0;
 
-	dev_dbg(&bl->dev, "%s(): brightness %u, pwr %x, blank %x, state %x\n",
-		__func__, bl->props.brightness, bl->props.power,
-		bl->props.fb_blank, bl->props.state);
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.fb_blank != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
+	brightness = backlight_get_brightness(bl);
 
 	if (data->type == AS3711_BL_SU1) {
 		ret = as3711_set_brightness_v(as3711, brightness,
-- 
2.25.1

