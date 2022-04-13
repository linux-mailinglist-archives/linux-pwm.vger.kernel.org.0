Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13C24FF2AD
	for <lists+linux-pwm@lfdr.de>; Wed, 13 Apr 2022 10:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiDMIxp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 13 Apr 2022 04:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234361AbiDMIxa (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 13 Apr 2022 04:53:30 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAE73EA83
        for <linux-pwm@vger.kernel.org>; Wed, 13 Apr 2022 01:51:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiO-0006XH-8U; Wed, 13 Apr 2022 10:51:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiM-002kHL-JB; Wed, 13 Apr 2022 10:51:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1neYiK-002yxP-9N; Wed, 13 Apr 2022 10:51:00 +0200
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
Subject: [PATCH 5/6] pwm: renesas-tpu: Improve maths to compute register settings
Date:   Wed, 13 Apr 2022 10:50:49 +0200
Message-Id: <20220413085050.61144-5-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
References: <20220413085050.61144-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2642; h=from:subject; bh=rYHIrAA48GsGOD8/J/9zAejAgt04LHzoAn8QOvls2gg=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiVo7jXFFbQ+1aXVOiQZTPKlTBShl3fynGmhvwshUg nxYU4AiJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYlaO4wAKCRDB/BR4rcrsCf22B/ 4u2hBVNzCo91PC8eHJOy4/nie79XOqsuDO/3OrLXaQu1/fXeaxXJKHQQUQpMxtHwdpZwJtVOSMmkzK xOIbLZ2QrKzY8xxCutD0xcd2NaSl2Ui4EU4zikOlcrDW9ZE0WF+VPj+T7M/enWjSmA6yES/H+zRBKS fKgOmwdOOJnrEe0N8wm8NlL7kX+QM45clpY89mHhw5/YrHTT0jOp8K6w7sSvqS7EZWZmUNTzgTzl/P uE33JFSTJtJGZYPI8MUPm9UV9WrPmRU328DAbNWropQIg+y9ZI3Fa13JzB736jxhdTj8AITEYyirBh V58POE5YwLSqu4cco+D/fD5qeLdWSx
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

The newly computed register values are intended to exactly match the
previously computed values. The main improvement is that the prescaler
is computed directly instead of with a loop. This uses the fact, that
prescalers[i] = 1 << (2 * i).

Assuming a moderately smart compiler, the needed number of divisions for
the case where the requested period is too big, is reduced from 5 to 2.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 671f1f824da8..fce7df418d62 100644
--- a/drivers/pwm/pwm-renesas-tpu.c
+++ b/drivers/pwm/pwm-renesas-tpu.c
@@ -244,7 +244,6 @@ static void tpu_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 			  int duty_ns, int period_ns, bool enabled)
 {
-	static const unsigned int prescalers[] = { 1, 4, 16, 64 };
 	struct tpu_pwm_device *tpd = pwm_get_chip_data(pwm);
 	struct tpu_device *tpu = to_tpu_device(chip);
 	unsigned int prescaler;
@@ -254,26 +253,21 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 duty;
 	int ret;
 
-	/*
-	 * Pick a prescaler to avoid overflowing the counter.
-	 * TODO: Pick the highest acceptable prescaler.
-	 */
 	clk_rate = clk_get_rate(tpu->clk);
 
-	for (prescaler = 0; prescaler < ARRAY_SIZE(prescalers); ++prescaler) {
-		period = clk_rate / prescalers[prescaler]
-		       / (NSEC_PER_SEC / period_ns);
-		if (period <= 0xffff)
-			break;
-	}
+	period = clk_rate / (NSEC_PER_SEC / period_ns);
+	if (period >= 64 * 0x10000 || period == 0)
+		return -EINVAL;
 
-	if (prescaler == ARRAY_SIZE(prescalers) || period == 0) {
-		dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
-		return -ENOTSUPP;
-	}
+	if (period < 0x10000)
+		prescaler = 0;
+	else
+		prescaler = ilog2(period / 0x10000) / 2 + 1;
+
+	period >>= 2 * prescaler;
 
 	if (duty_ns) {
-		duty = clk_rate / prescalers[prescaler]
+		duty = (clk_rate >> 2 * prescaler)
 		     / (NSEC_PER_SEC / duty_ns);
 		if (duty > period)
 			return -EINVAL;
@@ -283,7 +277,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	dev_dbg(&tpu->pdev->dev,
 		"rate %u, prescaler %u, period %u, duty %u\n",
-		clk_rate, prescalers[prescaler], period, duty);
+		clk_rate, 1 << (2 * prescaler), period, duty);
 
 	if (tpd->prescaler == prescaler && tpd->period == period)
 		duty_only = true;
-- 
2.35.1

