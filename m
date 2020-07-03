Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD6A9213F68
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgGCSqJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgGCSqI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:08 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70629C061794;
        Fri,  3 Jul 2020 11:46:08 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so38026124ljm.11;
        Fri, 03 Jul 2020 11:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eK/aZ3+ghdIFopzJxrnMF+M6xcoKuP5T0HDHhE7PCRE=;
        b=Kh0cYIP7f7GRh0jsMz67pBF5ogXJKQ7HBpCm8kOupB7NNCNTYuS2nhr5cYKlAV+XZk
         +t40EIa7T2OjEBA2E+1hU9CV+xVscjQY0tBenF6ouGcNayV9g8TqXWkIkH2b5DIoDRR+
         XvE1O8abD1mm/wxeD2v/SUMBPRUzX6C3k2mDiil6gHNrfozZtmf71iXfvGav2UEZaLH4
         BusJhlRNqdQmxRObtWc2I6ed/YOAA3XU9yWcdfbiJG5PIwEKUJBXc8MeIoiJJxsNxMo4
         rXkO/YJ0N3+JDrdboHmgth5Pct86Gvn9qT7he86M5Xyt24uu0PtildaZKF224trgwTUU
         3ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=eK/aZ3+ghdIFopzJxrnMF+M6xcoKuP5T0HDHhE7PCRE=;
        b=X1x9oBaxoo8gy75icZScue3rk6ix6Irby5mMzYpBJtlL1wBFBulMyaR3kVupwIL54E
         tIjoLS1tPrrOlQhESaBI5itZs63X2MySW0SrL342K3SzRLl4J+DKaiBzr/T4EpNLFXhm
         iu+G7TBMRagnwemYwQQ/APKK7uVjMCfIdAG4S/ytVbllEqaa8zGS2Eruy2yQAwiKfglL
         t4+gLKqSHjC9BPy/qIbwRnA6ABmxe1YYUDyTQI58tk11PJ5F0nBesoCUln69oJkiZtv/
         U5r6uyZC8Ylog3hbZghcseTPVIQZKEAr+sfe6atxDd1dIZQIRNw0dbonj7O6FZGZD6bD
         9UNg==
X-Gm-Message-State: AOAM530kjVWj9fNlQ2YRzCTO/qEo9RDmC1pbGoMRs3dA7cA4Iwr0b+fw
        vNcLTYm7SR81zOIv5b3TdEM=
X-Google-Smtp-Source: ABdhPJx6f8dy7nC47enwxaN0YU2FjLuW8bB0B5VwVDqrwe5zJLqWBOoRu8fveYQH8mG3ZLmypskStw==
X-Received: by 2002:a2e:99c6:: with SMTP id l6mr14274238ljj.220.1593801966954;
        Fri, 03 Jul 2020 11:46:06 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:06 -0700 (PDT)
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
Subject: [PATCH v4 02/20] backlight: add backlight_is_blank()
Date:   Fri,  3 Jul 2020 20:45:28 +0200
Message-Id: <20200703184546.144664-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The backlight support has two properties that express the state:
- power
- state

It is un-documented and easy to get wrong.
Add backlight_is_blank() helper to make it simpler
for drivers to get the check of the state correct.

A lot of drivers also includes checks for fb_blank.
This check is redundant when the state is checked
and thus not needed in this helper function.
But added anyway to avoid introducing subtle bugs
due to the creative use of fb_blank in some drivers.
Introducing this helper will for some drivers results in
added support for fb_blank. This will be a change in
functionality, which will improve the backlight driver.

Rolling out this helper to all relevant backlight drivers
will eliminate almost all accesses to fb_blank.

v4:
  - struct backlight_device * is now const

v3:
  - Clarified that the fb_blank support in
    backlight_is_blank() may result in functionality
    changes for the users (Emil)

v2:
  - Added fb_blank condition (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 56e4580d4f55..56e51ebab740 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -175,6 +175,25 @@ static inline void backlight_put(struct backlight_device *bd)
 		put_device(&bd->dev);
 }
 
+/**
+ * backlight_is_blank - Return true if display is expected to be blank
+ * @bd: the backlight device
+ *
+ * Display is expected to be blank if any of these is true::
+ *
+ *   1) if power in not UNBLANK
+ *   2) if fb_blank is not UNBLANK
+ *   3) if state indicate BLANK or SUSPENDED
+ *
+ * Returns true if display is expected to be blank, false otherwise.
+ */
+static inline bool backlight_is_blank(const struct backlight_device *bd)
+{
+	return bd->props.power != FB_BLANK_UNBLANK ||
+	       bd->props.fb_blank != FB_BLANK_UNBLANK ||
+	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
+}
+
 extern struct backlight_device *backlight_device_register(const char *name,
 	struct device *dev, void *devdata, const struct backlight_ops *ops,
 	const struct backlight_properties *props);
-- 
2.25.1

