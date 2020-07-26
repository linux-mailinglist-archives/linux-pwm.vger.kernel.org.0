Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9ED22E2F1
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jul 2020 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgGZWBM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Jul 2020 18:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgGZWBL (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Jul 2020 18:01:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50BAFC0619D2;
        Sun, 26 Jul 2020 15:01:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so7025552ply.11;
        Sun, 26 Jul 2020 15:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p2ZGaEvqbBo3caD5sMA/QnrK4wKw7E7gyzjsO5Ns6y0=;
        b=lZIAhLjLmirYDu8HeccJ5MDOHmQHenXob0dzJmZAaNgjBzX9AJfPp/L8TNC3fKDjQq
         vWViEXVNEJqJdnv5bkDfYQvF2D/LVThVUH4jtorm03bW3Qf3XV1soMh6OuCraCZ+FlEQ
         +SfghS1kCSBLwXhjTC5BYTDNQb6K+SKriJpDZ57FiZXohRbUJX+qXNkR+TQUpfo/FCGG
         yuCa5mF2O3VBrMRL0TLzUqYW+9nhOaDUTpM+mtCDy6hMwrM786A8AAwBLwDwKegj0v2h
         kV1AiZdRJfDrHR+8amqAJ/eYyvzxNrU+gZte3cuaNdDqaxctYUx2vM6vy48X9NAUzLV1
         g9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=p2ZGaEvqbBo3caD5sMA/QnrK4wKw7E7gyzjsO5Ns6y0=;
        b=oOXgXvsM7QJtRxY2lwY2e9ZlAWCrEHUn9t1rKi9zrGFTlpn7wCmBjcGezJ7kD6AONE
         fPE7sgrtcKfaXK95bWQek4gkK/b2lkxdddUEzYRCIDjMuY99sRGV+cs97LohvHl1V6Pk
         ASOA3bMP68YoL5/SYngHQ3r9dZ6b1OTTyMJ3VuCHDAIWxw3uATtVpM/1ZDuQwWO4PhW7
         xN1NGV+G+AYJH3FZ3RjpsnvV2RLke7f6+QMk+mcAaNcv6sEszYTIWlfO+72w71rbhD4z
         h08X1UHu8pI9Eavv+X1KMK2KznGicisC6OnZGdljmLD0jNrV61j23J3APyrOQbjXGbdc
         QK7w==
X-Gm-Message-State: AOAM530CLuVEQ0GuXdm71Rp1kKqwWPiNu1WJii9Zb3YZnS3SU+iVj4mu
        y35jNw3BYNO9z0wP43N/osU=
X-Google-Smtp-Source: ABdhPJzQhsWHwHIFLQVZNcXrpBs7Ty5n/9Rh3z/f/4DCVt5kvNDUdml+X9+STWqMiPbzGP4KB+zJeA==
X-Received: by 2002:a17:90a:c207:: with SMTP id e7mr15997035pjt.49.1595800869857;
        Sun, 26 Jul 2020 15:01:09 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a9sm12654566pfr.103.2020.07.26.15.01.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 26 Jul 2020 15:01:09 -0700 (PDT)
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
Subject: [PATCH v3 2/6] cros_ec_lightbar: Accept more error codes from cros_ec_cmd_xfer_status
Date:   Sun, 26 Jul 2020 15:00:57 -0700
Message-Id: <20200726220101.29059-3-linux@roeck-us.net>
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

