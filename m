Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F05724E84E
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgHVPJr (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728106AbgHVPJE (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329E8C061573;
        Sat, 22 Aug 2020 08:09:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g6so179633pjl.0;
        Sat, 22 Aug 2020 08:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4x4afjEuVHn+zEV5wCvJkjFDf4xgBLyslqYhfcwaoFI=;
        b=l41ZzxasALiq3GtUf+YfngG6SFwClg2LAvtO+OAqXoDeM+gGfG7u1b/NBUwK8yUgrG
         xaWZrgfoG3HxZbUY+aFcVTAVTL7f/xpmFJiFlu5BnqaE7cBcQVw8BF1KswxXK76S3MG7
         O36kzQeRMnXOoYfcBJbeNx0L5P0SDyNFqcpSniZjxkHb2I40T9MRtL3pEYYOSk3o0OTv
         NJPNdWH7VSBwlvlB/4uLmDTNXZwuegPMl8TTm5IigkevbnQVlZ+F90q1tfjxAYkSK922
         CoIV64vzCNEZzDk4AIBpIMkcWNF+k6kb8jcT4aQpawp2KtZK+FOVid7ma646wLi17mVg
         KKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4x4afjEuVHn+zEV5wCvJkjFDf4xgBLyslqYhfcwaoFI=;
        b=lyqG+Gt3Mj24urYZDwofSv8/9OI7Q6AoQsI0dA4lxwSo38ujq6CWmvFa1B2v30mUg9
         kWqVvPyFIEZ82keUNIIcq7gQhzwtZpwfkjg9gql81+a9/B7b/Bgjesa29e5ZQaNRANEW
         kvtCyhL83aWrx1rY6ajUMocB7qYyATX64byo/Y7JQDy4QmrYhaUCrriphPdTjsS3zkB0
         KmCtUtpY/ceYsI5TfM+MCZcuKG8Bfvg1o2tQSWVcsBTzQmlvWCnvjf0bGoEBnVIyvpLU
         5BsHZsyDX5gpVbwxXVACiQJ3mGUIi3Vq2kazBkMscYdInSNpqFiVjgU36o0dLvzwps2d
         Lqmw==
X-Gm-Message-State: AOAM530peTg5DursNGLuXKHIHdMHEIS6hdU/KSxscvYlR+Cyfh5u/z4c
        K4i5lG9KdgHuTU31NbCwxUk=
X-Google-Smtp-Source: ABdhPJzWAsGWaIN7KhDuWtE9gvakScLvPA2dDboXnoFZwHCggj3iIeyZj2k6IEnIm87gMJKfS1/lqw==
X-Received: by 2002:a17:902:c244:: with SMTP id 4mr66765plg.93.1598108943728;
        Sat, 22 Aug 2020 08:09:03 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mp3sm11405445pjb.0.2020.08.22.08.09.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:03 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v5 1/7] iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
Date:   Sat, 22 Aug 2020 08:08:51 -0700
Message-Id: <20200822150857.205775-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
References: <20200822150857.205775-1-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

A follow-up patch will extend the number of errors reported by
cros_ec_cmd_xfer_status(). Specifically, the function will return
-EOPNOTSUPP if a command is not supported by the EC. Prepare for it.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5: No change
v4: No change
v3: No change
v2: No change

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index 130ab8ce0269..d71e9064c789 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
@@ -73,7 +73,7 @@ static int cros_ec_sensors_read(struct iio_dev *indio_dev,
 		st->core.param.sensor_offset.flags = 0;
 
 		ret = cros_ec_motion_send_host_cmd(&st->core, 0);
-		if (ret == -EPROTO) {
+		if (ret == -EPROTO || ret == -EOPNOTSUPP) {
 			/* Reading calibscale is not supported on older EC. */
 			*val = 1;
 			*val2 = 0;
-- 
2.17.1

