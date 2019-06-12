Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2B5842E3A
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfFLSAM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 14:00:12 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35936 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbfFLSAM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 14:00:12 -0400
Received: by mail-pl1-f193.google.com with SMTP id d21so6947730plr.3
        for <linux-pwm@vger.kernel.org>; Wed, 12 Jun 2019 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m17jcxzIUWgBG3pTTkNAHaWLFrUkZn/F2jLeWBAwk/I=;
        b=K9ECcdPpoHNdUO2vD2Dylfi36k+JOk+4YD8Cfgm4Bn3VTPQdmcyN78WXD7L3d/HO0s
         hBdUSzi4DPjwEJ/logkQnM3DpJ+UFfFYykyjVso6WnixS6vlIlfMi6BeZJkZPIjx/bHO
         Dd9kFBgl1ab6JdR3Fm+FtrF4Nn2Y8//52ybEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m17jcxzIUWgBG3pTTkNAHaWLFrUkZn/F2jLeWBAwk/I=;
        b=gz5zEgTSxY5mqZ1Xl0z02qF9MtYR1f64CJREnxXoXo1UHV67w2wOYy9QAsYClAgWaH
         HNbfcfdRbRoVuHkViQRiH+O4OGY5MH42tKWp6a4eMYcH/fZHTUvB5GN7C1TDJ8HXFTQ6
         zV+J4xZwC538HQPUeAYAWWGQW9YndKNStRmnFvWXmqBhG+YtMHqYJ7m3iOJioO5+mhV2
         7zCiMOCXHADGC5PTWQKG6nETa2eGL8X+92heCHxySh/QGsZnYLEj/MGpUop4hSxwrqtO
         hxmY50Z7Rtr61mCynIldFUl+HuhpjAncP9vVs2O0kC9/Wpx6pm6H9TvU2DVf8V12TebJ
         ng8Q==
X-Gm-Message-State: APjAAAWfDJkhq6bdBKpkxktxAZrwJPBgWeYiMgycpwek76NoaL+p8jja
        pNhW7Q7mq94H6dNB5ICqUy68Cw==
X-Google-Smtp-Source: APXvYqx+SYfjf3qHKIePuC+ovfW0Z/QkZdT+QlY9I+ubfQA4/smq+JtaGNSKh6quVM8FvVoa9qFIKw==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr25655685pla.232.1560362411522;
        Wed, 12 Jun 2019 11:00:11 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id m6sm180932pgr.18.2019.06.12.11.00.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 11:00:10 -0700 (PDT)
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
Subject: [PATCH] backlight: pwm_bl: Fix heuristic to determine number of brightness levels
Date:   Wed, 12 Jun 2019 11:00:03 -0700
Message-Id: <20190612180003.161966-1-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.rc2.383.gf4fbbf30c2-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With commit 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of
LED linearly to human eye") the number of set bits (aka hweight())
in the PWM period is used in the heuristic to determine the number
of brightness levels, when the brightness table isn't specified in
the DT. The number of set bits doesn't provide a reliable clue about
the length of the period, instead change the heuristic to:

 nlevels = period / fls(period)

Also limit the maximum number of brightness levels to 4096 to avoid
excessively large tables.

With this the number of levels increases monotonically with the PWM
period, until the maximum of 4096 levels is reached:

period (ns)    # levels

100    	       16
500	       62
1000	       111
5000	       416
10000	       769
50000	       3333
100000	       4096

Fixes: 88ba95bedb79 ("backlight: pwm_bl: Compute brightness of LED linearly to human eye")
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/video/backlight/pwm_bl.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index fb45f866b923..0b7152fa24f7 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -194,29 +194,17 @@ int pwm_backlight_brightness_default(struct device *dev,
 				     struct platform_pwm_backlight_data *data,
 				     unsigned int period)
 {
-	unsigned int counter = 0;
-	unsigned int i, n;
+	unsigned int i;
 	u64 retval;
 
 	/*
-	 * Count the number of bits needed to represent the period number. The
-	 * number of bits is used to calculate the number of levels used for the
-	 * brightness-levels table, the purpose of this calculation is have a
-	 * pre-computed table with enough levels to get linear brightness
-	 * perception. The period is divided by the number of bits so for a
-	 * 8-bit PWM we have 255 / 8 = 32 brightness levels or for a 16-bit PWM
-	 * we have 65535 / 16 = 4096 brightness levels.
-	 *
-	 * Note that this method is based on empirical testing on different
-	 * devices with PWM of 8 and 16 bits of resolution.
+	 * Once we have 4096 levels there's little point going much higher...
+	 * neither interactive sliders nor animation benefits from having
+	 * more values in the table.
 	 */
-	n = period;
-	while (n) {
-		counter += n % 2;
-		n >>= 1;
-	}
+	data->max_brightness =
+		min((int)DIV_ROUND_UP(period, fls(period)), 4096);
 
-	data->max_brightness = DIV_ROUND_UP(period, counter);
 	data->levels = devm_kcalloc(dev, data->max_brightness,
 				    sizeof(*data->levels), GFP_KERNEL);
 	if (!data->levels)
-- 
2.22.0.rc2.383.gf4fbbf30c2-goog

