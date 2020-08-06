Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8336B23DC5D
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgHFQvc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729491AbgHFQvB (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:51:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C18C0086B5;
        Thu,  6 Aug 2020 08:33:21 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id l60so6885280pjb.3;
        Thu, 06 Aug 2020 08:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WjNGcySxRcaRcYcgPeVnxcihqjmgxQQKoyRxNRcejbY=;
        b=HKa7pqONCRww+Pym08+/wilDVmxt8tFBK3SU1VngGvM2DtkUaCMf+tVVr+JF2AfGIV
         JEP+aewH66rxzRomgohQzNlUClubnE1zNvjviZaf7wmNTEx+sXwPdo+5b9OjN+VlT9/4
         CWVUn/AHhlr3GsdD387h7ffAKwBFeh3nlq7WepukH2iZIBWIZ8B06smfNCYXmPYIo66/
         9gtymJbAptkIhXR7KUJOUxXzUTEjZbWRZ+dAYDWsYDwH83MPOYxqZMhVnltXTlU/Xk3n
         Vt84AEX8hJkv/UptQ88VL/GJQrTasMuIN1iI35WO0QZ+0Vbp0/75FQ75vj4peOrlQ+P5
         LwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=WjNGcySxRcaRcYcgPeVnxcihqjmgxQQKoyRxNRcejbY=;
        b=gpXMK1e+i4PTjsWydhP2BugWoIyq1pd4+XNT/GX2WP3HR0gqFIytfR3eDYgdgLBQrc
         5A39GajaWMvy+Xn4gt8VvHRYEsCq/itLJs/DwuWpLfl4vjRLNqrf6iVSe44YDQelM8f5
         o9cWcHPx34h/oNieQgZiScRfctOcYKWWndQJiWcWgmXyas1zcqd8X3RpjNgS1UkF9Yaj
         AvCCVynJHHjecQtLfyTuP0UdpprvBgjugmoCqPTQkG/WQSQkj56gcjVw1/UFTj8FRTbQ
         ciOQm3vfWZBJp2oJYi7F2fsCVssi7bhQtcoMGzd+REAzTmXxTcIT90Yfj1shAVjCWhRT
         O+aw==
X-Gm-Message-State: AOAM530DB9I1hgsbDhZcJUAyZ9+QwMh0Xrtv1LSc6pL2+jqxXW7lSNxl
        SmiEE+8Mlzkd8b1VRAtq55Q=
X-Google-Smtp-Source: ABdhPJyAk+h5y35gNsqwwwFGNm8e3OHM/Chrw1Kie32e0jvdY0BXQJ9AbnDAsazimg4SL9OE7qshuw==
X-Received: by 2002:a17:902:b20e:: with SMTP id t14mr8675313plr.58.1596728000737;
        Thu, 06 Aug 2020 08:33:20 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 27sm7471068pgk.89.2020.08.06.08.33.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:20 -0700 (PDT)
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
Subject: [PATCH v4 6/7] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Thu,  6 Aug 2020 08:33:07 -0700
Message-Id: <20200806153308.204605-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806153308.204605-1-linux@roeck-us.net>
References: <20200806153308.204605-1-linux@roeck-us.net>
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
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v4: Added Brian's Reviewed-by: tag
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

