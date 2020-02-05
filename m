Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7D1538DD
	for <lists+linux-pwm@lfdr.de>; Wed,  5 Feb 2020 20:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBETRC (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 5 Feb 2020 14:17:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38152 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETRC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 5 Feb 2020 14:17:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id a33so1430538pgm.5
        for <linux-pwm@vger.kernel.org>; Wed, 05 Feb 2020 11:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+0ykAx11fuyygrc+KyLwJgAkg4nrOamvVmCqDKRLdio=;
        b=SHIyAKDm+/TnelUmd18Oh98yrnaRJfqfwihlr+xRCOEuwSbwyCetq8quyA73ZpItjm
         L3aiKxG2wEYjOqo12SAfFVQD1fRJo2P+P5n0FHatV5njQYriQeUGS+7JpMunDOL2ECk5
         Z+33q2SdK7436ghVG1a+4KwauIYncVhTJx47Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+0ykAx11fuyygrc+KyLwJgAkg4nrOamvVmCqDKRLdio=;
        b=MWlk2K3vQnAHUAN3hhDKXSZpWgOa3Rbq8lOgpCOpO5Exii8hZX4gPR4ueNi26/y/sn
         axBun35oNFr2wGgNiNdGKXIQ4OS0DbaNecafp8ROphZQdsCbXaLsZOZCRoluTVz5MXRc
         bdR9FPD2nB29toQ/Y5jhQuUvKeiYFEzwWMcZIv9eo6LEQKZEX2ZoyqoDhQJtX9UtBw+Z
         hbHHSHkJPSl/bymVt7O4py+4aWhvWwT4TVcfDfJwerxiDY8CZpHViJ1SWgmSNrwIzLO2
         6lmMKD5soHge7fxJc5ZNnKvMbZvfXSJA+2zRj4eDerGZ5bhT6XOYdQKY7GGK102mzpPz
         7OmA==
X-Gm-Message-State: APjAAAUfJu1HRxTsiZM15yPofR2E7sFRz+dHbPYYhLau3zjGSVT1nsJ8
        kbKc+pwyW/BeqeM9ziuvI11Wug==
X-Google-Smtp-Source: APXvYqx6JwtfFVIKJ/jVZbqnS5l6rVzWM8Q30saJVdPfKjYGL9FBpxZfY1c8WznVEe5B8pJYFhC9SA==
X-Received: by 2002:aa7:9a42:: with SMTP id x2mr34667912pfj.71.1580930222078;
        Wed, 05 Feb 2020 11:17:02 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:17:01 -0800 (PST)
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
Subject: [PATCH v2 13/17] pwm: cros-ec: Remove cros_ec_cmd_xfer_status()
Date:   Wed,  5 Feb 2020 11:00:20 -0800
Message-Id: <20200205190028.183069-14-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert existing usages of cros_ec_cmd_xfer_status() to cros_ec_cmd(),
which accomplishes the same thing but also does the EC message struct
setup, is defined in platform/chrome and is accessible by other
modules.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.
- Use C99 element setting for struct initialization.

 drivers/pwm/pwm-cros-ec.c | 59 +++++++++++----------------------------
 1 file changed, 16 insertions(+), 43 deletions(-)

diff --git a/drivers/pwm/pwm-cros-ec.c b/drivers/pwm/pwm-cros-ec.c
index 89497448d21775..57a1cab4cfacad 100644
--- a/drivers/pwm/pwm-cros-ec.c
+++ b/drivers/pwm/pwm-cros-ec.c
@@ -32,59 +32,32 @@ static inline struct cros_ec_pwm_device *pwm_to_cros_ec_pwm(struct pwm_chip *c)
 
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
-
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_SET_DUTY;
-	msg->insize = 0;
-	msg->outsize = sizeof(*params);
-
-	params->duty = duty;
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
-
-	return cros_ec_cmd_xfer_status(ec, msg);
+	struct ec_params_pwm_set_duty params = {
+		.duty = duty,
+		.pwm_type = EC_PWM_TYPE_GENERIC,
+		.index = index,
+	};
+
+	return cros_ec_cmd(ec, 0, EC_CMD_PWM_SET_DUTY, &params,
+			   sizeof(params), NULL, 0, NULL);
 }
 
 static int __cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index,
 				  u32 *result)
 {
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_params_pwm_get_duty params;
-			struct ec_response_pwm_get_duty resp;
-		};
-	} __packed buf;
-	struct ec_params_pwm_get_duty *params = &buf.params;
-	struct ec_response_pwm_get_duty *resp = &buf.resp;
-	struct cros_ec_command *msg = &buf.msg;
+	struct ec_params_pwm_get_duty params = {
+		.pwm_type = EC_PWM_TYPE_GENERIC,
+		.index = index,
+	};
+	struct ec_response_pwm_get_duty resp = {0};
 	int ret;
 
-	memset(&buf, 0, sizeof(buf));
-
-	msg->version = 0;
-	msg->command = EC_CMD_PWM_GET_DUTY;
-	msg->insize = sizeof(*resp);
-	msg->outsize = sizeof(*params);
-
-	params->pwm_type = EC_PWM_TYPE_GENERIC;
-	params->index = index;
-
-	ret = cros_ec_cmd_xfer_status(ec, msg);
-	if (result)
-		*result = msg->result;
+	ret = cros_ec_cmd(ec, 0, EC_CMD_PWM_GET_DUTY, &params, sizeof(params),
+			  &resp, sizeof(resp), result);
 	if (ret < 0)
 		return ret;
 
-	return resp->duty;
+	return resp.duty;
 }
 
 static int cros_ec_pwm_get_duty(struct cros_ec_device *ec, u8 index)
-- 
2.25.0.341.g760bfbb309-goog

