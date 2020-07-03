Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8E7213F85
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2020 20:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgGCSq3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 3 Jul 2020 14:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgGCSq3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 3 Jul 2020 14:46:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14BF1C061794;
        Fri,  3 Jul 2020 11:46:29 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e8so3804599ljb.0;
        Fri, 03 Jul 2020 11:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=41qjmVVsRfujBfZE1W4YGhZi8CncNw8be02IRMyut3M=;
        b=VfpVPRzwwuFqCZ7fUPqVLOJvQKni550zzdLt2nGP8ambnSmBuqZNmOwpBEqZSOYgiD
         Q8wotiZqUwhzppC46a/R6RJQVIy7x8V/SdEntazBT6CNGvhWmpE2akVXz/zMHxEbC9yA
         a9gkAs2F+BBPUJGjxNT5WQUtL3nBRueVyIms0y1cIvPnm33wMSk7Vhv+HBLL5NmNQ+u5
         HZ/F7cbQJxWn3UWnV1oGF5R3idD8JquldlJz/TRhX89eih5/9rBJi7pvMpQ6m5hOG3/x
         NYiGpf8TElwWyQiw22MQIo2/FfKkB9TGrqeqLiOUUVwBT8z5aeRJEKNHK8SH/acHRmBX
         P2bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=41qjmVVsRfujBfZE1W4YGhZi8CncNw8be02IRMyut3M=;
        b=DnLekqQTnYgZbAAc5j+Z9XRVZPc/OwL1VFJ34kWa3PmaG5pbocBjejzSiwBSZO1jID
         scZctYegEVbY2XMktN/yr7UDp54HDqO7kFLqPf5QPurrvyadfaxwJCBvtFeDZXUobstE
         OC8iFuwoProTrD3xlqIkkXe7IIUEHx5gW3Rpu6aj6kItioy7+NQEuUH1ARHujJ6Bfd9c
         KkmS0orKP5R/F/bfQWlmxD60vh1sBFnSH7idwRFDxpnF4MqMu1e6Ujv72ZYLLtoc1IKl
         9VD9ZKBGtjGVtt/al958nhUHQ/ZIOjPgP4m06AwwcvQofpxMB0tUWLKjF0L1CQVJwbcz
         CoMw==
X-Gm-Message-State: AOAM530JwqXY9OTMFf1bQM8gYP0WlpxJc2dRLQ6yzUdhcttL1OOV+CHj
        spsmBK8Q8XV8o8QTI6FLLEU=
X-Google-Smtp-Source: ABdhPJzQM5YseU4FLRbGqPO9auj0rWYRuQJ6L3t2SBa1OIW6Mb98AjbEZouXoOeElwNDHjdcB1Td5w==
X-Received: by 2002:a2e:9b04:: with SMTP id u4mr21861645lji.364.1593801987598;
        Fri, 03 Jul 2020 11:46:27 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:4025:a614:1d5c:b7bc])
        by smtp.gmail.com with ESMTPSA id h22sm4404224ljg.1.2020.07.03.11.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 11:46:27 -0700 (PDT)
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
Subject: [PATCH v4 12/20] backlight: introduce backlight_get_brightness()
Date:   Fri,  3 Jul 2020 20:45:38 +0200
Message-Id: <20200703184546.144664-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200703184546.144664-1-sam@ravnborg.org>
References: <20200703184546.144664-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Based on an idea from Emil Velikov <emil.l.velikov@gmail.com>
add a helper that checks backlight_is_blank() and return 0 as brightness
if display is blank or the property value if not.

This allows us to simplify the update_status() implementation
in most of the backlight drivers.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Emil Velikov <emil.l.velikov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
---
 include/linux/backlight.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/backlight.h b/include/linux/backlight.h
index c6ac4cbb9ddb..38db67588b16 100644
--- a/include/linux/backlight.h
+++ b/include/linux/backlight.h
@@ -417,6 +417,25 @@ static inline bool backlight_is_blank(const struct backlight_device *bd)
 	       bd->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK);
 }
 
+/**
+ * backlight_get_brightness - Returns the current brightness value
+ * @bd: the backlight device
+ *
+ * Returns the current brightness value, taking in consideration the current
+ * state. If backlight_is_blank() returns true then return 0 as brightness
+ * otherwise return the current brightness property value.
+ *
+ * Backlight drivers are expected to use this function in their update_status()
+ * operation to get the brightness value.
+ */
+static inline int backlight_get_brightness(const struct backlight_device *bd)
+{
+	if (backlight_is_blank(bd))
+		return 0;
+	else
+		return bd->props.brightness;
+}
+
 struct backlight_device *
 backlight_device_register(const char *name, struct device *dev, void *devdata,
 			  const struct backlight_ops *ops,
-- 
2.25.1

