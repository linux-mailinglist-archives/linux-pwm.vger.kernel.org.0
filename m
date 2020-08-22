Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6850424E848
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgHVPJh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgHVPJK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:10 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A3CC061573;
        Sat, 22 Aug 2020 08:09:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id d4so2066976pjx.5;
        Sat, 22 Aug 2020 08:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XvKl02jufHLLnMJt3E8B12KOP7zAos8o1w+WI8beqQM=;
        b=eiJGeoAiy9iTITHjCX2YB16/FP0kudN3tuamVNNOt4/6rE420/YRkMRyYI50lKAc6Z
         meJq10torKmO5TGxw7cdNAdXC97dFO+fsWTy1EQJLhzXBEt/OPQR4IYqZdoCyMuK7g9b
         qVAWPMRMZ2vRbJg9UbapsosDBOCseDQ0C3xmpf57YPDBGnU6wdPyEkmm0OJcegJ8muVg
         DrE/1xnFjxb3reyDoEp4CJmnHuWMK7ALsYtD4Tg4wJ7kXoqhZseONT36xwQ8Oj6USz+5
         mKFcax61i5ZDB7vfW7gtnGzio0g7Vx0YvK+QeRlKbJkzLF7uSDk15pDs1XIs2PenOJel
         dxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=XvKl02jufHLLnMJt3E8B12KOP7zAos8o1w+WI8beqQM=;
        b=e/2GWshzClKsYOdApdmcAUvcFP/4Hmb3ICmhfu1mzvtoe3TZ+7r9Xl1uW55edBSEtN
         iTLO5LmpL2PkPA0YpW8VgIJlYsNVva06DbWSHyO7Movpl12lNFSaFbbaeqCPkddvTSK0
         M0oEiAVVu4EPWD+k5RDdik1NGkJPPCMTUL7VF0ekAlJvUg2jfBEks2XfwqF/+OCWjZZM
         98M6xsq9uCBdv//c8kLqAGuBjH+0Z/jnk1V+gGIIXNHV6npiif8d93kN/r0lLi/KO++F
         7LBAaaIYjKb8lgb5OwiIE3kZu9VdMlzAaBNdMFr3TxNwiuKpwboxrT+iAmTtBc0+mlpP
         PAXA==
X-Gm-Message-State: AOAM533wY3QVvqXsleV1OUI/x8mzt6+Y2QH9FzVbaCHGRLpdj+HANW8G
        wReqJeZJXU0GpZtlSrX9TnA=
X-Google-Smtp-Source: ABdhPJwA7x12JBUNVJ9JFUNiAOAwVhlsfBacnRFL3Z9rpk7Vnl3O4wTD7kKuTT2PnHENA8gXWnZF7g==
X-Received: by 2002:a17:90a:19dc:: with SMTP id 28mr6324439pjj.103.1598108949630;
        Sat, 22 Aug 2020 08:09:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a10sm5906611pfk.26.2020.08.22.08.09.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:09 -0700 (PDT)
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
Subject: [PATCH v5 5/7] platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
Date:   Sat, 22 Aug 2020 08:08:55 -0700
Message-Id: <20200822150857.205775-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
References: <20200822150857.205775-1-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

-ENOTSUPP is not a SUSV4 error code and should not be used. Use
-ENOPROTOOPT instead to report EC_RES_INVALID_VERSION responses
from the EC. This matches match the NFS response for unsupported
protocol versions.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5: No change
v4: Added Dmitry's Acked-by: tag
v3: Added patch

 drivers/input/keyboard/cros_ec_keyb.c   | 2 +-
 drivers/platform/chrome/cros_ec_proto.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index fc1793ca2f17..15d17c717081 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -348,7 +348,7 @@ static int cros_ec_keyb_info(struct cros_ec_device *ec_dev,
 	params->event_type = event_type;
 
 	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
-	if (ret == -ENOTSUPP) {
+	if (ret == -ENOPROTOOPT) {
 		/* With older ECs we just return 0 for everything */
 		memset(result, 0, result_size);
 		ret = 0;
diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 8d52b3b4bd4e..f4727511fb41 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -579,7 +579,7 @@ static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
  *
  * Return:
  * >=0 - The number of bytes transferred
- * -ENOTSUPP - Operation not supported
+ * -ENOPROTOOPT - Operation not supported
  * -EPROTO - Protocol error
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
@@ -593,7 +593,7 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 	} else if (msg->result == EC_RES_INVALID_VERSION) {
 		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
 			msg->result);
-		return -ENOTSUPP;
+		return -ENOPROTOOPT;
 	} else if (msg->result != EC_RES_SUCCESS) {
 		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
 		return -EPROTO;
-- 
2.17.1

