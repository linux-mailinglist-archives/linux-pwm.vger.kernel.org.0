Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131B175427E
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Jul 2023 20:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbjGNSVf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 14 Jul 2023 14:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235934AbjGNSVf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 14 Jul 2023 14:21:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D762199
        for <linux-pwm@vger.kernel.org>; Fri, 14 Jul 2023 11:21:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKNPz-0000xu-2N; Fri, 14 Jul 2023 20:21:27 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKNPx-00EPFu-OS; Fri, 14 Jul 2023 20:21:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qKNPx-004sR0-40; Fri, 14 Jul 2023 20:21:25 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH] pwm: atmel-hlcdc: Use consistent variable naming
Date:   Fri, 14 Jul 2023 20:21:22 +0200
Message-Id: <20230714182122.2482299-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6474; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yQngkZhJToziRTMQ+MzB/LS1La/J8K1nMagBr3+1MsQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBksZIh014cknwdFxawFyspNue59av1SPMeqhOZQ Seu1/UbeJWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZLGSIQAKCRCPgPtYfRL+ TkbtCACC93h69q0ZFDkWWjIgyQCOIh/0wlh/0vGGKgM6Vye8Og9Bsv6v3vbILXisthGsUDkLP6w l754iox4zHKy6+LHboWeUwN2W8jGfWhH9mxsSr+6neWYsETVJVWUNc/avF3XFX/3vLZQc0RDRAb qWWuLpPb0meunC6Y+Va9x+PhsAQTFNt1yP1ZEqywYmM7/4mo4KO0EN6GnVdJr+f5ZvBzQG+aEeJ J9t7U9j1rnU3yXZ/N81oMAJR6fXG0MzXcYYHqoxpdkmNmKTQppSS/5QIHt8MY7lfMIYMz2cx8/5 gbd/wui1zghL6OvP9djCMHIEhW3cB/T+QVyeHnEdz7dXe46N
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

In pwm drivers the variable name "chip" is usually only used for struct
pwm_chip pointers. This driver however used "chip" for its driver data
and pwm_chip pointers are named "chip", too, when there is no driver
data around and "c" otherwise. Instead use "ddata" for driver data and
always "chip" for pwm_chips.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-atmel-hlcdc.c | 64 +++++++++++++++++------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/pwm/pwm-atmel-hlcdc.c b/drivers/pwm/pwm-atmel-hlcdc.c
index 96a709a9d49a..9b0165d61c49 100644
--- a/drivers/pwm/pwm-atmel-hlcdc.c
+++ b/drivers/pwm/pwm-atmel-hlcdc.c
@@ -38,11 +38,11 @@ static inline struct atmel_hlcdc_pwm *to_atmel_hlcdc_pwm(struct pwm_chip *chip)
 	return container_of(chip, struct atmel_hlcdc_pwm, chip);
 }
 
-static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
+static int atmel_hlcdc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				 const struct pwm_state *state)
 {
-	struct atmel_hlcdc_pwm *chip = to_atmel_hlcdc_pwm(c);
-	struct atmel_hlcdc *hlcdc = chip->hlcdc;
+	struct atmel_hlcdc_pwm *ddata = to_atmel_hlcdc_pwm(chip);
+	struct atmel_hlcdc *hlcdc = ddata->hlcdc;
 	unsigned int status;
 	int ret;
 
@@ -54,7 +54,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		u32 pwmcfg;
 		int pres;
 
-		if (!chip->errata || !chip->errata->slow_clk_erratum) {
+		if (!ddata->errata || !ddata->errata->slow_clk_erratum) {
 			clk_freq = clk_get_rate(new_clk);
 			if (!clk_freq)
 				return -EINVAL;
@@ -64,7 +64,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		}
 
 		/* Errata: cannot use slow clk on some IP revisions */
-		if ((chip->errata && chip->errata->slow_clk_erratum) ||
+		if ((ddata->errata && ddata->errata->slow_clk_erratum) ||
 		    clk_period_ns > state->period) {
 			new_clk = hlcdc->sys_clk;
 			clk_freq = clk_get_rate(new_clk);
@@ -77,8 +77,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 
 		for (pres = 0; pres <= ATMEL_HLCDC_PWMPS_MAX; pres++) {
 		/* Errata: cannot divide by 1 on some IP revisions */
-			if (!pres && chip->errata &&
-			    chip->errata->div1_clk_erratum)
+			if (!pres && ddata->errata &&
+			    ddata->errata->div1_clk_erratum)
 				continue;
 
 			if ((clk_period_ns << pres) >= state->period)
@@ -90,7 +90,7 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 
 		pwmcfg = ATMEL_HLCDC_PWMPS(pres);
 
-		if (new_clk != chip->cur_clk) {
+		if (new_clk != ddata->cur_clk) {
 			u32 gencfg = 0;
 			int ret;
 
@@ -98,8 +98,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 			if (ret)
 				return ret;
 
-			clk_disable_unprepare(chip->cur_clk);
-			chip->cur_clk = new_clk;
+			clk_disable_unprepare(ddata->cur_clk);
+			ddata->cur_clk = new_clk;
 
 			if (new_clk == hlcdc->sys_clk)
 				gencfg = ATMEL_HLCDC_CLKPWMSEL;
@@ -160,8 +160,8 @@ static int atmel_hlcdc_pwm_apply(struct pwm_chip *c, struct pwm_device *pwm,
 		if (ret)
 			return ret;
 
-		clk_disable_unprepare(chip->cur_clk);
-		chip->cur_clk = NULL;
+		clk_disable_unprepare(ddata->cur_clk);
+		ddata->cur_clk = NULL;
 	}
 
 	return 0;
@@ -183,31 +183,31 @@ static const struct atmel_hlcdc_pwm_errata atmel_hlcdc_pwm_sama5d3_errata = {
 #ifdef CONFIG_PM_SLEEP
 static int atmel_hlcdc_pwm_suspend(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *ddata = dev_get_drvdata(dev);
 
 	/* Keep the periph clock enabled if the PWM is still running. */
-	if (pwm_is_enabled(&chip->chip.pwms[0]))
-		clk_disable_unprepare(chip->hlcdc->periph_clk);
+	if (pwm_is_enabled(&ddata->chip.pwms[0]))
+		clk_disable_unprepare(ddata->hlcdc->periph_clk);
 
 	return 0;
 }
 
 static int atmel_hlcdc_pwm_resume(struct device *dev)
 {
-	struct atmel_hlcdc_pwm *chip = dev_get_drvdata(dev);
+	struct atmel_hlcdc_pwm *ddata = dev_get_drvdata(dev);
 	struct pwm_state state;
 	int ret;
 
-	pwm_get_state(&chip->chip.pwms[0], &state);
+	pwm_get_state(&ddata->chip.pwms[0], &state);
 
 	/* Re-enable the periph clock it was stopped during suspend. */
 	if (!state.enabled) {
-		ret = clk_prepare_enable(chip->hlcdc->periph_clk);
+		ret = clk_prepare_enable(ddata->hlcdc->periph_clk);
 		if (ret)
 			return ret;
 	}
 
-	return atmel_hlcdc_pwm_apply(&chip->chip, &chip->chip.pwms[0], &state);
+	return atmel_hlcdc_pwm_apply(&ddata->chip, &ddata->chip.pwms[0], &state);
 }
 #endif
 
@@ -244,14 +244,14 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct device *dev = &pdev->dev;
-	struct atmel_hlcdc_pwm *chip;
+	struct atmel_hlcdc_pwm *ddata;
 	struct atmel_hlcdc *hlcdc;
 	int ret;
 
 	hlcdc = dev_get_drvdata(dev->parent);
 
-	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
-	if (!chip)
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
 		return -ENOMEM;
 
 	ret = clk_prepare_enable(hlcdc->periph_clk);
@@ -260,31 +260,31 @@ static int atmel_hlcdc_pwm_probe(struct platform_device *pdev)
 
 	match = of_match_node(atmel_hlcdc_dt_ids, dev->parent->of_node);
 	if (match)
-		chip->errata = match->data;
+		ddata->errata = match->data;
 
-	chip->hlcdc = hlcdc;
-	chip->chip.ops = &atmel_hlcdc_pwm_ops;
-	chip->chip.dev = dev;
-	chip->chip.npwm = 1;
+	ddata->hlcdc = hlcdc;
+	ddata->chip.ops = &atmel_hlcdc_pwm_ops;
+	ddata->chip.dev = dev;
+	ddata->chip.npwm = 1;
 
-	ret = pwmchip_add(&chip->chip);
+	ret = pwmchip_add(&ddata->chip);
 	if (ret) {
 		clk_disable_unprepare(hlcdc->periph_clk);
 		return ret;
 	}
 
-	platform_set_drvdata(pdev, chip);
+	platform_set_drvdata(pdev, ddata);
 
 	return 0;
 }
 
 static void atmel_hlcdc_pwm_remove(struct platform_device *pdev)
 {
-	struct atmel_hlcdc_pwm *chip = platform_get_drvdata(pdev);
+	struct atmel_hlcdc_pwm *ddata = platform_get_drvdata(pdev);
 
-	pwmchip_remove(&chip->chip);
+	pwmchip_remove(&ddata->chip);
 
-	clk_disable_unprepare(chip->hlcdc->periph_clk);
+	clk_disable_unprepare(ddata->hlcdc->periph_clk);
 }
 
 static const struct of_device_id atmel_hlcdc_pwm_dt_ids[] = {

base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.39.2

