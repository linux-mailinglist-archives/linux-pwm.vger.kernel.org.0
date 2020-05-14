Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 568A31D3CED
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbgENTKp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729158AbgENTKo (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489AC061A0C;
        Thu, 14 May 2020 12:10:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id h4so4714984ljg.12;
        Thu, 14 May 2020 12:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7NL7oOh2YpmGkieh3R7y/HMeuTthqrGLkMzsF1Tg8k0=;
        b=l7NkQzxmJKlSolH7PJHAvYG4SzzLtTDVkv7A5b8wb8TSIjPhQGtgXsYBBxnnIAKqbX
         pJchKTttYj1Gbcaqq2XupUvICzobt2Mdl1t7G2DjVrE3+Gc/y0pP4bJCp89MlCOLUl0w
         6YK2XlFOt1c286dSaBmDauQ6RcHYnYLOKfyPPaAsKIYpTc58IFpkPagWZURSJewPXbg5
         EPtuXM63ZGxf3p+ucfulm5rjpVbQkDph0XKtaojCjYaAxEudP3XAelw/UxLGxdNb498w
         eIf4RiMOc8ZesgTFe1ULkkmrT+hrwmmOvibWieZpqaLpBXNGmTQo1k5leY/tBU65PwP7
         0OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=7NL7oOh2YpmGkieh3R7y/HMeuTthqrGLkMzsF1Tg8k0=;
        b=nbv492qkhxz9XMW3PrTyQLOoWpjDL6mV1T/z/IrQXvGMQAC7VcZ17vYostiTLrlIAt
         XJPBRLQyuCCeoVxOl86YIa4SlJILdXtF/0GxuE5K59hUN7TLOTi75eP04a9mIUos+qjA
         x6rYPM86d8SF6oOTED/4JMWYEro483xgQd/AxyqTXOqtkxRZHpMw4pcUFeMUCSRWMvRv
         vjN2ymSmEO8mtbUEG2KSWQyYdKZXzCBX6gn4kZDDvwJlBZMQs5Tp4ZLBRGx9HK3ZItW/
         KrKMZ8yh9O1vRU5+lLiarpG2hXMIhLyC7L9zkDCulKHCnXHY7buAwUj0HcLFICLs8Ef9
         WR9A==
X-Gm-Message-State: AOAM530nzppfPkeRS5tJCCpqUUYBz2WY/VQUVSKeZTcG93m6AIY0U097
        mqFtmUniF88pDKWQkDAMHLE=
X-Google-Smtp-Source: ABdhPJzKDt4XU/BmWeiLV6W594VhbfU7W8uhu8wo1ZRThIlXSSv8E9xcMBsJko0RoOFHj/dT79mvAQ==
X-Received: by 2002:a05:651c:c8:: with SMTP id 8mr3521844ljr.182.1589483442684;
        Thu, 14 May 2020 12:10:42 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:42 -0700 (PDT)
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
Subject: [PATCH v1 13/18] backlight: document enums in backlight.h
Date:   Thu, 14 May 2020 21:09:56 +0200
Message-Id: <20200514191001.457441-14-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add kernel-doc documentation for the backlight enums

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 84 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index b8e78549a48c..bedc0c9885b6 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -14,26 +14,110 @@
 #include <linux/mutex.h>
 #include <linux/notifier.h>
 
+/**
+ * enum backlight_update_reason - what method was used to update backlight
+ *
+ * A driver indicates the method (reason) used for updating the backlight
+ * when calling backlight_force_update().
+ */
 enum backlight_update_reason {
+	/**
+	 * @BACKLIGHT_UPDATE_HOTKEY:
+	 *
+	 * The backlight was updated using a hot-key.
+	 */
 	BACKLIGHT_UPDATE_HOTKEY,
+
+	/**
+	 * @BACKLIGHT_UPDATE_SYSFS:
+	 *
+	 * The backlight was updated using sysfs.
+	 */
 	BACKLIGHT_UPDATE_SYSFS,
 };
 
+/**
+ * enum backlight_type - the type of backlight control
+ *
+ * The type of interface used to control the backlight.
+ */
 enum backlight_type {
+	/**
+	 * @BACKLIGHT_RAW:
+	 *
+	 * The backlight is controlled using hardware registers directly.
+	 */
 	BACKLIGHT_RAW = 1,
+
+	/**
+	 * @BACKLIGHT_PLATFORM:
+	 *
+	 * The backlight is controller using a platform-specific interface.
+	 */
 	BACKLIGHT_PLATFORM,
+
+	/**
+	 * @BACKLIGHT_FIRMWARE:
+	 *
+	 * The backlight is controlled using a standard firmware interface.
+	 */
 	BACKLIGHT_FIRMWARE,
+
+	/**
+	 * @BACKLIGHT_TYPE_MAX: Number of entries.
+	 */
 	BACKLIGHT_TYPE_MAX,
 };
 
+/**
+ * enum backlight_notification - the type of notification
+ *
+ * The notifications that is used for notification sent to the receiver
+ * that registered notifications using backlight_register_notifier().
+ */
 enum backlight_notification {
+	/**
+	 * @BACKLIGHT_REGISTERED:
+	 *
+	 * The backlight device is registered.
+	 */
 	BACKLIGHT_REGISTERED,
+
+	/**
+	 * @BACKLIGHT_UNREGISTERED:
+	 *
+	 * The backlight revice is unregistered.
+	 */
 	BACKLIGHT_UNREGISTERED,
 };
 
+/** enum backlight_scale - the type of scale used for brightness values
+ *
+ * The type of scale used for brightness values.
+ */
 enum backlight_scale {
+	/**
+	 * @BACKLIGHT_SCALE_UNKNOWN:
+	 *
+	 * The scale is unknown.
+	 */
 	BACKLIGHT_SCALE_UNKNOWN = 0,
+
+	/**
+	 * @BACKLIGHT_SCALE_LINEAR:
+	 *
+	 * The scale is linear, so the brigness increase is the same
+	 * when increasing with the same steps (more or less).
+	 */
 	BACKLIGHT_SCALE_LINEAR,
+
+	/**
+	 * @BACKLIGHT_SCALE_NON_LINEAR:
+	 *
+	 * The scale is not linear. This is often used when the brightness
+	 * values tries to adjust to the relative perception of the eye
+	 * demanding a non-linear scale.
+	 */
 	BACKLIGHT_SCALE_NON_LINEAR,
 };
 
-- 
2.25.1

