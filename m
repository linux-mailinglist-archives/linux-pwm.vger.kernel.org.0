Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EECDC8F12
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 18:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbfJBQ4J (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 2 Oct 2019 12:56:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45626 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbfJBQ4J (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 2 Oct 2019 12:56:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so12140144pgi.12
        for <linux-pwm@vger.kernel.org>; Wed, 02 Oct 2019 09:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0V6I7vxpenGYwQo+a0w9xjv8KE9amu4CMjrShydQWuc=;
        b=BNCWbn4YoFqFl6WmXRRnHBUsgZ15/0sG7ZoaJNoV2ERMyL0F2sh9H6Yz4aKEHvZdvj
         FJID9ANMx4kNqAyZ9Z+YtoAd6pfJacgQhQywuPzDjBbBLhTtZwVTI3CUZKUGgL2PHSrq
         QB9oc/76C2javT9MA1DwV78kZ9l7USnccItEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0V6I7vxpenGYwQo+a0w9xjv8KE9amu4CMjrShydQWuc=;
        b=FO3R58LFPAekTsYawPhF+b5iww0nD+/Ys221TSGKlZEkOH+3FanhBjLwoIjVcr+kKT
         JZSHKkrRgX9I///U1gnX/yrAi2YukV3nkGBfqbZmrlrXIImsZhBME2OYqMnxLrhxDZt3
         pWS3A3DsSm6oOwh/UusiEENgUGya9S7CtChLxOWg8CjtwzstTxZlj1LvaPPAI0KpQKWZ
         1rjCq2x5/DXCF3H+C5LnG8cN9de31BswYVKzYxf6KaKTjKDZKypwYZLX+M8B/D6tnoP6
         ll30uGED41ihJXA0L+xT1PjGg7G7H3MIQNf464Isvwyqy/5lhox6VaCUF/XJnIub74ai
         J30Q==
X-Gm-Message-State: APjAAAValmxf2/Wg/P5uwVy7yicLI/IUY9fR+IbmaQRQDhNOqQO9uJDF
        0LGyLa/LnGct0AoJ7NiWXQPFWQ==
X-Google-Smtp-Source: APXvYqw7iJb+eM19mWGTE2rmb9T/7FR39PHihYj+YtlS7q6rqzp4liG+5Pq1fL6s78/n2zPG//C9Cw==
X-Received: by 2002:a17:90a:cf93:: with SMTP id i19mr5509952pju.72.1570035368715;
        Wed, 02 Oct 2019 09:56:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id b123sm27546480pgc.72.2019.10.02.09.56.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 09:56:07 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] backlight: pwm_bl: Don't assign levels table repeatedly
Date:   Wed,  2 Oct 2019 09:56:01 -0700
Message-Id: <20191002095541.v2.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

pwm_backlight_probe() re-assigns pb->levels for every brightness
level. This is not needed and was likely not intended, since
neither side of the assignment changes during the loop. Assign
the field only once.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

Changes in v2:
- removed curly braces from for loop

 drivers/video/backlight/pwm_bl.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..05d3b3802658 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -564,18 +564,17 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
+		pb->levels = data->levels;
+
 		/*
 		 * For the DT case, only when brightness levels is defined
 		 * data->levels is filled. For the non-DT case, data->levels
 		 * can come from platform data, however is not usual.
 		 */
-		for (i = 0; i <= data->max_brightness; i++) {
+		for (i = 0; i <= data->max_brightness; i++)
 			if (data->levels[i] > pb->scale)
 				pb->scale = data->levels[i];
 
-			pb->levels = data->levels;
-		}
-
 		if (pwm_backlight_is_linear(data))
 			props.scale = BACKLIGHT_SCALE_LINEAR;
 		else
-- 
2.23.0.444.g18eeb5a265-goog

