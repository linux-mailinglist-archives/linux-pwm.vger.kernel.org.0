Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6CDC22E2F6
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgGZWBc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbgGZWBI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:08 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5361C0619D4;
        Sun, 26 Jul 2020 15:01:08 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so8283218pgc.5;
        Sun, 26 Jul 2020 15:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DnGWS5rFmjTRKwqhGKvHvn84YUtGHQ4e+LEEZ0MXHp0=;
        b=MJuSRaFDICq+1vdOCmEa3waOwusof7BIU/WUlGVa+BGlsHZ4fnuvFqqHxhViDsvEwn
         baDk12G6ZLWUNhmvkCcnEiXHFVuW0ul08Vp6SEYM5TjPijbovTVwfPyr3tpkPZa+4hC6
         B0ngHyUaUVHDwRBeveIGBIGjx586X7GXW3nLLA9ImvCrKcnCEhfODDlMDi89T+Vg4A4e
         3OzrnI+PQjJLuTwrs7kVokV4nPSC8SEDCK7b9Dcg2kqm+fsZ5cDj5hlhNuKSuUHKIT3g
         nheNTM1UNygvVVXZLBAJ0ytOnczXg5kH246iF6aUqMY82k6N5jOlAzFfhswdpXLlD+OG
         1a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=DnGWS5rFmjTRKwqhGKvHvn84YUtGHQ4e+LEEZ0MXHp0=;
        b=rl78i1MqOynEZb57m29mFhD1PrWqcwvkZ2y+w7Vw3reu9gKiuwvek9YNDrcvUL94Ja
         L58ed8g2i9Ef69GVjTh32pbM7SHU5lhpj0R7EXZzXdwStGsDsariUaIiEt6RE6L/cnw4
         uFRX4T6ZtxNknoYdis3w2lXoimzCYvJyE8ojEL4VOh8jRNV80Q3xSgp09lJhmxYiAKKg
         qQ2hHRAhbrXX68SRb6jCXl/8wlkLH3unBvyG2AaHmIYiVU5eS7pKEHMpIZll67rxTMiY
         +0HzpvEEmeKu/tDnYGZU4xMC3zSVoWyHGvvYrlP9CRXjyGswkQPiUe54dy+fY/4CMDIY
         IN8A==
X-Gm-Message-State: AOAM531DhfNMZXDVUfbn3OMLz3shkkTcQ9d4S3H0KND8M7BlzeeEMLYy
        HkVy5tFrPOv3mzwS3we9B6c=
X-Google-Smtp-Source: ABdhPJwdG4Inrjl9yNc9V2gfZe1G97e3QVW3lPVbX1jKkLnLNraU7YbmsCqW2MbaGwhQYCeYRDhQHA==
X-Received: by 2002:a62:ee03:: with SMTP id e3mr5935966pfi.10.1595800868365;
        Sun, 26 Jul 2020 15:01:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w70sm5362478pfc.98.2020.07.26.15.01.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:07 -0700 (PDT)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-pwm@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>
Subject: [PATCH v3 1/6] iio: cros_ec: Accept -EOPNOTSUPP as 'not supported' error code
Date:   Sun, 26 Jul 2020 15:00:56 -0700
Message-Id: <20200726220101.29059-2-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200726220101.29059-1-linux@roeck-us.net>
References: <20200726220101.29059-1-linux@roeck-us.net>
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

