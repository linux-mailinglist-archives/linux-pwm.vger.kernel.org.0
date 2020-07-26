Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6571522E2E3
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgGZWBN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgGZWBN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26BAC0619D2;
        Sun, 26 Jul 2020 15:01:12 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k4so7027543pld.12;
        Sun, 26 Jul 2020 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fq2PKsLTcpOe4sID4zNGxgfJWIybUhtDLXdwOBpz8MI=;
        b=KCbhTxa0FP0uoz946Um/nhEv9lDvSDgSwS84y4kveImF6rQzkJC4baIWw+j7tLanvS
         8PcmeE8VdAk8I/edOhhsqvK920ZGd3G+KdMsmiYQtbsT8Qqf6cTfd/SvlD172re7u/ay
         +CJErk8UUuN0uOV3n2H9kRhibsz/Y9lFSThUa3H1zPnaq2cI4HFQYcae+GtUd0l07ndu
         Z5zoKR/OSu4zP9qylxNWLz6w+nlh+HYoIQNKbmxnfzb2FD3/Ra2KOda9j0DB62OrXGWl
         iB8KnTF13WySJRX69d1GmneeRSnKufYfwtEfRXZhOE/zje6ntijq1hU+rbuvFIIpXDpy
         Y/AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=fq2PKsLTcpOe4sID4zNGxgfJWIybUhtDLXdwOBpz8MI=;
        b=Z2uCdRx1GxKU8KdpZ2K//GmnlMt+P2MzJYy0O3J78MHrRmdMIlrwsjIw3tPl7APS9x
         Avx2mvnuqawZ9urM5jv7yiyJNj8uJlLXBxPYQKjPpKfmyhD/GpFqdnoHNvGPooyi0kFf
         z1QgjlEffK24Datcl8GDK9pzaKut63ksLlqKY5AkO93zLvHejAC0DMOkzhXif37SYY+t
         ZPYZCYEq1/iqPdxO9N/UMBc5bYtGDtxNxA/Fu0CFvmB4hKVDuUC/0jQX8NLEJ6IFWNOq
         0pu7XmMLZrTmrQX5hP0Bi4pIOpgBp/mqUDtMXFVCzDcxEIsCBRuYU/RLsZrQuC+218WH
         PfSA==
X-Gm-Message-State: AOAM5314184ai/jA4cNav0He25DkZ3Qiea6OnXZCeLTaI7OFx7Nv5Mkq
        6MmKsQ3SgflteKchdSNdUg8=
X-Google-Smtp-Source: ABdhPJySA2tMKV9BbeEJjEE7opkHoQrKZYnjllohwrI/7cFAzo5WXjRFjqrfrArAFdM2VXdPxqE22w==
X-Received: by 2002:a17:902:d881:: with SMTP id b1mr16158086plz.74.1595800872535;
        Sun, 26 Jul 2020 15:01:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t1sm12529725pje.55.2020.07.26.15.01.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:12 -0700 (PDT)
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
Subject: [PATCH v3 4/6] pwm: cros-ec: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Sun, 26 Jul 2020 15:00:59 -0700
Message-Id: <20200726220101.29059-5-linux@roeck-us.net>
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

Handle this change by no longer assuming that only -EPROTO is used
to report all errors returned by the EC itself. Instead, support both
the old and the new error codes.

Cc: Gwendal Grignou <gwendal@chromium.org>
Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc: Prashant Malani <pmalani@chromium.org>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v3: Added patch

 drivers/pwm/pwm-cros-ec.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 09c08dee099e..ef05fba1bd37 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -213,20 +213,27 @@ static int cros_ec_num_pwms(struct cros_ec_device *ec)
 		u32 result = 0;
 
 		ret = __cros_ec_pwm_get_duty(ec, i, &result);
-		/* We want to parse EC protocol errors */
-		if (ret < 0 && !(ret == -EPROTO && result))
-			return ret;
-
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
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

