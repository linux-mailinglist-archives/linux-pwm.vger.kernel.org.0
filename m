Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A73914E414
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Jan 2020 21:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbgA3Uf3 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 30 Jan 2020 15:35:29 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39878 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbgA3Uf2 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 30 Jan 2020 15:35:28 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so1839952pjr.4
        for <linux-pwm@vger.kernel.org>; Thu, 30 Jan 2020 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OnHhTHan7oXdBJ9lqN5U957YaigDfCk8zR+rMkIC7QI=;
        b=eNckr7wvYrCJtQnD8laGiWme1n3OUA3V6nQ5tAz1cGMsJ/4PGzqGhDkGmhEZVVv0wZ
         xSIheJ5Gb5dQXt4S+sjnHwNxpbKAVTbUUgNAvyHRCSZzlPGQQeT+kThcYgVPNMyUKEmC
         48DpTGhGGmJRUpSiPLb+5QSRAoLi9Ia0uUjIM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OnHhTHan7oXdBJ9lqN5U957YaigDfCk8zR+rMkIC7QI=;
        b=X8xTriVkDUKmAaV8ZwKGvGr7KpRyA1bu8miSF9wzqJronOe47wtzZDHcoalbzbUkyj
         VXP6Xjd11UW/AKFTi8tf0cCwvlk7rnuzapeAKetZtd0QmHZ33qhMk+OKaYO93cczckBC
         XOAs5+NjZRxCiUdDuWM8GghZbk0GqjnVxUX6R32tESXfKsPNAPLAknqnZE0Sfav0Ccgu
         nHhXhkG22vM8A6Q9Pu4bhY9/tp8AwGeSKg4J8eEnea3BNr3zkDTlhmQc2+Rvpue+5s+g
         i4GP3sXtTDeI8dK/uIKv5coCqvj93O5np/7uFSPIgo7MdyrVfKv9LsIK6vLPfhB0uhWV
         2U8w==
X-Gm-Message-State: APjAAAXV+WYCZx1trwBkTR24xMMYpXsNNt96088lTyrpRsz7zwltqryU
        LqKk9L7T51du8zQ+GyiLqxIYssinaF1Htw==
X-Google-Smtp-Source: APXvYqypoOtJu0y9ma5MfFUcOlcLTGslbB96H/UYOfUM4gaW0ymEaZMWsyyqCyszJQTCxbR+hOxhZg==
X-Received: by 2002:a17:90a:628c:: with SMTP id d12mr8051348pjj.59.1580416528241;
        Thu, 30 Jan 2020 12:35:28 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:35:27 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM)
Subject: [PATCH 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
Date:   Thu, 30 Jan 2020 12:31:01 -0800
Message-Id: <20200130203106.201894-14-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert one existing usage of cros_ec_cmd_xfer_status() to
cros_ec_send_cmd_msg(), which accomplishes the same thing but also does
the EC message struct setup,and is defined in platform/chrome and is
accessible by other modules.

For the other usage, switch it to using cros_ec_cmd_xfer(), since the
calling functions rely on the result field of the struct cros_ec_command
struct that is used.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/pwm/pwm-cros-ec.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d21775..8bf610a6529e7e 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -32,25 +32,14 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 
 static int cros_ec_pwm_set_duty(struct cros_ec_device *ec, u8 index, u16 duty)
 {
-	struct {
-		struct cros_ec_command msg;
-		struct ec_params_pwm_set_duty params;
-	} __packed buf;
-	struct ec_params_pwm_set_duty *params = &buf.params;
-	struct cros_ec_command *msg = &buf.msg;
-
-	memset(&buf, 0, sizeof(buf));
+	struct ec_params_pwm_set_duty params = {0};
 
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_SET_DUTY;
-	msg->insize = 0;
-	msg->outsize = sizeof(*params);
-
-	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
+	params.duty = duty;
+	params.pwm_type = EC_PWM_TYPE_GENERIC;
+	params.index = index;
 
-	return cros_ec_cmd_xfer_status(ec, msg);
+	return cros_ec_send_cmd_msg(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
+				    sizeof(params), NULL, 0);
 }
 
 static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
@@ -78,11 +67,13 @@ static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 	params->pwm_type = EC_PWM_TYPE_GENERIC;
 	params->index = index;
 
-	ret = cros_ec_cmd_xfer_status(ec, msg);
+	ret = cros_ec_cmd_xfer(ec, msg);
 	if (result)
 		*result = msg->result;
 	if (ret < 0)
 		return ret;
+	else if (msg->result != EC_RES_SUCCESS)
+		return -EPROTO;
 
 	return resp->duty;
 }
-- 
2.25.0.341.g760bfbb309-goog

