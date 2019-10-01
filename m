Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5A7C4446
	for <lists+linux-pwm@lfdr.de>; Wed,  2 Oct 2019 01:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfJAX3a (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 1 Oct 2019 19:29:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42171 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbfJAX33 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 1 Oct 2019 19:29:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id z12so10788544pgp.9
        for <linux-pwm@vger.kernel.org>; Tue, 01 Oct 2019 16:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcVg9u8V8Uf/idldytEF3NgOMyW0OU8oijTXHZJkyVg=;
        b=LoLWuA/zt6wQo9niY6rS50WlST0jKh8TXiLphIX/HwUpy05ohub5qr5fmX/ajPIl38
         XXY9DeDYzLb3r6VQgb82GF+lkIrTF0YatAYRiWTOyE0EbZ19L9ZzOE4ZksI8EWzk99qF
         HppXuMICfou5mYFPWkwYg/UF2L+14P67qumf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EcVg9u8V8Uf/idldytEF3NgOMyW0OU8oijTXHZJkyVg=;
        b=frhaQakOt2pp76tKEUzlwirDV3iI4DD852WBBxfI0WyTbDg1r8tBWm5NZEVyQHLxsd
         nMaT70mO1VIg1cltm7yhWtP7usgXBQqUEbhxSGOWXTJ2KuBy9YLRgnhgZqftavv12cLK
         mWtYKsLYQHoERK3lvxBJdEDnNpAawChl1ecazeAkSaV5hBaggiFSxnW1lCVaOkwI2CUb
         aAJelV7RgWF72PZu3kB3qZoBMzGN8jjkSmHq7WZTQmRnLFqKW/Bi1YFTgK4XKfsiSXcv
         K9Vy8H5e4CIJWRDm6BnMZ9WkIvbyzjNxftwRHcEB1eyOLx47dJfoRjW3EZaX3/cc0H3d
         qoGQ==
X-Gm-Message-State: APjAAAVb4+FR5+QoflzcTYIuvxhhCpdsc+KytjZ/k+beR3zDO9mdqJiV
        jyOXGlGebfRSZyTF8XVE0SjyOQ==
X-Google-Smtp-Source: APXvYqyttY662qaZ9at4NRsqD7ukXbj1wr2h7SXDVAWfKw7gZzdYntUGCR2evMFpv1BqiZxzO5THcw==
X-Received: by 2002:a62:fc46:: with SMTP id e67mr1005912pfh.153.1569972568837;
        Tue, 01 Oct 2019 16:29:28 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id c8sm20990266pga.42.2019.10.01.16.29.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Oct 2019 16:29:28 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: pwm_bl: Don't assign levels table repeatedly
Date:   Tue,  1 Oct 2019 16:29:24 -0700
Message-Id: <20191001162835.1.I4f2ede1f55ddd1c72b0303b7fd7f73a782fa33e5@changeid>
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

 drivers/video/backlight/pwm_bl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 746eebc411df..959436b9e92b 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -564,6 +564,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	memset(&props, 0, sizeof(struct backlight_properties));
 
 	if (data->levels) {
+		pb->levels = data->levels;
+
 		/*
 		 * For the DT case, only when brightness levels is defined
 		 * data->levels is filled. For the non-DT case, data->levels
@@ -572,8 +574,6 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		for (i = 0; i <= data->max_brightness; i++) {
 			if (data->levels[i] > pb->scale)
 				pb->scale = data->levels[i];
-
-			pb->levels = data->levels;
 		}
 
 		if (pwm_backlight_is_linear(data))
-- 
2.23.0.444.g18eeb5a265-goog

