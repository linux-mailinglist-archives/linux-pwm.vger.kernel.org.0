Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D779123DCAE
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbgHFQzD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbgHFQuN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:50:13 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A0BC0086B2;
        Thu,  6 Aug 2020 08:33:16 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so9518713pgb.4;
        Thu, 06 Aug 2020 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wbIsF0VLsKUr8Tej9AFYCB19/bMe4rzU8gFPkziuHvo=;
        b=JCj3+hs4MeM4Y8N/fkjufH6uSDwWznQ1cfTMj/EsBOwwvbvsngbaF7Cza2d42jxyWo
         hrUSth33RnfjZk5AA3DtvqrwxM4YMkHj7w4rBK1MCdKE/9Z3F63YVHwE2KADtkn/84IN
         PWyPdf9bzMNFnKmqkTUnioD/OW+S6ym3ftdNufwGuCIGKE42HNyTKuOWXIBz4x2qwYUC
         fdb39rku1peh2wbvzf0SGzHdbMJA62FuikzTNxzs84r3LpqHyBl8eB66Y/dURXoAqqNN
         nSG53VvoHFMD2lR1OHkvAEFuLjRI2wxTBgcLyc7ElECjaCB6qDu8pwjHI15ZlczP7bOo
         9fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=wbIsF0VLsKUr8Tej9AFYCB19/bMe4rzU8gFPkziuHvo=;
        b=c/FwikFFlp19YLkBcYI+R8Nor9EF1+2G9v7MJTNA758tZlk6twB+m2N1zxgGAYthBH
         frCEK+rIOUBC7paACWnlTumFyY2EUT7kCiKT/vE7ae6MDIOEyMf2OIFRANS+GPWYDkg8
         xyxVNcuNFySrz7tjXKIixK8iWcLnhSUZnaEo2YNguSCM27q/YXHAAafly2CY21dDcMHE
         mHyRqvUTfwYPDPwmcPluqeOUBXDkf1WoTe0XQRWYSlnqqB27nPLCn2JA9Z1SjzD3eIRs
         rjfe3xKyXAne0uTba2cGcI95L8YOkh4G8XodZkzyKGDox0Jcbq2jv2GL/WaelkURplBx
         aSUA==
X-Gm-Message-State: AOAM533htQkOX+q0BSn0FaeR5R0WD2W1UCZrerMSPUfSNkZRkd4o8Zbm
        Y3BQCkAqln9xTl0/xTDt5jW6rg3j
X-Google-Smtp-Source: ABdhPJyn794NZYAgFqY9nmQ+9/1tVgHMyAZ8QEEnwMHUeShu2+Cw2pfEsM2aMhvDieYUsedWmN0r7Q==
X-Received: by 2002:a63:5049:: with SMTP id q9mr8046158pgl.219.1596727996482;
        Thu, 06 Aug 2020 08:33:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y79sm2975001pfb.65.2020.08.06.08.33.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:15 -0700 (PDT)
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
Subject: [PATCH v4 3/7] platform/chrome: cros_ec_sysfs: Report range of error codes from EC
Date:   Thu,  6 Aug 2020 08:33:04 -0700
Message-Id: <20200806153308.204605-4-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806153308.204605-1-linux@roeck-us.net>
References: <20200806153308.204605-1-linux@roeck-us.net>
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

