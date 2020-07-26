Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5C422E2F5
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGZWBS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgGZWBQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:16 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFE9C0619D2;
        Sun, 26 Jul 2020 15:01:16 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o1so7049251plk.1;
        Sun, 26 Jul 2020 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bjVnORhi6K4tnpvsHMJkLOHEhfuhVXgBDoQvEx+EDo0=;
        b=Bdb9ucGbVvdpZsbF7eqQyUw+F7iyLGKDr2atvdQhjJdRa+vSDcKNojEcsyxhC7JGWe
         7Q3d/4dUNj5HSMDxGouL0EP4vN7KES5w4LOMGmt8jyEOCjPNiQfAUWx1ZjWbEvOomp2O
         /glux9ODX7jgDUnM1+TSjpQkf6cOeit/oCyJtXb8HJ4+iQM65VERrBoda+Dheju21WwK
         DgADP/4kJ4TEwZww9UbyQQJgJvF1fX9l/jBxYtfLObiaZYDAlkq02yAUfLpFuosWRmFJ
         N8vHN0RK2UGzU2M3RyWHJrFO8VtHdc5co1xPa2OXSLdi6Gc/enPllnqK9Rk3n/SyQAXz
         4oow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=bjVnORhi6K4tnpvsHMJkLOHEhfuhVXgBDoQvEx+EDo0=;
        b=PdDDStOziPXhVIqp0Ckl43dLIEo3OvJIWLU3ZBerQAS47x/RpQYePpXAIpGSdmF2mJ
         bMq8+vsPma/J/elrh5LylV60g8lng2tYUgdOIMJNo9NmfJBQF9LEWu+yHwyfRU2+/Ws0
         h72g4jNFGIWKi36tZVJ7SW3xAi4IXSlvGVOxpK9fwFTJQbcu76pf0nEsrGJlGF1oh6ZA
         eOdVLrkH0h9Gjzu/+crmLhimxsualBM9zmLvDDfqlz5JlRXkzCCF1invFTUaeBiEIgEi
         y5y6pHGXg3lUNisfF3s3f6PkVcAmhZUhnF5miRwIGwMGx3uqbGxif+Mt0e3LKRAt3ory
         UCRw==
X-Gm-Message-State: AOAM530tIbvWfwoBKNTNK4pZhvjUNkFk19Rhd2g80QQKuH7Hr9PkX9+H
        wRGYzxjFedy4npnRqFFU1WU=
X-Google-Smtp-Source: ABdhPJwdn5BnDPDjUrPx0M+up64335H8qXNoJ+C7xz1PePlwnuIT4pqNYfYj9LJOk1i20KDeGZxHkA==
X-Received: by 2002:a17:90a:14a5:: with SMTP id k34mr16307487pja.37.1595800875961;
        Sun, 26 Jul 2020 15:01:15 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id lr1sm14455501pjb.27.2020.07.26.15.01.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:15 -0700 (PDT)
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
Subject: [PATCH v3 6/6] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Sun, 26 Jul 2020 15:01:01 -0700
Message-Id: <20200726220101.29059-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200726220101.29059-1-linux@roeck-us.net>
References: <20200726220101.29059-1-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The EC reports a variety of error codes. Most of those, with the exception
of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
EC error code gets lost. Introduce cros_ec_map_error() to map EC error
codes to Linux error codes, and use it in cros_ec_cmd_xfer_status() to
report more meaningful errors to the caller. With this change, callers of
cros_ec_cmd_xfer_status() can implement a more distinguished action without
having to rely on the EC error code. At the same time, debugging is improved
in situations where the Linux error code is reported to userspace and/or in
the kernel log.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
    Implement function to convert error codes
v2: No change

 drivers/platform/chrome/cros_ec_proto.c | 52 ++++++++++++++++++++-----
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index e5bbec979a2a..a081b8245682 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -15,6 +15,43 @@
 
 #define EC_COMMAND_RETRIES	50
 
+static const int cros_ec_error_map[] = {
+	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
+	[EC_RES_ERROR] = -EIO,
+	[EC_RES_INVALID_PARAM] = -EINVAL,
+	[EC_RES_ACCESS_DENIED] = -EACCES,
+	[EC_RES_INVALID_RESPONSE] = -EPROTO,
+	[EC_RES_INVALID_VERSION] = -ENOPROTOOPT,
+	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
+	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
+	[EC_RES_UNAVAILABLE] = -ENODATA,
+	[EC_RES_TIMEOUT] = -ETIMEDOUT,
+	[EC_RES_OVERFLOW] = -EOVERFLOW,
+	[EC_RES_INVALID_HEADER] = -EBADR,
+	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
+	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
+	[EC_RES_BUS_ERROR] = -EFAULT,
+	[EC_RES_BUSY] = -EBUSY,
+	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
+	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
+	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
+	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
+};
+
+static int cros_ec_map_error(uint32_t result)
+{
+	int ret = 0;
+
+	if (result != EC_RES_SUCCESS) {
+		if (result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[result])
+			ret = cros_ec_error_map[result];
+		else
+			ret = -EPROTO;
+	}
+
+	return ret;
+}
+
 static int prepare_packet(struct cros_ec_device *ec_dev,
 			  struct cros_ec_command *msg)
 {
@@ -555,8 +592,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
  *
  * Return:
  * >=0 - The number of bytes transferred
- * -ENOPROTOOPT - Operation not supported
- * -EPROTO - Protocol error
+ * <0 - Linux error code
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
@@ -566,15 +602,11 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret < 0) {
 		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-	} else if (msg->result == EC_RES_INVALID_VERSION) {
-		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
-			msg->result);
-		return -ENOPROTOOPT;
-	} else if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
+	} else {
+		ret = cros_ec_map_error(msg->result);
+		if (ret)
+			dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
 	}
-
 	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
-- 
2.17.1

