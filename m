Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCAA11BEDC5
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2020 03:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD3BlU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Apr 2020 21:41:20 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:29267 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD3Bkv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Apr 2020 21:40:51 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2020 18:40:50 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 29 Apr 2020 18:40:49 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 970DB4CF1; Wed, 29 Apr 2020 18:40:49 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v14 02/11] hwmon: pwm-fan: Use 64-bit division macro
Date:   Wed, 29 Apr 2020 18:40:38 -0700
Message-Id: <cc56a6017ecd1a8e8abba9ededf18d9e2311a4c2.1588208650.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1588208650.git.gurus@codeaurora.org>
References: <cover.1588208650.git.gurus@codeaurora.org>
In-Reply-To: <cover.1588208650.git.gurus@codeaurora.org>
References: <cover.1588208650.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by using DIV_ROUND_UP_ULL to handle
a 64-bit dividend.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Acked-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pwm-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pwm-fan.c b/drivers/hwmon/pwm-fan.c
index 30b7b3e..17bb642 100644
--- a/drivers/hwmon/pwm-fan.c
+++ b/drivers/hwmon/pwm-fan.c
@@ -447,7 +447,7 @@ static int pwm_fan_resume(struct device *dev)
 		return 0;
 
 	pwm_get_args(ctx->pwm, &pargs);
-	duty = DIV_ROUND_UP(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
+	duty = DIV_ROUND_UP_ULL(ctx->pwm_value * (pargs.period - 1), MAX_PWM);
 	ret = pwm_config(ctx->pwm, duty, pargs.period);
 	if (ret)
 		return ret;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

