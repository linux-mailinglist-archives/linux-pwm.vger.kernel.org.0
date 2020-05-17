Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6DF1D6C0B
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgEQTC1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTC0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:26 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512C9C061A0C;
        Sun, 17 May 2020 12:02:26 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h188so6120668lfd.7;
        Sun, 17 May 2020 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v8t7YeGruxta805OuVbRHUY0bPcsh9G6lLY/6w/o8Gc=;
        b=C8VbvOdph2/j2pwoQ7DsiImXfPNKAT0eHHEvwLzuP+9MN1VKrkgEuil2zrpn2ugsTO
         9DpnlwmDppjg+shy1eIsgV/K3OfqI490AVv9bRXedvAyLVRkjxBJQvemDOuno4ZKkrmP
         nRx3NJtXmuxFv6zNZcgjvUSCFuEf9pRGOrZNQwf2qkpPTWMFd7o9saUq7pkeD4ewzzSV
         ZW53n2BTfBGY0Fs4l1y1a4vKRGh+lYs3QhD4R5wlYjJpeSEQZSeMYKeykNIFUAIX/VNH
         LpPMFgvd4wF3DrKJopwG8dZotminQkZaZBJGLOInx3Ml/GBkUycLPPvJ9C0M+5faE4gY
         lnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=v8t7YeGruxta805OuVbRHUY0bPcsh9G6lLY/6w/o8Gc=;
        b=cvs8wwihKcK0nn7JQRGahw5dD6i/PyWgqmkHiaed6ZVcwh3O3TsetTew4IYXgGr4lc
         UheQJC9X/o3u6uITPYtqEEmMQY4BgwQ4aeHSdZkAwvQfSulpbmO0mjt84HomZ76LugHM
         jfE/oqzzG3S5NRpRvmyQa6zKp9R5LkZ+9fFsn9Ut/pUbr3/M2yERq6nHJRQEHYYGESPv
         B2po+Le12WxxJs2e9lcSbvW0jd6XtBlYzW+YPgEWa0mt/21PKg991oTAtX64BxPdG+uK
         /w5yhpu/3xtLmM8H41t5Cxlm5J0YUNk2INsaY3z64BLiIR8BZHDnGVPd4mAdR0EKQaB2
         PfSA==
X-Gm-Message-State: AOAM532kbMhwE409aBZzmgY9qNjB2sSth/sGeeqm9Lix8lqu+Sw5EJNR
        LkaIJ7ueSEGKTyEj/hBWONM=
X-Google-Smtp-Source: ABdhPJyo7uKvJpS51OtRduL77hMqwfbmMZUhY+3vQN+6QeXWWoevpMa889Y4H9Ca9cw+C8DjnD+zqg==
X-Received: by 2002:a19:ee19:: with SMTP id g25mr9231869lfb.124.1589742144801;
        Sun, 17 May 2020 12:02:24 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:24 -0700 (PDT)
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
Subject: [PATCH v2 14/16] backlight: drop backlight_put()
Date:   Sun, 17 May 2020 21:01:37 +0200
Message-Id: <20200517190139.740249-15-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of backlight_put().
Drop it and open code the two users in backlight.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c |  7 +++++--
 include/linux/backlight.h           | 10 ----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index e23b09d03a65..7f3eecaf8317 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -679,7 +679,10 @@ static struct backlight_device *of_find_backlight(struct device *dev)
 
 static void devm_backlight_release(void *data)
 {
-	backlight_put(data);
+	struct backlight_device *bd = data;
+
+	if (bd)
+		put_device(&bd->dev);
 }
 
 /**
@@ -707,7 +710,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
 		return bd;
 	ret = devm_add_action(dev, devm_backlight_release, bd);
 	if (ret) {
-		backlight_put(bd);
+		put_device(&bd->dev);
 		return ERR_PTR(ret);
 	}
 	return bd;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 99e7cdace2be..d92e523650ec 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -415,16 +415,6 @@ static inline int backlight_disable(struct backlight_device *bd)
 	return backlight_update_status(bd);
 }
 
-/**
- * backlight_put - Drop backlight reference
- * @bd: the backlight device to put
- */
-static inline void backlight_put(struct backlight_device *bd)
-{
-	if (bd)
-		put_device(&bd->dev);
-}
-
 /**
  * backlight_is_blank - Return true if display is expected to be blank
  * @bd: the backlight device
-- 
2.25.1

