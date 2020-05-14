Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88661D3CE0
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgENTKi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728752AbgENTKe (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:34 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83415C061A0C;
        Thu, 14 May 2020 12:10:33 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id 82so2080215lfh.2;
        Thu, 14 May 2020 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0CehtWkd1Er3yC2BMyIEGrFFapubFNN7PqykdJUfMHI=;
        b=eidvGM9t96XHHWfRflJPjBBF5HTlVuyDtHlLIgkQ17RztqdmJdDb5ththyU0zKGQ4m
         q54IGp7jpOWWEm13OdvzXnDuiL6IhITR4HNGgHvejHkL9tIkrhN7Z0X54Wz4mvoxxdsx
         aeAJqpmbvbvLKIKomqcMvNFzkir+eMGDIzeXf1dzcz7uCCsvmxXFsEbp2WZiy8aQ+b9K
         kofg6lfZvlrXKi16NHuuu5BviIcNsMgd5p+Jwkp8S05qoOGvqLpUUI8HJQk+WA8rDLfq
         ISHDb0p5qYN3IbCBh96bEobzdD9XWy3YRIqbt+jbVfa7Zhb0YeRGGa2Iki9z4oCC6wJe
         o6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0CehtWkd1Er3yC2BMyIEGrFFapubFNN7PqykdJUfMHI=;
        b=RJ6sNCku/zzlZay5ADiiTPWE7Yfe1rD36/MUbKqzhVhlPI5sQelSh/HLkl2AI02u40
         ZGPkotXEFjmVme+81L2bKoGOMpemIDoUJHGexAhsbK74+FsnKobG+tfRTeZ5hhdkYKwy
         uZWbMq+ueqEzHISCvR/K+C95LZdo6kFM2qG0744F5swbNy6cfb4KCFEBInIip53ygdbA
         HHuWNd4h7vUML/+A9DWJHaeBLeUd0kbWHkaHlxeDZ6P0pxMsGq1r2qGg8QSBU1DYgBml
         +1QP2vUG2bRZy98OFk70BowVDBYUravKn3+1usRyh8jY7sVr27trBnFr94NEW+kcBv6X
         p/zg==
X-Gm-Message-State: AOAM531zsEzDrcQg9jKE+s+uyMBU2wLbOYpCUiUjP4MCZDogw8PFqtwh
        +64vjIcM1TrTW+Dv/QZXCDA=
X-Google-Smtp-Source: ABdhPJzlhguokXHBb6OrRTCkI/stO8K6/VCjE7cIr/pNl4vTApu2RhD3AXVSV3P255PVDcwAxt3qMA==
X-Received: by 2002:ac2:599e:: with SMTP id w30mr3544961lfn.188.1589483432002;
        Thu, 14 May 2020 12:10:32 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:30 -0700 (PDT)
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
Subject: [PATCH v1 08/18] backlight: add backlight_is_blank()
Date:   Thu, 14 May 2020 21:09:51 +0200
Message-Id: <20200514191001.457441-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
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
as thus not needed in this helper function.
Rolling out this helper to all relevant backlight drivers
will eliminate almost all accesses to fb_blank.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index b7839ea9d00a..e67e926de1e2 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -165,6 +165,23 @@ static inline int backlight_disable(struct backlight_device *bd)
 	return backlight_update_status(bd);
 }
 
+/**
+ * backlight_is_blank - Return true if display is expected to be blank
+ * @bd: the backlight device
+ *
+ * Display is expected to be blank if any of these is true::
+ *
+ *   1) if power in not UNBLANK
+ *   2) if state indicate BLANK or SUSPENDED
+ *
+ * Returns true if display is expected to be blank, false otherwise.
+ */
+static inline bool backlight_is_blank(struct backlight_device *bd)
+{
+	return bd->props.power != FB_BLANK_UNBLANK ||
+	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
+}
+
 extern struct backlight_device *backlight_device_register(const char *name,
 	struct device *dev, void *devdata, const struct backlight_ops *ops,
 	const struct backlight_properties *props);
-- 
2.25.1

