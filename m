Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A6B77440B
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235441AbjHHSOu (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjHHSOX (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:14:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED631DD15
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:23 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQNE-0007cH-RK; Tue, 08 Aug 2023 19:20:00 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00229R-U1; Tue, 08 Aug 2023 19:19:59 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQND-00BTFZ-5q; Tue, 08 Aug 2023 19:19:59 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 084/101] pwm: omap: Store parent device in driver data
Date:   Tue,  8 Aug 2023 19:19:14 +0200
Message-Id: <20230808171931.944154-85-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3892; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=oZ/yzhw8N5dt0UiAbUX3gWSc4dsV0Pcy1+Mqkzy65SY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0nkP4b8Tu10w9OwCvL7dmfy/nOr1F1E/tr7QA v5MshQysvCJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ5DwAKCRCPgPtYfRL+ TiS2B/wL73ht7I6ZQmr8S58BRYTUMRVilHpJ7r7W932D3uQnBbzNkAQJuAVgjrDlb0r1lqPWXFC pxWELJIPaYtCk8qLXUV3Gdhv9LEM5dFUjtN5tvzdtRlTTgEd9d4hmIAWASik8l26BBjprs3HVSo Ffl6Bkef6ac5s+7Cxp95Mxex1sucutK1PIIwleBXmy/hohm1MDhA0HL30POSLv6ycsTuv+HuTxb EEbC451l4pxYVbDsoiCa1TAdjxJnZw5n0eVs2jYE0lv7U5SlACn/rp18ZG+fRwfxqzHL3GHpL7Z 7m4lfhnTP/NsPwBC2166GQahAJ2Q2yQ3TqzmVGDSRjub5M2N
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, store a pointer to
the parent device in driver data.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-omap-dmtimer.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index c8d2db240b9e..d00133d44324 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -61,6 +61,7 @@
  * @dm_timer_pdev:	Pointer to omap dm timer platform device
  */
 struct pwm_omap_dmtimer_chip {
+	struct device *parent;
 	/* Mutex to protect pwm apply state */
 	struct mutex mutex;
 	struct omap_dm_timer *dm_timer;
@@ -157,7 +158,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	unsigned long clk_rate;
 	struct clk *fclk;
 
-	dev_dbg(chip->dev, "requested duty cycle: %d ns, period: %d ns\n",
+	dev_dbg(omap->parent, "requested duty cycle: %d ns, period: %d ns\n",
 		duty_ns, period_ns);
 
 	if (duty_ns == pwm_get_duty_cycle(pwm) &&
@@ -166,17 +167,17 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 
 	fclk = omap->pdata->get_fclk(omap->dm_timer);
 	if (!fclk) {
-		dev_err(chip->dev, "invalid pmtimer fclk\n");
+		dev_err(omap->parent, "invalid pmtimer fclk\n");
 		return -EINVAL;
 	}
 
 	clk_rate = clk_get_rate(fclk);
 	if (!clk_rate) {
-		dev_err(chip->dev, "invalid pmtimer fclk rate\n");
+		dev_err(omap->parent, "invalid pmtimer fclk rate\n");
 		return -EINVAL;
 	}
 
-	dev_dbg(chip->dev, "clk rate: %luHz\n", clk_rate);
+	dev_dbg(omap->parent, "clk rate: %luHz\n", clk_rate);
 
 	/*
 	 * Calculate the appropriate load and match values based on the
@@ -198,27 +199,27 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	duty_cycles = pwm_omap_dmtimer_get_clock_cycles(clk_rate, duty_ns);
 
 	if (period_cycles < 2) {
-		dev_info(chip->dev,
+		dev_info(omap->parent,
 			 "period %d ns too short for clock rate %lu Hz\n",
 			 period_ns, clk_rate);
 		return -EINVAL;
 	}
 
 	if (duty_cycles < 1) {
-		dev_dbg(chip->dev,
+		dev_dbg(omap->parent,
 			"duty cycle %d ns is too short for clock rate %lu Hz\n",
 			duty_ns, clk_rate);
-		dev_dbg(chip->dev, "using minimum of 1 clock cycle\n");
+		dev_dbg(omap->parent, "using minimum of 1 clock cycle\n");
 		duty_cycles = 1;
 	} else if (duty_cycles >= period_cycles) {
-		dev_dbg(chip->dev,
+		dev_dbg(omap->parent,
 			"duty cycle %d ns is too long for period %d ns at clock rate %lu Hz\n",
 			duty_ns, period_ns, clk_rate);
-		dev_dbg(chip->dev, "using maximum of 1 clock cycle less than period\n");
+		dev_dbg(omap->parent, "using maximum of 1 clock cycle less than period\n");
 		duty_cycles = period_cycles - 1;
 	}
 
-	dev_dbg(chip->dev, "effective duty cycle: %lld ns, period: %lld ns\n",
+	dev_dbg(omap->parent, "effective duty cycle: %lld ns, period: %lld ns\n",
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * duty_cycles,
 				      clk_rate),
 		DIV_ROUND_CLOSEST_ULL((u64)NSEC_PER_SEC * period_cycles,
@@ -230,7 +231,7 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
 	omap->pdata->set_load(omap->dm_timer, load_value);
 	omap->pdata->set_match(omap->dm_timer, true, match_value);
 
-	dev_dbg(chip->dev, "load value: %#08x (%d), match value: %#08x (%d)\n",
+	dev_dbg(omap->parent, "load value: %#08x (%d), match value: %#08x (%d)\n",
 		load_value, load_value,	match_value, match_value);
 
 	return 0;
@@ -386,6 +387,7 @@ static int pwm_omap_dmtimer_probe(struct platform_device *pdev)
 	omap->pdata = pdata;
 	omap->dm_timer = dm_timer;
 	omap->dm_timer_pdev = timer_pdev;
+	omap->parent = &pdev->dev;
 
 	/*
 	 * Ensure that the timer is stopped before we allow PWM core to call
-- 
2.40.1

