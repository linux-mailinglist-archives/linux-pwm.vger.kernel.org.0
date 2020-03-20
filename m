Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02F218C4C7
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 02:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgCTBlc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 21:41:32 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:61050 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgCTBlb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:31 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Mar 2020 18:41:26 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 19 Mar 2020 18:41:26 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 111E723CD; Thu, 19 Mar 2020 18:41:26 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH v11 11/12] clk: pwm: Assign u64 divisor to unsigned int before use
Date:   Thu, 19 Mar 2020 18:41:22 -0700
Message-Id: <ab7b568b1d287949276b3b1c9efdb1cad1f92004.1584667964.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's datatype
to u64, prepare for this transition by assigning the 64-bit divisor to
an unsigned int variable to use as the divisor. This is being done
because the divisor is a 32-bit constant and the quotient will be zero
if the divisor exceeds 2^32.

Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org
Cc: David Laight <David.Laight@ACULAB.COM>

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/clk/clk-pwm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-pwm.c b/drivers/clk/clk-pwm.c
index 87fe0b0e..c0b5da3 100644
--- a/drivers/clk/clk-pwm.c
+++ b/drivers/clk/clk-pwm.c
@@ -72,6 +72,7 @@ static int clk_pwm_probe(struct platform_device *pdev)
 	struct pwm_device *pwm;
 	struct pwm_args pargs;
 	const char *clk_name;
+	unsigned int period;
 	int ret;
 
 	clk_pwm = devm_kzalloc(&pdev->dev, sizeof(*clk_pwm), GFP_KERNEL);
@@ -88,8 +89,9 @@ static int clk_pwm_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	period = pargs.period;
 	if (of_property_read_u32(node, "clock-frequency", &clk_pwm->fixed_rate))
-		clk_pwm->fixed_rate = NSEC_PER_SEC / pargs.period;
+		clk_pwm->fixed_rate = NSEC_PER_SEC / period;
 
 	if (pargs.period != NSEC_PER_SEC / clk_pwm->fixed_rate &&
 	    pargs.period != DIV_ROUND_UP(NSEC_PER_SEC, clk_pwm->fixed_rate)) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

