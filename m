Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACE81E9E95
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgFAGwm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFAGwm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:42 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDA5C061A0E;
        Sun, 31 May 2020 23:52:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e4so6770896ljn.4;
        Sun, 31 May 2020 23:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AnaHL8ZW2AHSXoDqHfMNaVU3hWEgwww58aZX9yKaEh8=;
        b=E7MeDZFYP1vjvb0jmnutl7Cd/7rXGGCPAXDxfA3kTRbZHzTQ2zKfSTZtmIrriXZLdY
         6WIWBnm/MFR3O9nIQxM3tR0Cl1HBuV3Emywhryw1zL4FZwh/66DsL5G6TKVeC4nzEPsv
         wVPKVD3gj04X9hB5d7ZN6lR7DCjJ0jGjtauxtNB2VIzQ4gQqv1L2W81H+owG6MuFS/N+
         IkjT1FrK5OJSb4Yss1QUwQKddggmHXmXPZkn7KryS48uwBNvh4uXmZxd0VI+rFeL9l88
         ddtpPee0eUztEq4yAVQy397i2KERofzwnmWngZ5ZLhIm0Ul/3hkeA4JNev+xJQusw3Rm
         vV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=AnaHL8ZW2AHSXoDqHfMNaVU3hWEgwww58aZX9yKaEh8=;
        b=MMVZzcAbYXZW62tX6CWR1jUSGQ5RsO/pj38gc8jg29O29N3aXGPgN2yyAXCm/jXYLe
         /F81KLWrlTbQ1U6FTrAr+IMjLncgQmVwBhKuK3nDNuKyPRdoCarCQOYwdjlf7Dx9s4EI
         OzTJYAJxsXiVhBzs0GA/0E4r42nbSazHB6LQzJI0v7PN0T02zV8/fNXMmlnQRII0IXfi
         E+BXNtz489OwwvTrlUie+ZpFgzuurOQ3eX0aTzshSwycLA7P8N7s7UIBCt3XVKqJlbcJ
         KsiJdPOVPp+ZKL9QlXKfLPNO3pQ2qCkVF+k0q+y8h9wbxHBHOg0qjaFIC4OaMovBNw64
         Dr7A==
X-Gm-Message-State: AOAM533p4KtTivhLSeseZtvxi0wdMTrz72nT4Z6mWB33chafj0oXnFvr
        vPzMlBgXLTWVxuqEAbDeM1Q=
X-Google-Smtp-Source: ABdhPJy6NUne+NeaxEir/nZPRNno9Z/JzFLm/d5YWSPgm0nw28WxZgRoVCFDsShL4PLF+JqMBV3P3w==
X-Received: by 2002:a2e:960b:: with SMTP id v11mr2290702ljh.77.1590994360550;
        Sun, 31 May 2020 23:52:40 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:40 -0700 (PDT)
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
Subject: [PATCH v3 11/13] backlight: wire up kernel-doc documentation
Date:   Mon,  1 Jun 2020 08:52:05 +0200
Message-Id: <20200601065207.492614-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
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

