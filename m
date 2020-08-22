Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20824E840
	for <lists+linux-pwm@lfdr.de>; Sat, 22 Aug 2020 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgHVPJ0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 22 Aug 2020 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgHVPJN (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 22 Aug 2020 11:09:13 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33C3C061573;
        Sat, 22 Aug 2020 08:09:12 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q1so2076143pjd.1;
        Sat, 22 Aug 2020 08:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tyw6vA6yQNsN/wIQW/tyNI4Wu5/Dv3Pgq6wDKg4/E3s=;
        b=YbE1w7oD6AZf3nS8X/ngNno+kA8Zo52fmQNdcS18SCftss1D3yFLglNwe+oipf8jOX
         DRFtnMAZWNojSnWzlc/n6pDvWWDbgcQwFYYCml+QMVZGfqO3RzcIRiXLGa0Nsm3se4oe
         Fei6MpahuQeRmntgo9MrDRT//+440ZakOLhqTIEGfW696V25d3fA/s0NxNA0bmIH2OVi
         LuKWw37yjwTZp14MPJNrDNSPou2msXBze3NnXQcnsLezWul4nMFMXOIvi8+w1NM6PWyK
         zF+G4NS6A5QAswGttxfG3mb6YYzOK+QKMl30yPAs9o7g1KjIoAVhN7zodbgq6HqskgA+
         FeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tyw6vA6yQNsN/wIQW/tyNI4Wu5/Dv3Pgq6wDKg4/E3s=;
        b=FjD7n+67SrhlkyqQxKEtQktzsWGKn2qaadHj2+SqqwxqTNeVYYF44RDfadUX6fgSfA
         T8ksI+2dP3ZlpeB6rBg7KIV00Kod0aa140hLzIP7nD8CGvqW3jgmkZNCh+AzUvmNoz1g
         bGEtBMlKZnWFTBoYY+zNkFsVq9PiTWQD8r7k3Lkv0hlQ1KAVvuppRWFwLPeywExmVImA
         l53EXmTkk9LDgMHHbG4+hIx0XepPAFagARdVqpcZxVv67ujJF2MqVNZffwkT/Uj8fbV7
         fsK+8Jv6Qsa2g2f3p/bjW7KUp7ZGQiSB1ucbMBI3U1cdWT/dGPNwP9bkXWBuWo0ge27m
         Ol3w==
X-Gm-Message-State: AOAM533atrtWbfc6eOwW5/GQ17svOWi2srKAnHOChznVaKjXixAFzTj2
        I5HGZxMorzWKvw8TI05au5o=
X-Google-Smtp-Source: ABdhPJyVbAW/pyqe68An3ewBWq6iwe7ykVWD8BuDS3ND+hrizcTTwB7VQ11E/eWTtXdShmZOKg5Xpw==
X-Received: by 2002:a17:902:7605:: with SMTP id k5mr6513045pll.122.1598108952417;
        Sat, 22 Aug 2020 08:09:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l9sm5331944pgg.29.2020.08.22.08.09.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Aug 2020 08:09:12 -0700 (PDT)
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
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5 7/7] pwm: cros-ec: Simplify EC error handling
Date:   Sat, 22 Aug 2020 08:08:57 -0700
Message-Id: <20200822150857.205775-8-linux@roeck-us.net>
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

With enhanced error reporting from cros_ec_cmd_xfer_status() in place,
we can fully use it and no longer rely on EC error codes.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v5: Added Brian's Reviewed-by: tag
    Added Uwe's Acked-by: tag
v4: Added patch to series

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

