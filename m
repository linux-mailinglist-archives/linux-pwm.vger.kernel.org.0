Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D964F1D6C04
	for <lists+linux-pwm@lfdr.de>; Sun, 17 May 2020 21:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgEQTCV (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 17 May 2020 15:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgEQTCV (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 17 May 2020 15:02:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07343C061A0C;
        Sun, 17 May 2020 12:02:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e25so7532061ljg.5;
        Sun, 17 May 2020 12:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5HPqfvqRtncVQoHgcS/XINMTd0DOJVWJH0ZC6vuce8s=;
        b=ok8MopO9rneb9yJfTROGOYbIX9MXrlnlnkw3yNr3bMxjvniQAbQ0seWhsvYALaTF9E
         JwLA0Ls79pqiaHECZQCysVloRWrL0GA62wfWMLm05PrhHCVG3ufoFZZJoSPx1hy6N56/
         an9Wk1loxD4qVgcH3slk0rC+tHgfI0UAHVEh6XmTnetf0MePNJ9gBebdQX6qyDpGpibL
         QJBg46D6jYZ1sKyBRm5k+7a437LqTb14R5OIKSjZnvrtVvHCMPI1l5o1SLm/l+t99/ut
         99tI1XfoqK6P9iZJZtj1SwBmRAKEH1xq43VrfUnEs1wEFYGEJmk3koLIvQyRIYiDhckN
         OPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5HPqfvqRtncVQoHgcS/XINMTd0DOJVWJH0ZC6vuce8s=;
        b=l6J9eSpXVcpR6ideVZM+BThVX9+zircbtMTflr404C4EvuhEkDkp86pj5At+FhOpkg
         IbI57Fleye3a1A+dsat5gs1bfBXPfQ+JOLsTPg9102dc/eraob4tPuYC2v1oFWRYEb0/
         8umy63n/nNH/nJh8NgEeDT8zgOrPD1ZlAM7NqcLqChXb9tgLWo+aRoGfnoNCy8CgDoJd
         2przH7lDZBC2oSHsc8wkFdmcXpjUp0Z90WsWKdNUGTSnnWXir9bq/p5swUmJLAohP6Dr
         om/Zx0zwxLLM27yzveXa2ctdOib/1+Ao46a1dbtytAPeNhXithhV+UuglQYQbyBvqDFU
         1Z0A==
X-Gm-Message-State: AOAM532aS9bKV2RQEM+Br5+hnbjlSO4jaCP6Xih4qtik/Q5izUpI+Vc+
        VAVuYd471SFHq2O+EHrNNbk=
X-Google-Smtp-Source: ABdhPJzQHolQWwc6+x1Ugs5U3BPnVbfqs6FVluzObxl5aohq58l6EEY9wyV6a1r02QHSw8SzQtSo6w==
X-Received: by 2002:a2e:b177:: with SMTP id a23mr8196584ljm.140.1589742139509;
        Sun, 17 May 2020 12:02:19 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:5d55:b3eb:397b:9086])
        by smtp.gmail.com with ESMTPSA id t20sm3282535lfl.17.2020.05.17.12.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2020 12:02:19 -0700 (PDT)
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
        Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v2 12/16] backlight: wire up kernel-doc documentation
Date:   Sun, 17 May 2020 21:01:35 +0200
Message-Id: <20200517190139.740249-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517190139.740249-1-sam@ravnborg.org>
References: <20200517190139.740249-1-sam@ravnborg.org>
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

