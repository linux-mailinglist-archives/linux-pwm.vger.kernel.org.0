Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3FB551C5C
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Jun 2019 22:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731825AbfFXUb3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 24 Jun 2019 16:31:29 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39770 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731828AbfFXUb0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 24 Jun 2019 16:31:26 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so7552255pls.6
        for <linux-pwm@vger.kernel.org>; Mon, 24 Jun 2019 13:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZKHvCx8L/nRTrUb/ohywx0d3IXX3vcHyiOoGdIF2Vg=;
        b=G/bUhQslRBb9yDeN/Ju1v2H78Jn3pcV6lvi6ZsyGVCuBbzJ+oIhAcvU04QfS10U/4R
         pdE3J6hWbwxyP4QcHwwtH00UNcd1LgYEz2XOvY5wmOr4tiTSrA/9uD0OATvj9bqrmoPn
         id+vaY8rgFoQ9n7vUdhFL4XPoNNii/WHKNs9A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZKHvCx8L/nRTrUb/ohywx0d3IXX3vcHyiOoGdIF2Vg=;
        b=s9iaDsTsK03M2czX1G1kl/Nd6bfILCzaIn0rxzNJA4NZn0sautjOPxlz4K5LcagIzh
         5xQ3/3d/JuuxwVljWXqn/R6WtWlNOMwcNbV/8R7Tv31sxPHPb5BDKkUVP6s4lxZOdxwA
         3cZfRzL0e4fY2JACxuQBJ4At6bdvUBi7t9tZhmW7CRviOy0K2FuZmd2LUd3Yic1x90bu
         d1aKEt9hoxwBBfqeYhQWC3VSfKOqzaBinwPJaoVOJdxgo1G66AAl+HY4WPCxuOZVE+6o
         jAk0w49PvyU/QYHnCYv0CfhR3Hy/8L3g3rDHZluUIlBip1ThUm9w+KPDrBmhnG+3I3wC
         Bz4w==
X-Gm-Message-State: APjAAAUOyHKPAB/a+isulX7/f8H2ddkTc2T/rTKMon+aiL8xg5+cLOR3
        b9Xc6CLIBEy/Fe16b6jVfsknkg==
X-Google-Smtp-Source: APXvYqzY0+srP89wCVDbPca+cx8EHxAJHQuHwUe5lX3IaE2YnttbyJ+9Ii8mxU7OnlFea1FBJZ1y0Q==
X-Received: by 2002:a17:902:2006:: with SMTP id n6mr94261265pla.232.1561408286127;
        Mon, 24 Jun 2019 13:31:26 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id r2sm21887470pfl.67.2019.06.24.13.31.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 13:31:25 -0700 (PDT)
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
Subject: [PATCH v2 4/4] backlight: pwm_bl: Set scale type for brightness curves specified in the DT
Date:   Mon, 24 Jun 2019 13:31:13 -0700
Message-Id: <20190624203114.93277-5-mka@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190624203114.93277-1-mka@chromium.org>
References: <20190624203114.93277-1-mka@chromium.org>
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
Changes in v2:
- use 128 (power of two) instead of 100 as factor for the slope
- add comment about max quantization error
- added Daniel's 'Acked-by' tag
---
 drivers/video/backlight/pwm_bl.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index f067fe7aa35d..2297fb4af49d 100644
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

