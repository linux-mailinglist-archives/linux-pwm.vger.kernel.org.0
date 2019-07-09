Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D989F63B95
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jul 2019 21:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfGITAS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 9 Jul 2019 15:00:18 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37483 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727710AbfGITAS (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 9 Jul 2019 15:00:18 -0400
Received: by mail-pf1-f194.google.com with SMTP id 19so9747277pfa.4
        for <linux-pwm@vger.kernel.org>; Tue, 09 Jul 2019 12:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kVvpaDbzpEWbBjYARfR8dh/gP0bxxZgHm+m/Jkyi7lE=;
        b=ml+EGHk2gBbO+Ix+y3IXBdYnqYmz2DJ80cGljmi3CgE65/Et2Vg5hVrN5terF5lHFL
         S8tCFSnVYVpvKoafo00DLzPqA9hwRTKA8NY6EdeYlR4aSVKABT4hmSAr0Q9X7SnlphZC
         jHDTSVqfquQ6omSj4rf4xOaEmRWxY5QFJmPZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kVvpaDbzpEWbBjYARfR8dh/gP0bxxZgHm+m/Jkyi7lE=;
        b=jNxDgsjEITyrMUCgs7k694keQdRdV2PolEFZ9squXFjbKWNdZH7/i0aeRrIO2g2gUh
         VqTpiloqdJEjm4YSexZWFnDnBVP3HStyC/YCJW5kobyOcc+MZoNAOlRaAx85+bWuu3kK
         QKcpXWsPIdIHp/iFjTH8buJKqJhZF+yHI0CEYYw+JPIOlKNFz5vW/Lkz1GMDiEQhoO+b
         WISmJCwgnf+ZlKpt8WQRCK2DaBxueU1/c74+ES/XMy3rWA8S83l8hF8zfHykCNofQAwa
         IsYWC3M0LlBquTjUQeeY1As18Qedlv5D5dyD6owEgUPsmA+jZcXVbf3q7755yVp4d3k8
         MWsQ==
X-Gm-Message-State: APjAAAV2sGnUopHdbwe753UQURzmJ/MSkdCjpZAOMnRVdyQqYu5NALgv
        KKqKb+2p+5qnUxS6OF7ZDZwXxArf/Zg=
X-Google-Smtp-Source: APXvYqwBv0ikAuzn0RvswN8IgnqKDvN7XJZoGxWHBvHVxIkxhLmxMvq0Xmq/5AXVyvtVcIKhjRshPQ==
X-Received: by 2002:a17:90a:c58e:: with SMTP id l14mr1789873pjt.104.1562698817408;
        Tue, 09 Jul 2019 12:00:17 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id o14sm2998437pjp.19.2019.07.09.12.00.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 12:00:16 -0700 (PDT)
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
Subject: [PATCH v3 3/4] backlight: pwm_bl: Set scale type for CIE 1931 curves
Date:   Tue,  9 Jul 2019 12:00:06 -0700
Message-Id: <20190709190007.91260-4-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190709190007.91260-1-mka@chromium.org>
References: <20190709190007.91260-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For backlight curves calculated with the CIE 1931 algorithm set
the brightness scale type to non-linear. This makes the scale type
available to userspace via the 'scale' sysfs attribute.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Acked-by: Daniel Thompson <daniel.thompson@linaro.org>
---
Changes in v3:
- mark scale as non-linear instead of using the CIE1931 type which
  has been removed
- updated commit message

Changes in v2:
- added Enric's 'Tested-by' tag
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..7c6dfc4a601d 100644
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
+		props.scale = BACKLIGHT_SCALE_NON_LINEAR;
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

