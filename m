Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762084FF2AE
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Apr 2022 10:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234079AbiDMIxq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Apr 2022 04:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234358AbiDMIxa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2022 04:53:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9CE37A09
        for <linux-pwm@vger.kernel.org>; Wed, 13 Apr 2022 01:51:09 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiO-0006XF-8U; Wed, 13 Apr 2022 10:51:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiM-002kHI-Ec; Wed, 13 Apr 2022 10:51:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiK-002yxS-Dd; Wed, 13 Apr 2022 10:51:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH 6/6] pwm: renesas-tpu: Improve precision of period and duty_cycle calculation
Date:   Wed, 13 Apr 2022 10:50:50 +0200
Message-Id: <20220413085050.61144-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3173; h=from:subject; bh=To3Or6W+jc16XwScrmzN0w37nRFhAJ8ifH/qhlKS3/0=; b=owEBbAGT/pANAwAKAcH8FHityuwJAcsmYgBiVo7mBSJF2KbShxT9qqTI64K+NJjqTXe9nRPXylKi 1l7ujOSJATIEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlaO5gAKCRDB/BR4rcrsCdIoB/ j33Mhrq2HiFzH3VwKNbf6FTbf34SXIzTEmRVKuUVMk3AkWO4aNRJhdBMe0TDxut9QlxXrsHux1mhr3 ntZHKfSrN8ru2+WvhLb5St+AaMF846DvGMZALktUhE8vatNJOHXh9p71zFSU5i94KXtoZ9tAVANs9d ftYiuRWRraEF+aV4HdRGwEuvtR9nGpJb6p3x5AXxyHtOJ47yji5IcEmt0BbF0OHmmCFPvGtbncdRER kR8MTI/A9vcmAyXNB+aK/mehbw+KLF+wb/HtQoOL4HZcxuc4pY23+xd/+U4SZt6FMA6I2dETcDxMwV IKHs/M8jRoSVnp9J6hUHHvbQKSTgQ=
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

Dividing by the result of a division looses precision. Consider for example
clk_rate = 33000000 and period_ns = 500001. Then

	clk_rate / (NSEC_PER_SEC / period_ns)

has the exact value 16500.033, but in C this evaluates to 16508. It gets
worse for even bigger values of period_ns, so with period_ns = 500000001,
the exact result is 16500000.033 while in C we get 33000000.

For that reason use

	clk_rate * period_ns / NSEC_PER_SEC

instead which doesn't suffer from this problem. To ensure this doesn't
overflow add a safeguard check for clk_rate.

Incidentally this fixes a division by zero if period_ns > NSEC_PER_SEC.
Another side effect is that values bigger than INT_MAX for period and
duty_cyle are not wrongly discarded any more.

Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index fce7df418d62..c8c7a896fc55 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -242,42 +242,52 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
-			  int duty_ns, int period_ns, bool enabled)
+			  u64 duty_ns, u64 period_ns, bool enabled)
 {
 	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 	struct tpu_device *tpu = to_tpu_device(chip);
 	unsigned int prescaler;
 	bool duty_only = false;
 	u32 clk_rate;
-	u32 period;
+	u64 period;
 	u32 duty;
 	int ret;
 
 	clk_rate = clk_get_rate(tpu->clk);
+	if (unlikely(clk_rate > 1000000000UL)) {
+		/*
+		 * This won't happen in the nearer future, so this is only a
+		 * safeguard to prevent the following calculation from
+		 * overflowing. With this clk_rate * period_ns / NSEC_PER_SEC is
+		 * not greater than period_ns and so fits into an u64.
+		 */
+		return -EINVAL;
+	}
 
-	period = clk_rate / (NSEC_PER_SEC / period_ns);
+	period = mul_u64_u64_div_u64(clk_rate, period_ns, NSEC_PER_SEC);
 	if (period >= 64 * 0x10000 || period == 0)
 		return -EINVAL;
 
 	if (period < 0x10000)
 		prescaler = 0;
 	else
-		prescaler = ilog2(period / 0x10000) / 2 + 1;
+		/*
+		 * We know period to fit into an u32, so cast accordingly to
+		 * make the division a bit cheaper
+		 */
+		prescaler = ilog2((u32)period / 0x10000) / 2 + 1;
 
 	period >>= 2 * prescaler;
 
-	if (duty_ns) {
-		duty = (clk_rate >> 2 * prescaler)
-		     / (NSEC_PER_SEC / duty_ns);
-		if (duty > period)
-			return -EINVAL;
-	} else {
+	if (duty_ns)
+		duty = mul_u64_u64_div_u64(clk_rate, duty_ns,
+					   (u64)NSEC_PER_SEC << (2 * prescaler));
+	else
 		duty = 0;
-	}
 
 	dev_dbg(&tpu->pdev->dev,
 		"rate %u, prescaler %u, period %u, duty %u\n",
-		clk_rate, 1 << (2 * prescaler), period, duty);
+		clk_rate, 1 << (2 * prescaler), (u32)period, duty);
 
 	if (tpd->prescaler == prescaler && tpd->period == period)
 		duty_only = true;
-- 
2.35.1

