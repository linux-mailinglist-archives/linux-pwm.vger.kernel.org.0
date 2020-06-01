Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF1B1E9E79
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgFAGwW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFAGwW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA793C061A0E;
        Sun, 31 May 2020 23:52:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m18so6757404ljo.5;
        Sun, 31 May 2020 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=18JbutLa3sEGZU8ji80y4T0HOoe/GimoCUZDbVyKY0E=;
        b=e2Fj5MogkKmmlicpZQIOcwOKcfsndqV5JSgZlnOJPZKp5N41Qkoah2I5L+kq+0n5xH
         3wTRhIuHGWcFmhJecE6nLFQQEAgNEn0P5D72ORGOutadmzwdvFMXCoQlxfbmN+Myklzl
         rguVPFRYjbKEkUFrlPWeF5147m7T/7ELoYom48Fdu1C/F1qH4wKFR76529LX2cTBtgDz
         J5NlM9AJ/0Z7WJGmQPmbZ/x5QYxm5SBp2RdyIl0DAAuuUC7YBSK/2J2uKFoL0ntMGdnK
         dHZ/3Wy/+sVKJtZtQe2kQ67mTFb5aOlSC8FdrBm5kiY5ybts/i67pwFqK7AJm3E0cJYN
         1jfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=18JbutLa3sEGZU8ji80y4T0HOoe/GimoCUZDbVyKY0E=;
        b=VABIJrX0Da4XIj75CQtWiQqduaUd+9VtLvLy0UI3kYOIa6kNTW9wgYakp0vYtzXaKp
         fxOLwVyjBj0jpdrTT5bFFa6BX1FMk0fCIV/Ew8lG5cBEH3KJEhyjStL7b9JpueVLFviq
         N0Dxg1ecxoCNIqNsEuwSizfrxBDpqVDAwMbnqckSXVGOwcwci3IldUbG0MzU074ijqQH
         wJeLaFXb9RnXIjtJ3eQVIT04c9Ab+ffOxwSEj24cmnANhDVGHSSFZbXwYTUari/KYB3K
         Idax+FujdfZG6Naiyu/s7LRNdnb77IExdA9Mt9s2z+yyGrG95mQP/inKD5MyjCqXtdZU
         U07Q==
X-Gm-Message-State: AOAM533YdfPasUtMPvoQ+hf+yJEPtSmDOKNfKc2+ypJ/xJl7B1mFl1xz
        q+/iOpH4cUDQnc/nNKGfPIk=
X-Google-Smtp-Source: ABdhPJzTmzfyLe20++Ve5cRFiyoAQagMqwFVvs32L/FlmdwyctEw1qWH+8aNS3DXRsegMEk3+htxXg==
X-Received: by 2002:a2e:4612:: with SMTP id t18mr4691823lja.212.1590994340242;
        Sun, 31 May 2020 23:52:20 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:19 -0700 (PDT)
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
Subject: [PATCH v3 02/13] backlight: add backlight_is_blank()
Date:   Mon,  1 Jun 2020 08:51:56 +0200
Message-Id: <20200601065207.492614-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
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

v3:
  - Clarified that the fb_blank support in
    backlight_is_blank() may result in functionality
    changes for the users (Emil)

v2:
  - Added fb_blank condition (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index c7d6b2e8c3b5..a0a083b35c47 100644
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
+static inline bool backlight_is_blank(struct backlight_device *bd)
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

