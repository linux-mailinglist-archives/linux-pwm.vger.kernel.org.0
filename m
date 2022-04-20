Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52C35087D6
	for <lists+linux-pwm@lfdr.de>; Wed, 20 Apr 2022 14:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352208AbiDTMPq (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 20 Apr 2022 08:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352845AbiDTMPm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 20 Apr 2022 08:15:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23D840912
        for <linux-pwm@vger.kernel.org>; Wed, 20 Apr 2022 05:12:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CT-00022K-QD; Wed, 20 Apr 2022 14:12:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CU-0049dL-BA; Wed, 20 Apr 2022 14:12:48 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nh9CS-004Tjc-4s; Wed, 20 Apr 2022 14:12:48 +0200
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
Subject: [PATCH v2 5/6] pwm: renesas-tpu: Improve maths to compute register settings
Date:   Wed, 20 Apr 2022 14:12:39 +0200
Message-Id: <20220420121240.67781-6-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
References: <20220420121240.67781-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; h=from:subject; bh=pPojDEu8z/W+/Kd6UveQxXHJ9q84tC1SOQi5YlALafE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiX/ixNXAhCHjiYXdiwdodnuRuPu1zzi1W00JTOrPc xKC5xc+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYl/4sQAKCRDB/BR4rcrsCdazB/ 92Ln8NX2iZKelpuVLDEwcyRb/vtTlv1TYQOA5ASb06DyqSrTZumcFXkSAfsdpkTBIaYlEdKrPeOkX8 DDWKPozqKUICiKJZLWHovoCE2a/NiNxR1PvOCvCJt7nRABieJjMcbWLa2+2/6DGIx9IXn5mvqImMMh QIKQ5a/T6959hSbkDihOktwxvPftXNpermnN8MblfodJQZZx4G+AJfoIxnM2nU23LBWlnAF0PEfSli QQt/FbOcZQs3q55X+kGY+7V8xUjp1gGzxOkhgNp5v/OSqGWI+Zb/9OsFEy/lVCUPMSuQBKdGKzRaag 4W+bMq3S+M2egiigtU1jHcV/fgjjTQ
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

The newly computed register values are intended to exactly match the
previously computed values. The main improvement is that the prescaler
is computed without a loop that involves two divisions in each step.
This uses the fact, that prescalers[i] = 1 << (2 * i).

Assuming a moderately smart compiler, the needed number of divisions for
the case where the requested period is too big, is reduced from 5 to 2.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-renesas-tpu.c | 50 ++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-renesas-tpu.c b/drivers/pwm/pwm-renesas-tpu.c
index 5bced2050ece..60ba7cf275c7 100644
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
@@ -254,26 +253,47 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	u32 duty;
 	int ret;
 
+	clk_rate = clk_get_rate(tpu->clk);
+
+	period = clk_rate / (NSEC_PER_SEC / period_ns);
+
 	/*
-	 * Pick a prescaler to avoid overflowing the counter.
-	 * TODO: Pick the highest acceptable prescaler.
+	 * Find the minimal prescaler in [0..3] such that
+	 *
+	 * 	period >> (2 * prescaler) < 0x10000
+	 *
+	 * This could be calculated using something like:
+	 *
+	 * 	prescaler = max(ilog2(period) / 2, 7) - 7;
+	 *
+	 * but given there are only four allowed results and that ilog2 isn't
+	 * cheap on all platforms using a switch statement is more effective.
 	 */
-	clk_rate = clk_get_rate(tpu->clk);
+	switch (period) {
+	case 1 ... 0xffff:
+		prescaler = 0;
+		break;
 
-	for (prescaler = 0; prescaler < ARRAY_SIZE(prescalers); ++prescaler) {
-		period = clk_rate / prescalers[prescaler]
-		       / (NSEC_PER_SEC / period_ns);
-		if (period <= 0xffff)
-			break;
-	}
+	case 0x10000 ... 0x3ffff:
+		prescaler = 1;
+		break;
 
-	if (prescaler == ARRAY_SIZE(prescalers) || period == 0) {
-		dev_err(&tpu->pdev->dev, "clock rate mismatch\n");
-		return -ENOTSUPP;
+	case 0x40000 ... 0xfffff:
+		prescaler = 2;
+		break;
+
+	case 0x100000 ... 0x3fffff:
+		prescaler = 3;
+		break;
+
+	default:
+		return -EINVAL;
 	}
 
+	period >>= 2 * prescaler;
+
 	if (duty_ns) {
-		duty = clk_rate / prescalers[prescaler]
+		duty = (clk_rate >> 2 * prescaler)
 		     / (NSEC_PER_SEC / duty_ns);
 		if (duty > period)
 			return -EINVAL;
@@ -283,7 +303,7 @@ static int tpu_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	dev_dbg(&tpu->pdev->dev,
 		"rate %u, prescaler %u, period %u, duty %u\n",
-		clk_rate, prescalers[prescaler], period, duty);
+		clk_rate, 1 << (2 * prescaler), period, duty);
 
 	if (tpd->prescaler == prescaler && tpd->period == period)
 		duty_only = true;
-- 
2.35.1

