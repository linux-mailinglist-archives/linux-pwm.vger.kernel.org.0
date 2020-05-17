Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8701D6BE8
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgEQTB5 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTB5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:01:57 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2E4C061A0C;
        Sun, 17 May 2020 12:01:56 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h26so6112686lfg.6;
        Sun, 17 May 2020 12:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qdUWGmoPechd3oTgEgd4ji1RiSP4wLSttPnRYm7mOf8=;
        b=AQIZP9wNKtpqZPp7o5/1bx3Ejx43EMIA5uNG1cn8dcJJ0TuVkpZukGXTQEvZbQblmN
         weJ/ls2F+p+y8NzKtQz8TsHmQivN+m+c1ENLCa2O9Xp0tR2p16VJR8nHAEO1ZgP/fRhS
         /UNLEvYKhBbvLHGJFMG3XrQHQB8qGXlEBaDDj5UQkDDsp6bdejtJjWTUfjV3YG3xJFWU
         12qbZfuyHyRcOWTDYO025WVy+Pw1pyniZsxO1g/fSJs50ufsybpHysu8WMQ/f4NhxGTd
         exZN2AV7T7Gx2qmSfUeWmfUik/3It4XUoHoYhyA4jAwtD0tWxEIqlXBt1vf13Rimod+a
         tiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=qdUWGmoPechd3oTgEgd4ji1RiSP4wLSttPnRYm7mOf8=;
        b=D3qGWZj8Gh+fd7L9uTjHTGZQGPEL5XbDMMlsFsKY8jT0Bp0r1fxNHgsT4mt9uCWId1
         jswd8G8rH0Sdbfe/4gVnq6COQSsKMvbO48TpbXCW61PHdPTlPmYoKjiwD9aWItHGYF0A
         d5WaQrxByLUx25UYZrL3oN3lNtfqyev045Sqr41SXAapkiIOIz16RTwC5sEQOWJ86R0a
         wcVh3JpcKRTurymAvfYPeIb7WI8JL3OXV5dZsSLDkfigeUHLLEMd4eO6MlO7IwAHZ6n1
         azL3kdHAAvBgc0IBF+MlxKQ+ktKe/Zsd4adyty7hOGieJvjRzqXbLtRIP0ZSu/DzeHOJ
         CZFg==
X-Gm-Message-State: AOAM532YU7ycuhat5qVvHMcvIkmf3VMWWDng7CgxpqiyRsOrQouFNm30
        AXKo7koM5KBL29tHCOS+fGI=
X-Google-Smtp-Source: ABdhPJwgFShcA04YlNT67vxlMevlvo9ORmiZZnKO32yhlGqrtbcAipVRWTl5RVfOmkpzs7i/B6hHsA==
X-Received: by 2002:ac2:5de6:: with SMTP id z6mr8903150lfq.18.1589742115122;
        Sun, 17 May 2020 12:01:55 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:01:54 -0700 (PDT)
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
Subject: [PATCH v2 03/16] backlight: add backlight_is_blank()
Date:   Sun, 17 May 2020 21:01:26 +0200
Message-Id: <20200517190139.740249-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
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
Add backlight_is_blank() helper to make it simpler for drivers
to get the check of the state correct.

A lot of drivers also includes checks for fb_blank.
This check is redundant when the state is checked
and thus not needed in this helper function.
But added anyway to avoid introducing subtle bug
due to the creative use in some drivers.

Rolling out this helper to all relevant backlight drivers
will eliminate almost all accesses to fb_blank.

v2:
  - Added fb_blank condition (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
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

