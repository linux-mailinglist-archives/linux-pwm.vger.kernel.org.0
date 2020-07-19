Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15352250A3
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgGSIIZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2BC0619D2;
        Sun, 19 Jul 2020 01:08:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so17078807ljm.1;
        Sun, 19 Jul 2020 01:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pcuwxUbNQ02ezWkTsCzZiUS7wW0ksGl96SStmrqrSfs=;
        b=fi3Bs4uqa9jVLVXLEM0m7dgPj6ibdld6VHgAfosz+EQUhP81hsD2D0IbWFKl0fkIMu
         oUMHCLR7FQptKSyQYl9FYPnjcFzr4WFocEw0LStcfh4EYZEZeOM/ef9dTBn/ZArY5k7s
         TNFlFmjVuDN5oORWxos8GhIV+e2LKsHLVMEK/V/i+48/pl2oxLQXfvxk9eAcOSEF+hFD
         phFmh5BRH7UFxHmchzRiAb+7MnPpppip950Tob6OnfXPKE/NKIUXTMgOjCt4ezmtPXZB
         37+B+frmLwYj5V44HSeI7DtJ+O4X7ibFvuCn+aKp+KKJM5/eHmxVCacmhsjFbNjbnW6a
         8c7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pcuwxUbNQ02ezWkTsCzZiUS7wW0ksGl96SStmrqrSfs=;
        b=W74I1vCJn5FULiXFsSuntBxLGV07O4TUOs1fO8VpVfQLxT36dID8Z4P/EZERSbPAX3
         hYOP4wE/bY/APIh9IRVZ4TNKZ4JjyGA/vr2+vTJex/aTnxmyF1nWd9sEZLo3k05v6OE3
         8VAGKNfdehaykQ09gIAyRLXmLkCTwVkE3aSy1Usv+FIjDGMHZZHvOMuHBskl/k6EOfbU
         PFPr1U4ujp+vrahTGPpxeEeI8LvgjVQ0hawhgjMc8IK/mG0/MCt3cizQ02BYqnK3iMR1
         gr59ZnkYazeIeYF3JbJ8Wrxq2jHAvG/BwJUjqRXWxli9OP7wUI/yWIxZ8Od/yk5y0Mrr
         iASQ==
X-Gm-Message-State: AOAM5318l6C7A0Hjxy81TY43nRMjMYCu5R7g4/LsU41SKQgDwOtGc5V4
        K7WOSRJfNH3zoVVW1/jbkPc=
X-Google-Smtp-Source: ABdhPJw1ENiBQ0uLk0l74mX8NuTfduet72T4huNn0yGXdgzGp3lYKsspmCqsOIqOthPY0/A7OUkyKw==
X-Received: by 2002:a2e:8505:: with SMTP id j5mr590968lji.65.1595146103398;
        Sun, 19 Jul 2020 01:08:23 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:22 -0700 (PDT)
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
Subject: [PATCH v5 14/19] backlight: cr_bllcd: introduce gpio-backlight semantics
Date:   Sun, 19 Jul 2020 10:07:38 +0200
Message-Id: <20200719080743.8560-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

cr_bllcd can turn backlight ON or OFF.
Fix semantitics so they equals what we know from gpio-backlight.
brightness == 0   => backlight off
brightness == 1   => backlight on

Use the backlight_get_brightness() helper to simplify the code.

v2:
  - reworked to introduce gpio-backlight semantics (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/cr_bllcd.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/video/backlight/cr_bllcd.c b/drivers/video/backlight/cr_bllcd.c
index 4624b7b7c6a6..a24d42e1ea3c 100644
--- a/drivers/video/backlight/cr_bllcd.c
+++ b/drivers/video/backlight/cr_bllcd.c
@@ -63,22 +63,15 @@ static int cr_backlight_set_intensity(struct backlight_device *bd)
 	u32 addr = gpio_bar + CRVML_PANEL_PORT;
 	u32 cur = inl(addr);
 
-	if (bd->props.power == FB_BLANK_UNBLANK)
-		intensity = FB_BLANK_UNBLANK;
-	if (bd->props.fb_blank == FB_BLANK_UNBLANK)
-		intensity = FB_BLANK_UNBLANK;
-	if (bd->props.power == FB_BLANK_POWERDOWN)
-		intensity = FB_BLANK_POWERDOWN;
-	if (bd->props.fb_blank == FB_BLANK_POWERDOWN)
-		intensity = FB_BLANK_POWERDOWN;
-
-	if (intensity == FB_BLANK_UNBLANK) { /* FULL ON */
-		cur &= ~CRVML_BACKLIGHT_OFF;
-		outl(cur, addr);
-	} else if (intensity == FB_BLANK_POWERDOWN) { /* OFF */
+	if (backlight_get_brightness(bd) == 0) {
+		/* OFF */
 		cur |= CRVML_BACKLIGHT_OFF;
 		outl(cur, addr);
-	} /* anything else, don't bother */
+	} else {
+		/* FULL ON */
+		cur &= ~CRVML_BACKLIGHT_OFF;
+		outl(cur, addr);
+	}
 
 	return 0;
 }
@@ -90,9 +83,9 @@ static int cr_backlight_get_intensity(struct backlight_device *bd)
 	u8 intensity;
 
 	if (cur & CRVML_BACKLIGHT_OFF)
-		intensity = FB_BLANK_POWERDOWN;
+		intensity = 0;
 	else
-		intensity = FB_BLANK_UNBLANK;
+		intensity = 1;
 
 	return intensity;
 }
-- 
2.25.1

