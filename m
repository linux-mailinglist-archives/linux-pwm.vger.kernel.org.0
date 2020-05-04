Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51FEC1C4653
	for <lists+linux-pwm@lfdr.de>; Mon,  4 May 2020 20:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgEDSuX (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 4 May 2020 14:50:23 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:7667 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727797AbgEDSuW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 4 May 2020 14:50:22 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 May 2020 11:50:20 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 04 May 2020 11:50:20 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 27221DBF; Mon,  4 May 2020 11:50:20 -0700 (PDT)
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
Subject: [RESEND PATCH v14 04/11] pwm: clps711x: Cast period to u32 before use as divisor
Date:   Mon,  4 May 2020 11:50:10 -0700
Message-Id: <1d6918c3fc2976bdbdb687bf54a2ef09fc1558db.1588616856.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1588616856.git.gurus@codeaurora.org>
References: <cover.1588616856.git.gurus@codeaurora.org>
In-Reply-To: <cover.1588616856.git.gurus@codeaurora.org>
References: <cover.1588616856.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by typecasting it to u32.

Also, since the dividend is still a 32-bit number, any divisor greater
than the numerator will cause the quotient to be zero, so return 0 in
that case to efficiently skip the division.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-clps711x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a..da771b1 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+	if (pwm->args.period > (v * 0xf))
+		return 0;
+
+	return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

