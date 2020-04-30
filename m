Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87C41BEDB8
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Apr 2020 03:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgD3Bkx (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 29 Apr 2020 21:40:53 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:25994 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726282AbgD3Bkw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 29 Apr 2020 21:40:52 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Apr 2020 18:40:50 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 29 Apr 2020 18:40:50 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 138B64D38; Wed, 29 Apr 2020 18:40:50 -0700 (PDT)
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
Subject: [PATCH v14 10/11] clk: pwm: Use 64-bit division function
Date:   Wed, 29 Apr 2020 18:40:46 -0700
Message-Id: <6c4bf80524c9ce0dac96f9a9ab8612861468a4ff.1588208650.git.gurus@codeaurora.org>
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
to u64, prepare for this transition by using div64_u64() to handle a
64-bit divisor.

Also ensure that divide-by-zero (with fixed_rate as denominator) does
not happen with an explicit check with probe failure as a consequence.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk-pwm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 87fe0b0e..86f2e2d 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -89,7 +89,12 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	}
 
 	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
-		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
+		clk_pwm->fixed_rate = div64_u64(NSEC_PER_SEC, pargs.period);
+
+	if (!clk_pwm->fixed_rate) {
+		dev_err(&pdev->dev, "fixed_rate cannot be zero\n");
+		return -EINVAL;
+	}
 
 	if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
 	    pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

