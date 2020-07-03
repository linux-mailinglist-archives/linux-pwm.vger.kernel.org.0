Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD1213F7C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbgGCSqX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgGCSqX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C1DC061794;
        Fri,  3 Jul 2020 11:46:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so38039863ljv.5;
        Fri, 03 Jul 2020 11:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMIhGECQ39mxsFBNf2RZfIR0vNjqITM52PNfMW2B2fM=;
        b=CQPQFiOfJOvQsfgdhUU3Zl+ZYMCyX8a6t2TCYHjiTn6hqmlUvooqT7C30hg6ilj/ek
         k1a0AXbEzGYW10pu8eooF8kgdF1CTZ/euzASPYmGbZgDrcktTg/pO5GESva7pwfIpTxt
         gEUZgTaRdy+zoJempzZdVNW3CYj8DaVYqdLVJ/rWvECgL6q2WMDFJ+tUNMCKNIBexq2a
         305I0tMVL0ZTOvJY3VPdnWpIOaRV9J2Xcx0eN044vqLbVuZqEISB6ezM9UtTfqWCiH9r
         sbsnuvI0P66OmceZ0X8mTW+f9kB3GY60oUECWOQlPaGT9PDQ7jmpFBAwVfmsmQgsn6CJ
         5VEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=QMIhGECQ39mxsFBNf2RZfIR0vNjqITM52PNfMW2B2fM=;
        b=RjGAK9+HjtdPo2gWb4h7T/tBZM0FA2J8mkQgG7YYdUKw/WUBfv7+tvjF1Lzi67uyO2
         HESyuZKTgobBZqOWGTVrui3ewaKxahenQvPm6/jPBhmIZzbtrG6KofnmTw8sTqETmY3U
         JbujTszor/ncjmlN89tIqnuIeIPbFriERMWlfvNadTAAAvTTdsDJfG5ZqtiLKtLgK/Xd
         EmMFzP31p05pS83wOGxMLdycwoGsWRxU8JTDiGVQr83Y1wr+qQVB6Xt0V5NJ5tijC1kU
         4/AecAI4xHeXY58w+4gcfLYsfBs5kT9aPxxxI+4u8YyzOMnQaHxQjG0Y6AQVkbMXshl1
         0cFA==
X-Gm-Message-State: AOAM531WRPXyLbirzrbNXyBQqUvbvy/6vQWtSUjTXRKUaayPk+g78xtm
        NuxkSyLBkR8JsOSWR52G714=
X-Google-Smtp-Source: ABdhPJzf9L8N4cz0RXnl+kds2M1mB9xgIlwVmFXhdkQBQtHfhvqbYqt46eq1HskHMqSbdEDRhNeGlw==
X-Received: by 2002:a2e:91da:: with SMTP id u26mr14772411ljg.311.1593801981314;
        Fri, 03 Jul 2020 11:46:21 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:20 -0700 (PDT)
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
Subject: [PATCH v4 09/20] backlight: drop extern from prototypes
Date:   Fri,  3 Jul 2020 20:45:35 +0200
Message-Id: <20200703184546.144664-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 8f2005a6f8a9..c6ac4cbb9ddb 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -417,23 +417,26 @@ static inline bool backlight_is_blank(const struct backlight_device *bd)
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
 struct backlight_device *backlight_device_get_by_name(const char *name);
-extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned long brightness);
+struct backlight_device *backlight_device_get_by_type(enum backlight_type type);
+int backlight_device_set_brightness(struct backlight_device *bd,
+				    unsigned long brightness);
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
-- 
2.25.1

