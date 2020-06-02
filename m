Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 618AF1EC4FC
	for <lists+linux-pwm@lfdr.de>; Wed,  3 Jun 2020 00:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbgFBWba (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 2 Jun 2020 18:31:30 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:45987 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728390AbgFBWbY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 2 Jun 2020 18:31:24 -0400
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 02 Jun 2020 15:31:23 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg01-sd.qualcomm.com with ESMTP; 02 Jun 2020 15:31:22 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 9AC754D82; Tue,  2 Jun 2020 15:31:22 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        linux-kernel@vger.kernel.org, Joe Perches <joe@perches.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-arm-kernel@lists.infradead.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v16 07/11] pwm: sifive: Use 64-bit division macro
Date:   Tue,  2 Jun 2020 15:31:12 -0700
Message-Id: <15c8dc6b4dcf384a6099236ff105c49bdc990944.1591136989.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1591136989.git.gurus@codeaurora.org>
References: <cover.1591136989.git.gurus@codeaurora.org>
In-Reply-To: <cover.1591136989.git.gurus@codeaurora.org>
References: <cover.1591136989.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by using DIV64_U64_ROUND_CLOSEST to
handle a 64-bit divisor.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 drivers/pwm/pwm-sifive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index cc63f9b..62de0bb 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -181,7 +181,7 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * consecutively
 	 */
 	num = (u64)duty_cycle * (1U << PWM_SIFIVE_CMPWIDTH);
-	frac = DIV_ROUND_CLOSEST_ULL(num, state->period);
+	frac = DIV64_U64_ROUND_CLOSEST(num, state->period);
 	/* The hardware cannot generate a 100% duty cycle */
 	frac = min(frac, (1U << PWM_SIFIVE_CMPWIDTH) - 1);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

