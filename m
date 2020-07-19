Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9AC22509B
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgGSIIV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:20 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3B9C0619D2;
        Sun, 19 Jul 2020 01:08:20 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id b30so5883458lfj.12;
        Sun, 19 Jul 2020 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wW63XUx9iwsgo3sF+eLJ1EmI31rAQ/9VoQVVmqYGrJA=;
        b=HuW3STOjnm+5nA7TKFdrHyzBWygB7TYqPWMehFXq2MvpLMqQEL0KGAe5sg2xHurSL7
         yTEvfW8rP3bsTWPpPulplN7Wb7PBEHud8WVBnoIB/GPMUQk23NvL3VU4zJ6moNHIDeFl
         VqJFEgbISll+a9tCrHRVmVtdv8v8aanuM9QJCi4qsjrHtdaWn/5M2/pa6BHxOfK4UZlV
         V2+3LWiCOLWdJhmAFNRu74uELktGOPi1wf6XpnzVHs1rnwEQ4fiFRa5tUk+9NzAuwFIM
         +sVPLJJYBc73HiorGIirrriC+eL9Cd7R9NPUpSANVeOFwLamC83wwOcm5BK+h4lHwra7
         GfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wW63XUx9iwsgo3sF+eLJ1EmI31rAQ/9VoQVVmqYGrJA=;
        b=sP9byqGmAjH18OJvzmbYS0hjZkaD5yTX9FETLRWqUkYVyY/sgco5BhZwUaKzZ9EYss
         28vjs4qWxpvlnVL6+ViSdih5peyjiZaIt+r2UbaOSlBEtdDBwvZIqtdSmGVm4bfxVeTJ
         tw5/nBBBhh8XcEZOHOflrHVhnE7jLBGnpYvtoOvFBhaz9CBxxRkNhWq7JGQm7QFAapJ3
         p3+CR7GnkrUoUY33YfH5MlIaPgk1rP1aTKXhrrqaxVqQ33oZOOUa7SGp/pglqLiy+mlC
         ikLQ7/7zhI6ZgXhMENnH53dbfNrB9VwWPVTni3tjHMEQsOrLr/y32oVZpnwnMevAtl9N
         bCVg==
X-Gm-Message-State: AOAM531RORHKbX64nYS9yHS/OC0PXIqlUgWiSjNP1u+iRYFbfWd8DL/y
        +/0EqijqCN5nrO3qCB54TZ4=
X-Google-Smtp-Source: ABdhPJwLvz2z9lmHimCaJxwSbfMyBaB/B0JnKaQ3Wdhc/h602Hub6VMpVFeHlh9jZTqOOYVvZJdHpg==
X-Received: by 2002:a19:c1d6:: with SMTP id r205mr484342lff.141.1595146098916;
        Sun, 19 Jul 2020 01:08:18 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:18 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v5 11/19] backlight: wire up kernel-doc documentation
Date:   Sun, 19 Jul 2020 10:07:35 +0200
Message-Id: <20200719080743.8560-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Include backlight so the documentation is now generated
with make htmldocs and friends.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
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

