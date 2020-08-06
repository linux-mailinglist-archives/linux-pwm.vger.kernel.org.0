Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9316423DC87
	for <lists+linux-pwm@lfdr.de>; Thu,  6 Aug 2020 18:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729524AbgHFQxX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 6 Aug 2020 12:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgHFQu7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 6 Aug 2020 12:50:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6FC0086B7;
        Thu,  6 Aug 2020 08:33:22 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so26959041pgf.0;
        Thu, 06 Aug 2020 08:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NXM7oKIqExo6jQUCEcqG7gsdReCWsat1fidWX99SIu0=;
        b=qtmrG/B/x58Madbk7LLC7WKbj2mBIkC1GmyA7WafBLX+ZoV6WYIRo1bU1eavNX5Odx
         H7cx7siSu0FEcpEG2ucdbQh8uMSgyJr3m/zq34an/vJzcmGC7ug1STJRw2wYoPazPWX3
         TBZCJdqoyqyzJhoHsFQkqguml/jS1jLMWrcpfXAo1/LjQZa9WLmgoCG77PRUFZw8W8k1
         A/MAfASV7jEhnvtYzFzzxlanVOh+iy0XW5b/BflcA14wgsmEFuXTkzOWpE74LxS4I4BL
         gwRxBfJbn5omiFoDDdm1r7IJHL8wf2cKCRw1mKh8WRS+dagMNRS1v5jr6fOWnfWBq/8t
         1zhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=NXM7oKIqExo6jQUCEcqG7gsdReCWsat1fidWX99SIu0=;
        b=dVf//0zjvqXYIg6M0m+pXTnQGf6rRBpRFoXxc1ye615zEoKj17MtWKMd0HMYBFBwt8
         IgYwjOyzRA24hBWiRPPCW3N4IgjcvTxXiA1pdHVI3E/vgZAXvVd/F4Jzo/oTxYN/bzy3
         TNV4u1Pcu3Y7TIxe/on3KEKwe48TZgp99pk/Cpca2HmGaOT7kUsIqOzeeUOGni8f98B4
         OZhoa5ZrBzbzAczuOh8C6l44/r3AEiG+VbxIGCSOWaPrrJIuLxRVNWQV08+7D67gGc0y
         eIOfJQEsSdwxG/ZfgzW9ynmB1kxqSEZ4B84Jng5Ib8F/LzuCkVp1VNNemnjgBm44dKoe
         AsUw==
X-Gm-Message-State: AOAM531vWQ8K+/fV/tqgitgQE93kMwMGOmIr6NIsV7vkod+qV9lEXZD6
        EzM6YLr8cYD55zmuEvNis6k=
X-Google-Smtp-Source: ABdhPJxPgUkkRVp7LsuLLycjHy7G09Nd7fR2ySbGBe+ceuVccLylbMsZBpLGEhRshGy64Vbl4JwA2A==
X-Received: by 2002:a63:d143:: with SMTP id c3mr7775779pgj.306.1596728002409;
        Thu, 06 Aug 2020 08:33:22 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 12sm8379264pfn.173.2020.08.06.08.33.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Aug 2020 08:33:21 -0700 (PDT)
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
Subject: [PATCH v4 7/7] pwm: cros-ec: Simplify EC error handling
Date:   Thu,  6 Aug 2020 08:33:08 -0700
Message-Id: <20200806153308.204605-8-linux@roeck-us.net>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806153308.204605-1-linux@roeck-us.net>
References: <20200806153308.204605-1-linux@roeck-us.net>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

With enhanced error reporting from cros_ec_cmd_xfer_status() in place,
we can fully use it and no longer rely on EC error codes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/pwm/pwm-cros-ec.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 94d3dff9b0e5..c1c337969e4e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -81,8 +81,7 @@ static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 	return cros_ec_cmd_xfer_status(ec, msg);
 }
 
-static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
-				  u32 *result)
+static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
 {
 	struct {
 		struct cros_ec_command msg;
@@ -107,19 +106,12 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 	params->index = index;
 
 	ret = cros_ec_cmd_xfer_status(ec, msg);
-	if (result)
-		*result = msg->result;
 	if (ret < 0)
 		return ret;
 
 	return resp->duty;
 }
 
-static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
-{
-	return __cros_ec_pwm_get_duty(ec, index, NULL);
-}
-
 static int cros_ec_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			     const struct pwm_state *state)
 {
@@ -215,28 +207,18 @@ static int cros_ec_num_pwms(struct cros_ec_device *ec)
 
 	/* The index field is only 8 bits */
 	for (i = 0; i <= U8_MAX; i++) {
-		u32 result = 0;
-
-		ret = __cros_ec_pwm_get_duty(ec, i, &result);
+		ret = cros_ec_pwm_get_duty(ec, i);
 		/*
 		 * We look for SUCCESS, INVALID_COMMAND, or INVALID_PARAM
 		 * responses; everything else is treated as an error.
-		 * The EC error codes either map to -EOPNOTSUPP / -EINVAL,
-		 * or -EPROTO is returned and the EC error is in the result
-		 * field. Check for both.
+		 * The EC error codes map to -EOPNOTSUPP and -EINVAL,
+		 * so check for those.
 		 */
 		switch (ret) {
 		case -EOPNOTSUPP:	/* invalid command */
 			return -ENODEV;
 		case -EINVAL:		/* invalid parameter */
 			return i;
-		case -EPROTO:
-			/* Old or new error return code: Handle both */
-			if (result == EC_RES_INVALID_COMMAND)
-				return -ENODEV;
-			else if (result == EC_RES_INVALID_PARAM)
-				return i;
-			return -EPROTO;
 		default:
 			if (ret < 0)
 				return ret;
-- 
2.17.1

