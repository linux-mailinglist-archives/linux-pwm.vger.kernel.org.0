Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62B9651C59
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 22:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfFXUbZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 16:31:25 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39050 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731819AbfFXUbZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 16:31:25 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so8162715pfe.6
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 13:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lSYYVqhHYII5ViyDtFOkp4I/i31+agPnClo/p5CN7rU=;
        b=Mg4fv0I1KvsvYo7P+k+I0/jzY0DpnxpM73UwzZA397nYxCv69Pmx51bd0IZKJQS/T0
         e/T2av1TRlRVmfz56FF9Jew1DTrqN5iqbEIH15c5yTcYw4xPo9wLhvaIaKD96sdi5ihi
         w7DU16/nElyk+XneNHQnooeQwSyLleBKKFhyY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lSYYVqhHYII5ViyDtFOkp4I/i31+agPnClo/p5CN7rU=;
        b=SRDKoX7nl8q4fSxtIKsqBqcSYutLmNWzqu2fz35sqasopPYYjBziC9rubtQbVQ+daS
         +uwQrFw1j1YyQ5awyXM4IFujY9cgnw1nsuGu4nHFIwIexZPnHMbZ04DzuHIuRcUox7bf
         vjI4dTIjsbEiZIGQzoigX2Igyos5KWcozkqBdxVTzhbM/a01JCCyCN5ygQ90C6o2ceKo
         w6SzxFUamUUyJ+GdbvKbKYuaY0TZToPef24uByecVaEOEagy6qS+ACr0TNbI/+dIFS+j
         FAs8mIk8SSctlk/4/OUAa+9/tdHiFCx6zVWtF/YTeBSnMxq1EzKHPlGdXC8eJmxPXpF2
         6UdA==
X-Gm-Message-State: APjAAAXVWwcm5PwOuzohDOAR20IuuoGdY4N+s1MwNoGfY+rCxxAIVxDF
        +0MvwmEFStLYNozgEuVJC42qvA==
X-Google-Smtp-Source: APXvYqzbWxM5xrdZvQVssIkJ108K28bRsNta+aYXMp4VczMFyBnMpEFk0/3OUZMH3nt4zl2HLpoBMQ==
X-Received: by 2002:a65:62ca:: with SMTP id m10mr34696355pgv.57.1561408284531;
        Mon, 24 Jun 2019 13:31:24 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id e10sm9833411pfi.153.2019.06.24.13.31.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:24 -0700 (PDT)
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
Subject: [PATCH v2 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Date:   Mon, 24 Jun 2019 13:31:12 -0700
Message-Id: <20190624203114.93277-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For backlight curves calculated with the CIE 1931 algorithm set
the brightness scale type property accordingly. This makes the
scale type available to userspace via the 'scale' sysfs attribute.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v2:
- added Enric's 'Tested-by' tag
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..f067fe7aa35d 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -553,6 +553,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		goto err_alloc;
 	}
 
+	memset(&props, 0, sizeof(struct backlight_properties));
+
 	if (data->levels) {
 		/*
 		 * For the DT case, only when brightness levels is defined
@@ -591,6 +593,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 			pb->levels = data->levels;
 		}
+
+		props.scale = BACKLIGHT_SCALE_CIE1931;
 	} else {
 		/*
 		 * That only happens for the non-DT case, where platform data
@@ -601,7 +605,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 
 	pb->lth_brightness = data->lth_brightness * (state.period / pb->scale);
 
-	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
 	props.max_brightness = data->max_brightness;
 	bl = backlight_device_register(dev_name(&pdev->dev), &pdev->dev, pb,
-- 
2.22.0.410.gd8fdbe21b5-goog

