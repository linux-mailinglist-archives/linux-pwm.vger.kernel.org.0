Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73A23DC7D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:52:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729549AbgHFQwl (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728618AbgHFQvC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:51:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D064C0086B0;
        Thu,  6 Aug 2020 08:33:13 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so9518531pgb.4;
        Thu, 06 Aug 2020 08:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CN7uHlPIi8/iD7OlGD8kFHlcRvOdmfTdi7G7UlWQ4cQ=;
        b=bzDR8/m7lhxxuexHxN8XtssGQWJGqBJsSmWiN7jtIMtLvoVdn94DwJr9Su2QJRQGZs
         k29+mHOG9x2wsoA5CWruJlqxflFi2bQ36Fb4xCsxBDz0a4ERJHPuU3xI02EXlQ+SkaZH
         78yOyQGOyE48KySnZY/Sy1Y+focpKatwdt9yJashzTjxCyZTHB9YC1HUnzEEgYE92HoS
         FDTceYg/sfB8KHsQ17SJtCKTQPWE45ziA2Wv+u9hJyWiyfogXran7AefBZ+tUZFHswWp
         wbomNsX73S4/jwlA9GAGPqMzo5hMGGlvNrBxKIqRHvjIV9uG588ZV3PUV18kEvbugH7f
         1uCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=CN7uHlPIi8/iD7OlGD8kFHlcRvOdmfTdi7G7UlWQ4cQ=;
        b=tPGtnioMhCujeNsvzRD1tjq6+2uVbE6hwa48hqFAYZbPb+//R4vA9Co5x/TSZ7nMzm
         iCW0rAXQm6DV/dluzj8XnljQMkIK/016MWYsYw6/X9rNQ2U862iEyn1VQizWJ4hiu8OY
         P4wHuOL24PIKKh8srutLGJYjkv817+BV/ZWewg4W6iC+p5/i7h5rZJ66irNh81uZ6eso
         OZZSYDsRuX69mRhD5cr5tLZ+quyJMovmyl9W/2gb/Yh5ZDQO8PhJrgFBxBZTNXVUdB8i
         nE38A345n8E/RYp+FkYL38ShwOWkW7FPMfNyNu+RaYcsPAoZXPNtj3RCXIy55ymFpqv8
         kopw==
X-Gm-Message-State: AOAM530TZiAhp8WmeHY9GgGvMSf773eoiP3TjBmJaj6v+6Y9rIPtIn7h
        gJU2pne7QKMCk9ami0+jGSo=
X-Google-Smtp-Source: ABdhPJxhsDhjaMYsKZs6gAAdwc4LekHYCqv+Ibr7AR7BKYdy6R2x5nFLfZMsGjMySWEvo48m78m2Zg==
X-Received: by 2002:a63:f24a:: with SMTP id d10mr7739694pgk.4.1596727992856;
        Thu, 06 Aug 2020 08:33:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g12sm8159035pfb.190.2020.08.06.08.33.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:12 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 1/7] iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
Date:   Thu,  6 Aug 2020 08:33:02 -0700
Message-Id: <20200806153308.204605-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806153308.204605-1-linux@roeck-us.net>
References: <20200806153308.204605-1-linux@roeck-us.net>
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
v4: No change
v3: No change
v2: No change

 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
index a66941fdb385..e3aff95493dd 100644
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

