Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3A124E838
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgHVPJN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbgHVPJF (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3AE0C061573;
        Sat, 22 Aug 2020 08:09:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id j13so2068559pjd.4;
        Sat, 22 Aug 2020 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3ojjDGinYxNQUXg0N/YZCfPJhsS5y6qCv15zZNisimw=;
        b=FYMHfmyQcP6r87y54D39SU0U/EXItY7BuTkYJg//dksggcAH0PmjNsG2HLFYlwLgsL
         +iAJHEBCM50FyAWpXX8ktBcxGV5aj9bN7hTgngLpw+9rM0xhvBix3c/zk96h2RR0TJIF
         1u6MRRf5jclW2sk8ZIT+49NMprGPCUC8txAG0fPwSwSAk6eyuGIdkgFOxxIdE+KrsAeU
         cLi9ub+ChT1VakxFRXma4xICnvC6AnFl3mmh6bZcn0vDIZ6ejNR0HkYQ2Uo9RNWiuEAV
         0TyDRfQUrjz/sohswEGdGfurDntNNg7vo2OM+0R46rBfumdvVwQq56cHl888YxEfKcZ7
         AypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=3ojjDGinYxNQUXg0N/YZCfPJhsS5y6qCv15zZNisimw=;
        b=qZBwGwwHB8rZ4vZSK30YO0CXYmKxZNbT/qrHV/KVsZIx+9U3XfsS6yEVRJ+umxTWGp
         Y12DSsC0jPckFb/tF+vLKgsh6yfYwUcMj0Zh+QXSYsSlA/0vUJaB+qLg39mh5Yxv2oGF
         LIUiLBsqcnMG+Z6HRBgQz0261XnIcsuAzkbWaQK0zxLtG5Jiu4ToMQBrkDtAcrW+iNiP
         GGaY7HbV4VpLT2qvagTgFXldf0ig3Z07EyOWxlgh+TnrHhmAYTTDAxZD7yg9LI7HR+BW
         jBdhC9/Ulxl2swterqm1CnH+q+qDKfFI6fNj4+g1VmfrglbgN0SfFMi+3Pxv6zWfU7b1
         rGag==
X-Gm-Message-State: AOAM531Z4xIXSkCAS/32EnyewYlrIHkHG8z3NhXJlnYvQXK79fe5sR0I
        CdtPWSp2t0n/bo0s8vMzY/c=
X-Google-Smtp-Source: ABdhPJxdqCjvAVsoNTQz4p/S3SBkxECC2lx6F079AYS6/n65xj8rZ65zisMod2OMZx3jjLjbAP/5Pg==
X-Received: by 2002:a17:90a:f0d7:: with SMTP id fa23mr1874486pjb.91.1598108945205;
        Sat, 22 Aug 2020 08:09:05 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q66sm4684090pjq.17.2020.08.22.08.09.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:04 -0700 (PDT)
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
Subject: [PATCH v5 2/7] cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Sat, 22 Aug 2020 08:08:52 -0700
Message-Id: <20200822150857.205775-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200822150857.205775-1-linux@roeck-us.net>
References: <20200822150857.205775-1-linux@roeck-us.net>
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
v5: No change
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

