Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB1E23DCB5
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgHFQzF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729556AbgHFQuN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:50:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D9FC0086B1;
        Thu,  6 Aug 2020 08:33:15 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so9518639pgb.4;
        Thu, 06 Aug 2020 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e2z5ihEKycv93uWBiu5MSP57xzQDMSDWIawsJEucN+M=;
        b=E9eLeCdxGuq5X89zbRq6hxl0SP+c1Di9JG9QW4eGxsspqaGWWSy1v7UBgnETqNvA/H
         J55vtc7st60z+Px4TmpjTSb3Xu2+5qsSUpDq6w5NmQ0+9cPTbmXU2STD1mVe5SHc6Aw1
         Z5RfLJVavTilBJvxKdxX56opDiw7mR0a9mDLCuFVMjNCQqjy8RigNHj/tnTH5pD+kVSL
         RtE3eVMGoHd9KwBzJTJFDxeaoyNIZmKUossFb7evT8f7Jzi5cAt6gB7wR3jO/91HKEHP
         Rtrp1mRB3FmSOC9QZ2QfqYjznOtbLUfjepkOGeyZqODnxGIYZdq5bZijSprym0wrVX7n
         9rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=e2z5ihEKycv93uWBiu5MSP57xzQDMSDWIawsJEucN+M=;
        b=MfWrn5A+/LvEJ26p+CP+HX+yEy/HBPMNUV4e+TBiikwMc/9c8bqR4+NpWCOQuDaaNg
         ulOsZO/LkGzzE4+ZoDfeG8Eyu/dFX+kTKvi6O6gtxv2dYJKpk07ePmIqA5seUf4gEO90
         rRUqzWpS6PLdunowGkpQQDqzMtSY5hD7ZW+wqCh3+VJBdwD8cXQ3GPJRpMLNWIPEX543
         zgNG8Ev2JP/jqXeGKuphnLTpDBzdBD4hPHJVKxF1jm+J5TuxdZKHCa4G/zXbKLTCX8SU
         bRJJW2ZBCJFWVyaBpZzc3jIH/uQ0Ncwkwkge71Dsa7P6mSv3n6KQxWQ1RR5FZ5Tbc6wr
         1M4Q==
X-Gm-Message-State: AOAM532I+x6h/8+JsfmJJbxHoelawE1DI5+tDLWb2ojqGx8nbgYOrr3g
        R4cg6x+8RmGpGFkCqPU73Vs=
X-Google-Smtp-Source: ABdhPJyrW4Oh9jNEwChjzEenHkBb7qSdo656ODjCJZgJFlkavMZN0tNmhmfUlRsR6Y+ywfHWI5oXIQ==
X-Received: by 2002:a62:d149:: with SMTP id t9mr8822019pfl.59.1596727994750;
        Thu, 06 Aug 2020 08:33:14 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s185sm8581193pgc.18.2020.08.06.08.33.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:14 -0700 (PDT)
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
Subject: [PATCH v4 2/7] cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Thu,  6 Aug 2020 08:33:03 -0700
Message-Id: <20200806153308.204605-3-linux@roeck-us.net>
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

Handle this change by no longer assuming that -EPROTO is used to report
all errors returned by the EC itself. Since errors reported by the EC are
already reported in text form through sysfs attributes, extend this form
of error reporting to all errors reported by cros_ec_cmd_xfer_status().

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

 drivers/platform/chrome/cros_ec_lightbar.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index b59180bff5a3..8445cda57927 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -117,7 +117,7 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_VERSION;
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret < 0) {
+	if (ret < 0 && ret != -EINVAL) {
 		ret = 0;
 		goto exit;
 	}
@@ -298,11 +298,9 @@ static ssize_t sequence_show(struct device *dev,
 		goto exit;
 
 	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	if (ret == -EPROTO) {
-		ret = scnprintf(buf, PAGE_SIZE,
-				"ERROR: EC returned %d\n", msg->result);
-		goto exit;
-	} else if (ret < 0) {
+	if (ret < 0) {
+		ret = scnprintf(buf, PAGE_SIZE, "XFER / EC ERROR %d / %d\n",
+				ret, msg->result);
 		goto exit;
 	}
 
-- 
2.17.1

