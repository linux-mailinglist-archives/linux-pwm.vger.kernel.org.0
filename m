Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C53271D3CD9
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgENTK3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730289AbgENTK2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:28 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D456C061A0C;
        Thu, 14 May 2020 12:10:28 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id a9so3574460lfb.8;
        Thu, 14 May 2020 12:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=es7L7BT5X1JhlaIi9tn96sUgeVkIuHpmkzZvtAwIcug=;
        b=CVItBRgQEjiAp4UKpopUfv37fyjDo1mY+XLZ8itHw+itr+e6Dc2W1Vwv+h7O94kTKO
         ojVnxcMI0XuVLhYbZThBf7xSndRQhUZSUZygweq503IdIl7oGa+TRkVU/DAqknpwVA6X
         5bEKgfcjbRZqcFUz+Thpwnr7oStu1zNdb2ghP8iQ/wS46V6lMGfIv0ZJItty3by/0hQ4
         IQRDi7Kk0xZ39rzzeWMQM6XgJ+9P9vc5XpXlmbrKDKLDNbvetdJN+utHwluVYHA91VyE
         sn4qpE62jAztmy4V6sw51DHoW0Gb2YlPqpjmqYegPOojTKEuWN9eAiXcYRW6u0eIXkJU
         udHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=es7L7BT5X1JhlaIi9tn96sUgeVkIuHpmkzZvtAwIcug=;
        b=WVhpE7TmyACU8F+T8fq7XozhblFFPr64zlc54fyd6HJf8u2lfpRoPBFcOWPSu6IHbL
         qddZFKpqwXO/EGOygetxypGZqKmQc15cdf6eoLl2iavdxsvGR994wVfrF4X+2RbkcnX2
         /SVS3oaFCCRWybafuWq4QfYFOJFe+gAgIKVy0+cEBVpjN6EF39RS2scGOppkQze6UU0W
         q4+cn3JhtBReIhBSGnaZpUeaCyxHIxG6GfJpgtlwJstGNmt52Xkw/uCcLwDEeulRP30L
         9ZEtB5eMnwDT6zhTvDhAM7fiJPNQN1iBWa2DR9dIPRCzjGTGRYOcKcKp9uwbNr3J7p06
         EBfQ==
X-Gm-Message-State: AOAM5304ZotrTkgnEaDXJvFrSSBW0eGRWzkPIi/IBnYGAjHqlZFrcvRZ
        TBvv7eH/M77PGQK3AHyLCnw=
X-Google-Smtp-Source: ABdhPJz8pGerusE9OOKAKVj0mi5K/KXSSEFkTv+0WU6pZ/84b7vD0iKdmma7g9JVVyDE/6Qynkos6Q==
X-Received: by 2002:ac2:4436:: with SMTP id w22mr4268011lfl.55.1589483426792;
        Thu, 14 May 2020 12:10:26 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:26 -0700 (PDT)
From:   Sam Ravnborg <sam@ravnborg.org>
To:     dri-devel@lists.freedesktop.org, Jingoo Han <jingoohan1@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Allison Randal <allison@lohutok.net>,
        Andy Gross <agross@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Weigelt <info@metux.net>,
        Jani Nikula <jani.nikula@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, Jyri Sarha <jsarha@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Uwe Kleine Konig <u.kleine-koenig@pengutronix.de>,
        Zheng Bin <zhengbin13@huawei.com>
Subject: [PATCH v1 06/18] backlight: make of_find_backlight_by_node() static
Date:   Thu, 14 May 2020 21:09:49 +0200
Message-Id: <20200514191001.457441-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight_by_node().
Make it static so we keep it that way.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 22 +++++++++-------------
 include/linux/backlight.h           | 10 ----------
 2 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 547aa3e1a03a..91dfcf4a2087 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -577,19 +577,9 @@ static int of_parent_match(struct device *dev, const void *data)
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
 
@@ -598,6 +588,12 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 	return dev ? to_backlight_device(dev) : NULL;
 }
 EXPORT_SYMBOL(of_find_backlight_by_node);
+#else
+static struct backlight_device *
+of_find_backlight_by_node(struct device_node *node)
+{
+	return NULL;
+}
 #endif
 
 static struct backlight_device *of_find_backlight(struct device *dev)
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 3d757a850b88..b7839ea9d00a 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -198,16 +198,6 @@ struct generic_bl_info {
 	void (*kick_battery)(void);
 };
 
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

