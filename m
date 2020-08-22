Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD7E24E842
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgHVPJM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHVPJH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:07 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C27AC061574;
        Sat, 22 Aug 2020 08:09:07 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so2207330plt.3;
        Sat, 22 Aug 2020 08:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eEKURatWoOyX4mXbEcKrGBngoGWk63CMYHPsunNbJTc=;
        b=TZvBBg0U8y9ZfGLz46oncQ+gP9hEAr3sReiuDQUjNgwW3E3A1T7uO3Qla9jcmwuE9S
         LZyASHqniYTv/bBxuRnGdIWY+jxhjnsc3QEvPM5amkT864Luzzzs/cvte8fWh6aqs+F4
         N2k0q4GptKmL1/MrtaZ2crfXRELCkdCxZuGl6SwAcSr5UFYqYC2aoUefbeSLrmkr2Su7
         8wempBAehRGf7RZmZ7Iba9l7ZqTXs4yP/JeYrNh1HEzizVsk1athc8zOhXmisJtDK2wK
         UbJo43FT5Z/znVQxwmlkpFfYaacXND4e9L3YOIu438+eh4cZvR0+YBS9n2V0BvuB7dgX
         7lUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=eEKURatWoOyX4mXbEcKrGBngoGWk63CMYHPsunNbJTc=;
        b=SNYYNcT6E2q9Te6OAaUwsmncdhBOE/Hn3b+fdlKVUyCb4+Rx1Axtk0679GWXQ7nc1E
         Csgi0zgUAGMxw4R5pQb4ZgCkTiu+n29TpExc3zM94Y4/0lkR2hzl7sN62QZzdcSrJr9g
         xwqR2/9r4NWcR9av6hDZNf/6cVtmht3HCCMZ90We/UR21+s+wCHy7KD/Ua/eBJuk8Dob
         vfhg74kvcj9BPmQ8w1PvkI0hNj1MNbURUYWYF2J129tZgOmSNC5Ss9Tp6gkpA4Z2YfcP
         TK8Q7rsUWNqtICMTvJvwIzUDVWB3N2fvZQbpEfjxyddKTKQ9NedqHiwoeJu3SKrO6xJv
         WfIw==
X-Gm-Message-State: AOAM533AvXR7Vy1rtXsf4LquMXDfQi44mkC/eBa49pZH2uzYt0p082KH
        vsLLVSVr04cMPkQeZKxDj1k=
X-Google-Smtp-Source: ABdhPJxex72UbBHHS47bB0l+BXemPbZkW+fJSV/POh1CAnnX2zBkQOYsRykCfMy4T9EqMQhEsfo9Dg==
X-Received: by 2002:a17:902:6b45:: with SMTP id g5mr2648347plt.163.1598108946638;
        Sat, 22 Aug 2020 08:09:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x28sm5991386pfj.73.2020.08.22.08.09.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:06 -0700 (PDT)
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
Subject: [PATCH v5 3/7] platform/chrome: cros_ec_sysfs: Report range of error codes from EC
Date:   Sat, 22 Aug 2020 08:08:53 -0700
Message-Id: <20200822150857.205775-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
References: <20200822150857.205775-1-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
not supported") we can no longer assume that cros_ec_cmd_xfer_status()
reports -EPROTO for all errors returned by the EC itself. A follow-up
patch will change cros_ec_cmd_xfer_status() to report additional errors
reported by the EC as distinguished Linux error codes.

Prepare for this change by always reporting both the Linux error code
and the EC error code in sysfs attributes.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5: No change
v4: No change
v3: No change
v2: Added patch

 drivers/platform/chrome/cros_ec_sysfs.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index d45ea5d5bfa4..9c1e0998a721 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -150,12 +150,10 @@ static ssize_t version_show(struct device *dev,
 	msg->command = EC_CMD_GET_BUILD_INFO + ec->cmd_offset;
 	msg->insize = EC_HOST_PARAM_SIZE;
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Build info:    EC error %d\n", msg->result);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Build info:    XFER ERROR %d\n", ret);
+				   "Build info:    XFER / EC ERROR %d / %d\n",
+				   ret, msg->result);
 	} else {
 		msg->data[EC_HOST_PARAM_SIZE - 1] = '\0';
 		count += scnprintf(buf + count, PAGE_SIZE - count,
@@ -166,12 +164,10 @@ static ssize_t version_show(struct device *dev,
 	msg->command = EC_CMD_GET_CHIP_INFO + ec->cmd_offset;
 	msg->insize = sizeof(*r_chip);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Chip info:     EC error %d\n", msg->result);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Chip info:     XFER ERROR %d\n", ret);
+				   "Chip info:     XFER / EC ERROR %d / %d\n",
+				   ret, msg->result);
 	} else {
 		r_chip = (struct ec_response_get_chip_info *)msg->data;
 
@@ -190,12 +186,10 @@ static ssize_t version_show(struct device *dev,
 	msg->command = EC_CMD_GET_BOARD_VERSION + ec->cmd_offset;
 	msg->insize = sizeof(*r_board);
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Board version: EC error %d\n", msg->result);
-	} else if (ret < 0) {
+	if (ret < 0) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Board version: XFER ERROR %d\n", ret);
+				   "Board version: XFER / EC ERROR %d / %d\n",
+				   ret, msg->result);
 	} else {
 		r_board = (struct ec_response_board_version *)msg->data;
 
-- 
2.17.1

