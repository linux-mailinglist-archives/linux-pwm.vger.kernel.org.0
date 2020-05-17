Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8281D6C0E
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgEQTCb (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:30 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BB2C061A0C;
        Sun, 17 May 2020 12:02:29 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z22so6129104lfd.0;
        Sun, 17 May 2020 12:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Owbva2nI3N+6cL1et4Ic0vlFkieZkLc8sBPTb4V9KjM=;
        b=hN+B0ncxMnsYjbsNPzAOQsDQ1qNfQEAee8Rvy/Sg1Das5/j4oJocjdDj3+zUWjVMY/
         Dn1HbNv8rwOVhhVZ1nCiOWwjdpPS9yJnfkL0QjnAZVdiY62ymOIF5YU//tQtx1jtvO2c
         v6XonIDeEYjlmafpyWPih0jaXeot4mRN33AGnB5LG96gpM0fNP3NZeekqkIFt9sY01ow
         i83ATMywsCNBR9JON4RBAZks7gyS4/ItAmHqfCOsQZvN45s9HfIxX3mzUFKkZ+tMZNtP
         ihIUbPtQqttBQ44NqCeRVCWEPWhlXlIHogpbe/axqcbMgxF5bTnq+vX/9TAFAUZIOnUT
         F7Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Owbva2nI3N+6cL1et4Ic0vlFkieZkLc8sBPTb4V9KjM=;
        b=AwW0xiBMPSL12k0320CU6zrAkjcghR15tHEaiACZ/0f+NtkPWe2FQb38J1/+XxBTCL
         GLXf644uKPbADiBWYOJln9kTa7iPW+9lE6EQnndExMFJ6IJgWWzSgeMdesKFQWoqPbc7
         miidTuVuEJpODhX8om66yg1yKqlVUNUnTuFljMv4E+vFs9QNBMo3hvEjQFIquqfKzWy0
         LvnofkNYJc10+Gx1Btlu+i1lbi+Kx+HV/aaFz7qS9mfmvUjSuI9lbaNJLMGGMWtBwMAr
         Ri4NMx2OjmUEmSz0M2Ohiei5sBnCeoevfscrNn/tKBczS9XK8/Nj9+s/AKEZoljAbe2L
         xZzA==
X-Gm-Message-State: AOAM533pRtCdK7tE0mCeskbdYdWocmvrj7ykzDCP4BatRC+lvWI05/1Q
        2BMW5p/sYlFDEOMDlvfYpKc=
X-Google-Smtp-Source: ABdhPJxl/7pzFvOlBBOcqYBTHrjSV2Qiq2U2NVwdgfJ71Q9y2fMdtw/rpOeZnDVh1WqQvHbXKGDzZA==
X-Received: by 2002:a19:be11:: with SMTP id o17mr8841315lff.187.1589742147479;
        Sun, 17 May 2020 12:02:27 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:27 -0700 (PDT)
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
Subject: [PATCH v2 15/16] backlight: make of_find_backlight_by_node() static
Date:   Sun, 17 May 2020 21:01:38 +0200
Message-Id: <20200517190139.740249-16-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight_by_node().
Make it static so we keep it that way.

v2:
  - drop EXPORT of of_find_backlight_by_node

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 23 +++++++++--------------
 include/linux/backlight.h           | 10 ----------
 2 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 7f3eecaf8317..3fa29330a820 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -627,19 +627,9 @@ static int of_parent_match(struct device *dev, const void *data)
 	return dev->parent && dev->parent->of_node == data;
 }
 
-/**
- * of_find_backlight_by_node() - find backlight device by device-tree node
- * @node: device-tree node of the backlight device
- *
- * Returns a pointer to the backlight device corresponding to the given DT
- * node or NULL if no such backlight device exists or if the device hasn't
- * been probed yet.
- *
- * This function obtains a reference on the backlight device and it is the
- * caller's responsibility to drop the reference by calling put_device() on
- * the backlight device's .dev field.
- */
-struct backlight_device *of_find_backlight_by_node(struct device_node *node)
+/* Find backlight device by device-tree node */
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
@@ -647,7 +637,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
-EXPORT_SYMBOL(of_find_backlight_by_node);
+#else
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
+{
+	return NULL;
+}
 #endif
 
 static struct backlight_device *of_find_backlight(struct device *dev)
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index d92e523650ec..1e29ab43f4f6 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -473,16 +473,6 @@ static inline void * bl_get_data(struct backlight_device *bl_dev)
 	return dev_get_drvdata(&bl_dev->dev);
 }
 
-#ifdef CONFIG_OF
-struct backlight_device *of_find_backlight_by_node(struct device_node *node);
-#else
-static inline struct backlight_device *
-of_find_backlight_by_node(struct device_node *node)
-{
-	return NULL;
-}
-#endif
-
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
 struct backlight_device *devm_of_find_backlight(struct device *dev);
 #else
-- 
2.25.1

