Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4322E2E7
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgGZWBQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbgGZWBP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:15 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E054EC0619D2;
        Sun, 26 Jul 2020 15:01:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id e22so1025074pjt.3;
        Sun, 26 Jul 2020 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HZU+CLnTFoPQ1JpymZdUcH3mmJgipVbUCtqjlmDAw4Y=;
        b=CdxD1K88z+pamrzdL50IXo3+fI/VewOlDiIsVj0yC9ux7QMRnYUYRnce+xaioIwu5w
         K6rLBVZwaCGYF2RXjt6SA3i4iuH/DdR1XLE9OMPVkuuyDjjt0kxbbVeoWfsE4Esvo3xe
         wv7Z4ikMuMy8v0QAIDbO4jimtiA63GpwrmB0No5zX67DucutM4Wc/s7gicfyHMvP+2F5
         BPwy3ZYi5FoYLigOLnDF+ycy5As6724VO3oEf9jHZ82lAbooHkNijSRc0QxrWrWLTVn9
         bTkQJQaWwbH94hOJ9AbvcgWFWsS1eSwMBSrFWi8duDFy+3OVwMb3lwXjsAWBXyLRCFs0
         EZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=HZU+CLnTFoPQ1JpymZdUcH3mmJgipVbUCtqjlmDAw4Y=;
        b=him9WNvmu3/87KOqiG+K5rRC8RkXNRicnK074j8ahp0Bik8BSDE0RVwZyQ2egKmqcG
         TvmaKfusnM6djxBECD1rf2SCfktvN23s1YuygM9vmIbAQhmwZIGcYO4UPN63M+6El9/6
         QCg3WGBqnV8PRW1cJkUjyLRaA9CJZbZskQd3yQwKqkO4ha/+vDsug0nFDiaBq1t2AmM4
         voWmCACQTA4YY1Pk3zwMdwbVnRn7yTDj2WTvqlph68ax7YgV3NI2W0ARL24bIo+TVR28
         7qTCXCUoc/YPp+JEHgGtXPhVunUTJFKrbnway6X7lxk1mqcUMztTcdMdPgRiso2ZRprv
         NzjQ==
X-Gm-Message-State: AOAM530cOJJyoaiLwgN67IwLhAOvtCwv8EJPf8vKRDo1ks0Xu0snr+LG
        mABLvehjRV3FztOT1rkhuJI=
X-Google-Smtp-Source: ABdhPJyiR2/jzi0/mGeVbInjQrjH9JtBbofevJuQAdZAS21fYp/R60zxL4MAY3tywdlHrPPk3A/hcQ==
X-Received: by 2002:a17:902:b685:: with SMTP id c5mr16430943pls.115.1595800874478;
        Sun, 26 Jul 2020 15:01:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s6sm12899414pfd.20.2020.07.26.15.01.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:14 -0700 (PDT)
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
Subject: [PATCH v3 5/6] platform/input: cros_ec: Replace -ENOTSUPP with -ENOPROTOOPT
Date:   Sun, 26 Jul 2020 15:01:00 -0700
Message-Id: <20200726220101.29059-6-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200726220101.29059-1-linux@roeck-us.net>
References: <20200726220101.29059-1-linux@roeck-us.net>
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
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
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

