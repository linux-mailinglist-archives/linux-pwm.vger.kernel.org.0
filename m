Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21417213F8B
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgGCSqd (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgGCSqd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:33 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40523C061794;
        Fri,  3 Jul 2020 11:46:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id d17so23371399ljl.3;
        Fri, 03 Jul 2020 11:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yVpNCLVbYK3myT9m7EMLcaTGTbPNg14V6/aAMmsTZXg=;
        b=i+dGOr4EWUC5qQNHs62J7il3yC06m2A2KuvuM3yYcl8cBQLVGR/s0evNAyTgE2gcL6
         dWM2JmoB1nEH4m+EYd1sCOmt3eIF/qSD7cZpMCla1tgSHcPn3R1KzFxnVTBbu9kTJT2y
         aafHd4s88I8gQloKgllw6AvfV24E3rSHtJlq8RijQRAL1lodcrvg1nnftOj8st6usR+0
         PsXVhep4vXi2W4d/pWgkuUwF0/Te/s3OVe3iGYVC8UcWYURMgEPbhgdk9J1LKcar7g3d
         0o/cx9EmYbM7MdzAHLxShbbqr/ReRkLyGSIA8Vpz2tb6VpphFmQ9P43mLiEKCAk0krZz
         qfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=yVpNCLVbYK3myT9m7EMLcaTGTbPNg14V6/aAMmsTZXg=;
        b=NesniCjanxznVwz3lTFYRK0UZJNDW2a6R7DjIfyf0kqQdkK+8aCuh1QivI6S3UOI75
         WCidgnKgj3AM2nsL3Q+goEF/+eRIS/KzrUNTPXz703bfCznFVV2hqaiUdE2s/YFFWdac
         Cf9aip4D8WRB3jaZXqPOvbexvTC9OQDB4hLWf9uQGnfaJCPOtr/BVTVF6siqRa9UJxmQ
         LwvScHViqbAuUcKcUfSB4WX2FtRZEf9kO5zJuOVw096jyQWwHYklJXOu/E5YoGG5S6ZW
         CfneC9dw4IxZtlIv6tk1Ct646JlPUJj5j6b3VdBwj3uXn8c9MmDD+K6s8KfJun+13zeQ
         cfcw==
X-Gm-Message-State: AOAM532FzcZnisw7bD7yeEUPtwzXDcJh/RW5VD5guqby6ASXrBv8jPxB
        lWb/AEgYT+QY0RPPWaLLGPg=
X-Google-Smtp-Source: ABdhPJz6ywgEAki17QCT6lxB5XBqQ6/MR1UrT5bX2iXgmUlYUHpArI48qZ8zUwJ276Dr8lVs/vVFZA==
X-Received: by 2002:a05:651c:1a7:: with SMTP id c7mr20688976ljn.345.1593801991763;
        Fri, 03 Jul 2020 11:46:31 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:31 -0700 (PDT)
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
Subject: [PATCH v4 14/20] backlight: cr_bllcd: introduce backlight_is_blank()
Date:   Fri,  3 Jul 2020 20:45:40 +0200
Message-Id: <20200703184546.144664-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The cr_bllcd uses the FB_BLANK states as brightness.
This results in brightness value equals 0 that turn on
the display and 4 that turn off the display.
Simplify the logic but keep current behaviour
as userspace may expect brightness set to 0 to turn on the display.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/cr_bllcd.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index 4624b7b7c6a6..edca5fee9689 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -63,22 +63,16 @@ static int cr_backlight_set_intensity(struct backlight_device *bd)
 	u32 addr = gpio_bar + CRVML_PANEL_PORT;
 	u32 cur = inl(addr);
 
-	if (bd->props.power == FB_BLANK_UNBLANK)
-		intensity = FB_BLANK_UNBLANK;
-	if (bd->props.fb_blank == FB_BLANK_UNBLANK)
-		intensity = FB_BLANK_UNBLANK;
-	if (bd->props.power == FB_BLANK_POWERDOWN)
-		intensity = FB_BLANK_POWERDOWN;
-	if (bd->props.fb_blank == FB_BLANK_POWERDOWN)
+	if (backlight_is_blank(bd))
 		intensity = FB_BLANK_POWERDOWN;
 
-	if (intensity == FB_BLANK_UNBLANK) { /* FULL ON */
+	if (intensity != FB_BLANK_POWERDOWN) { /* FULL ON */
 		cur &= ~CRVML_BACKLIGHT_OFF;
 		outl(cur, addr);
-	} else if (intensity == FB_BLANK_POWERDOWN) { /* OFF */
+	} else { /* OFF */
 		cur |= CRVML_BACKLIGHT_OFF;
 		outl(cur, addr);
-	} /* anything else, don't bother */
+	}
 
 	return 0;
 }
-- 
2.25.1

