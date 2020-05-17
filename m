Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837531D6C07
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgEQTCY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:24 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF23C061A0C;
        Sun, 17 May 2020 12:02:23 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h26so6113346lfg.6;
        Sun, 17 May 2020 12:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IvDsy/nPUi02XD/vfbNhyiPf7njrVCeQx3+gL16YDUg=;
        b=czbyCVEw53JapFDgPo5oUqLk+4ZpOVDDGegu4yOGim/1D2iWS5LoJ4s+WO986t4Oca
         QYdPzvpcnbinj/gMkr8AGQJnSGX9/PpX1YsMM1iCQkybIRFzRfnLhy/OKyD6Y2e5EQpf
         iUcstdjY2Q1zwjtH9KwAccx5AKbadwx7zIakR4kj4GnJu3BZAkuN4rld16ch04aCqXRJ
         7K/zgUfwm+2r4nPkAoccrJv76FqVZZBljDlI3MsO75hcDAbcbb6xoy3O5mLvyDDs9bCI
         A4UQFkaihP7w768jWRGqH7j2Z93jaTWvNnhepZ4B5Gia8GTxaIoqjvLJcmmlz4TtW2L5
         r5KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=IvDsy/nPUi02XD/vfbNhyiPf7njrVCeQx3+gL16YDUg=;
        b=H8WXD5elJbu7yBiAjP18wZAZsNfpqAV/tHkyBAwU9Eov3RD+z6f45baXnGfjQ1bkEX
         Xqpi/LrXHqwlpuiHVs9DBK9hS60y5W2P3bW3pHtBKAuBjRMyo/q/AQDIcEqDHhKhRVHg
         hHtEdQsNzrbg8a2IV0+mJKTAUnSOQTgGOWOLps6Uf4cLSuyDDRMtEXLmEgrbZIRYhZZz
         6H5+b7UfRXX3DYqUuAwA44oNm1pLtluko5O/ZyCMogCjWnirRiYfL+HAlckfqjAVNFOc
         nDnsinpDKUeYXfWVxyMBcVFJVC860iuKfMWsSUomOuFbfsT9pqyKJFKRfenkq2yC4Cpa
         AyGA==
X-Gm-Message-State: AOAM533fEFMHXE1pgKjAu6bnVMT641G7UxlZlIXk+CF+fLPhdI2SNEqO
        bCEaxQa73mcPOS9b6KairCw=
X-Google-Smtp-Source: ABdhPJxJEsVz8vUKYsbXCKwcWbHSyuHi0wKOTOertCRfru+9AvoX2lvlXxp8S+s1/M35SOwFd5ubPQ==
X-Received: by 2002:a19:5f5c:: with SMTP id a28mr9085446lfj.98.1589742142136;
        Sun, 17 May 2020 12:02:22 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:21 -0700 (PDT)
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
Subject: [PATCH v2 13/16] backlight: make of_find_backlight static
Date:   Sun, 17 May 2020 21:01:36 +0200
Message-Id: <20200517190139.740249-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There are no external users of of_find_backlight,
as they have all changed to use the managed version.
Make of_find_backlight static to prevent new external users.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 drivers/video/backlight/backlight.c | 31 ++++++++++-------------------
 include/linux/backlight.h           |  6 ------
 2 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 2212f0e3570e..e23b09d03a65 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -650,22 +650,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 EXPORT_SYMBOL(of_find_backlight_by_node);
 #endif
 
-/**
- * of_find_backlight - Get backlight device
- * @dev: Device
- *
- * This function looks for a property named 'backlight' on the DT node
- * connected to @dev and looks up the backlight device.
- *
- * Call backlight_put() to drop the reference on the backlight device.
- *
- * Returns:
- * A pointer to the backlight device if found.
- * Error pointer -EPROBE_DEFER if the DT property is set, but no backlight
- * device is found.
- * NULL if there's no backlight property.
- */
-struct backlight_device *of_find_backlight(struct device *dev)
+static struct backlight_device *of_find_backlight(struct device *dev)
 {
 	struct backlight_device *bd = NULL;
 	struct device_node *np;
@@ -691,7 +676,6 @@ struct backlight_device *of_find_backlight(struct device *dev)
 
 	return bd;
 }
-EXPORT_SYMBOL(of_find_backlight);
 
 static void devm_backlight_release(void *data)
 {
@@ -702,9 +686,16 @@ static void devm_backlight_release(void *data)
  * devm_of_find_backlight - find backlight for a device
  * @dev: the device
  *
- * Device managed version of of_find_backlight().
- * The reference on the backlight device is automatically
- * dropped on driver detach.
+ * This function looks for a property named 'backlight' on the DT node
+ * connected to @dev and looks up the backlight device.
+ * The lookup is device managed so the reference to the backlight device
+ * is automatically dropped on driver detach.
+ *
+ * Returns:
+ * A pointer to the backlight device if found.
+ * Error pointer -EPROBE_DEFER if the DT property is set, but no backlight
+ * device is found.
+ * NULL if there's no backlight property.
  */
 struct backlight_device *devm_of_find_backlight(struct device *dev)
 {
diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 308aec67fa4f..99e7cdace2be 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -494,14 +494,8 @@ of_find_backlight_by_node(struct device_node *node)
 #endif
 
 #if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
-struct backlight_device *of_find_backlight(struct device *dev);
 struct backlight_device *devm_of_find_backlight(struct device *dev);
 #else
-static inline struct backlight_device *of_find_backlight(struct device *dev)
-{
-	return NULL;
-}
-
 static inline struct backlight_device *
 devm_of_find_backlight(struct device *dev)
 {
-- 
2.25.1

