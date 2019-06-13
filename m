Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B45044C7A
	for <lists+linux-pwm@lfdr.de>; Thu, 13 Jun 2019 21:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbfFMTni (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 13 Jun 2019 15:43:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33861 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729530AbfFMTni (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 13 Jun 2019 15:43:38 -0400
Received: by mail-pf1-f193.google.com with SMTP id c85so12471281pfc.1
        for <linux-pwm@vger.kernel.org>; Thu, 13 Jun 2019 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pqXyxTTAbi5aST0rw8BM87gXyR3d1+ROgexg6G5YkyQ=;
        b=g7PzxI3g42K7LJ1ywDPo6EXnhLkUuGu9zje5jOJWOtwmgEfQQqo/EhoS1ZZt31I04+
         fL1PiB7Ex9sJ7fFijAjKJXwHIRQGwUDJKGx1a2snaLaeGJ5l7VIa4Ae5wrAbEPSfcrWL
         huLjIf47PLe+/0vlbh03Nc3iTlYmithF5Qyts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pqXyxTTAbi5aST0rw8BM87gXyR3d1+ROgexg6G5YkyQ=;
        b=VpgwGkuhvUo0tzAx7F61PnRZvTYTUA9gJfQ0T6XRaPK4mTXD8AEuONL2pBkPHtJobO
         CB2Pi55Gacfjfy0htbuj0ZkW3MPqYlSRw2GQgdQuZfXGXvjhGig8GYPBdpfWeiNBf1hV
         52ScjFk5H3wmxkKd+F9GKvDSzr2Vsa9ESfMuj1HdZZo8Pw6IBy88SmX8oPx2UsRTA/RI
         YmXKq38GbqoMO5jjbAXyZvpnyxh2te7ZYaSi9P+aqqVBkVg+ppoqvTKGlCXAXjm7tWFC
         ayT4lGP2vS6YdyiwV8OLFlgs96+ltz2/pKdFT7+lMqsGXlZepAJRZIlUCH0PSmz8hKXe
         ZTCQ==
X-Gm-Message-State: APjAAAVFFyfHoE2fKXM6ASEi/LwR66sdzv71vkDumb7/CSQC+YmMENe8
        GmU4luKkR9Wn6qDaQr0XFk8Igw==
X-Google-Smtp-Source: APXvYqyj6R9zaxDLlDqwPo077OY+vPSo/K4pYOSOfb40+7Tt58DAXZ7DMLGY75TjBV8lSKyivOQt1Q==
X-Received: by 2002:a17:90a:898e:: with SMTP id v14mr7218671pjn.119.1560455017445;
        Thu, 13 Jun 2019 12:43:37 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 5sm557967pgi.28.2019.06.13.12.43.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 12:43:37 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-pwm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Pavel Machek <pavel@ucw.cz>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Date:   Thu, 13 Jun 2019 12:43:26 -0700
Message-Id: <20190613194326.180889-5-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
In-Reply-To: <20190613194326.180889-1-mka@chromium.org>
References: <20190613194326.180889-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Check if a brightness curve specified in the device tree is linear or
not and set the corresponding property accordingly. This makes the
scale type available to userspace via the 'scale' sysfs attribute.

To determine if a curve is linear it is compared to a interpolated linear
curve between min and max brightness. The curve is considered linear if
no value deviates more than +/-5% of ${brightness_range} from their
interpolated value.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/video/backlight/pwm_bl.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f067fe7aa35d..912407b6d67f 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -404,6 +404,26 @@ int pwm_backlight_brightness_default(struct device *dev,
 }
 #endif
 
+static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
+{
+	unsigned int nlevels = data->max_brightness + 1;
+	unsigned int min_val = data->levels[0];
+	unsigned int max_val = data->levels[nlevels - 1];
+	unsigned int slope = (100 * (max_val - min_val)) / nlevels;
+	unsigned int margin = (max_val - min_val) / 20; /* 5% */
+	int i;
+
+	for (i = 1; i < nlevels; i++) {
+		unsigned int linear_value = min_val + ((i * slope) / 100);
+		unsigned int delta = abs(linear_value - data->levels[i]);
+
+		if (delta > margin)
+			return false;
+	}
+
+	return true;
+}
+
 static int pwm_backlight_initial_power_state(const struct pwm_bl_data *pb)
 {
 	struct device_node *node = pb->dev->of_node;
@@ -567,6 +587,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 			pb->levels = data->levels;
 		}
+
+		if (pwm_backlight_is_linear(data))
+			props.scale = BACKLIGHT_SCALE_LINEAR;
+		else
+			props.scale = BACKLIGHT_SCALE_NON_LINEAR;
 	} else if (!data->max_brightness) {
 		/*
 		 * If no brightness levels are provided and max_brightness is
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

