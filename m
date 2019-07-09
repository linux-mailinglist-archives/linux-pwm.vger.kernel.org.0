Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC863B9B
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2019 21:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbfGITAY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jul 2019 15:00:24 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37548 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfGITAT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jul 2019 15:00:19 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so7250060plr.4
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2019 12:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7VTnoQhILwKHLps+gGfkisxkuSKBxEyo68mEBQUHAaY=;
        b=kfV/7/kvbkaJ7UsIzdsFDRlAMdzpK6L6mf+hCSJgo/ppqnLdG493pA1TwsgBo8gqI+
         4m8IhLpUYafypQV62VutcuQ/xBvf5+Qfw9xSrUk4r15c6IIY+l2X2T26Z72GsIoqOOBe
         J11qlTxGksNKv6aSrfL+fr+Nca1CmutGbOxRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7VTnoQhILwKHLps+gGfkisxkuSKBxEyo68mEBQUHAaY=;
        b=tBBIO38AC9AQWHLT8vxvrEVOurU3O8BsP88WX0wSFpQdcYyelepI92Tyfjt9GBRbRa
         fNuiWDVkn1e/RDBqq01Z9hzgd33rihKw/i+M/oL+y1XKOFYSnq9z/WYE8n7aakNIqXnL
         Kg/VGke3Euu3uYsdWraHH2Qcwo6WeS9u19uyiqsv42W42EA5PHWf2OKvLR9I27w6Hil2
         tT8gMk347j2NoXA0EaQ5MDAG2y4NklKfyWaBkV3TI0lsxlGWu6lyzeoVgNon8yYzbKfD
         Hteu6DEXGsuXszdPGeRG8RtzYv/px54SBHuOAzMDnWIa6oNd6dZ0MYKzwp+ClyqFr5/D
         UvHw==
X-Gm-Message-State: APjAAAUa8e5+GXidj+BCYbGm7tOH+yta/grlT6fazzba9coosy2H/iq9
        XUCdpT0GLJmg9CoJt3E0HCBFCw==
X-Google-Smtp-Source: APXvYqyFxcn+t9rWGoWrMrwk7IGCCiVhSunnF0u4fJQLec9Z7/8us2QIzzEsGo2V3Ixk/lZr9QooRQ==
X-Received: by 2002:a17:902:29e6:: with SMTP id h93mr32447140plb.297.1562698818959;
        Tue, 09 Jul 2019 12:00:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id v63sm8391683pfv.174.2019.07.09.12.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:00:18 -0700 (PDT)
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
Subject: [PATCH v3 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Date:   Tue,  9 Jul 2019 12:00:07 -0700
Message-Id: <20190709190007.91260-5-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190709190007.91260-1-mka@chromium.org>
References: <20190709190007.91260-1-mka@chromium.org>
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
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v3:
- none

Changes in v2:
- use 128 (power of two) instead of 100 as factor for the slope
- add comment about max quantization error
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 7c6dfc4a601d..fef98beb8b7e 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -404,6 +404,31 @@ int pwm_backlight_brightness_default(struct device *dev,
 }
 #endif
 
+static bool pwm_backlight_is_linear(struct platform_pwm_backlight_data *data)
+{
+	unsigned int nlevels = data->max_brightness + 1;
+	unsigned int min_val = data->levels[0];
+	unsigned int max_val = data->levels[nlevels - 1];
+	/*
+	 * Multiplying by 128 means that even in pathological cases such
+	 * as (max_val - min_val) == nlevels the error at max_val is less
+	 * than 1%.
+	 */
+	unsigned int slope = (128 * (max_val - min_val)) / nlevels;
+	unsigned int margin = (max_val - min_val) / 20; /* 5% */
+	int i;
+
+	for (i = 1; i < nlevels; i++) {
+		unsigned int linear_value = min_val + ((i * slope) / 128);
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
@@ -567,6 +592,11 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
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
2.22.0.410.gd8fdbe21b5-goog

