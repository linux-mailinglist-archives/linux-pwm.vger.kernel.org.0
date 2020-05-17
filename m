Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC471D6BFF
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgEQTCQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:15 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066BC061A0C;
        Sun, 17 May 2020 12:02:15 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d22so6091999lfm.11;
        Sun, 17 May 2020 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ej6ukq+60uPTP3MIHc3/HurH6JGEh6Vx0QT7mCROCYs=;
        b=AuqrU1ueWhxi0LOT8AQ8EKPM60KewpmUdt239G59yuYr3Tx6mulNuq6eboBbLIIz1V
         33ignFrjSIKgpjtvIfdiSg7Pqe681yC0iFvaO+O0YwzVaqnmO8/2GiM7pgdrjjnp2EUJ
         3rEV8ffQWuEdJpTyabljDFq25LYs3SeqGVlJHxGA1hUsmdTd4xhlkiuEzE/BeBmAtY/I
         VuNNU4lbuGRBnkxfigH6eEYXBvx0FmZGIaAowjr4E+t8hqkIOr5S84xQDw+coA6OFbLD
         oUvgbC6hHP/4sk1vF0H8V3iSBJmrIOZkNST812+y5/yycH/XPSMyWernKwtn+iTLlJM4
         hp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=ej6ukq+60uPTP3MIHc3/HurH6JGEh6Vx0QT7mCROCYs=;
        b=hCrYbT2to8ZxuCtWW0ZsfbO0ma9tIQaZtXDux/TPldAEa/d243rW1G1RbqQF/5bJre
         ddF6t9MN2ABFLEotbLVG4isd2iD5dPoiCPV1RUAcl4jM30nhCAqP8Lf8YmkjLUiBeWlY
         pJrBy4iPzSIk4y5l1Fib8jkDSYf7oEh+cDw8iTZn0jS02uZZ92YDfKsO4rfSjADt4XOE
         AmmOksrmR8Udwij2IRNYJnHG5HFsT+6guntsD9WQoa8DgaCOjlOd1HbLI0scRIs6zY7u
         MJVq5VUMO5ntLc5psjLYN/SM4cvE91P2ilwvHurVu427lQtpU+LieZ7BX5laaNi7LzoO
         KNTA==
X-Gm-Message-State: AOAM533MbY6ZTkRB5hBUBdrnkBsqeBFf9LG8DQ6HWu6TEYys8utrk1DK
        kIPN6U2JxkXZnpDW+0XAvWU=
X-Google-Smtp-Source: ABdhPJwxy8XBEDB8HEDtsuefFUzmp0iN6Azy4WO6eudwOO5aKM2R0tejYGT4yHurWN45UzLvMsvYOg==
X-Received: by 2002:ac2:59c3:: with SMTP id x3mr2623468lfn.117.1589742133936;
        Sun, 17 May 2020 12:02:13 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:13 -0700 (PDT)
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
Subject: [PATCH v2 10/16] backlight: drop extern from prototypes
Date:   Sun, 17 May 2020 21:01:33 +0200
Message-Id: <20200517190139.740249-11-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

No need to put "extern" in front of prototypes.
While touching the prototypes adjust indent to follow
the kernel style.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index eae7a5e66248..308aec67fa4f 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -444,22 +444,25 @@ static inline bool backlight_is_blank(struct backlight_device *bd)
 	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
 }
 
-extern struct backlight_device *backlight_device_register(const char *name,
-	struct device *dev, void *devdata, const struct backlight_ops *ops,
-	const struct backlight_properties *props);
-extern struct backlight_device *devm_backlight_device_register(
-	struct device *dev, const char *name, struct device *parent,
-	void *devdata, const struct backlight_ops *ops,
-	const struct backlight_properties *props);
-extern void backlight_device_unregister(struct backlight_device *bd);
-extern void devm_backlight_device_unregister(struct device *dev,
-					struct backlight_device *bd);
-extern void backlight_force_update(struct backlight_device *bd,
-				   enum backlight_update_reason reason);
-extern int backlight_register_notifier(struct notifier_block *nb);
-extern int backlight_unregister_notifier(struct notifier_block *nb);
-extern struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
-extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned long brightness);
+struct backlight_device *
+backlight_device_register(const char *name, struct device *dev, void *devdata,
+			  const struct backlight_ops *ops,
+			  const struct backlight_properties *props);
+struct backlight_device *
+devm_backlight_device_register(struct device *dev, const char *name,
+			       struct device *parent, void *devdata,
+			       const struct backlight_ops *ops,
+			       const struct backlight_properties *props);
+void backlight_device_unregister(struct backlight_device *bd);
+void devm_backlight_device_unregister(struct device *dev,
+				      struct backlight_device *bd);
+void backlight_force_update(struct backlight_device *bd,
+			    enum backlight_update_reason reason);
+int backlight_register_notifier(struct notifier_block *nb);
+int backlight_unregister_notifier(struct notifier_block *nb);
+struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
+int backlight_device_set_brightness(struct backlight_device *bd,
+				    unsigned long brightness);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
-- 
2.25.1

