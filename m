Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDA924E835
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgHVPJK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgHVPJJ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:09 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D0AC061575;
        Sat, 22 Aug 2020 08:09:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kr4so2091713pjb.2;
        Sat, 22 Aug 2020 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWfg/p1bEEsF9VR7qbKwXbT4prM1ax9SkBLPqSVouws=;
        b=TreoCnNRUV59m5H5mc54POb5e9AKUfujBJtw6CIU7DJ7TlGxX+yWWCP90io+UvOhtI
         6lN6VARFlIqBKPqYLlaGNDPnM9Q3+Fsd5EiE77WcG1FjMNbhUiTgw+eHU9Odthuh81lh
         BY+V/CK+INs+HgCEm8drPMVSUzhSMeEGuR33FpIiedWXcilR1XxjcbF3SHrkRzPyH56f
         baurpXfeJMVOEuh5wP4ETfaQXhStCqc6nMOycfWwUbB7ksdW8nnvtGzXBBKHgb2FTwet
         3BqxDuzR3/1LGrjg1flO1cB++9SUh1+CP3TNx9S7/0sxZxUkPvbe+FsBqSSJfHyMphfn
         oGiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=aWfg/p1bEEsF9VR7qbKwXbT4prM1ax9SkBLPqSVouws=;
        b=b9XiuoU01BLGuQCJyVU7COCO63YBASXCjsW+yLXpfiaadDIZAWLvIyOGXVF6Ua9Zi0
         O0dl4j89f+7vKnWr7MXBPd5CBlChMVmynVrsXglu3q2Xypy3fJFwdmKiFhpo6xqit3P5
         jOh6VmR12aEE++2BBzw5TlqWTwVC+PSemthapbl1LtwbHi/9cJjI7dL0EEZaODcBHMmh
         5exK9XgJRa98DQRmoCL93dPa1hSrX0TxfhcOUxBVk9wTkYFSYR4DiC2KBgLNEU3jIebX
         MACGmRk6SBiVnmXi3cyi/2mRC6bXy1Q43zApustOTwepFICziL6DWL/2rTJX/BSg/WuT
         CqxQ==
X-Gm-Message-State: AOAM530a2WubOv2eTbJYYvgmlyKjMt6OBlgTKiKlXrytfMOMr8nsERbb
        x9FPIS/3CN9WdEadDKYWY/U=
X-Google-Smtp-Source: ABdhPJys2OLCfUIKzWTMevNyztH0683b7F8X4R7+XyRTVJJiiPVel4kLEjsxFqZHvK3QajGoT+87wA==
X-Received: by 2002:a17:90b:154:: with SMTP id em20mr6778169pjb.173.1598108948143;
        Sat, 22 Aug 2020 08:09:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n18sm5066040pgd.91.2020.08.22.08.09.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:07 -0700 (PDT)
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
Subject: [PATCH v5 4/7] pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Sat, 22 Aug 2020 08:08:54 -0700
Message-Id: <20200822150857.205775-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
References: <20200822150857.205775-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since commit c5cd2b47b203 ("platform/chrome: cros_ec_proto: Report command
not supported") we can no longer assume that cros_ec_cmd_xfer_status()
reports -EPROTO for all errors returned by the EC itself. A follow-up
patch will change cros_ec_cmd_xfer_status() to report additional errors
reported by the EC as distinguished Linux error codes.

Handle this change by no longer assuming that only -EPROTO is used
to report all errors returned by the EC itself. Instead, support both
the old and the new error codes.

Add a comment describing cros_ec_num_pwms() to explain its functionality.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5: Added Uwe's Acked-by: tag
v4: Added comments describing cros_ec_num_pwms() in more detail
    Added Thierry's Acked-by: tag
v3: Added patch

 drivers/pwm/pwm-cros-ec.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 09c08dee099e..94d3dff9b0e5 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -204,6 +204,11 @@ static const struct pwm_ops cros_ec_pwm_ops = {
 	.owner		= THIS_MODULE,
 };
 
+/*
+ * Determine the number of supported PWMs. The EC does not return the number
+ * of PWMs it supports directly, so we have to read the pwm duty cycle for
+ * subsequent channels until we get an error.
+ */
 static int cros_ec_num_pwms(struct cros_ec_device *ec)
 {
 	int i, ret;
@@ -213,20 +218,30 @@ static int cros_ec_num_pwms(struct cros_ec_device *ec)
 		u32 result = 0;
 
 		ret = __cros_ec_pwm_get_duty(ec, i, &result);
-		/* We want to parse EC protocol errors */
-		if (ret < 0 && !(ret == -EPROTO && result))
-			return ret;
-
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
+		 * The EC error codes either map to -EOPNOTSUPP / -EINVAL,
+		 * or -EPROTO is returned and the EC error is in the result
+		 * field. Check for both.
 		 */
-		if (result == EC_RES_INVALID_COMMAND)
+		switch (ret) {
+		case -EOPNOTSUPP:	/* invalid command */
 			return -ENODEV;
-		else if (result == EC_RES_INVALID_PARAM)
+		case -EINVAL:		/* invalid parameter */
 			return i;
-		else if (result)
+		case -EPROTO:
+			/* Old or new error return code: Handle both */
+			if (result == EC_RES_INVALID_COMMAND)
+				return -ENODEV;
+			else if (result == EC_RES_INVALID_PARAM)
+				return i;
 			return -EPROTO;
+		default:
+			if (ret < 0)
+				return ret;
+			break;
+		}
 	}
 
 	return U8_MAX;
-- 
2.17.1

