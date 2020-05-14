Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B591D3CE9
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgENTKn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728355AbgENTKm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:42 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E44C061A0E;
        Thu, 14 May 2020 12:10:42 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u6so4755420ljl.6;
        Thu, 14 May 2020 12:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2As4iiMj0BTo7C+dTbzUgkC9XsiqqnfWF8EBRNpLd7g=;
        b=a5Ap00Ov2KLpVSkuuJkC3wj3lAszNGu+09WiQxhFyIG16BxWDWEP0CTK+Ir8wQolJB
         fmNSaQvE3d6FYDQmT7XN4eiJDVmy+OGsc1Okns994TIBQ7jN5UHgrXc+D8kh9+oJowHX
         Pxt2zCCeofI4AYNqqmGoXvtPUnynTsVjRBJHYpFnDfjQUimKmm1XLYJMKzk/UZ4XZXbm
         RX8arI7PerFkdsLcQLBm1T6wGmwNKohqY0EdsQZsY+/p0+cqai/NHfN4Z6TuSL5V0nzR
         bShpRseQyR+pEIzfHxb0wdhbehBq41T2pFW0nCxYBcnIaZqVd0CtqvThiz1aBQ8je36I
         JOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2As4iiMj0BTo7C+dTbzUgkC9XsiqqnfWF8EBRNpLd7g=;
        b=Qm6+G7wqlzv/m5yt3/XBTmPAL8R5EBag5NsK6Xd2D3lG223tQnQnRQWfTFhOJbfLyY
         5TYeRVcWwVD939CWEUuquHwtIHEu1nj9lpYH9MofQR2qQg3PrcHE1TluGvt75S5XqU8G
         nZNNkUfUtuXO4IEIG1vC7KTnD9tpEKRPMUIrKJiCFN8iVeWld/faZNgo9rBbbJobdAaX
         i/psmyhCRQhcaoGOYesZmd8iHAu1jBjY13My0zWwHMXm6QVf/PbGDrhvi394KrQNqstF
         K59cjqjClStfFP4VvZUBmEdbwNEEOP8lBg76PsOubG7v5CTyBCG0tHaf3rvfEdoxq/XW
         S2Hg==
X-Gm-Message-State: AOAM531zy7YVBAhT72Ma8PBPS0o4IKwrvdXQq+hM2wSHTqvjyJJBJy3L
        F9fCrCL/36omzhcK+BH+eAE=
X-Google-Smtp-Source: ABdhPJxOE9RU/MsJ6k8PfrsSEIcqB8AFxJK7Zaq6b7zomy4TpPcp6vACPeUyOYCZdkuXTyvn1J9mHg==
X-Received: by 2002:a2e:9456:: with SMTP id o22mr3716363ljh.94.1589483440767;
        Thu, 14 May 2020 12:10:40 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:40 -0700 (PDT)
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
Subject: [PATCH v1 12/18] backlight: document inline functions in backlight.h
Date:   Thu, 14 May 2020 21:09:55 +0200
Message-Id: <20200514191001.457441-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for the inline functions in backlight.h

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 34ba1e444334..b8e78549a48c 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -283,6 +283,10 @@ struct backlight_device {
 	int use_count;
 };
 
+/**
+ * backlight_update_status - force an update of the backligt device status
+ * @bd: the backlight device
+ */
 static inline int backlight_update_status(struct backlight_device *bd)
 {
 	int ret = -ENOENT;
@@ -363,6 +367,18 @@ extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned
 
 #define to_backlight_device(obj) container_of(obj, struct backlight_device, dev)
 
+/**
+ * bl_get_data - access devdata
+ * @bl_dev: pointer to backlight device
+ *
+ * When a backlight device is registered the driver has the possibility
+ * to supply a void * devdata. bl_get_data() return a pointer to the
+ * devdata.
+ *
+ * RETURNS:
+ *
+ * pointer to devdata stored while registering the backlight device.
+ */
 static inline void * bl_get_data(struct backlight_device *bl_dev)
 {
 	return dev_get_drvdata(&bl_dev->dev);
-- 
2.25.1

