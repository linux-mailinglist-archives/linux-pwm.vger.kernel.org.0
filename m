Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F367E22509E
	for <lists+linux-pwm@lfdr.de>; Sun, 19 Jul 2020 10:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgGSIIW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 19 Jul 2020 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSIIW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 19 Jul 2020 04:08:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF88C0619D2;
        Sun, 19 Jul 2020 01:08:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h22so17035245lji.9;
        Sun, 19 Jul 2020 01:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJDKBzM5WCM/wOabtI6YcckSIiYQMrhs/j9cUZtSyfE=;
        b=ke0IBpPTuBlyL2cszAZT9C9ayT7fVfvVzC6OVH3QBVUidZxNtMEqCBCq0s6HPGBv11
         gXWEqvswIX9DA5Xter6f8TUidX6LiV6GRtUhdh2SY0CWmxVl8cYs9CWI08MAB4nJYF4v
         J/UCP/A6eLnvH3XyzxH9hR8I0ZJbrB/LatKBwvGdnTK5AI06N63kiVytCbqnzJtvNL67
         roPN+b6GObh6hOHmeMW/FixrnYeylnz5e1P5jPNTaDKnhPBKLkBLXfFp2TOCPvVu1Z6R
         X60dHm+H+0bghNBCCYLWQXetFC1paWcfrV/Pn+lw9QH28Ygvk/O9Dite+bT3jJbfT75K
         hp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=OJDKBzM5WCM/wOabtI6YcckSIiYQMrhs/j9cUZtSyfE=;
        b=Z9TIeMU1grGxeMA27RZP4xaG6jTfDav0Z1WWrvRrEPO9LVZK33zIQGwscXDI3Ut54z
         +5OQbzKW236CqfR3MHnbWV88jMREmfywZAQ08FIjAc8Wh+ukWoxSXQx/9rB+hdOMVTcU
         /Gv1yg2YJd5vVIEHaT+EiqYbHxlpOse29Mxo+auwACEOwUSa45NZarUkTdDPARMI7JNe
         DlDTn+Y/ptY2424GlD81Im4agTWkfVb0slI8+RwBwUvvkRnGi0LdqlXXB+ktNGPIBx5X
         9EZOa4wgUfDpjaBNyGIMN502YODRYK3nROC3AzWGBTCtmedRlfO4zDHpBWkVFR3oZQ/1
         gARg==
X-Gm-Message-State: AOAM531RjgDgnNxsuorKRsEEi0mDMSnsMaHaWUZ3kyK3s6cM6BIF7JaK
        BSnCL9XVZeeCVNsbBZrtW4A=
X-Google-Smtp-Source: ABdhPJw6MoGAA6/OzdTbDIA16nVyRjHatL9PcGdLBKA3q4XDBNcAWImwR5+k5f9pz7bIALWGu643sg==
X-Received: by 2002:a2e:9908:: with SMTP id v8mr7603333lji.186.1595146100487;
        Sun, 19 Jul 2020 01:08:20 -0700 (PDT)
Received: from saturn.lan ([2a00:fd00:805f:db00:d5fe:fe9c:fc06:b74c])
        by smtp.gmail.com with ESMTPSA id 72sm732407lfh.97.2020.07.19.01.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 01:08:20 -0700 (PDT)
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
Subject: [PATCH v5 12/19] backlight: introduce backlight_get_brightness()
Date:   Sun, 19 Jul 2020 10:07:36 +0200
Message-Id: <20200719080743.8560-13-sam@ravnborg.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200719080743.8560-1-sam@ravnborg.org>
References: <20200719080743.8560-1-sam@ravnborg.org>
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
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
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

