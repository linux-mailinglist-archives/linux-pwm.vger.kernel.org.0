Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 891BED6471
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2019 15:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732117AbfJNNxP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Oct 2019 09:53:15 -0400
Received: from vps.xff.cz ([195.181.215.36]:39696 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731092AbfJNNxO (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 14 Oct 2019 09:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1571061192; bh=46QzCIBZ/9atA9i8sP3TsXg10uJJ6p13+mX/uBQH05Y=;
        h=From:To:Cc:Subject:Date:From;
        b=qeaJSpN7BUJp2ZteQ5BjyIkVRC6U0UOhE7/gTCpY+DprLpl8kJMvhno9FN5fEXAj/
         vqfuwWbW7gK6ALcnPDN5dGh0qLtwAAR92w1PbxUXFpnTl3wx9TeUVdsvoQiTHkucCk
         6LgmSYX/mtr2I/n5v+Sbbo87xQkbzlHzWd6xUGPY=
From:   megous@megous.com
Cc:     Ondrej Jirman <megous@megous.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] pwm: sun4i: Fix incorrect calculation of duty_cycle/period
Date:   Mon, 14 Oct 2019 15:53:03 +0200
Message-Id: <20191014135303.2944058-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

Since 5.4-rc1, pwm_apply_state calls ->get_state after ->apply
if available, and this revealed an issue with integer precision
when calculating duty_cycle and period for the currently set
state in ->get_state callback.

This issue manifested in broken backlight on several Allwinner
based devices.

Previously this worked, because ->apply updated the passed state
directly.

Fixes: deb9c462f4e53 ("pwm: sun4i: Don't update the state for the caller of pwm_apply_state")
Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6f5840a1a82d..05273725a9ff 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -137,10 +137,10 @@ static void sun4i_pwm_get_state(struct pwm_chip *chip,
 
 	val = sun4i_pwm_readl(sun4i_pwm, PWM_CH_PRD(pwm->hwpwm));
 
-	tmp = prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
+	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_DTY(val);
 	state->duty_cycle = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 
-	tmp = prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
+	tmp = (u64)prescaler * NSEC_PER_SEC * PWM_REG_PRD(val);
 	state->period = DIV_ROUND_CLOSEST_ULL(tmp, clk_rate);
 }
 
-- 
2.23.0

