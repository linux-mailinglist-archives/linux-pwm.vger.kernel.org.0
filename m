Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02ED818C4BB
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2020 02:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbgCTBl1 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Mar 2020 21:41:27 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:61050 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727492AbgCTBl1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Mar 2020 21:41:27 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Mar 2020 18:41:26 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 19 Mar 2020 18:41:25 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id DFC2823CD; Thu, 19 Mar 2020 18:41:25 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v11 08/12] pwm: stm32-lp: Use %llu format specifier for period
Date:   Thu, 19 Mar 2020 18:41:19 -0700
Message-Id: <5ea1fa27dd036ce732c1c7a1a5d84362752a911f.1584667964.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
In-Reply-To: <cover.1584667964.git.gurus@codeaurora.org>
References: <cover.1584667964.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Since the PWM framework is switching struct pwm_args.period's
datatype to u64, prepare for this transition by using the right
specifier for printing a 64-bit value.

Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-stm32-lp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 67fca62..134c146 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %u ns\n",	state->period);
+		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

