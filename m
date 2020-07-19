Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA3612250AF
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgGSIIb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:31 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D573DC0619D2;
        Sun, 19 Jul 2020 01:08:30 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so17035474lji.9;
        Sun, 19 Jul 2020 01:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IDEH3J4Q+Jjiu+FxPrY8mOUxDmtf7lYrk8yEJzvKVUQ=;
        b=RZVey3SWCAEostOET4Prc4fJIq//QTGR6FobtObJ+eknE0vNlYugFxPfRGJbB+hpPQ
         pydeDarW6k7WvW8ctkt8YijlV4JvsVJdk0Rl5B4fyfm+rlCoSOR0XPzSGqnOHkpNefMK
         GMbLSKAGa4iM5XuIwf7DtNwiXhOxs7XF288qZ5hnBxrg6rDCjdyCORXYeJzIcJALtMNt
         lso8g+YNyfW6jVQlxFS7Ay90BSywb70ryp4U8qHpjXy3RxuBFJgYl9Kgo9OI6GeJlUrb
         esssmPdke8kFNT6+cbQRnF8KmS3FhjXsYevkLxaA/1kFdC7pnBHf6SnFwaap8HyL/pl6
         n4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IDEH3J4Q+Jjiu+FxPrY8mOUxDmtf7lYrk8yEJzvKVUQ=;
        b=GNk+aFhTz4VmUuFgyVdxTCtwnBa8K7Ibf+JY6/PYRsGwaPi1YIrlgsNGLhkGtPe1si
         buaWfYeTdBINXd8vVjSwgsf9V40FyMS7t+uhZn2ir7cnDczNRpG0kHjEF8lnmn9pCYZx
         molZB3N7tQyjN+wrp7zyzDnqXEeS9mZfCr6ZyAkXoiUItZ6RccFxor81le1aIY/M9Ihy
         nd7xN6wHqH4Mt5ZGkO25B2lND1Kj45jkN8RLFstwbWcQG8sUvfIvXdsdb448+LH5s898
         XPcKcXZn3fdTBWiGysvRjuVaFpSeSEKFK1VCpwuDB6SaPw6fOEZgGB0rXCxYOD1Y1qBB
         yPtA==
X-Gm-Message-State: AOAM530FnmHlTGqkXSYY4WqnPrJJjpqJypptHouTyInswcni3tW6AwVt
        GUGMDqT8Y/yl4IWXKGF9xBg=
X-Google-Smtp-Source: ABdhPJx31S8uL+DzfpbblGSuB6RPYkE/DcMSsq1zq8vUzlGE1rLjv9FeAN5ewmQ6Rux/w+ehFSGw1g==
X-Received: by 2002:a2e:99d0:: with SMTP id l16mr7417620ljj.209.1595146109333;
        Sun, 19 Jul 2020 01:08:29 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:28 -0700 (PDT)
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
Subject: [PATCH v5 18/19] backlight: drop backlight_put()
Date:   Sun, 19 Jul 2020 10:07:42 +0200
Message-Id: <20200719080743.8560-19-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of backlight_put().
Drop it and open code the two users in backlight.c.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c |  7 +++++--
 include/linux/backlight.h           | 10 ----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 93ae8c63fe4c..d8387c8e7112 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -718,7 +718,10 @@ EXPORT_SYMBOL(of_find_backlight);
 
 static void devm_backlight_release(void *data)
 {
-	backlight_put(data);
+	struct backlight_device *bd = data;
+
+	if (bd)
+		put_device(&bd->dev);
 }
 
 /**
@@ -746,7 +749,7 @@ struct backlight_device *devm_of_find_backlight(struct device *dev)
 		return bd;
 	ret = devm_add_action(dev, devm_backlight_release, bd);
 	if (ret) {
-		backlight_put(bd);
+		put_device(&bd->dev);
 		return ERR_PTR(ret);
 	}
 	return bd;
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 38db67588b16..f3b484c99789 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -388,16 +388,6 @@ static inline int backlight_disable(struct backlight_device *bd)
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

