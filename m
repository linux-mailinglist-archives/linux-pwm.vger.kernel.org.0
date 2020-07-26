Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD822E2EF
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgGZWBM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727046AbgGZWBL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955A7C0619D4;
        Sun, 26 Jul 2020 15:01:11 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gc9so8060300pjb.2;
        Sun, 26 Jul 2020 15:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=D0FjvCBud6M7Ooa+U2QMuqNklPJEapjHDwZLoN3fzsg=;
        b=SStpM4mXtSymgmbKrWmgXmcYAzQ/gVEImp2FEvTvkoYqPuk4JkwT+Q1mhtVK/RKMTb
         6P3Fj4Qx/T900X8dAeIVgtJt3BdIWNntgS9zL8Pvv/58TBe0wrd0evDTaNRhqmy3wLnP
         udmMg9CsohZni6zaWs9kBTS3+xiP5DUcw74Wop9Xl6AiWHl5EBt7RPEDGFLkW9QQ8xUH
         MQpYwY6YMZtmko8LuI+7eYEft0YkMlZ0IIvZJ3ddCWR8Chwj9k6EXW2hcP/YJ6F0kc2/
         U3ZkNJDwNUaQmcFrhsAwWjePvXmptjZr4BeJ9HNd0b1DhpafOxVjD/K6QtOx0xMWVLYc
         1yUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=D0FjvCBud6M7Ooa+U2QMuqNklPJEapjHDwZLoN3fzsg=;
        b=OYYUjTWySN5OpqLqkxs6b6qj99R7hAyp3fQycLTT8NeBPcrLPNTmxVxUamRp/OUsOy
         p2vynS8kkJPXOj10yooj0rysZlGhOGsA5qmKbMR3tdnTXBRr59bOfmUNO4K01WG23zI1
         QO6KoVAuD1oaDYxyEj/HvKlvwHRMP95DUGUVhqvSm/T7aP6uzknQoD3Y2Qd9bU3TuZzn
         su0PKzqoljozcxDsiO//b+qcmEm7gIMUVwmabAKkXyo4EdE4bCv3uPasIFTwbOGYkLNX
         VXilVC7jE+CML8TjrlY876ENFGGmz2yJuCV17rycNDHBQTRAlqF4iQU+auGZ/3QRrd/k
         9/5w==
X-Gm-Message-State: AOAM532ZA9hok3xZ6bppH7IwSK+Cr8OJjxmNnyDsBamBOtLafwq+lhFu
        dAZCaxcA3Oe2Vg+G6pRxC7Q=
X-Google-Smtp-Source: ABdhPJzq+9qhsdckOyjPbghpzvMnaavEGMu1FVqsHODnd4JiT+U5oG/8c3ApvsP3xBIXL/S7Rrf0LQ==
X-Received: by 2002:a17:90a:2dcb:: with SMTP id q11mr15838703pjm.135.1595800871199;
        Sun, 26 Jul 2020 15:01:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p1sm5861033pjp.10.2020.07.26.15.01.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:10 -0700 (PDT)
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
Subject: [PATCH v3 3/6] platform/chrome: cros_ec_sysfs: Report range of error codes from EC
Date:   Sun, 26 Jul 2020 15:00:58 -0700
Message-Id: <20200726220101.29059-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200726220101.29059-1-linux@roeck-us.net>
References: <20200726220101.29059-1-linux@roeck-us.net>
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

