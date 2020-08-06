Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E9023DC8F
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbgHFQxf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbgHFQuu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:50:50 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0798C0086B4;
        Thu,  6 Aug 2020 08:33:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ep8so6718503pjb.3;
        Thu, 06 Aug 2020 08:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/kfb4ZQpb2tkNgbxiJxI6ygfh+mopJAzbP4u/Uarhhw=;
        b=YshsLTtAmxizgZjkdFUqcXMOgLksKPr9ptr5N8zEoe0jgGZewp9KsGgm+ukdBGCoLg
         0T56CdbUqFe38etBcj2QythGBWe4+KbqrljBmaYzmkHiIwIeL0fMJuFpAF6qQcEeQX50
         EOB9vsW0qw0BW813CNSfRLARlnpNjLuDADmDyxrNPmrHpfaQ6dnbmgyK5Y1YaXkxCdSd
         pyYmCmPKM07sH9nse+YFsbd141ayFJWDJ2ke/MHAtA7BbJdeYMgHbUFFpuEp2nuyMhV5
         FkY+bCNA74CfPVEKMlL6Yj9t6TNRWMqT5p2LnAn+Vpu72PU98IiciSg8yQkCSK8tDmJc
         Mlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=/kfb4ZQpb2tkNgbxiJxI6ygfh+mopJAzbP4u/Uarhhw=;
        b=lZhz5iUbBURHB9boMmcO8ifwUEs4QPIvKb6i9dEx8Frgt5ek+PzwgjQQUEIrE6WQpv
         fcPSnEfdzupFe5HxJsP6gACoRbT4jlnqRbt+DBpFw8bD7T42fmoki0qLYBGYjSVaLIWN
         Meh1DydzvMTv08DTF9IwXstmJfGDBhswBpP3k2h9HWM0ga+0RkwIPdA7GrDJ+dpg7k/P
         60xZfonUcRNqhf5pGeR/Jn/CBIhf4VHQWZhkwxSKYwplTDKaRk3ZQEG45jgH3kYUSP1X
         REEtHxcwVWQUABzp+q+XcBBcAvg6d0EMc44JfkFzpZVxDON+0fEOGeyaTQ/SoiakKHyQ
         qz0Q==
X-Gm-Message-State: AOAM5304AJOr1IqkWz2oMk00wsLvad6IFHC0fb2BMIIs2vS4RVxu2xW8
        R9u0BlKVrPbKPxLVSGKaaSHRFoHw
X-Google-Smtp-Source: ABdhPJzE6Y/hT3rFpQmb3xQBSxIt1oWKnq5rtGjja+UoNAxThUy/FjQJNiUv85Be9mNTTN6XlsJvkw==
X-Received: by 2002:a17:902:ea8c:: with SMTP id x12mr8555473plb.60.1596727999379;
        Thu, 06 Aug 2020 08:33:19 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f6sm9261141pfa.23.2020.08.06.08.33.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:19 -0700 (PDT)
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
Subject: [PATCH v4 5/7] platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
Date:   Thu,  6 Aug 2020 08:33:06 -0700
Message-Id: <20200806153308.204605-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806153308.204605-1-linux@roeck-us.net>
References: <20200806153308.204605-1-linux@roeck-us.net>
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
index 3e745e0fe092..e5bbec979a2a 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -555,7 +555,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
  *
  * Return:
  * >=0 - The number of bytes transferred
- * -ENOTSUPP - Operation not supported
+ * -ENOPROTOOPT - Operation not supported
  * -EPROTO - Protocol error
  */
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
@@ -569,7 +569,7 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
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

