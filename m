Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D689524E849
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbgHVPJg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgHVPJL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:11 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA9AC061574;
        Sat, 22 Aug 2020 08:09:11 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l191so290649pgd.5;
        Sat, 22 Aug 2020 08:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JmEZo7JliKyaNvQUkZX7O3ywNsax+k7CM+J9IWyH0O8=;
        b=pNazA2RbIBC03uC2Y6gQ59/A9sMvImbQ+i7nzehssb+bSv8g1yzgwsnKqgegu0EpKy
         uRx9jP9Im6HbFHT9xg39Cm3f+jrEAiKfJfG9NvEumevHgMBEEAVzAX8BAqMS3e1jdrck
         l7fLOfAgMsaKP419yH/p4pS6VrAxezGA/cBQojoWK7U8p0iSXpqrmlufnJUGhUApsGZK
         2efOfqXpsC052dNWCQYEP7g/dN26Fj/lWchRzpNGXBE7ac6vZNGhdousFxA8ngkH1t9T
         X+E7CszNV1vACKt+oZ/Aie61HRcTWSL8/8QR5WabEDSQbYnUDk8gFFjQQP7imSJ938sM
         YZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=JmEZo7JliKyaNvQUkZX7O3ywNsax+k7CM+J9IWyH0O8=;
        b=rEwJeUBdYmwB3WTnhKZmR0ewHO2L3zVLqmskm/8eDe6byh0+cXhQDU5ze+rBzwJtA0
         aWw6XpmKbZNYQddTd2+8kYw7oWPlcfHZm5XUn6YULTUnhnIVWCCCO/XGgQdKi93f1VTQ
         y5QGpE/D5m8v/G5Q8F2ut4JDHv2gDuhQfMihKKsUnSQQWWGnr27xqxQ3KZ111uoykAC6
         X/lApsSK0nZYtJnjBlvgX9k+YzieKR4L1WHc5PFYx2VamchicT64MTfnR3BngRwq5gjQ
         JUsJ8u0hAEgmUpURTiJIYkqir0nKKSihDO2sBuecPuWkclF7GJoyNUmkfgliCp6RpOtL
         qGag==
X-Gm-Message-State: AOAM533zdwHPnFJAa8jmH+8KSBZp9fgE16gdfnmUc7GWEohwnrS8WkEg
        Ol42P4zShGVFlCIREh4U5UM=
X-Google-Smtp-Source: ABdhPJxviXqFk8MFEQIDULTUbYU3PYJkaeWMMWejQqlChvuxU6ox4NfWGQQ5QkQSMnzmM7CHuBxoRA==
X-Received: by 2002:aa7:9d0e:: with SMTP id k14mr6412670pfp.162.1598108951029;
        Sat, 22 Aug 2020 08:09:11 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u8sm4504985pjy.35.2020.08.22.08.09.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:10 -0700 (PDT)
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
Subject: [PATCH v5 6/7] platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
Date:   Sat, 22 Aug 2020 08:08:56 -0700
Message-Id: <20200822150857.205775-7-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
References: <20200822150857.205775-1-linux@roeck-us.net>
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
v5: If there is no error, cros_ec_cmd_xfer_status() needs to return the
    number of received bytes, not 0. While fixing that, rearranged the
    function to reduce its indentation.
    Dropped Reviewed-by:/Acked-by: tags to reflect change
v4: Added Brian's Reviewed-by: tag
v3: Use -ENOPROTOOPT for EC_RES_INVALID_VERSION
    Implement function to convert error codes
v2: No change

 drivers/platform/chrome/cros_ec_proto.c | 57 ++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index f4727511fb41..dda182132a6a 100644
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
@@ -579,26 +616,24 @@ static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
  *
  * Return:
  * >=0 - The number of bytes transferred
- * -ENOPROTOOPT - Operation not supported
- * -EPROTO - Protocol error
+ * <0 - Linux error code
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg)
 {
-	int ret;
+	int ret, mapped;
 
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
+		return ret;
+	}
+	mapped = cros_ec_map_error(msg->result);
+	if (mapped) {
+		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n",
+			msg->result, mapped);
+		ret = mapped;
 	}
-
 	return ret;
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
-- 
2.17.1

