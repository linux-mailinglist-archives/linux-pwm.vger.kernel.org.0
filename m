Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451797746A5
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjHHS7A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjHHS6n (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBA1DD48
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:20:10 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN7-0007Jy-RD; Tue, 08 Aug 2023 19:19:53 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-00226M-W7; Tue, 08 Aug 2023 19:19:52 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN5-00BTD9-Ay; Tue, 08 Aug 2023 19:19:51 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 047/101] pwm: samsung: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:37 +0200
Message-Id: <20230808171931.944154-48-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6760; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=AGnWQ7y/qAVO/jZ2uYkSK29sATEtLWj0sVKTrvVnOF8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njl44VEgFJDu0aUed118FurkohMybK8f/Hpz SRoLLBXTtWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ45QAKCRCPgPtYfRL+ TitsCACUi4TP6TibhPeAK3MRihsbrSO9VbYs5kLrRFCxMrhK2OrzTCZGFm3+Nk/pHt9q7tm+xBt tZpNtUdwZ4u3aNnFRb8LGzGbOVRLOyI/ICQkmutw3m05bIysfkmFxPcxhzrN3zAvGYQHLXplke9 oWaqZxMrTKDe9JLRleR1n3cHgtHO/0eX1iETH3ygKwqifrrQM8QwPKANZxFP9QEt9Jwhqu0RY4C dFGYbd21XXTyYSTI6uR/n0mBG5zFWQBZtutbXNEa7FVpNxK2ntE9hp00OVBzqa8a6THdqrRfV5G 3lC9922IM33cjpcXTML6UANDAJFKjl6Bs7ZGLRXAF4f1EKrn
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-samsung driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 52 ++++++++++++++++++++-------------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 10fe2c13cd80..88d66c281015 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -79,7 +79,6 @@ struct samsung_pwm_channel {
  * @tclk1:		external clock 1 (can be ERR_PTR if not present)
  */
 struct samsung_pwm_chip {
-	struct pwm_chip chip;
 	struct samsung_pwm_variant variant;
 	u8 inverter_mask;
 	u8 disabled_mask;
@@ -109,7 +108,7 @@ static DEFINE_SPINLOCK(samsung_pwm_lock);
 static inline
 struct samsung_pwm_chip *to_samsung_pwm_chip(struct pwm_chip *chip)
 {
-	return container_of(chip, struct samsung_pwm_chip, chip);
+	return pwmchip_priv(chip);
 }
 
 static inline unsigned int to_tcon_channel(unsigned int channel)
@@ -180,9 +179,10 @@ static unsigned long pwm_samsung_get_tin_rate(struct samsung_pwm_chip *our_chip,
 	return rate / (reg + 1);
 }
 
-static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
+static unsigned long pwm_samsung_calc_tin(struct pwm_chip *chip,
 					  unsigned int chan, unsigned long freq)
 {
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	struct samsung_pwm_variant *variant = &our_chip->variant;
 	unsigned long rate;
 	struct clk *clk;
@@ -196,12 +196,12 @@ static unsigned long pwm_samsung_calc_tin(struct samsung_pwm_chip *our_chip,
 				return rate;
 		}
 
-		dev_warn(our_chip->chip.dev,
+		dev_warn(chip->dev,
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(our_chip->chip.dev, "tin parent at %lu\n", rate);
+	dev_dbg(chip->dev, "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -325,12 +325,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(our_chip->chip.dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(chip->dev, "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
-		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
+		tin_rate = pwm_samsung_calc_tin(chip, pwm->hwpwm, period);
 
-		dev_dbg(our_chip->chip.dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(chip->dev, "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -354,7 +354,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(our_chip->chip.dev,
+	dev_dbg(chip->dev,
 				"tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
@@ -367,7 +367,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(our_chip->chip.dev, "Forcing manual update");
+		dev_dbg(chip->dev, "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
@@ -506,9 +506,10 @@ static const struct of_device_id samsung_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
-	struct device_node *np = our_chip->chip.dev->of_node;
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
+	struct device_node *np = chip->dev->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -522,7 +523,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(our_chip->chip.dev,
+			dev_err(chip->dev,
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
@@ -533,7 +534,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 	return 0;
 }
 #else
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
 	return -ENODEV;
 }
@@ -542,21 +543,21 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 static int pwm_samsung_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct pwm_chip *chip;
 	struct samsung_pwm_chip *our_chip;
 	unsigned int chan;
 	int ret;
 
-	our_chip = devm_kzalloc(&pdev->dev, sizeof(*our_chip), GFP_KERNEL);
-	if (our_chip == NULL)
+	chip = devm_pwmchip_alloc(&pdev->dev, SAMSUNG_PWM_NUM, sizeof(*chip));
+	if (chip == NULL)
 		return -ENOMEM;
+	our_chip = to_samsung_pwm_chip(chip);
 
-	our_chip->chip.dev = &pdev->dev;
-	our_chip->chip.ops = &pwm_samsung_ops;
-	our_chip->chip.npwm = SAMSUNG_PWM_NUM;
+	chip->ops = &pwm_samsung_ops;
 	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-		ret = pwm_samsung_parse_dt(our_chip);
+		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
 	} else {
@@ -595,7 +596,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, our_chip);
 
-	ret = pwmchip_add(&our_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
 		clk_disable_unprepare(our_chip->base_clk);
@@ -612,9 +613,10 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 static void pwm_samsung_remove(struct platform_device *pdev)
 {
-	struct samsung_pwm_chip *our_chip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
-	pwmchip_remove(&our_chip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(our_chip->base_clk);
 }
@@ -622,8 +624,8 @@ static void pwm_samsung_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int pwm_samsung_resume(struct device *dev)
 {
-	struct samsung_pwm_chip *our_chip = dev_get_drvdata(dev);
-	struct pwm_chip *chip = &our_chip->chip;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 	unsigned int i;
 
 	for (i = 0; i < SAMSUNG_PWM_NUM; i++) {
-- 
2.40.1

