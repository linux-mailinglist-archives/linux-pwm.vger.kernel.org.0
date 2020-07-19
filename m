Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61C06225085
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgGSIIG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF2AC0619D2;
        Sun, 19 Jul 2020 01:08:05 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id x9so17028659ljc.5;
        Sun, 19 Jul 2020 01:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BtmQn9giIZ5hxkwK3X6Uyd4+tt3rw+QxpQWl1Fgi+8Y=;
        b=m0o1tttwiUHt1WthakYIAwHFJ59daNJuz7IVB3JnCyaZz0w7mCjJ6LFSRCTv1VSwCd
         WXK46r7kRAh+iTw/TMN2yFIF+J9Z8mQ+ZOKP6H0DnZyADjwr3ngY0Qlt7IUpeY4EgNKz
         dh4WdXxzgKKv4/eDRbaqG5OfpsJLDgpYA5t1j4z8bRM+5efzTQOQNmboEntDAeywWq6u
         OtZeAcZSyLtZ5r0FXfHxbTGFA4kmecbigeHMZYRGnelcJ4srnqjv5hHeSSzTx14452Lh
         Zy6F72vANE1PNZsduLIbAhqqbYAh3Vzrbpjba5Yy1ZtuJYSkPM/OcQ4ieOqMd20JiUQO
         GpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BtmQn9giIZ5hxkwK3X6Uyd4+tt3rw+QxpQWl1Fgi+8Y=;
        b=Mzq7v6UHdz76edCUVpAPdTOMtk2QA1FSQo+F4sHI7+DD+vM5xTIBIE2C7RgZVV63Fj
         p8fWf7Fc6zfNnNkLccXI711i1SVlOJJbO2AMb7qD7sF8FcmG9gO2r3iidybe+0ig3T9U
         Ahn114xx5yN/QOrI0wkgIJOUMRueK6MWRr2dOQVYPDuHLURWPEKm04lXQ5EEemqyLy9B
         lyLaFAcV7G1+geQa9EUKobanTL6edawmYNgeNmoaXCl0YV/Y0+hAzlIHJsZgWclfbVGg
         awqH046UPQQGVy2ClQybcWRT+GfggneXArynyxgCWPq/EbQcFgnfrSpUO3O+uVtzDOha
         EXDg==
X-Gm-Message-State: AOAM5315cblYmRKCzIt14mG2Evvv1sCbs/mCvpyJre7VNMnLUcp/BYFx
        OCFEUyF9MvcCP/i+mElcTm8=
X-Google-Smtp-Source: ABdhPJycJq2U5Syxryg3drCdjc+s82C7Kvu1qoBVnwr5waApqzSlh47x0jMk/YdughkLZ1ra3potHQ==
X-Received: by 2002:a2e:9e5a:: with SMTP id g26mr8280144ljk.207.1595146084147;
        Sun, 19 Jul 2020 01:08:04 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:03 -0700 (PDT)
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
Subject: [PATCH v5 01/19] backlight: refactor fb_notifier_callback()
Date:   Sun, 19 Jul 2020 10:07:25 +0200
Message-Id: <20200719080743.8560-2-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 43 +++++++++++++++--------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 744ba58488e0..18501956dd87 100644
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

