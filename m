Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228E117E891
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgCITfY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Mar 2020 15:35:24 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:22361 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgCITfX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Mar 2020 15:35:23 -0400
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Mar 2020 12:35:21 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP; 09 Mar 2020 12:35:21 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 1D0414A19; Mon,  9 Mar 2020 12:35:21 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     linux-pwm@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
        Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v7 11/13] pwm: sun4i: Use 64-bit division macros for period and duty cycle
Date:   Mon,  9 Mar 2020 12:35:14 -0700
Message-Id: <e553511c1c29ebf5af7d2798f92adf886711c861.1583782035.git.gurus@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
In-Reply-To: <cover.1583782035.git.gurus@codeaurora.org>
References: <cover.1583782035.git.gurus@codeaurora.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Because period and duty cycle are defined in the PWM framework structs
as ints with units of nanoseconds, the maximum time duration that can be
set is limited to ~2.147 seconds. Redefining them as u64 values will
enable larger time durations to be set.

As a first step, prepare drivers to handle the switch to u64 period and
duty_cycle by replacing division operations involving pwm period and duty cycle
with their 64-bit equivalents as appropriate. The actual switch to u64 period
and duty_cycle follows as a separate patch.

Where the dividend is 64-bit but the divisor is 32-bit, use *_ULL
macros:
- DIV_ROUND_UP_ULL
- DIV_ROUND_CLOSEST_ULL
- div_u64

Where the divisor is 64-bit (dividend may be 32-bit or 64-bit), use
DIV64_* macros:
- DIV64_U64_ROUND_CLOSEST
- div64_u64

Cc: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/pwm/pwm-sun4i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 3e3efa6..772fdf4 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -286,7 +286,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	val = (duty & PWM_DTY_MASK) | PWM_PRD(period);
 	sun4i_pwm_writel(sun4i_pwm, val, PWM_CH_PRD(pwm->hwpwm));
 	sun4i_pwm->next_period[pwm->hwpwm] = jiffies +
-		usecs_to_jiffies(cstate.period / 1000 + 1);
+		usecs_to_jiffies(div_u64(cstate.period, 1000) + 1);
 	sun4i_pwm->needs_delay[pwm->hwpwm] = true;
 
 	if (state->polarity != PWM_POLARITY_NORMAL)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

