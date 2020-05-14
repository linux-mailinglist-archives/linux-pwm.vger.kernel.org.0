Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68DD91D3CF6
	for <lists+linux-pwm@lfdr.de>; Thu, 14 May 2020 21:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbgENTKx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 14 May 2020 15:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728174AbgENTKw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 14 May 2020 15:10:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235CBC061A0C;
        Thu, 14 May 2020 12:10:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id r17so3584617lff.9;
        Thu, 14 May 2020 12:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HPqfvqRtncVQoHgcS/XINMTd0DOJVWJH0ZC6vuce8s=;
        b=emUIe2CrPkK2Pwcu2rfzSfgyOhqN1IgF5D2tNyx65tJLOK+sdsxdQdABAi2myLyVNU
         FVe7XS7lP2xf1PtrUdBTd7VG0r7l/xopB+Shzu2H8leaiBz0cAJ5Lmz0UZ8UN0NaAZAG
         kdeSlnmPPmTnRmjTrDfK98KxZ2UqI+JIRnhty532B+bH9W4Z7O+VW6MZH/dsackpEzee
         u+Ojyu99hdyfHcq8qv5JDnjR6ToMFTjtwZmG/vb3dATHY2ijf6AksA557BDukLR/f4m4
         gfDXh+sgY9mp7Xj0jCssrrUPa+hpwpm86QE2h2YVFKxK6YXUdMoczCrymXX6e/yUncQT
         CLbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5HPqfvqRtncVQoHgcS/XINMTd0DOJVWJH0ZC6vuce8s=;
        b=puP4bh6ZST3plbr/rj1cExLMDNuruBbiKZb08SmKdgi5sPOR9Pbq0NnmfBTiBGZ2dw
         XuaMlIa94s/lTuUT8pucP6UrlSS8oSTiTeaLRCc3g1zYR5Xact2eUMQnGi/hwW/9TEGA
         c1Zy8QPRCFTPXmJfwKr8TZrYcnqm9LJf6G7lRfPabxT9QfOia6zAdNaDaK9NDw0oDApt
         s7Lfy6JCBNxLkzdWMKjH7HcS7XyyPWeDECdQb5+84g5dFYqCyNN3AOxA+4RdovekXVef
         AjBzwwANW6EFXkYHuVR7BCOc6tFn2CU7TLTeGCEuOd4rmoFc43o5hkkjHrIqevaZ5hX0
         ShsA==
X-Gm-Message-State: AOAM531Kwom02P2il6CKTSLFOCbTosaWdKj6SSQoS5QWjlkULZULZQRJ
        RlUdUPzM8lzgxhBnrCux064=
X-Google-Smtp-Source: ABdhPJz4fQ85VUGDnvtJWFMEdr6v82wLiLbqW9nzb/RM5/7jT50m1uFyuDASQfywGtOcDsB8ZlPt5Q==
X-Received: by 2002:a05:6512:3384:: with SMTP id h4mr4329647lfg.150.1589483450598;
        Thu, 14 May 2020 12:10:50 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:8d23:71d:e677:1c7c])
        by smtp.gmail.com with ESMTPSA id q30sm2362958lfd.32.2020.05.14.12.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 12:10:50 -0700 (PDT)
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
        Zheng Bin <zhengbin13@huawei.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v1 17/18] backlight: wire up kernel-doc documentation
Date:   Thu, 14 May 2020 21:10:00 +0200
Message-Id: <20200514191001.457441-18-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200514191001.457441-1-sam@ravnborg.org>
References: <20200514191001.457441-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Include backlight so the documentation is now generated
with make htmldocs and friends.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/gpu/backlight.rst | 12 ++++++++++++
 Documentation/gpu/index.rst     |  1 +
 2 files changed, 13 insertions(+)
 create mode 100644 Documentation/gpu/backlight.rst

diff --git a/Documentation/gpu/backlight.rst b/Documentation/gpu/backlight.rst
new file mode 100644
index 000000000000..9ebfc9d0aced
--- /dev/null
+++ b/Documentation/gpu/backlight.rst
@@ -0,0 +1,12 @@
+=================
+Backlight support
+=================
+
+.. kernel-doc:: drivers/video/backlight/backlight.c
+   :doc: overview
+
+.. kernel-doc:: include/linux/backlight.h
+   :internal:
+
+.. kernel-doc:: drivers/video/backlight/backlight.c
+   :export:
diff --git a/Documentation/gpu/index.rst b/Documentation/gpu/index.rst
index 1fcf8e851e15..c9a51e3bfb5a 100644
--- a/Documentation/gpu/index.rst
+++ b/Documentation/gpu/index.rst
@@ -12,6 +12,7 @@ Linux GPU Driver Developer's Guide
    drm-uapi
    drm-client
    drivers
+   backlight
    vga-switcheroo
    vgaarbiter
    todo
-- 
2.25.1

