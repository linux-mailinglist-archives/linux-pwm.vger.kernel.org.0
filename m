Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA977C72F6
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Oct 2023 18:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379497AbjJLQbn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Oct 2023 12:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379646AbjJLQbQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 12 Oct 2023 12:31:16 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31A2EE1
        for <linux-pwm@vger.kernel.org>; Thu, 12 Oct 2023 09:31:13 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyac-0005jg-Ep; Thu, 12 Oct 2023 18:31:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaa-001CAS-5T; Thu, 12 Oct 2023 18:31:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qqyaZ-00F5Rh-SK; Thu, 12 Oct 2023 18:31:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH v2 083/109] pwm: samsung: Make use of devm_pwmchip_alloc() function
Date:   Thu, 12 Oct 2023 18:29:51 +0200
Message-ID: <20231012162827.1002444-194-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7dd
In-Reply-To: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
References: <20231012162827.1002444-111-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5977; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bVXaU7lju/k20JY+MzBeQEdbLs2HcYfCa+/gNqhRAuE=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlKB8OugivzjKvKhGtTA4PaxwoucZ1xSV54oDEj pLR4RKbMMKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZSgfDgAKCRCPgPtYfRL+ Tv5EB/4k3R2bu5/D7YH9mg62kh6G5g8OKdt7/VrsoO43ox5F2U98dRSYuEsUQowqFHUUaKvTMry Y7bPkTX7v/HIoQ56QIuQkOAMSdJEShLP7cxl6HcbS81q76+tiquU1ZTliGXQOtxzz3B+Q4ABbGm dR2c72Da1ZdH4LqUnqNzGvNlTEJWrGgD83Tto+jiEW9gd6w+CFiY1JdnbekXDtU1s0WUlqa1ZkV e58sjPp+ZI/yGuA1NGteySB5+BrFrPwvJjEds0VSo4FBAhegWSF+ea3zpndhAxMyKNNqS6lxn/W 2JQlX2zg9bO4b74z1BGorKf2Co4BAKQ6QZwiN9g5HQKQ2Qd0
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/pwm/pwm-samsung.c | 45 +++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index ac0d1f6e9c6b..d20f3b2336be 100644
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
 
-		dev_warn(pwmchip_parent(&our_chip->chip),
+		dev_warn(pwmchip_parent(chip),
 			"tclk of PWM %d is inoperational, using tdiv\n", chan);
 	}
 
 	rate = pwm_samsung_get_tin_rate(our_chip, chan);
-	dev_dbg(pwmchip_parent(&our_chip->chip), "tin parent at %lu\n", rate);
+	dev_dbg(pwmchip_parent(chip), "tin parent at %lu\n", rate);
 
 	/*
 	 * Compare minimum PWM frequency that can be achieved with possible
@@ -328,7 +328,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		dev_dbg(pwmchip_parent(chip), "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
-		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
+		tin_rate = pwm_samsung_calc_tin(chip, pwm->hwpwm, period);
 
 		dev_dbg(pwmchip_parent(chip), "tin_rate=%lu\n", tin_rate);
 
@@ -505,9 +505,10 @@ static const struct of_device_id samsung_pwm_matches[] = {
 };
 MODULE_DEVICE_TABLE(of, samsung_pwm_matches);
 
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
-	struct device_node *np = pwmchip_parent(&our_chip->chip)->of_node;
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
+	struct device_node *np = pwmchip_parent(chip)->of_node;
 	const struct of_device_id *match;
 	struct property *prop;
 	const __be32 *cur;
@@ -521,7 +522,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
-			dev_err(pwmchip_parent(&our_chip->chip),
+			dev_err(pwmchip_parent(chip),
 				"%s: invalid channel index in samsung,pwm-outputs property\n",
 								__func__);
 			continue;
@@ -532,7 +533,7 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
 	return 0;
 }
 #else
-static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
+static int pwm_samsung_parse_dt(struct pwm_chip *chip)
 {
 	return -ENODEV;
 }
@@ -541,21 +542,22 @@ static int pwm_samsung_parse_dt(struct samsung_pwm_chip *our_chip)
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
+
+	chip->ops = &pwm_samsung_ops;
 
-	our_chip->chip.dev = &pdev->dev;
-	our_chip->chip.ops = &pwm_samsung_ops;
-	our_chip->chip.npwm = SAMSUNG_PWM_NUM;
 	our_chip->inverter_mask = BIT(SAMSUNG_PWM_NUM) - 1;
 
 	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
-		ret = pwm_samsung_parse_dt(our_chip);
+		ret = pwm_samsung_parse_dt(chip);
 		if (ret)
 			return ret;
 	} else {
@@ -594,7 +596,7 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, our_chip);
 
-	ret = pwmchip_add(&our_chip->chip);
+	ret = pwmchip_add(chip);
 	if (ret < 0) {
 		dev_err(dev, "failed to register PWM chip\n");
 		clk_disable_unprepare(our_chip->base_clk);
@@ -611,9 +613,10 @@ static int pwm_samsung_probe(struct platform_device *pdev)
 
 static void pwm_samsung_remove(struct platform_device *pdev)
 {
-	struct samsung_pwm_chip *our_chip = platform_get_drvdata(pdev);
+	struct pwm_chip *chip = platform_get_drvdata(pdev);
+	struct samsung_pwm_chip *our_chip = to_samsung_pwm_chip(chip);
 
-	pwmchip_remove(&our_chip->chip);
+	pwmchip_remove(chip);
 
 	clk_disable_unprepare(our_chip->base_clk);
 }
@@ -621,8 +624,8 @@ static void pwm_samsung_remove(struct platform_device *pdev)
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
2.42.0

