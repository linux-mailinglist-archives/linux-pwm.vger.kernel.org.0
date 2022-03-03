Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A309E4CC463
	for <lists+linux-pwm@lfdr.de>; Thu,  3 Mar 2022 18:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbiCCRwZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 3 Mar 2022 12:52:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiCCRwY (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 3 Mar 2022 12:52:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E93C1A1C6B
        for <linux-pwm@vger.kernel.org>; Thu,  3 Mar 2022 09:51:37 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPpbz-0006WA-E1; Thu, 03 Mar 2022 18:51:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPpby-002SG9-LD; Thu, 03 Mar 2022 18:51:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nPpbx-006kwO-0s; Thu, 03 Mar 2022 18:51:33 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH] pwm: tegra: Optimize period calculation
Date:   Thu,  3 Mar 2022 18:50:12 +0100
Message-Id: <20220303175012.358613-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2744; h=from:subject; bh=g0VDo2ZTwl5abWqLJlDJgWxv6PzZwMxPfrKBw55rvTA=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiIP/QaamitcKfZEryPLRMlFNY7JjYB7J4xU1Umz45 B8fLnJ6JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYiD/0AAKCRDB/BR4rcrsCUZNB/ 9P4MYim6PxAN9CTWyOeh7VgK0wxFh4CSeyOcK+r3ze3L17nYP0dVrK6RzHhKvsqxrgtH+//37nTRmB 0UjzmnZgBJHV9lo/gO7d8uh9DNuv7NmS7nFSS7aW6iSBcqWuoy0YMZGvvd+ExEC98fsF23x/CASyup mZYJE3QhmSxlOs88U/NiFl+81hUq0YgoCRfixHEEWZvFiNeuuQJmdI4NxjYxkgz6SJONKpWPBmw+fM xapB4qk7CcLwY+2TXe2hNUSQzj3qGBkvBLp1DGrAPkwc74VKlGWtyYXhP+30cynTs/FBcQdo3443T9 8djFAl7dYdl+x8OtFMXFYkWnQirGrg
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

With this optimizations also switch from round-closest to round-down. Given
that the calculations were non-optimal for quite some time now which
nobody reported as a problem, this is the opportunity to align the driver's
behavior to the requirements of new drivers. (Note however that the
duty_cycle calculation isn't aligned yet.)

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
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

base-commit: ed14d36498c8d15be098df4af9ca324f96e9de74
-- 
2.34.1

