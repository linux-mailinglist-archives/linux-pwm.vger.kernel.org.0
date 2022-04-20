Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DC65087DE
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352850AbiDTMPt (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 08:15:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352954AbiDTMPn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:15:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2456D403E5
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 05:12:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CU-00022V-CW; Wed, 20 Apr 2022 14:12:50 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CV-0049dR-2D; Wed, 20 Apr 2022 14:12:49 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CS-004Tjg-Ap; Wed, 20 Apr 2022 14:12:48 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, linux-pwm@vger.kernel.org,
        kernel@pengutronix.de
Subject: [PATCH v2 6/6] pwm: renesas-tpu: Improve precision of period and duty_cycle calculation
Date:   Wed, 20 Apr 2022 14:12:40 +0200
Message-Id: <20220420121240.67781-7-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3068; h=from:subject; bh=qhmj+/kClimdnaMQquEEOOHX5xZ+ZRCX9FU00iWnViM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX/i09g8CTVqTyKus3foEapayKgO+ir799otZKwof S7D4f3qJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/4tAAKCRDB/BR4rcrsCb1fCA CSWg4qs1CDKt47OWQYbajjaAIkiiTZiL6UiB7gD8Rk9sq+I4g3X3dyD+5LAtCYwVHm+p1lgQa1a0PS fAqLWMPfKBYRwPrsekaR4qa2FfQ42NOq3sN7JA2Vkj8wb7/kECp9j2n3dI1M0pGJrZAurXDDnUt/sn AK3lN79Q3Or/NRbsULoEAIj3HyvhyfoBarxzGg/o4gj/JbpKzzkq0+AWMBOKT66EtLIIKaeA4w76pr sifzthRq27fo+KsTH0w9qPrwrUekqHj/0xn3jvWVTvsKh4UBkF65jHOIzWIiThmXMGN9QGbi2wvSlM b5nuyxPpah01sQ+Zsw3bIkNB0C1XeH
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

Note that duty > period can never happen, so the respective check can be
dropped.

Incidentally this fixes a division by zero if period_ns > NSEC_PER_SEC.
Another side effect is that values bigger than INT_MAX for period and
duty_cyle are not wrongly discarded any more.

Fixes: 99b82abb0a35 ("pwm: Add Renesas TPU PWM driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 60ba7cf275c7..9e6978c39788 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -242,20 +242,29 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
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
+	if (unlikely(clk_rate > NSEC_PER_SEC)) {
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
 
 	/*
 	 * Find the minimal prescaler in [0..3] such that
@@ -292,18 +301,15 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
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

