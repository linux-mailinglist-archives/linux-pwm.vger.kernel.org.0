Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D01D6BE5
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgEQTBy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTBy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:01:54 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E6CC061A0C;
        Sun, 17 May 2020 12:01:53 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 202so6098569lfe.5;
        Sun, 17 May 2020 12:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjJ5TugtFafrUz9tMvPPgVQeP2vZZBra/hz3unCyA74=;
        b=MBqCIzMBzSoOolD7CgrY2zj0/KHIoG36rEIfx7ECTna0EC3p5iLR4b/hOYxmvMtbrF
         r3fgL0Dh3VOuQpLUF+rJRTN6sHztUxB/HIlATnfHC/lrsakMSQAI+Hjb6567eMQbnaFy
         SQWkFUg/MZ0CoirDiSQw8YfLT82cn4bNLYwLNVSJHLAlvMdRCDWHCWw/pMbbljMYXQLr
         oDe+T7l9Y7hAi43iNeWCi8BIY5i1vgm/Ky7y6n8g3uf18f6U0XizJMLnpMXcl0ACK1k9
         dU7G3vbOsfyCmjFk5qfgkpisuxuEvwI8+Aa2PddgaTsYAQM9xX6pLNIRqH0FSOIERZqM
         BTlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zjJ5TugtFafrUz9tMvPPgVQeP2vZZBra/hz3unCyA74=;
        b=kcchXUW46pNWIu3pGNfFYLe1t/crxM4KTytropAeTE6cEHdtFf6ba+FryXQOE4L3re
         CX2DwJKDRDg785fboVHx1Sztl7vdg7aRuViHHXWI0oG82Gx7pX8l7oUfPFGX+c7XPiHt
         sIJH6YAtK4l0+BAIbmH6DRZzwdaLYD74AxMo3wJbPqPW+geQh6hVvvqq1on8n3BpSwWr
         nOLpNz3yraERsCTeUOoAIRC85GWXL168UV5ZREIq/ypH03qAUgviigrTDzdjwI171eRd
         /VE4Har1cFbtXGJd8QazJiodlPJEldnPxteZCcg7zfDIMmxrjMhN6ugHY4TePQ0OAGHo
         vsIw==
X-Gm-Message-State: AOAM531b1m2VCl1dA9VTb2uSlrwKOttJWlecFmGKp1G6xNNYpiHY5P42
        VEfb8b/f1x1tkWL3lph6Tos=
X-Google-Smtp-Source: ABdhPJyNQwf2WU45rn3WQtz7QrQncxMhX+3U6IFhIvsSFjKrU8q+k0a/Ycqya6mgzGXcxDkRhBNa9A==
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr9295868lfm.40.1589742112363;
        Sun, 17 May 2020 12:01:52 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:01:51 -0700 (PDT)
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
Subject: [PATCH v2 02/16] backlight: refactor fb_notifier_callback()
Date:   Sun, 17 May 2020 21:01:25 +0200
Message-Id: <20200517190139.740249-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Increase readability of fb_notifier_callback() by removing
a few indent levels.
No functional change.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 43 +++++++++++++++--------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index cac3e35d7630..17f04cff50ab 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -58,28 +58,29 @@ static int fb_notifier_callback(struct notifier_block *self,
 
 	bd = container_of(self, struct backlight_device, fb_notif);
 	mutex_lock(&bd->ops_lock);
-	if (bd->ops)
-		if (!bd->ops->check_fb ||
-		    bd->ops->check_fb(bd, evdata->info)) {
-			fb_blank = *(int *)evdata->data;
-			if (fb_blank == FB_BLANK_UNBLANK &&
-			    !bd->fb_bl_on[node]) {
-				bd->fb_bl_on[node] = true;
-				if (!bd->use_count++) {
-					bd->props.state &= ~BL_CORE_FBBLANK;
-					bd->props.fb_blank = FB_BLANK_UNBLANK;
-					backlight_update_status(bd);
-				}
-			} else if (fb_blank != FB_BLANK_UNBLANK &&
-				   bd->fb_bl_on[node]) {
-				bd->fb_bl_on[node] = false;
-				if (!(--bd->use_count)) {
-					bd->props.state |= BL_CORE_FBBLANK;
-					bd->props.fb_blank = fb_blank;
-					backlight_update_status(bd);
-				}
-			}
+
+	if (!bd->ops)
+		goto out;
+	if (bd->ops->check_fb && !bd->ops->check_fb(bd, evdata->info))
+		goto out;
+
+	fb_blank = *(int *)evdata->data;
+	if (fb_blank == FB_BLANK_UNBLANK && !bd->fb_bl_on[node]) {
+		bd->fb_bl_on[node] = true;
+		if (!bd->use_count++) {
+			bd->props.state &= ~BL_CORE_FBBLANK;
+			bd->props.fb_blank = FB_BLANK_UNBLANK;
+			backlight_update_status(bd);
+		}
+	} else if (fb_blank != FB_BLANK_UNBLANK && bd->fb_bl_on[node]) {
+		bd->fb_bl_on[node] = false;
+		if (!(--bd->use_count)) {
+			bd->props.state |= BL_CORE_FBBLANK;
+			bd->props.fb_blank = fb_blank;
+			backlight_update_status(bd);
 		}
+	}
+out:
 	mutex_unlock(&bd->ops_lock);
 	return 0;
 }
-- 
2.25.1

