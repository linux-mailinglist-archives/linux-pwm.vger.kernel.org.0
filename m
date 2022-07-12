Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F375957208A
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Jul 2022 18:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbiGLQQA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 12 Jul 2022 12:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbiGLQPd (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 12 Jul 2022 12:15:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D972CA6D4
        for <linux-pwm@vger.kernel.org>; Tue, 12 Jul 2022 09:15:32 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBIXp-0003m1-A9; Tue, 12 Jul 2022 18:15:29 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBIXn-000Xqf-NU; Tue, 12 Jul 2022 18:15:27 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oBIXm-004lKF-VF; Tue, 12 Jul 2022 18:15:26 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Ariel D'Alessandro <ariel@vanguardiasur.com.ar>,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: lpc18xx: Fix period handling
Date:   Tue, 12 Jul 2022 18:15:19 +0200
Message-Id: <20220712161519.44010-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220712161519.44010-1-u.kleine-koenig@pengutronix.de>
References: <20220712161519.44010-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4304; h=from:subject; bh=/KvdXFVONNgbnxqAIydrW+vgDhHw+y+cRp28qc9hu70=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBizZ4UF1BHoqhLa5MZvD9od8LW41y6knDig71Sz5fx kwplrqeJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYs2eFAAKCRDB/BR4rcrsCSboB/ 9WmXNXSaPamoWphSW1cFXc4u/ohx6MzWeFsNFMUbZGw9ZoCt4XmPACDLHlBPr1sTvAQxJK4jhFgpAp eVcg0qMoHfY6tQM2GDQljJpMN1F8EehzxiXpetTW4Is/BINdhI8QOfc5S8Z5tX2/zCJlkBa9VLd/3U Al3d5MeXcent7yjdOCbB5SzC/iwDDMgM5vizMid0cot/ZCRg+fJkDeCmCoRlC5hn7Zbd57sYl1Wmzf KhrwT8yT8T1EIl3F9isNK4DCzfgQCGf9LJsPP2kGEN6vl9xYUanX2dShkh2DucXvtS4OyII9zOGWDZ xZ/HfpQLpblzqptOk12atJ7lIkoy3O
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

The calculation:

	val = (u64)NSEC_PER_SEC * LPC18XX_PWM_TIMER_MAX;
	do_div(val, lpc18xx_pwm->clk_rate);
	lpc18xx_pwm->max_period_ns = val;

is bogus because with NSEC_PER_SEC = 1000000000,
LPC18XX_PWM_TIMER_MAX = 0xffffffff and clk_rate < NSEC_PER_SEC this
overflows the (on lpc18xx (i.e. ARM32) 32 bit wide) unsigned int
.max_period_ns. This results (dependant of the actual clk rate) in an
arbitrary limitation of the maximal period.  E.g. for clkrate =
333333333 (Hz) we get max_period_ns = 9 instead of 12884901897.

So make .max_period_ns an u64 and pass period and duty as u64 to not
discard relevant digits. And also make use of mul_u64_u64_div_u64()
which prevents all overflows assuming clk_rate < NSEC_PER_SEC.

Fixes: 841e6f90bb78 ("pwm: NXP LPC18xx PWM/SCT driver")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpc18xx-sct.c | 47 +++++++++++++++++++++++------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/drivers/pwm/pwm-lpc18xx-sct.c b/drivers/pwm/pwm-lpc18xx-sct.c
index 9bb2693cece3..763f2e3a146d 100644
--- a/drivers/pwm/pwm-lpc18xx-sct.c
+++ b/drivers/pwm/pwm-lpc18xx-sct.c
@@ -98,7 +98,7 @@ struct lpc18xx_pwm_chip {
 	unsigned long clk_rate;
 	unsigned int period_ns;
 	unsigned int min_period_ns;
-	unsigned int max_period_ns;
+	u64 max_period_ns;
 	unsigned int period_event;
 	unsigned long event_map;
 	struct mutex res_lock;
@@ -145,40 +145,48 @@ static void lpc18xx_pwm_set_conflict_res(struct lpc18xx_pwm_chip *lpc18xx_pwm,
 	mutex_unlock(&lpc18xx_pwm->res_lock);
 }
 
-static void lpc18xx_pwm_config_period(struct pwm_chip *chip, int period_ns)
+static void lpc18xx_pwm_config_period(struct pwm_chip *chip, u64 period_ns)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
-	u64 val;
+	u32 val;
 
-	val = (u64)period_ns * lpc18xx_pwm->clk_rate;
-	do_div(val, NSEC_PER_SEC);
+	/*
+	 * With clk_rate < NSEC_PER_SEC this cannot overflow.
+	 * With period_ns < max_period_ns this also fits into an u32.
+	 * As period_ns >= min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, lpc18xx_pwm->clk_rate);
+	 * we have val >= 1.
+	 */
+	val = mul_u64_u64_div_u64(period_ns, lpc18xx_pwm->clk_rate, NSEC_PER_SEC);
 
 	lpc18xx_pwm_writel(lpc18xx_pwm,
 			   LPC18XX_PWM_MATCH(lpc18xx_pwm->period_event),
-			   (u32)val - 1);
+			   val - 1);
 
 	lpc18xx_pwm_writel(lpc18xx_pwm,
 			   LPC18XX_PWM_MATCHREL(lpc18xx_pwm->period_event),
-			   (u32)val - 1);
+			   val - 1);
 }
 
 static void lpc18xx_pwm_config_duty(struct pwm_chip *chip,
-				    struct pwm_device *pwm, int duty_ns)
+				    struct pwm_device *pwm, u64 duty_ns)
 {
 	struct lpc18xx_pwm_chip *lpc18xx_pwm = to_lpc18xx_pwm_chip(chip);
 	struct lpc18xx_pwm_data *lpc18xx_data = &lpc18xx_pwm->channeldata[pwm->hwpwm];
-	u64 val;
+	u32 val;
 
-	val = (u64)duty_ns * lpc18xx_pwm->clk_rate;
-	do_div(val, NSEC_PER_SEC);
+	/*
+	 * With clk_rate < NSEC_PER_SEC this cannot overflow.
+	 * With duty_ns <= period_ns < max_period_ns this also fits into an u32.
+	 */
+	val = mul_u64_u64_div_u64(duty_ns, lpc18xx_pwm->clk_rate, NSEC_PER_SEC);
 
 	lpc18xx_pwm_writel(lpc18xx_pwm,
 			   LPC18XX_PWM_MATCH(lpc18xx_data->duty_event),
-			   (u32)val);
+			   val);
 
 	lpc18xx_pwm_writel(lpc18xx_pwm,
 			   LPC18XX_PWM_MATCHREL(lpc18xx_data->duty_event),
-			   (u32)val);
+			   val);
 }
 
 static int lpc18xx_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -375,12 +383,19 @@ static int lpc18xx_pwm_probe(struct platform_device *pdev)
 		goto disable_pwmclk;
 	}
 
+	/*
+	 * If clkrate is too fast, the calculations in .apply() might overflow.
+	 */
+	if (lpc18xx_pwm->clk_rate > NSEC_PER_SEC) {
+		ret = dev_err_probe(&pdev->dev, -EINVAL, "pwm clock to fast\n");
+		goto disable_pwmclk;
+	}
+
 	mutex_init(&lpc18xx_pwm->res_lock);
 	mutex_init(&lpc18xx_pwm->period_lock);
 
-	val = (u64)NSEC_PER_SEC * LPC18XX_PWM_TIMER_MAX;
-	do_div(val, lpc18xx_pwm->clk_rate);
-	lpc18xx_pwm->max_period_ns = val;
+	lpc18xx_pwm->max_period_ns =
+		mul_u64_u64_div_u64(NSEC_PER_SEC, LPC18XX_PWM_TIMER_MAX, lpc18xx_pwm->clk_rate);
 
 	lpc18xx_pwm->min_period_ns = DIV_ROUND_UP(NSEC_PER_SEC,
 						  lpc18xx_pwm->clk_rate);
-- 
2.36.1

