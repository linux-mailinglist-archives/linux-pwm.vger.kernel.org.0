Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDABC22508F
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgGSIIO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0096C0619D2;
        Sun, 19 Jul 2020 01:08:12 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d17so17062487ljl.3;
        Sun, 19 Jul 2020 01:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=76GYwHJgmpg1D+ufO0JSzMv0fcAJAUH2Ai/nlDiORJQ=;
        b=fH3SGUi6PCNnnzkTN7BquDl+u2btMvTf81oi3LU+7FneCF2MCGfqc7CKzni3O2OX6L
         KWnF534GMBpMZGFDjscLbUeFGk1AuYP5sDRxPStQJgp6W+Mh+rN6Ja54z6uvnAZ5LBUk
         DviY2+kn/YsIwezhGuLxaL4k5PJORjV3yCT3lcPcnNX4/ZWxydT9svNvr+OkZmHalkx5
         vNpnpvg/lvJ7ZneIWDRrAvn5/Ng18ORLvC8Y9AKo2Nmwla7p+pT59d+uqegZZftgP+pJ
         kU4hss2AXLRGa5XO+M5rcOQvYA8MvVuHPG3mQWa+jRoB6vaNtZFm6PgQDcBfS8VcMidK
         dSlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=76GYwHJgmpg1D+ufO0JSzMv0fcAJAUH2Ai/nlDiORJQ=;
        b=TW5bR82FuQcHZKPpx8D/hsbCu36J6wNMrL0T0UuEHexNif6u+SS9pP1qx/MjnCzXfD
         nXR42LkFPCkZ3xsUUsHyTZrFbYI+z4BtdpuiCjIeQECnSBFDV7w1mwOBMu3mHSy/1OLA
         8Y2cDv/D8kZWrZrzk0fua32p5bqzBiK7b31TjMgtZrq5BLbtssavVFLSTr/xbdxnbZtV
         01bzC8oyl1M6ybZFlZ2YWzjtKDaiMMNPq7tPqEcIknPmcLZo8yrf56pCA3FbMMi0ffX4
         iyiAkM5ddnll1w4tdp9EhFMV1CwDtVfUjoTTDKa3yhDO9zn6U+AkB8btBdSBxPDTwPdA
         DE/w==
X-Gm-Message-State: AOAM532sOphLN0MRrYkHUJOAwwWJrXwWQ7H6GfXnhky5Sg7JaKdAn/8Z
        yNh6KHhRiZLsA9olLhDplRA=
X-Google-Smtp-Source: ABdhPJwYCyvEJr4JKQu2wAiVlSR8RATflYb7drCCKaX0jVaBWgPcevLelVojOMKCgG3v5B+FO+PQvg==
X-Received: by 2002:a05:651c:1b6:: with SMTP id c22mr6893563ljn.421.1595146091482;
        Sun, 19 Jul 2020 01:08:11 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:11 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v5 06/19] backlight: document inline functions in backlight.h
Date:   Sun, 19 Jul 2020 10:07:30 +0200
Message-Id: <20200719080743.8560-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add documentation for the inline functions in backlight.h

v2:
 - Fix spelling (Daniel)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index 7654fe5f1589..7d6cb61e10f5 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -268,6 +268,10 @@ struct backlight_device {
 	int use_count;
 };
 
+/**
+ * backlight_update_status - force an update of the backlight device status
+ * @bd: the backlight device
+ */
 static inline int backlight_update_status(struct backlight_device *bd)
 {
 	int ret = -ENOENT;
@@ -361,6 +365,18 @@ extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned
 
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

