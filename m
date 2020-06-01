Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A3D1E9E88
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jun 2020 08:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgFAGwe (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 1 Jun 2020 02:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgFAGwd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 1 Jun 2020 02:52:33 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4CC061A0E;
        Sun, 31 May 2020 23:52:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so3307467lfb.3;
        Sun, 31 May 2020 23:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69nTzFI2GNQU9AQvcUBs3yFCmAT6Gg/K7NgbR/V9P7s=;
        b=VktVUoO8qiYt72hT3cUOFa7m832AcmJVn4azwkTffzj718DYgrsAiAe+pQylySaE3z
         2qbA2Od2sVWrnx5VhmKMbAgZnVQObrPPJD7QdpmPLrXvbIrxHgh4JF0tWmP9BOW9GdI4
         4FOD3VbPc1vWAHZOsqSteyU42LfkvkFjhQ+KUO5scm2F0yWif8WccThGeEMsWOH1q3B7
         QsNZ5o2j3A/TzyQf+lqCJnrsRgFIN4LyspE+lmjqg8RZcpVXkCTWIyOnabnhzJOfCDD1
         sTmWUghnYSC7+m/7V6iz00DT1PVLQumitScjqWtQ54p6OWW+WTlydQSIVpyo1W6ZwiMX
         1vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=69nTzFI2GNQU9AQvcUBs3yFCmAT6Gg/K7NgbR/V9P7s=;
        b=Nn7fRbvY2QvRxv4LDzrA7CVsiU2/00zCCncbEUrhF2awnocu5neD/zy926H6yvHKCA
         XEsqymjABOM7xk0w2360E9s5d1ASrvIiVx8Nhn+qjy2UCpwdPKoivwtv+kK3StWnnG4n
         0JZzTh0j1uhyQ9WQGzUSaW8cc6uppO5ksFDMPXgm1qm/hO42rofYwy9SEZV0zKTwDnPm
         RCD0qoaPd3krRnA/r2EVKW08yXu5qX+O76y/otRMiObleZ0H5wd8VwLmm7bDIyCIW62T
         N+SeWDbVkhK+Zk55N5qTIMPnsXkmU5dY2Cqo9zSS+Q30KOOCpe1470idn+fp92BcGJpD
         hhbA==
X-Gm-Message-State: AOAM532WAEXPy/Xrh0J1xvYqm2O0HwuMp6/W7I0iGMXFLsByNUeuYO8g
        wJOQDkU5pC6efCAYe378xNk=
X-Google-Smtp-Source: ABdhPJxsAjomR+EHBTZIUY3oWKM0UlreSmcXcRGSGObIKKhLr85RwEES5aA9AnNo+TFzZ8DUbJib0Q==
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr8177683lfi.204.1590994349317;
        Sun, 31 May 2020 23:52:29 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:281d:a604:434c:a58d])
        by smtp.gmail.com with ESMTPSA id e13sm2540462ljl.117.2020.05.31.23.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 23:52:28 -0700 (PDT)
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
Subject: [PATCH v3 06/13] backlight: document inline functions in backlight.h
Date:   Mon,  1 Jun 2020 08:52:00 +0200
Message-Id: <20200601065207.492614-7-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601065207.492614-1-sam@ravnborg.org>
References: <20200601065207.492614-1-sam@ravnborg.org>
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
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index cae1af95dd9d..f99ca19cc3ec 100644
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
@@ -360,6 +364,18 @@ extern int backlight_device_set_brightness(struct backlight_device *bd, unsigned
 
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

