Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3145D23DC6F
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgHFQwB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729516AbgHFQvD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:51:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73218C0086B3;
        Thu,  6 Aug 2020 08:33:18 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r11so17255581pfl.11;
        Thu, 06 Aug 2020 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OB49z5mjW0LWW4JF1oLw/U9qGTQogmAmaaexYlsEeUw=;
        b=m7aHHurSz7uvNcMNReeucg84mWKcscHNcmgJuLIIEgFG4hxSY6p8emZ8iiBLZU/SjU
         hnpDSG6rOqZL5ObYwMcDzUPqcKMrVziaFBtLZEyIGIPaKBYhG/nCZFPxWmaHFLTey134
         B+Y45WUbfnQa99OlAw+RhZgOe7H+WYQwrwwu4UyqG8OZN+UMxfOagz/oO4Ip9YekWoH0
         zuew55ms00TRlcuHveJKjLHunhcFXF/IhdiG7UuGivLBYZy8ShKzchCJUTkZ1C0DW8uG
         KHFjJYWhwx15gMR1fMcEwMoLLLPtsztdq/zWKAor2CJGnH8q7XibLdKD7IyKA7XZD6T/
         B4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=OB49z5mjW0LWW4JF1oLw/U9qGTQogmAmaaexYlsEeUw=;
        b=dJ6HTEaIrc13Nx6W3KAj73IzHkIf8Gx4zrD7YHdWZCKvLFAvWVsP5I9KOTUt1EOXpA
         Hg6bbicmgIZ9xOJFhQULl/Tky5IjkA9ZDKJW9uaay9UPdr/fgo8KonK1dyFMAJY9NX9+
         Q5U23auz/RE1enMF/KQDG60FKcjVvPg9fGoanqaim9ALhG1UG5/koNtGnNjR25DbSC85
         6SOF/zhA+t50Ryi4ND+i3CAx77+l4vPUA5u9+ntnfN3K0icJqwC0q53mhf0d0LIzHJlv
         PBSJSKlgD3eaiYrTC5FMs2YxFV6OBgXEpH7pJfOAGSApOC+lUaHhLw6pKzjsQTyk/bQo
         KN/Q==
X-Gm-Message-State: AOAM5322hHHkmylZQawG3M74Geau7u2AhPdce9D+e3Dhr7VidwxGdWTx
        5oY06ZiV9l+W22yazmnZ/2I=
X-Google-Smtp-Source: ABdhPJxiJvfAbC9f+jE+gjdTyrvBQXJFfHAlNRMm9oer2udDGpn+6J5NittGKv7K821x1r9QYXU9bA==
X-Received: by 2002:a63:1a49:: with SMTP id a9mr7834508pgm.110.1596727998029;
        Thu, 06 Aug 2020 08:33:18 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 207sm8479732pfz.203.2020.08.06.08.33.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:17 -0700 (PDT)
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
Subject: [PATCH v4 4/7] pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Thu,  6 Aug 2020 08:33:05 -0700
Message-Id: <20200806153308.204605-5-linux@roeck-us.net>
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

Handle this change by no longer assuming that only -EPROTO is used
to report all errors returned by the EC itself. Instead, support both
the old and the new error codes.

Add a comment describing cros_ec_num_pwms() to explain its functionality.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Acked-by: Thierry Reding <thierry.reding@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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

