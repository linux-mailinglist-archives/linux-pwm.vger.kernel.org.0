Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04018213F82
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgGCSq1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgGCSq1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:27 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC1DC061794;
        Fri,  3 Jul 2020 11:46:27 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id k15so19011522lfc.4;
        Fri, 03 Jul 2020 11:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wW63XUx9iwsgo3sF+eLJ1EmI31rAQ/9VoQVVmqYGrJA=;
        b=AEA3tNC3BMq9rPELr/rZiMYPpVOIgC5hETJd60ZbiaM2cESBA/+X6SIVasVZyvUEr6
         cHgqNIYhMv4o1ACU1pNaBLEdnNvfZsPpwvGNquYML5vL12I8TBAauNOURQt3Knjlgf04
         ZJG0pg+nwijDjTqOX8bJOzplLrBMVtQCgJ0BYfKgXdf54tmt7VQ+gUhdTTpGaDn8N5MX
         o65NysSypWG+FAdScjb1ygXPmFmHnyKSmuRYI+sP/q5QIMxFEHf2Iw1rtrxXNcRKPeda
         T7HQeUO1rf8M9+L/8GSNTG8DmqIIJsecGhQbruef2OdAIVBQfc+6ur/9b85tbX0ojth4
         AnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wW63XUx9iwsgo3sF+eLJ1EmI31rAQ/9VoQVVmqYGrJA=;
        b=MNm+aC0WZ1QvWdikZn03FmaTLw86T69p1sZtXtMZA3CzLZKWctznGC3Ey0+zGzIoF6
         ZAUAKTv7oyCcfB5G+nfGqAgBEKy/nwb1vxZkit7dhkoqJG/ib/Joito3LlTmYyMgUHIj
         ujxvAefal7PkScb45as0ModhGIZN3nl2oNC3w+YKDOH8SfutbrZsroq25dzeL4vcVpha
         xUSPEINjywERxfp3XEPm+FwrIRetBMrIeTPm6GQk4UjtOITFd3rwQ5woUuAbNjL1DJwT
         R5zyPfOMWiTyN9bK9Pdy/itBIoEeIEgkVtvDFwfW6YKM6QQLiSt5uttepLBQ59QHPSHo
         nfJg==
X-Gm-Message-State: AOAM532/vRewlrMVdfP59LVtZKVasxEST1b3x9ufHwFKFrajh7NqIEhA
        AanhiFX0LGuJgM/otpPMX50=
X-Google-Smtp-Source: ABdhPJxEUXz4bOYpqKTDSZSj17VqbWse7IL9pSVI2ig7Wc0HkhTmo1clZ+dbXQsbopGFStzEnYoN6Q==
X-Received: by 2002:a19:815:: with SMTP id 21mr22267814lfi.119.1593801985628;
        Fri, 03 Jul 2020 11:46:25 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:25 -0700 (PDT)
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
Subject: [PATCH v4 11/20] backlight: wire up kernel-doc documentation
Date:   Fri,  3 Jul 2020 20:45:37 +0200
Message-Id: <20200703184546.144664-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
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

