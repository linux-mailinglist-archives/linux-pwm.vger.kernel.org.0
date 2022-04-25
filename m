Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA4250E186
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Apr 2022 15:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiDYN0U (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Apr 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbiDYN0I (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Apr 2022 09:26:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A262C3298D
        for <linux-pwm@vger.kernel.org>; Mon, 25 Apr 2022 06:23:01 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1niyg2-0001O4-AD; Mon, 25 Apr 2022 15:22:54 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1niyg2-0059pC-6i; Mon, 25 Apr 2022 15:22:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1niyfz-005Wxi-WA; Mon, 25 Apr 2022 15:22:52 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2] pwm: tegra: Optimize period calculation
Date:   Mon, 25 Apr 2022 15:22:44 +0200
Message-Id: <20220425132244.48688-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3241; h=from:subject; bh=S4+1ZoALLU+8TDV+bW3oBGSo04bXxSRkdgy0lyQIbkA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiZqARIhor3MC1ppcD5nm1hTCuPmB9iuB2NpBxuFjG vWvdpluJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYmagEQAKCRDB/BR4rcrsCWDCB/ 404T/ChaTD8h0P3A9yzpgid+K/37AMar2HOYkBMICH8NudJV51rm3SkB49f03Ujbf0xov2XlqoVqeM 2xZlWH43GcmSwtvKE5hnxERNwqule8Cbx2NAIfWQpGsNBgplM0kTRmP06PDdQAjtBAdU3wdNDDyMP8 SBxJwPHdYD7njfBeliJK4Kj6Y+3KhO62L2d+MjqTChTnYWcR8GLkoMlnheMBW4kwZyywOEpKNmBpuL HV/TJ3z2eFslpGuY8JD5WGAyEplA/MkLuaAEfskYA/kHUlwqBPJOg3f6wzvr8R2HvZykk7jEtSBU+E iaRDOdBP6QLHXy9/4DbSKE/ZCnD/hd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Dividing by the result of a division looses precision because the result is
rounded twice. E.g. with clk_rate = 48000000 and period = 32760033 the
following numbers result:

	rate = pc->clk_rate >> PWM_DUTY_WIDTH = 187500
	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns) = 3052
	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz) = 6144

The exact result would be 6142.5061875 and (apart from rounding) this is
found by using a single division. As a side effect is also a tad
cheaper to calculate.

Also using clk_rate >> PWM_DUTY_WIDTH looses precision. Consider for
example clk_rate = 47999999 and period = 106667:

	mul_u64_u64_div_u64(pc->clk_rate >> PWM_DUTY_WIDTH, period_ns,
			    NSEC_PER_SEC) = 19

	mul_u64_u64_div_u64(pc->clk_rate, period_ns,
			    NSEC_PER_SEC << PWM_DUTY_WIDTH) = 20

(The exact result is 20.000062083332033.)

With this optimizations also switch from round-closest to round-down for
the period calculation. Given that the calculations were non-optimal for
quite some time now with variations in both directions which nobody
reported as a problem, this is the opportunity to align the driver's
behavior to the requirements of new drivers. This has several upsides:

 - Implementation is easier as there are no round-nearest variants of
   mul_u64_u64_div_u64().
 - Requests for too small periods are now consistently refused. This was
   kind of arbitrary before, where period_ns < min_period_ns was
   refused, but in some cases min_period_ns isn't actually implementable
   and then values between min_period_ns and the actual minimum were
   rounded up to the actual minimum.

Note that the duty_cycle calculation isn't using the usual round-down
approach yet.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

changes since (implicit) v1: Updated changelog to explain why rate = 0
is refused now.

Best regards
Uwe

 drivers/pwm/pwm-tegra.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index e5a9ffef4a71..7fc03a9ec154 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -99,7 +99,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			    int duty_ns, int period_ns)
 {
 	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
-	unsigned long long c = duty_ns, hz;
+	unsigned long long c = duty_ns;
 	unsigned long rate, required_clk_rate;
 	u32 val = 0;
 	int err;
@@ -156,11 +156,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pc->clk_rate = clk_get_rate(pc->clk);
 	}
 
-	rate = pc->clk_rate >> PWM_DUTY_WIDTH;
-
 	/* Consider precision in PWM_SCALE_WIDTH rate calculation */
-	hz = DIV_ROUND_CLOSEST_ULL(100ULL * NSEC_PER_SEC, period_ns);
-	rate = DIV_ROUND_CLOSEST_ULL(100ULL * rate, hz);
+	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
+				   (u64)NSEC_PER_SEC << PWM_DUTY_WIDTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -169,6 +167,8 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (rate > 0)
 		rate--;
+	else
+		return -EINVAL;
 
 	/*
 	 * Make sure that the rate will fit in the register's frequency

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

