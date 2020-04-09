Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95A891A2F81
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Apr 2020 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgDIGwz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Apr 2020 02:52:55 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:42559 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725783AbgDIGwz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Apr 2020 02:52:55 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Apr 2020 23:52:54 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 08 Apr 2020 23:52:54 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 2DBEC4C4D; Wed,  8 Apr 2020 23:52:54 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v12 04/11] pwm: clps711x: Cast period to u32 before use as divisor
Date:   Wed,  8 Apr 2020 23:52:33 -0700
Message-Id: <c3619bdd4856e881d6bdfd936c5f903be0c3ff57.1586414867.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1586414867.git.gurus@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
In-Reply-To: <cover.1586414867.git.gurus@codeaurora.org>
References: <cover.1586414867.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by typecasting it to u32.

Also, since the dividend is still a 32-bit number, any divisor greater
than the numerator will cause the quotient to be zero, so return 0 in
that case to efficiently skip the division.

Cc: Alexander Shiyan <shc_work@mail.ru>
Cc: Arnd Bergmann <arnd@arndb.de>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-clps711x.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-clps711x.c b/drivers/pwm/pwm-clps711x.c
index 924d39a..0d368ac 100644
--- a/drivers/pwm/pwm-clps711x.c
+++ b/drivers/pwm/pwm-clps711x.c
@@ -43,7 +43,10 @@ static void clps711x_pwm_update_val(struct clps711x_chip *priv, u32 n, u32 v)
 static unsigned int clps711x_get_duty(struct pwm_device *pwm, unsigned int v)
 {
 	/* Duty cycle 0..15 max */
-	return DIV_ROUND_CLOSEST(v * 0xf, pwm->args.period);
+	if ((u32)pwm->args.period > (v * 0xf))
+		return 0;
+
+	return DIV_ROUND_CLOSEST(v * 0xf, (u32)pwm->args.period);
 }
 
 static int clps711x_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

